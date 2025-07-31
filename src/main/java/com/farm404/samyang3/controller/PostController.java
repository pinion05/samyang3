package com.farm404.samyang3.controller;

import com.farm404.samyang3.domain.CommentVO;
import com.farm404.samyang3.domain.PostVO;
import com.farm404.samyang3.domain.UserVO;
import com.farm404.samyang3.service.CommentService;
import com.farm404.samyang3.service.PostService;
import com.farm404.samyang3.util.SessionUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/post")
public class PostController {
    
    @Autowired
    private PostService postService;
    
    @Autowired
    private CommentService commentService;
    
    // 게시글 목록
    @GetMapping
    public String list(@RequestParam(required = false) String category,
                      @RequestParam(required = false) String keyword,
                      Model model) {
        
        List<PostVO> posts;
        
        if (category != null && !category.isEmpty()) {
            posts = postService.getPostsByCategory(category);
            model.addAttribute("selectedCategory", category);
        } else if (keyword != null && !keyword.isEmpty()) {
            posts = postService.searchPosts(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            posts = postService.getAllPosts();
        }
        
        model.addAttribute("posts", posts);
        model.addAttribute("categories", postService.getCategories());
        
        return "post/list";
    }
    
    // 게시글 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        PostVO post = postService.getPostById(id);
        
        if (post == null) {
            return "redirect:/post";
        }
        
        // 조회수 증가
        postService.increaseViewCount(id);
        
        // 댓글 목록
        List<CommentVO> comments = commentService.getCommentsByPost(id);
        
        model.addAttribute("post", post);
        model.addAttribute("comments", comments);
        
        return "post/detail";
    }
    
    // 게시글 작성 폼
    @GetMapping("/write")
    public String writeForm(HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        return "post/write";
    }
    
    // 게시글 작성 처리
    @PostMapping("/write")
    public String write(PostVO post,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        post.setUserID(loginUser.getUserID());
        post.setAuthorName(loginUser.getFullName());
        
        if (postService.createPost(post)) {
            redirectAttributes.addFlashAttribute("success", "게시글이 등록되었습니다.");
            return "redirect:/post/" + post.getPostID();
        } else {
            redirectAttributes.addFlashAttribute("error", "게시글 등록에 실패했습니다.");
            return "redirect:/post/write";
        }
    }
    
    // 게시글 수정 폼
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id,
                         HttpSession session,
                         Model model) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        PostVO post = postService.getPostById(id);
        
        if (post == null || !post.getUserID().equals(loginUser.getUserID())) {
            return "redirect:/post";
        }
        
        model.addAttribute("post", post);
        
        return "post/edit";
    }
    
    // 게시글 수정 처리
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id,
                      PostVO post,
                      HttpSession session,
                      RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        PostVO existingPost = postService.getPostById(id);
        
        if (existingPost == null || !existingPost.getUserID().equals(loginUser.getUserID())) {
            redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
            return "redirect:/post";
        }
        
        post.setPostID(id.intValue());
        post.setUserID(loginUser.getUserID());
        
        if (postService.updatePost(post)) {
            redirectAttributes.addFlashAttribute("success", "게시글이 수정되었습니다.");
            return "redirect:/post/" + id;
        } else {
            redirectAttributes.addFlashAttribute("error", "게시글 수정에 실패했습니다.");
            return "redirect:/post/edit/" + id;
        }
    }
    
    // 게시글 삭제
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        PostVO post = postService.getPostById(id);
        
        if (post == null || (!post.getUserID().equals(loginUser.getUserID()) && !loginUser.getIsAdmin())) {
            redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
            return "redirect:/post";
        }
        
        if (postService.deletePost(id)) {
            redirectAttributes.addFlashAttribute("success", "게시글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "게시글 삭제에 실패했습니다.");
        }
        
        return "redirect:/post";
    }
    
    // 내가 쓴 글
    @GetMapping("/my")
    public String myPosts(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        List<PostVO> posts = postService.getPostsByUser(loginUser.getUserID());
        model.addAttribute("posts", posts);
        
        return "post/my";
    }
    
    // 댓글 작성
    @PostMapping("/{postId}/comment")
    public String addComment(@PathVariable Long postId,
                           @RequestParam String content,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        CommentVO comment = new CommentVO();
        comment.setPostID(postId.intValue());
        comment.setUserID(loginUser.getUserID());
        comment.setAuthorName(loginUser.getFullName());
        comment.setContent(content);
        
        if (commentService.addComment(comment)) {
            redirectAttributes.addFlashAttribute("success", "댓글이 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "댓글 등록에 실패했습니다.");
        }
        
        return "redirect:/post/" + postId + "#comments";
    }
    
    // 댓글 삭제
    @PostMapping("/comment/delete/{commentId}")
    public String deleteComment(@PathVariable Long commentId,
                              @RequestParam Long postId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        CommentVO comment = commentService.getCommentById(commentId);
        
        if (comment == null || (!comment.getUserID().equals(loginUser.getUserID()) && !loginUser.getIsAdmin())) {
            redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
            return "redirect:/post/" + postId;
        }
        
        if (commentService.deleteComment(commentId)) {
            redirectAttributes.addFlashAttribute("success", "댓글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "댓글 삭제에 실패했습니다.");
        }
        
        return "redirect:/post/" + postId + "#comments";
    }
}
package com.farm404.samyang3.controller;

import com.farm404.samyang3.domain.ProductVO;
import com.farm404.samyang3.domain.ReviewVO;
import com.farm404.samyang3.domain.UserVO;
import com.farm404.samyang3.service.ProductService;
import com.farm404.samyang3.service.ReviewService;
import com.farm404.samyang3.util.SessionUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/product")
public class ProductController {
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private ReviewService reviewService;
    
    // 상품 목록 보여주기... category랑 keyword로 검색도 가능
    @GetMapping
    public String list(@RequestParam(required = false) String category,
                      @RequestParam(required = false) String keyword,
                      Model model) {
        
        List<ProductVO> products;
        
        if (category != null && !category.isEmpty()) {
            products = productService.getProductsByCategory(category);
            model.addAttribute("selectedCategory", category);
        } else if (keyword != null && !keyword.isEmpty()) {
            products = productService.searchProducts(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            products = productService.getAllProducts();
        }
        
        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getAllCategories());
        
        return "product/list";
    }
    
    /**
     * 상품 상세페이지
     * 근데 id가 없으면 어떻게 되는거지?
     */
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        ProductVO product = productService.getProductById(id);
        
        if (product == null) {
            return "redirect:/product";
        }
        
        // 리뷰 목록 조회
        List<ReviewVO> reviews = reviewService.getReviewsByProduct(id);
        double avgRating = reviewService.getAverageRating(id);
        
        model.addAttribute("product", product);
        model.addAttribute("reviews", reviews);
        model.addAttribute("avgRating", avgRating);
        model.addAttribute("reviewCount", reviews.size());
        
        return "product/detail";
    }
    
    // 상품 등록 폼 (관리자)
    @GetMapping("/add")
    public String addForm(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null || !loginUser.getIsAdmin()) {
            return "redirect:/";
        }
        
        model.addAttribute("product", new ProductVO());
        return "product/form";
    }
    
    // 상품 등록 처리 (관리자)
    @PostMapping("/add")
    public String add(ProductVO product, 
                     @RequestParam(required = false) MultipartFile imageFile,
                     HttpSession session,
                     RedirectAttributes redirectAttributes) throws IOException {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null || !loginUser.getIsAdmin()) {
            return "redirect:/";
        }
        
        /* 이미지 업로드 처리하는 부분임 */
        if (imageFile != null && !imageFile.isEmpty()) {
            String uploadDir = "src/main/resources/static/images/products/";
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            String originalFilename = imageFile.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String savedFilename = UUID.randomUUID().toString() + extension; // UUID써서 파일명 중복안되게..
            
            File saveFile = new File(uploadDir + savedFilename);
            imageFile.transferTo(saveFile);
            
            product.setImageUrl("/images/products/" + savedFilename);
        }
        
        if (productService.addProduct(product)) {
            redirectAttributes.addFlashAttribute("success", "상품이 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "상품 등록에 실패했습니다.");
        }
        
        return "redirect:/product";
    }
    
    // 상품 수정 폼 (관리자)
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null || !loginUser.getIsAdmin()) {
            return "redirect:/";
        }
        
        ProductVO product = productService.getProductById(id);
        if (product == null) {
            return "redirect:/product";
        }
        
        model.addAttribute("product", product);
        return "product/form";
    }
    
    // 상품 수정 처리 (관리자)
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id,
                      ProductVO product,
                      @RequestParam(required = false) MultipartFile imageFile,
                      HttpSession session,
                      RedirectAttributes redirectAttributes) throws IOException {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null || !loginUser.getIsAdmin()) {
            return "redirect:/";
        }
        
        product.setProductID(id.intValue());
        
        // 기존 상품 정보 조회
        ProductVO existingProduct = productService.getProductById(id);
        
        // 이미지 파일 처리
        if (imageFile != null && !imageFile.isEmpty()) {
            String uploadDir = "src/main/resources/static/images/products/";
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            String originalFilename = imageFile.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String savedFilename = UUID.randomUUID().toString() + extension;
            
            File saveFile = new File(uploadDir + savedFilename);
            imageFile.transferTo(saveFile);
            
            product.setImageUrl("/images/products/" + savedFilename);
        } else {
            // 이미지를 변경하지 않은 경우 기존 이미지 URL 유지
            product.setImageUrl(existingProduct.getImageUrl());
        }
        
        if (productService.updateProduct(product)) {
            redirectAttributes.addFlashAttribute("success", "상품이 수정되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "상품 수정에 실패했습니다.");
        }
        
        return "redirect:/product/" + id;
    }
    
    // 상품 삭제 (관리자)
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null || !loginUser.getIsAdmin()) {
            return "redirect:/";  //관리자 아니면 못지움
        }
        
        // 삭제처리..
        if (productService.deleteProduct(id)) {
            redirectAttributes.addFlashAttribute("success", "상품이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "상품 삭제에 실패했습니다.");
        }
        
        return "redirect:/product";
    }
}
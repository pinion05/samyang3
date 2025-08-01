package com.farm404.samyang3;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// 메인 클래스
@SpringBootApplication
@MapperScan("com.farm404.samyang3.mapper")  /* 매퍼 스캔하는 어노테이션 */
public class Samyang3Application {

	/** 메인 메소드임... 스프링부트 실행 */
	public static void main(String[] args) {
		SpringApplication.run(Samyang3Application.class, args);
	}

}

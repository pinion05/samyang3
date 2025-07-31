package com.farm404.samyang3;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.farm404.samyang3.mapper")
public class Samyang3Application {

	public static void main(String[] args) {
		SpringApplication.run(Samyang3Application.class, args);
	}

}

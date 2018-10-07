package com.cts.survey;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages={
"com.cts.survey"})
public class CtsSurveyApplication {

	public static void main(String[] args) {
		SpringApplication.run(CtsSurveyApplication.class, args);
	}
}

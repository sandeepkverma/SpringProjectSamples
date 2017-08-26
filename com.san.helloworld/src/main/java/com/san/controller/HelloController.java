package com.san.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.san.service.TestService;

@Controller
public class HelloController {
	
	@Autowired
	TestService testService;
	
	@RequestMapping(value="/")
	public ModelAndView index()
	{
		return new ModelAndView("ajaxform");
	}

	@RequestMapping("/hello")
	@ResponseBody
	public String helloUser(){
		
		return "hello sandy";
	}
	
	@RequestMapping("/getuserinfo")
	@ResponseBody
	public String getUserInfo(){
		String mess = null;
		try {
			mess = testService.getUserInfo();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return mess;
	}
}

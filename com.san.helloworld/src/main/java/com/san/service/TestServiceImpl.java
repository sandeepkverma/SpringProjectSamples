package com.san.service;

import org.springframework.jdbc.core.JdbcTemplate;

public class TestServiceImpl implements TestService {
	
//	private JdbcTemplate jdbcTemplate;
//
//	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
//		this.jdbcTemplate = jdbcTemplate;
//	}

	@Override
	public String getUserInfo() {
		// here get information from database
		return "get user information successfully";
	}

}

package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.ResultData;

@Controller
public class UsrHomeController {
	
	@GetMapping("/usr/home/main")
	public String showMain() {
		return "usr/home/main";
	}
	
	@GetMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
	
	@GetMapping("/usr/home/test")
	@ResponseBody
	public ResultData<Map<String, Object>> test(String key1, String key2) {

		Map<String, Object> map = new HashMap<>();
		map.put("key1", key1);
		map.put("key2", key2);
		
		return ResultData.from("code", key1 + key2, map);
	}
}
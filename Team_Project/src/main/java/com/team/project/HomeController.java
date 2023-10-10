package com.team.project;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main_page(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		hs.setAttribute("loginstatus", false);
		return "main_page";
	}
	
	@RequestMapping(value = "/user_page", method = RequestMethod.GET)
	public String user_page(HttpServletRequest request) {
		return "user_page";
	}

	@RequestMapping(value = "/seller_page", method = RequestMethod.GET)
	public String seller_page() {
		return "seller_page";
	}
	
}

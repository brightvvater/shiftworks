package org.shiftworks.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {
	
	// �α��� �ʿ� �� Ŀ���� �α��� �������� �̵�
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error: " + error + ", logout:" + logout);
		
		// ���� �߻� �� view�� �޽��� ����
		if(error != null) {
			model.addAttribute("error", "Login Error");
		}
		
		// �α׾ƿ� �� view�� �޽��� ����
		if(logout != null) {
			model.addAttribute("logout", "Logout");
		}
	}
	
	// �α׾ƿ� �� ��Ű, ���� ���� ����(���� �۾��� ������ ���ο���!)
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom Logout");
	}
	
	
	// ���� ������ ���� �������� ���� �� ���� �Ұ� ������ ���
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied: " + auth);
		
		// view�� ���� �Ұ� �޽��� ����
		model.addAttribute("message", "Access Denied");
	}

}
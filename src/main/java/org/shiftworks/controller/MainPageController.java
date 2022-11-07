package org.shiftworks.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/login")
@Log4j
public class MainPageController {
	
	@GetMapping
	public String main(Model model) {
	
		//�Ķ���ͷ� @AuthenticationPrincipal ������̼� ���ؼ� 
		//UserDetails �������̽��� ������ SecurityUser��ü �ӿ� ����ִ�
		//principal�ʵ�(����ID)�� ������ �� �ִ�.
		//@AuthenticationPrincipal UserDetailsimpl userDetails
		
		return null;//�α��� �� ������ username������ ��� empVO��ü��
		//"���������� url"�� �����ϸ� �Ѿ��.
	}

	@GetMapping("/LOG_main")
	public void doMain() {
	
		log.info("LOGIN MAIN PAGE .............................");
		
	}
	
	@GetMapping("/LOG_user")
	public void doUser() {
		
		log.info("user page.........");
	}
	
	@GetMapping("/LOG_admin")
	public void doAdmin() {
		log.info("admin only...........");
	}
	
}

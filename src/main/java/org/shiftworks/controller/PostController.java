package org.shiftworks.controller;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.shiftworks.domain.Criteria;
import org.shiftworks.domain.PostVO;
import org.shiftworks.service.PostService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/board/*")
@RestController
@Log4j
@AllArgsConstructor
public class PostController {
	
	
	private PostService service;
	
	//register form 이동
	@GetMapping(value = "/new")
	public ModelAndView register() throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/board/register");
		return mav;
	}
	
	//register form에서 받아온 값 db에 넣기
	@PostMapping(value = "/new")
	public ResponseEntity<String> register(@RequestBody PostVO vo){
		log.info("controller..............................");
		int insertCount = service.insertPost(vo);
		log.info("insertCount: " + insertCount);
		
		return insertCount ==1
		? new ResponseEntity<String>("success", HttpStatus.OK)
		: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	//list.jsp 이동
	@GetMapping(value = "/pages/{pageNum}")
	public  ModelAndView getList(@PathVariable("pageNum") int page){
		
		Criteria cri = new Criteria(page,10);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/board/list");
		mav.addObject("list",service.getList(cri));
		
		return mav;
	}
	
	
	//db에서 PostVO list 받아오기
//	@GetMapping(value = "/pages/{pageNum}/{type}/{keyword}")
//	public  ModelAndView getList(
//								@PathVariable("pageNum")int page,
//								@PathVariable("type") String type,
//								@PathVariable("keyword") String keyword){
//		
//		Criteria cri = new Criteria(page,10);
//		
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("/board/list");
//		
//		mav.addObject("list",service.getList(cri));
//		return mav;
//	}
	
	
	//db에서 특정 PostVO 받아오기 
	@GetMapping(value = "/{post_id}")
	public ResponseEntity<PostVO> getPost(@PathVariable("post_id") int post_id){
		
		return new ResponseEntity<PostVO>(service.getPost(post_id),HttpStatus.OK);
	}
	
	
	//수정 클릭 시 modify.jsp로 이동
	@GetMapping(value = "/modify/{post_id}")
	public ModelAndView modify(@PathVariable("post_id") int post_id) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/board/modify");
		
		mav.addObject("PostVO",service.getPost(post_id));
		return mav;
		
	}
	
	// 수정 데이터 값을 db 넣기
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
								value = "/{post_id}")
	public ResponseEntity<String> modify(@RequestBody PostVO vo,
															   @PathVariable("post_id") int post_id){
		
		vo.setPost_id(post_id);
		return service.updatePost(vo)==1
		? new ResponseEntity<String>("success", HttpStatus.OK)
		: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//삭제하기
	@DeleteMapping(value = "/{post_id}")
	public ResponseEntity<String> deletePost(@PathVariable("post_id")int post_id){
		
		 return service.deletePost(post_id) ==1
		? new ResponseEntity<String>("success", HttpStatus.OK)
		: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	
	
	
	

}

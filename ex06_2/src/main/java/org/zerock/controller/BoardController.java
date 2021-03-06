package org.zerock.controller;


import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
	
//	
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("list");
//		model.addAttribute("list", service.getList());
//	}
//	
	
	@GetMapping("/list")
	public void list(Criteria cri,Model model) {
		log.info("list");
		
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	//등록페이지를 호출해주는 역할
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {	
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("register" + board);
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return"redirect:/board/list";
	}
	
	
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or modify");
		System.out.println(service.get(bno).getReplyCnt());
		model.addAttribute("board", service.get(bno));
	}
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(@ModelAttribute("cri") Criteria cri,BoardVO board, RedirectAttributes rttr) {
		log.info("modify:" + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		
		
		return"redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@ModelAttribute("cri") Criteria cri, @RequestParam("bno") long bno, RedirectAttributes rttr) {
		log.info("remove :" + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNumber", cri.getPageNumber());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return"redirect:/board/list" + cri.getListLink();
	}
	
}

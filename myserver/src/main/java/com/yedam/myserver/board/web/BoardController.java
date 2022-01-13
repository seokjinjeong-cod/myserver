package com.yedam.myserver.board.web;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class BoardController {
	
	@PostMapping("boardInsert.do")
	public String boardInsert(Board board, MultipartFile uploadFile) throws IllegalStateException, IOException { //jsp파일에 name속성 값이랑 일치해야함
		String fname = uploadFile.getOriginalFilename();
		System.out.println(uploadFile.getOriginalFilename());
		System.out.println(uploadFile.getSize());
		uploadFile.transferTo(new File("C:/upload", fname));
		
		board.setAttachFile(fname);
		
		return "redirect:./";
	}
}

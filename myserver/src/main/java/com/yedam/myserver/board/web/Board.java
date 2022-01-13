package com.yedam.myserver.board.web;

import lombok.Data;

@Data
public class Board {

	String no;
	String title;
	String contents;
	String writer;
	String wdate;
	String replyCnt;
	String attachFile;
}

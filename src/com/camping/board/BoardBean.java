package com.camping.board;

import java.sql.Date;

public class BoardBean {
	
	// 사용자가 입력한 정보를 저장할 수 있는 자바빈 객체
	// 3가지로 구성된다 1. 메서드에 사용될 변수  2. 기본 생성자 3.메서드
	
	// 게시판 필수 정보
	private int num;
	private String writer;
	private String pass;
	private String subject;
	private String content;
	
	// 게시판 답글 + 조회수
	private int readcount;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	
	//게시판 옵션
	private Date date;  // java.sql 사용
	private String ip;
	private String file;
	
	public BoardBean() {}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getRe_ref() {
		return re_ref;
	}

	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}

	public int getRe_lev() {
		return re_lev;
	}

	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}

	public int getRe_seq() {
		return re_seq;
	}

	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}
	// 
	@Override
	public String toString() {
		return "BoardBean [num=" + num + ", writer=" + writer + ", pass=" + pass + ", subject=" + subject + ", content="
				+ content + ", readcount=" + readcount + ", re_ref=" + re_ref + ", re_lev=" + re_lev + ", re_seq="
				+ re_seq + ", date=" + date + ", ip=" + ip + ", file=" + file + "]";
	}
	
	
}

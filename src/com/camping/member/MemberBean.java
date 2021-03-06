package com.camping.member;

import java.sql.Timestamp;

public class MemberBean {
	
	private String member_id;
	private String member_pwd;
	private String member_name;
	private String member_email;
	private Timestamp reg_date;
	private String member_address;
	
	public MemberBean() {}

	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pwd() {
		return member_pwd;
	}

	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public String getMember_address() {
		return member_address;
	}

	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}

	@Override
	public String toString() {
		return "MemberBean [member_id=" + member_id + ", member_pwd=" + member_pwd + ", member_name=" + member_name
				+ ", member_email=" + member_email + ", reg_date=" + reg_date + ", member_address=" + member_address
				+ "]";
	}
}

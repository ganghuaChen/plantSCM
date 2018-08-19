package org.npc.plantSCM.po;

import java.io.Serializable;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

public class Staff{
	
	private String sAccount;//账号
	private String sPassword;//密码
	private String staffName;
	private String staffPhone;
	private Role role; // 角色
	
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public String getStaffPhone() {
		return staffPhone;
	}
	public void setStaffPhone(String staffPhone) {
		this.staffPhone = staffPhone;
	}
	public String getsAccount() {
		return sAccount;
	}
	public void setsAccount(String sAccount) {
		this.sAccount = sAccount;
	}
	public String getsPassword() {
		return sPassword;
	}
	public void setsPassword(String sPassword) {
		this.sPassword = sPassword;
	}
	public String getStaffName() {
		return staffName;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	@Override
	public String toString() {
		return "Staff [sAccount=" + sAccount + ", sPassword=" + sPassword + ", staffName=" + staffName + ", staffPhone="
				+ staffPhone + ", role=" + role + "]";
	}
	


	

}

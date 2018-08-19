package org.npc.plantSCM.po;

public class Phone {
	
	private int id;
	private String phone;
	private String role;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public String toString() {
		return "Phone [id=" + id + ", phone=" + phone + ", role=" + role + "]";
	}
	
	
	

    
	 

}

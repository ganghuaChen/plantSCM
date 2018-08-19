package org.npc.plantSCM.po;

public class Inform {
	private Integer id;//记录id
	private String informTime;//通知时间
    private String informContent;//通知内容
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getInformTime() {
		return informTime;
	}
	public void setInformTime(String informTime) {
		this.informTime = informTime;
	}
	public String getInformContent() {
		return informContent;
	}
	public void setInformContent(String informContent) {
		this.informContent = informContent;
	}
	@Override
	public String toString() {
		return "Inform [id=" + id + ", informTime=" + informTime + ", informContent=" + informContent + "]";
	}

}

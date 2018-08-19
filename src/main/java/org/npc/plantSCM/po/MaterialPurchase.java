package org.npc.plantSCM.po;

public class MaterialPurchase {
	
	private Integer id;//记录id
	private String ylDate;//采购日期
	private String ylSpecies;//种类
	private Float ylPrice;//单价
	private Float ylWeight;//数量
	private Float ylTotalPrice;//总价
	private String ylFactory;//采购商家
	private String ylnote;//备注
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getYlDate() {
		return ylDate;
	}
	public void setYlDate(String ylDate) {
		this.ylDate = ylDate;
	}
	public String getYlSpecies() {
		return ylSpecies;
	}
	public void setYlSpecies(String ylSpecies) {
		this.ylSpecies = ylSpecies;
	}
	public Float getYlPrice() {
		return ylPrice;
	}
	public void setYlPrice(Float ylPrice) {
		this.ylPrice = ylPrice;
	}

	
	public Float getYlWeight() {
		return ylWeight;
	}
	public void setYlWeight(Float ylWeight) {
		this.ylWeight = ylWeight;
	}
	public Float getYlTotalPrice() {
		return ylTotalPrice;
	}
	public void setYlTotalPrice(Float ylTotalPrice) {
		this.ylTotalPrice = ylTotalPrice;
	}
	public String getYlFactory() {
		return ylFactory;
	}
	public void setYlFactory(String ylFactory) {
		this.ylFactory = ylFactory;
	}
	public String getYlnote() {
		return ylnote;
	}
	public void setYlnote(String ylnote) {
		this.ylnote = ylnote;
	}
	@Override
	public String toString() {
		return "MaterialPurchase [id=" + id + ", ylDate=" + ylDate + ", ylSpecies=" + ylSpecies + ", ylPrice=" + ylPrice
				+ ", HjWeight=" + ylWeight + ", ylTotalPrice=" + ylTotalPrice + ", ylFactory=" + ylFactory + ", ylnote="
				+ ylnote + "]";
	}

}

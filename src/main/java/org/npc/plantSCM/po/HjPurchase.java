package org.npc.plantSCM.po;

public class HjPurchase {
	
	private Integer id;//记录id
	private String hjDate;//采购(入库)日期
	private String hjSpecies;//焊剂种类
	private Float hjPrice;//单价
	private Integer hjNumber;//焊剂数量
	private Float hjTotalPrice;//总价
	private String hjFrom;//采购商家
	private Boolean hjStorageState;//入库状态
	private String hjNote;//备注
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getHjDate() {
		return hjDate;
	}
	public void setHjDate(String hjDate) {
		this.hjDate = hjDate;
	}
	public String getHjSpecies() {
		return hjSpecies;
	}
	public void setHjSpecies(String hjSpecies) {
		this.hjSpecies = hjSpecies;
	}
	public Float getHjPrice() {
		return hjPrice;
	}
	public void setHjPrice(Float hjPrice) {
		this.hjPrice = hjPrice;
	}
	public Integer getHjNumber() {
		return hjNumber;
	}
	public void setHjNumber(Integer hjNumber) {
		this.hjNumber = hjNumber;
	}
	public Float getHjTotalPrice() {
		return hjTotalPrice;
	}
	public void setHjTotalPrice(Float hjTotalPrice) {
		this.hjTotalPrice = hjTotalPrice;
	}
	public String getHjFrom() {
		return hjFrom;
	}
	public void setHjFrom(String hjFrom) {
		this.hjFrom = hjFrom;
	}
	public Boolean getHjStorageState() {
		return hjStorageState;
	}
	public void setHjStorageState(Boolean hjStorageState) {
		this.hjStorageState = hjStorageState;
	}
	public String getHjNote() {
		return hjNote;
	}
	public void setHjNote(String hjNote) {
		this.hjNote = hjNote;
	}
	@Override
	public String toString() {
		return "HjPurchase [id=" + id + ", hjDate=" + hjDate + ", hjSpecies=" + hjSpecies + ", hjPrice=" + hjPrice
				+ ", hjNumber=" + hjNumber + ", hjTotalPrice=" + hjTotalPrice + ", hjFrom=" + hjFrom
				+ ", hjStorageState=" + hjStorageState + ", hjNote=" + hjNote + "]";
	}
	
}

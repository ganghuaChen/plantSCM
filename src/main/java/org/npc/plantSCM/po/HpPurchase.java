package org.npc.plantSCM.po;

public class HpPurchase {
	private Integer id;//记录id
	private String hpDate;//采购日期
	private String hpShape;//形状
	private String hpModel;//型号
	private String hpSpec;//规格
	private Float hpPrice;//单价
	private Float hpWeight;//数量
	private Float hpTotalPrice;//总价
	private String hpFactory;//厂家
	private String hpNote;//备注
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getHpDate() {
		return hpDate;
	}
	public void setHpDate(String hpDate) {
		this.hpDate = hpDate;
	}
	public String getHpShape() {
		return hpShape;
	}
	public void setHpShape(String hpShape) {
		this.hpShape = hpShape;
	}
	public String getHpModel() {
		return hpModel;
	}
	public void setHpModel(String hpModel) {
		this.hpModel = hpModel;
	}
	public String getHpSpec() {
		return hpSpec;
	}
	public void setHpSpec(String hpSpec) {
		this.hpSpec = hpSpec;
	}
	public Float getHpPrice() {
		return hpPrice;
	}
	public void setHpPrice(Float hpPrice) {
		this.hpPrice = hpPrice;
	}

	public Float getHpWeight() {
		return hpWeight;
	}
	public void setHpWeight(Float hpWeight) {
		this.hpWeight = hpWeight;
	}
	public Float getHpTotalPrice() {
		return hpTotalPrice;
	}
	public void setHpTotalPrice(Float hpTotalPrice) {
		this.hpTotalPrice = hpTotalPrice;
	}
	public String getHpFactory() {
		return hpFactory;
	}
	public void setHpFactory(String hpFactory) {
		this.hpFactory = hpFactory;
	}
	public String getHpNote() {
		return hpNote;
	}
	public void setHpNote(String hpNote) {
		this.hpNote = hpNote;
	}
	@Override
	public String toString() {
		return "HpPurchase [id=" + id + ", hpDate=" + hpDate + ", hpShape=" + hpShape + ", hpModel=" + hpModel
				+ ", hpSpec=" + hpSpec + ", hpPrice=" + hpPrice + ", hpWeight=" + hpWeight + ", hpTotalPrice="
				+ hpTotalPrice + ", hpFactory=" + hpFactory + ", hpNote=" + hpNote + "]";
	}

	
}

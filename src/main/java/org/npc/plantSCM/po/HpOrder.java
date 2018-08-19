package org.npc.plantSCM.po;

public class HpOrder {
	
	private Integer hporderId;//订单id
	private String hporderDate;//订单日期
	private String hpCustomerName;//收货单位
	private String hporderPhone;//联系电话
    private String hporderPerformer;//送货人
    private String hpdeliveryDate;//需送达日期
    private String hporderShape;//形态
    private String hporderSpec;//规格
    private String hporderModel;//型号',
    private Integer hporderNumber;//'应送数量
    private Integer hpsongchuNumber;//送出数量
    private Integer hpweisongNumber;//未送数量
    private String actualDate;//实际送达日期
    private Float hporderPrice;//单价
    private Float hporderTotalPrice;//总价
    private String hporderState;//订单状态
    private String hporderRemark;//订单备注

    
	public Integer getHporderId() {
		return hporderId;
	}
	public void setHporderId(Integer hporderId) {
		this.hporderId = hporderId;
	}
	public String getHporderDate() {
		return hporderDate;
	}
	public void setHporderDate(String hporderDate) {
		this.hporderDate = hporderDate;
	}
	public String getHpCustomerName() {
		return hpCustomerName;
	}
	public void setHpCustomerName(String hpCustomerName) {
		this.hpCustomerName = hpCustomerName;
	}
	public String getHporderPhone() {
		return hporderPhone;
	}
	public void setHporderPhone(String hporderPhone) {
		this.hporderPhone = hporderPhone;
	}
	public String getHporderPerformer() {
		return hporderPerformer;
	}
	public void setHporderPerformer(String hporderPerformer) {
		this.hporderPerformer = hporderPerformer;
	}
	public String getHpdeliveryDate() {
		return hpdeliveryDate;
	}
	public void setHpdeliveryDate(String hpdeliveryDate) {
		this.hpdeliveryDate = hpdeliveryDate;
	}
	public String getHporderShape() {
		return hporderShape;
	}
	public void setHporderShape(String hporderShape) {
		this.hporderShape = hporderShape;
	}
	public String getHporderSpec() {
		return hporderSpec;
	}
	public void setHporderSpec(String hporderSpec) {
		this.hporderSpec = hporderSpec;
	}
	public String getHporderModel() {
		return hporderModel;
	}
	public void setHporderModel(String hporderModel) {
		this.hporderModel = hporderModel;
	}
	public Integer getHporderNumber() {
		return hporderNumber;
	}
	public void setHporderNumber(Integer hporderNumber) {
		this.hporderNumber = hporderNumber;
	}
	public Integer getHpsongchuNumber() {
		return hpsongchuNumber;
	}
	public void setHpsongchuNumber(Integer hpsongchuNumber) {
		this.hpsongchuNumber = hpsongchuNumber;
	}
	public Integer getHpweisongNumber() {
		return hpweisongNumber;
	}
	public void setHpweisongNumber(Integer hpweisongNumber) {
		this.hpweisongNumber = hpweisongNumber;
	}
	public String getActualDate() {
		return actualDate;
	}
	public void setActualDate(String actualDate) {
		this.actualDate = actualDate;
	}
	public Float getHporderPrice() {
		return hporderPrice;
	}
	public void setHporderPrice(Float hporderPrice) {
		this.hporderPrice = hporderPrice;
	}
	public Float getHporderTotalPrice() {
		return hporderTotalPrice;
	}
	public void setHporderTotalPrice(Float hporderTotalPrice) {
		this.hporderTotalPrice = hporderTotalPrice;
	}
	public String getHporderState() {
		return hporderState;
	}
	public void setHporderState(String hporderState) {
		this.hporderState = hporderState;
	}
	public String getHporderRemark() {
		return hporderRemark;
	}
	public void setHporderRemark(String hporderRemark) {
		this.hporderRemark = hporderRemark;
	}
	@Override
	public String toString() {
		return "HpOrder [hporderId=" + hporderId + ", hporderDate=" + hporderDate + ", hpCustomerName=" + hpCustomerName
				+ ", hporderPhone=" + hporderPhone + ", hporderPerformer=" + hporderPerformer + ", hpdeliveryDate="
				+ hpdeliveryDate + ", hporderShape=" + hporderShape + ", hporderSpec=" + hporderSpec + ", hporderModel="
				+ hporderModel + ", hporderNumber=" + hporderNumber + ", hpsongchuNumber=" + hpsongchuNumber
				+ ", hpweisongNumber=" + hpweisongNumber + ", actualDate=" + actualDate + ", hporderPrice="
				+ hporderPrice + ", hporderTotalPrice=" + hporderTotalPrice + ", hporderState=" + hporderState
				+ ", hporderRemark=" + hporderRemark + "]";
	}


	
}

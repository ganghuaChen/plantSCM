package org.npc.plantSCM.po;

public class HpOut {

	private Integer id;
	private String outDate;//出厂日期
	private String outModel;//出厂产品型号
	private String outSpec;//出厂产品规格
	private Float outWeight;//出厂产品重量
	private String outShape;//出厂产品形状
	private Boolean outFlow;//出厂流向
	private String customerName;//收货单位
	private String customerPhone;//电话
	private Float price;//焊片单价
    private Float totalPrice;//焊片总价
    
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOutDate() {
		return outDate;
	}
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}
	public String getOutModel() {
		return outModel;
	}
	public void setOutModel(String outModel) {
		this.outModel = outModel;
	}
	public String getOutSpec() {
		return outSpec;
	}
	public void setOutSpec(String outSpec) {
		this.outSpec = outSpec;
	}
	public Float getOutWeight() {
		return outWeight;
	}
	public void setOutWeight(Float outWeight) {
		this.outWeight = outWeight;
	}
	public String getOutShape() {
		return outShape;
	}
	public void setOutShape(String outShape) {
		this.outShape = outShape;
	}
	public Boolean getOutFlow() {
		return outFlow;
	}
	public void setOutFlow(Boolean outFlow) {
		this.outFlow = outFlow;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerPhone() {
		return customerPhone;
	}
	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}
	
	public Float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	public Float getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Float totalPrice) {
		this.totalPrice = totalPrice;
	}
	@Override
	public String toString() {
		return "HpOut [id=" + id + ", outDate=" + outDate + ", outModel=" + outModel + ", outSpec=" + outSpec
				+ ", outWeight=" + outWeight + ", outShape=" + outShape + ", outFlow=" + outFlow + ", customerName="
				+ customerName + ", customerPhone=" + customerPhone + ", price=" + price + ", totalPrice=" + totalPrice
				+ "]";
	}
	
	
	
}

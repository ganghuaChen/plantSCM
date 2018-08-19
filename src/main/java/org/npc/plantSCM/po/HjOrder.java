package org.npc.plantSCM.po;

public class HjOrder {
	
	private Integer hjorderId;//订单id
	private String hjProductDate;//订单日期
    private String hjType;//焊剂种类
    private String hjCustomerName;//收货单位
    private String hjorderPhone;//联系电话

    private String hjdeliveryDate;//需送达日期
    private Integer hjorderNumber;//应送数量
    private Integer hjsongchuNumber;//送出数量',
    private Integer hjweisongNumber;//未送数量
    private String actualDate;//实际送达日期
    private String hjorderFactory;//厂家
    private Float hjorderPrice;//单价
    private Float hjorderTotalPrice;//总价
    private String hjorderState;//订单状态
    private String hjorderRemark;//订单备注

    
	public Integer getHjorderId() {
		return hjorderId;
	}
	public void setHjorderId(Integer hjorderId) {
		this.hjorderId = hjorderId;
	}
	public String getHjProductDate() {
		return hjProductDate;
	}
	public void setHjProductDate(String hjProductDate) {
		this.hjProductDate = hjProductDate;
	}
	public String getHjType() {
		return hjType;
	}
	public void setHjType(String hjType) {
		this.hjType = hjType;
	}
	public String getHjCustomerName() {
		return hjCustomerName;
	}
	public void setHjCustomerName(String hjCustomerName) {
		this.hjCustomerName = hjCustomerName;
	}
	public String getHjorderPhone() {
		return hjorderPhone;
	}
	public void setHjorderPhone(String hjorderPhone) {
		this.hjorderPhone = hjorderPhone;
	}
	public String getHjdeliveryDate() {
		return hjdeliveryDate;
	}
	public void setHjdeliveryDate(String hjdeliveryDate) {
		this.hjdeliveryDate = hjdeliveryDate;
	}
	public Integer getHjorderNumber() {
		return hjorderNumber;
	}
	public void setHjorderNumber(Integer hjorderNumber) {
		this.hjorderNumber = hjorderNumber;
	}

	public Integer getHjsongchuNumber() {
		return hjsongchuNumber;
	}
	public void setHjsongchuNumber(Integer hjsongchuNumber) {
		this.hjsongchuNumber = hjsongchuNumber;
	}
	public Integer getHjweisongNumber() {
		return hjweisongNumber;
	}
	public void setHjweisongNumber(Integer hjweisongNumber) {
		this.hjweisongNumber = hjweisongNumber;
	}
	public String getActualDate() {
		return actualDate;
	}
	public void setActualDate(String actualDate) {
		this.actualDate = actualDate;
	}
	public String getHjorderFactory() {
		return hjorderFactory;
	}
	public void setHjorderFactory(String hjorderFactory) {
		this.hjorderFactory = hjorderFactory;
	}
	public Float getHjorderPrice() {
		return hjorderPrice;
	}
	public void setHjorderPrice(Float hjorderPrice) {
		this.hjorderPrice = hjorderPrice;
	}
	public Float getHjorderTotalPrice() {
		return hjorderTotalPrice;
	}
	public void setHjorderTotalPrice(Float hjorderTotalPrice) {
		this.hjorderTotalPrice = hjorderTotalPrice;
	}
	public String getHjorderState() {
		return hjorderState;
	}
	public void setHjorderState(String hjorderState) {
		this.hjorderState = hjorderState;
	}
	public String getHjorderRemark() {
		return hjorderRemark;
	}
	public void setHjorderRemark(String hjorderRemark) {
		this.hjorderRemark = hjorderRemark;
	}
	@Override
	public String toString() {
		return "HjOrder [hjorderId=" + hjorderId + ", hjProductDate=" + hjProductDate + ", hjType=" + hjType
				+ ", hjCustomerName=" + hjCustomerName + ", hjorderPhone=" + hjorderPhone + ", hjdeliveryDate=" + hjdeliveryDate + ", hjorderNumber=" + hjorderNumber
				+ ", hjsongchuNumber=" + hjsongchuNumber + ", hjweisongNumber=" + hjweisongNumber + ", actualDate=" + actualDate
				+ ", hjorderFactory=" + hjorderFactory + ", hjorderPrice=" + hjorderPrice + ", hjorderTotalPrice="
				+ hjorderTotalPrice + ", hjorderState=" + hjorderState + ", hjorderRemark=" + hjorderRemark + "]";
	}

}

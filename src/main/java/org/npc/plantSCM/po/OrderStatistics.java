package org.npc.plantSCM.po;

public class OrderStatistics {
	private String customerName;//收货人
	private Integer hporderNumber;//焊片应送数量
    private Integer hpsongchuNumber;//焊片送出数量
    private Integer hjorderNumber;//焊剂应送数量
    private Integer hjsongchuNumber;//焊剂送出数量'
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
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
	@Override
	public String toString() {
		return "OrderStatistics [customerName=" + customerName + ", hporderNumber=" + hporderNumber
				+ ", hpsongchuNumber=" + hpsongchuNumber + ", hjorderNumber=" + hjorderNumber + ", hjsongchuNumber="
				+ hjsongchuNumber + "]";
	}


}

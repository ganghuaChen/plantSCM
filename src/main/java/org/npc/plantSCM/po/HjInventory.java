package org.npc.plantSCM.po;

public class HjInventory {
	
	private Integer hjkcId;
	private String hjType;//焊剂种类
	private String hjFactory;//采购的商家
	private Integer hjActualNumber;//库存数量
	public Integer getHjkcId() {
		return hjkcId;
	}
	public void setHjkcId(Integer hjkcId) {
		this.hjkcId = hjkcId;
	}
	public String getHjType() {
		return hjType;
	}
	public void setHjType(String hjType) {
		this.hjType = hjType;
	}
	public String getHjFactory() {
		return hjFactory;
	}
	public void setHjFactory(String hjFactory) {
		this.hjFactory = hjFactory;
	}
	public Integer getHjActualNumber() {
		return hjActualNumber;
	}
	public void setHjActualNumber(Integer hjActualNumber) {
		this.hjActualNumber = hjActualNumber;
	}
	@Override
	public String toString() {
		return "HjInventory [hjkcId=" + hjkcId + ", hjType=" + hjType + ", hjFactory=" + hjFactory
				+ ", hjActualNumber=" + hjActualNumber + "]";
	}
	

}

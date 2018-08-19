package org.npc.plantSCM.po;

public class MaterialInventory {
	
	private int ylId;
	private String ylType;//原料种类
	private float ylremainingInventory;//剩余库存
	private float ylAveragePrice;//平均价格

	public MaterialInventory() {		
	}
	
	public MaterialInventory(String type, float avPrice) {	
		this.ylType=type;
		this.ylAveragePrice=avPrice;
	}
	
	public float getYlAveragePrice() {
		return ylAveragePrice;
	}
	public void setYlAveragePrice(float ylAveragePrice) {
		this.ylAveragePrice = ylAveragePrice;
	}
	public int getYlId() {
		return ylId;
	}
	public void setYlId(int ylId) {
		this.ylId = ylId;
	}
	public String getYlType() {
		return ylType;
	}
	public void setYlType(String ylType) {
		this.ylType = ylType;
	}
	public float getYlremainingInventory() {
		return ylremainingInventory;
	}
	public void setYlremainingInventory(float ylremainingInventory) {
		this.ylremainingInventory = ylremainingInventory;
	}
	@Override
	public String toString() {
		return "MaterialInventory [ylId=" + ylId + ", ylType=" + ylType + ", ylremainingInventory="
				+ ylremainingInventory + ", ylAveragePrice=" + ylAveragePrice + "]";
	}

}

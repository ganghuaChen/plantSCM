package org.npc.plantSCM.po;

public class HpPurchaseStatistics {
	
	private String hpShape;//形状
	private String hpModel;//型号
	private String hpSpec;//规格
	private Float hpWeightStatistics;//数量
	private Float hpTotalPriceStatistics;//总价
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
	public Float getHpWeightStatistics() {
		return hpWeightStatistics;
	}
	public void setHpWeightStatistics(Float hpWeightStatistics) {
		this.hpWeightStatistics = hpWeightStatistics;
	}
	public Float getHpTotalPriceStatistics() {
		return hpTotalPriceStatistics;
	}
	public void setHpTotalPriceStatistics(Float hpTotalPriceStatistics) {
		this.hpTotalPriceStatistics = hpTotalPriceStatistics;
	}
	@Override
	public String toString() {
		return "HpPurchaseStatistics [hpShape=" + hpShape + ", hpModel=" + hpModel + ", hpSpec=" + hpSpec
				+ ", hpWeightStatistics=" + hpWeightStatistics + ", hpTotalPriceStatistics=" + hpTotalPriceStatistics
				+ "]";
	}

	
	

}

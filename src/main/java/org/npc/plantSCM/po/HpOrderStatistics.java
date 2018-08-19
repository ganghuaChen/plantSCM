package org.npc.plantSCM.po;

public class HpOrderStatistics {

    private String hporderShape;//形态
    private String hporderSpec;//规格
    private String hporderModel;//型号',
    private Integer hporderNumberStatistics ;//'应送重量
    private Float hporderTotalPriceStatistics ;//总价
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
	public Integer getHporderNumberStatistics() {
		return hporderNumberStatistics;
	}
	public void setHporderNumberStatistics(Integer hporderNumberStatistics) {
		this.hporderNumberStatistics = hporderNumberStatistics;
	}
	public Float getHporderTotalPriceStatistics() {
		return hporderTotalPriceStatistics;
	}
	public void setHporderTotalPriceStatistics(Float hporderTotalPriceStatistics) {
		this.hporderTotalPriceStatistics = hporderTotalPriceStatistics;
	}
	@Override
	public String toString() {
		return "HpOrderStatistics [hporderShape=" + hporderShape + ", hporderSpec=" + hporderSpec + ", hporderModel="
				+ hporderModel + ", hporderNumberStatistics=" + hporderNumberStatistics
				+ ", hporderTotalPriceStatistics=" + hporderTotalPriceStatistics + "]";
	}

}

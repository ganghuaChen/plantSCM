package org.npc.plantSCM.po;

public class HjPurchaseStatistics {
	private String hjSpecies;//焊剂种类
	private Integer hjNumberStatistics;
	private Float hjTotalPriceStatistics;
	public Integer getHjNumberStatistics() {
		return hjNumberStatistics;
	}
	public void setHjNumberStatistics(Integer hjNumberStatistics) {
		this.hjNumberStatistics = hjNumberStatistics;
	}
	public Float getHjTotalPriceStatistics() {
		return hjTotalPriceStatistics;
	}
	public void setHjTotalPriceStatistics(Float hjTotalPriceStatistics) {
		this.hjTotalPriceStatistics = hjTotalPriceStatistics;
	}
	public String getHjSpecies() {
		return hjSpecies;
	}
	public void setHjSpecies(String hjSpecies) {
		this.hjSpecies = hjSpecies;
	}
	@Override
	public String toString() {
		return "HjPurchaseStatistics [hjSpecies=" + hjSpecies + ", hjNumberStatistics=" + hjNumberStatistics
				+ ", hjTotalPriceStatistics=" + hjTotalPriceStatistics + "]";
	}
	
	
}

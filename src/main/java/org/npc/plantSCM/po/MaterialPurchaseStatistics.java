package org.npc.plantSCM.po;

public class MaterialPurchaseStatistics {
	private String ylSpecies;//种类
	private Float ylWeightStatistics;
	private Float ylTotalPriceStatistics;
	public Float getYlWeightStatistics() {
		return ylWeightStatistics;
	}
	public void setYlWeightStatistics(Float ylWeightStatistics) {
		this.ylWeightStatistics = ylWeightStatistics;
	}
	public Float getYlTotalPriceStatistics() {
		return ylTotalPriceStatistics;
	}
	public void setYlTotalPriceStatistics(Float ylTotalPriceStatistics) {
		this.ylTotalPriceStatistics = ylTotalPriceStatistics;
	}
	public String getYlSpecies() {
		return ylSpecies;
	}
	public void setYlSpecies(String ylSpecies) {
		this.ylSpecies = ylSpecies;
	}
	@Override
	public String toString() {
		return "MaterialPurchaseStatistics [ylSpecies=" + ylSpecies + ", ylWeightStatistics=" + ylWeightStatistics
				+ ", ylTotalPriceStatistics=" + ylTotalPriceStatistics + "]";
	}
	
	

}

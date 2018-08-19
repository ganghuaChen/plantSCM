package org.npc.plantSCM.po;

public class HjOrderStatistics {
	
    private String hjType;//焊剂种类
    private Integer hjorderNumberStatistics;//应送数量
    private Float hjorderTotalPriceStatistics;//总价
	public String getHjType() {
		return hjType;
	}
	public Integer getHjorderNumberStatistics() {
		return hjorderNumberStatistics;
	}
	public void setHjorderNumberStatistics(Integer hjorderNumberStatistics) {
		this.hjorderNumberStatistics = hjorderNumberStatistics;
	}
	public Float getHjorderTotalPriceStatistics() {
		return hjorderTotalPriceStatistics;
	}
	public void setHjorderTotalPriceStatistics(Float hjorderTotalPriceStatistics) {
		this.hjorderTotalPriceStatistics = hjorderTotalPriceStatistics;
	}
	public void setHjType(String hjType) {
		this.hjType = hjType;
	}
	@Override
	public String toString() {
		return "HjOrderStatistics [hjType=" + hjType + ", hjorderNumberStatistics=" + hjorderNumberStatistics
				+ ", hjorderTotalPriceStatistics=" + hjorderTotalPriceStatistics + "]";
	}
	
    

}

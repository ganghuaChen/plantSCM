package org.npc.plantSCM.po;

//送货统计
public class SonghuoStatistics {
	
	private String customerName;
    private Integer hporderNumberStatistics;//'应送数量
    private Integer hpsongchuNumberStatistics;//送出数量
    private Integer hjorderNumberStatistics;//应送数量
    private Integer hjsongchuNumberStatistics;//送出数量

	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public Integer getHporderNumberStatistics() {
		return hporderNumberStatistics;
	}
	public void setHporderNumberStatistics(Integer hporderNumberStatistics) {
		this.hporderNumberStatistics = hporderNumberStatistics;
	}
	public Integer getHpsongchuNumberStatistics() {
		return hpsongchuNumberStatistics;
	}
	public void setHpsongchuNumberStatistics(Integer hpsongchuNumberStatistics) {
		this.hpsongchuNumberStatistics = hpsongchuNumberStatistics;
	}
	public Integer getHjorderNumberStatistics() {
		return hjorderNumberStatistics;
	}
	public void setHjorderNumberStatistics(Integer hjorderNumberStatistics) {
		this.hjorderNumberStatistics = hjorderNumberStatistics;
	}
	public Integer getHjsongchuNumberStatistics() {
		return hjsongchuNumberStatistics;
	}
	public void setHjsongchuNumberStatistics(Integer hjsongchuNumberStatistics) {
		this.hjsongchuNumberStatistics = hjsongchuNumberStatistics;
	}
	@Override
	public String toString() {
		return "SonghuoStatistics [customerName=" + customerName + ", hporderNumberStatistics="
				+ hporderNumberStatistics + ", hpsongchuNumberStatistics=" + hpsongchuNumberStatistics
				+ ", hjorderNumberStatistics=" + hjorderNumberStatistics + ", hjsongchuNumberStatistics="
				+ hjsongchuNumberStatistics + "]";
	}

	
}

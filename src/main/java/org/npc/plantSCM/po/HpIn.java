package org.npc.plantSCM.po;

public class HpIn {

	private Integer id;//入库记录id
	private String hpstorageDate;//入库日期,
	private String hpModel;//入库产品型号
    private String hpSpec;//入库产品规格
    private Float hpstorageWeight;//入库产品重量
    private String hpShape;//入库产品形状
    private Boolean hpFrom;//来源',
    private Boolean hpstorageState;//入库状态
    private Integer hpOutId;//对应唯一一条出厂记录
    private Integer hpPurchaseId;//或者对应唯一一条采购记录
    
    

	public Integer getHpOutId() {
		return hpOutId;
	}
	public void setHpOutId(Integer hpOutId) {
		this.hpOutId = hpOutId;
	}
	public Integer getHpPurchaseId() {
		return hpPurchaseId;
	}
	public void setHpPurchaseId(Integer hpPurchaseId) {
		this.hpPurchaseId = hpPurchaseId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getHpstorageDate() {
		return hpstorageDate;
	}
	public void setHpstorageDate(String hpstorageDate) {
		this.hpstorageDate = hpstorageDate;
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
	public Float getHpstorageWeight() {
		return hpstorageWeight;
	}
	public void setHpstorageWeight(Float hpstorageWeight) {
		this.hpstorageWeight = hpstorageWeight;
	}
	public String getHpShape() {
		return hpShape;
	}
	public void setHpShape(String hpShape) {
		this.hpShape = hpShape;
	}
	public Boolean getHpFrom() {
		return hpFrom;
	}
	public void setHpFrom(Boolean hpFrom) {
		this.hpFrom = hpFrom;
	}
	public Boolean getHpstorageState() {
		return hpstorageState;
	}
	public void setHpstorageState(Boolean hpstorageState) {
		this.hpstorageState = hpstorageState;
	}
	@Override
	public String toString() {
		return "HpIn [id=" + id + ", hpstorageDate=" + hpstorageDate + ", hpModel=" + hpModel + ", hpSpec=" + hpSpec
				+ ", hpstorageWeight=" + hpstorageWeight + ", hpShape=" + hpShape + ", hpFrom=" + hpFrom
				+ ", hpstorageState=" + hpstorageState + ", hpOutId=" + hpOutId + ", hpPurchaseId=" + hpPurchaseId
				+ "]";
	}
	

    
}

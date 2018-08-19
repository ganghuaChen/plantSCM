package org.npc.plantSCM.po;


//开炉记录
public class OpenFactory {
	
	private Integer id;
	private String model;//型号
	private String openDate;//开炉日期
	private Float agWeight;//银重量
	private Float cuWeight;//铜重量
	private Float znWeight;//锌重量
	private Float cdWeight;//镉重量
	private Float snWeight;//锡重量
	private Float batchYlWeight;//每批次原料消耗总量
	private Float wasteWeight;//添加的废料重量
	private Float batchBlanksWeight;//胚料重量
	private Integer fireNumber;//炉数
	private Float averageConsume;//每炉平均损耗
	private Float proportion;//总产出比
	
	public OpenFactory(){};
	
	public OpenFactory(OpenFactory openFactory)
	{
		this.id=openFactory.id;
		this.model=openFactory.model;//型号
		this.openDate=openFactory.openDate;//开炉日期
		this.agWeight=openFactory.agWeight;//银重量
		this.cuWeight=openFactory.cuWeight;//铜重量
		this.znWeight=openFactory.znWeight;//锌重量
		this.cdWeight=openFactory.cdWeight;//镉重量
		this.snWeight=openFactory.snWeight;//锡重量
		this.batchYlWeight=openFactory.batchYlWeight;//每批次原料消耗总量
		this.wasteWeight=openFactory.wasteWeight;//添加的废料重量
		this.batchBlanksWeight=openFactory.batchBlanksWeight;//胚料重量
		this.fireNumber=openFactory.fireNumber;//炉数
		this.averageConsume=openFactory.averageConsume;//每炉平均损耗
		this.proportion=openFactory.proportion;//总产出比
	}

	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public Float getAgWeight() {
		return agWeight;
	}
	public void setAgWeight(Float agWeight) {
		this.agWeight = agWeight;
	}
	public Float getCuWeight() {
		return cuWeight;
	}
	public void setCuWeight(Float cuWeight) {
		this.cuWeight = cuWeight;
	}
	public Float getZnWeight() {
		return znWeight;
	}
	public void setZnWeight(Float znWeight) {
		this.znWeight = znWeight;
	}
	public Float getCdWeight() {
		return cdWeight;
	}
	public void setCdWeight(Float cdWeight) {
		this.cdWeight = cdWeight;
	}
	public Float getSnWeight() {
		return snWeight;
	}
	public void setSnWeight(Float snWeight) {
		this.snWeight = snWeight;
	}
	public Float getBatchYlWeight() {
		return batchYlWeight;
	}
	public void setBatchYlWeight(Float batchYlWeight) {
		this.batchYlWeight = batchYlWeight;
	}
	public Float getWasteWeight() {
		return wasteWeight;
	}
	public void setWasteWeight(Float wasteWeight) {
		this.wasteWeight = wasteWeight;
	}
	public Float getBatchBlanksWeight() {
		return batchBlanksWeight;
	}
	public void setBatchBlanksWeight(Float batchBlanksWeight) {
		this.batchBlanksWeight = batchBlanksWeight;
	}
	public Integer getFireNumber() {
		return fireNumber;
	}
	public void setFireNumber(Integer fireNumber) {
		this.fireNumber = fireNumber;
	}
	
	public Float getAverageConsume() {
		return averageConsume;
	}
	public void setAverageConsume(Float averageConsume) {
		this.averageConsume = averageConsume;
	}
	public Float getProportion() {
		return proportion;
	}
	public void setProportion(Float proportion) {
		this.proportion = proportion;
	}
	@Override
	public String toString() {
		return "OpenFactory [id=" + id + ", model=" + model + ", openDate=" + openDate + ", agWeight=" + agWeight
				+ ", cuWeight=" + cuWeight + ", znWeight=" + znWeight + ", cdWeight=" + cdWeight + ", snWeight="
				+ snWeight + ", batchYlWeight=" + batchYlWeight + ", wasteWeight=" + wasteWeight
				+ ", batchBlanksWeight=" + batchBlanksWeight + ", fireNumber=" + fireNumber + ", averageConsume="
				+ averageConsume + ", proportion=" + proportion + "]";
	}
	
	
	
	
	

}

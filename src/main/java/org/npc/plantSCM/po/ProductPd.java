package org.npc.plantSCM.po;

public class ProductPd {
    private Integer id;//记录id
	private String model;//型号
	private String inventoryDate;//盘点时间
	private Float beforeBlanks;//生产前胚料重量
	private Float beforeWaste;//生产前废料重量
	private Float beforeBulk;//生产前散料重量
	private Float beforeSemi;//生产前半成品重量
	private Float beforeProduct;//T生产前成品总重
	private Float beforeDailiao;//生产前呆料
	private Float beforeTotal;//生产前总重量
	private Integer afterSale;//生产后销售重量
	private Float afterWaste;//生产后废料重量
	private Float afterBulk;//生产后散料重量
	private Float afterSemi;//生产后半成品重量
	private Float afterProduct;//生产后成品总重
	private Float afterDailiao;//生产后呆料
	private Float afterTotal;//生产后总重量
	private Float dValue;//差值

	public Float getdValue() {
		return dValue;
	}
	public void setdValue(Float dValue) {
		this.dValue = dValue;
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
	public String getInventoryDate() {
		return inventoryDate;
	}
	public void setInventoryDate(String inventoryDate) {
		this.inventoryDate = inventoryDate;
	}
	public Float getBeforeBlanks() {
		return beforeBlanks;
	}
	public void setBeforeBlanks(Float beforeBlanks) {
		this.beforeBlanks = beforeBlanks;
	}
	public Float getBeforeWaste() {
		return beforeWaste;
	}
	public void setBeforeWaste(Float beforeWaste) {
		this.beforeWaste = beforeWaste;
	}
	public Float getBeforeBulk() {
		return beforeBulk;
	}
	public void setBeforeBulk(Float beforeBulk) {
		this.beforeBulk = beforeBulk;
	}
	public Float getBeforeSemi() {
		return beforeSemi;
	}
	public void setBeforeSemi(Float beforeSemi) {
		this.beforeSemi = beforeSemi;
	}
	public Float getBeforeProduct() {
		return beforeProduct;
	}
	public void setBeforeProduct(Float beforeProduct) {
		this.beforeProduct = beforeProduct;
	}
	public Float getBeforeDailiao() {
		return beforeDailiao;
	}
	public void setBeforeDailiao(Float beforeDailiao) {
		this.beforeDailiao = beforeDailiao;
	}
	public Float getBeforeTotal() {
		return beforeTotal;
	}
	public void setBeforeTotal(Float beforeTotal) {
		this.beforeTotal = beforeTotal;
	}

	public Integer getAfterSale() {
		return afterSale;
	}
	public void setAfterSale(Integer afterSale) {
		this.afterSale = afterSale;
	}
	public Float getAfterWaste() {
		return afterWaste;
	}
	public void setAfterWaste(Float afterWaste) {
		this.afterWaste = afterWaste;
	}
	public Float getAfterBulk() {
		return afterBulk;
	}
	public void setAfterBulk(Float afterBulk) {
		this.afterBulk = afterBulk;
	}
	public Float getAfterSemi() {
		return afterSemi;
	}
	public void setAfterSemi(Float afterSemi) {
		this.afterSemi = afterSemi;
	}
	public Float getAfterProduct() {
		return afterProduct;
	}
	public void setAfterProduct(Float afterProduct) {
		this.afterProduct = afterProduct;
	}
	public Float getAfterDailiao() {
		return afterDailiao;
	}
	public void setAfterDailiao(Float afterDailiao) {
		this.afterDailiao = afterDailiao;
	}
	public Float getAfterTotal() {
		return afterTotal;
	}
	public void setAfterTotal(Float afterTotal) {
		this.afterTotal = afterTotal;
	}
	@Override
	public String toString() {
		return "ProductPd [id=" + id + ", model=" + model + ", inventoryDate=" + inventoryDate + ", beforeBlanks="
				+ beforeBlanks + ", beforeWaste=" + beforeWaste + ", beforeBulk=" + beforeBulk + ", beforeSemi="
				+ beforeSemi + ", beforeProduct=" + beforeProduct + ", beforeDailiao=" + beforeDailiao
				+ ", beforeTotal=" + beforeTotal + ", afterSale=" + afterSale + ", afterWaste=" + afterWaste
				+ ", afterBulk=" + afterBulk + ", afterSemi=" + afterSemi + ", afterProduct=" + afterProduct
				+ ", afterDailiao=" + afterDailiao + ", afterTotal=" + afterTotal + ", dValue=" + dValue + "]";
	}
	
	


}

package org.npc.plantSCM.po;

public class HpInventory {
	private Integer hpkcId;
	private String model;
	private String shape;
	private String spec;
	private Float actualNumber;
	
	public Integer getHpkcId() {
		return hpkcId;
	}
	public void setHpkcId(Integer hpkcId) {
		this.hpkcId = hpkcId;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getShape() {
		return shape;
	}
	public void setShape(String shape) {
		this.shape = shape;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}

	public Float getActualNumber() {
		return actualNumber;
	}
	public void setActualNumber(Float actualNumber) {
		this.actualNumber = actualNumber;
	}
	@Override
	public String toString() {
		return "hpInventory [hpkcId=" + hpkcId + ", model=" + model + ", shape=" + shape + ", spec=" + spec
				+ ", actualNumber=" + actualNumber + "]";
	}

}

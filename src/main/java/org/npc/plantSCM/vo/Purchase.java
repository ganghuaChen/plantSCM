package org.npc.plantSCM.vo;

import java.util.List;

import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpPurchase;
import org.npc.plantSCM.po.MaterialPurchase;

public class Purchase {
	private List<MaterialPurchase> materialPurchase;
	private List<HjPurchase> hjPurchase;
	private List<HpPurchase> hpPurchase;
	public List<MaterialPurchase> getMaterialPurchase() {
		return materialPurchase;
	}
	public void setMaterialPurchase(List<MaterialPurchase> materialPurchase) {
		this.materialPurchase = materialPurchase;
	}
	public List<HjPurchase> getHjPurchase() {
		return hjPurchase;
	}
	public void setHjPurchase(List<HjPurchase> hjPurchase) {
		this.hjPurchase = hjPurchase;
	}
	public List<HpPurchase> getHpPurchase() {
		return hpPurchase;
	}
	public void setHpPurchase(List<HpPurchase> hpPurchase) {
		this.hpPurchase = hpPurchase;
	}
	@Override
	public String toString() {
		return "Purchase [materialPurchase=" + materialPurchase + ", hjPurchase=" + hjPurchase + ", hpPurchase="
				+ hpPurchase + "]";
	}
	
}

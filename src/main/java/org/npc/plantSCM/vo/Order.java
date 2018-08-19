package org.npc.plantSCM.vo;

import java.util.ArrayList;

import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpOrder;

public class Order {
	private ArrayList<HjOrder> hjOrder;
	private ArrayList<HpOrder> hpOrder;
	@Override
	public String toString() {
		return "Order [hjOrder=" + hjOrder + ", hpOrder=" + hpOrder + "]";
	}
	public ArrayList<HjOrder> getHjOrder() {
		return hjOrder;
	}
	public void setHjOrder(ArrayList<HjOrder> hjOrder) {
		this.hjOrder = hjOrder;
	}
	public ArrayList<HpOrder> getHpOrder() {
		return hpOrder;
	}
	public void setHpOrder(ArrayList<HpOrder> hpOrder) {
		this.hpOrder = hpOrder;
	}
}

package org.npc.plantSCM.service;

import java.util.List;

import org.npc.plantSCM.po.MaterialInventory;
import org.npc.plantSCM.po.ProductPd;
import org.npc.plantSCM.vo.CommonDTO;

public interface FactoryPdService {

	public CommonDTO createPdRecord(List<ProductPd> list);//新增工厂模块盘点清仓
	public CommonDTO modifyPdRecord(ProductPd productpd);//新增工厂模块修改盘点清仓记录
	public CommonDTO getPdRecord(String beginDate, String endDate,String Model);//根据搜索条件返回指定的盘点清仓记录，Controller调用记得加上默认参数,并告知Dao管理员默认值
	
	public CommonDTO modifyMaterialInventory(MaterialInventory materialInventory);//修改原料库存
	public CommonDTO getMaterialInventory();//查看原料库存
	
}

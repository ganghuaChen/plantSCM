package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HpInventory;

public interface HpInventoryDao {
	
	//获取型号(搜索条件的显示）
	List<String> getModel();
	
	//获取规格
	List<String> getSpec();
	
	//跟据形状、规格、型号获取库存记录
	List<HpInventory> getHpInventoryByHp(@Param("shape") String shape,
			                             @Param("model") String model,
			                             @Param("spec") String spec);
	
	//新建库存记录
	void insertHpInventory(HpInventory hpInventory);
	
	//修改库存记录
	void updateHpInventory(HpInventory hpInventory);
	
	HpInventory checkHpInventory(int id);

}

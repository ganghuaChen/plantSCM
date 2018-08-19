package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HjInventory;

public interface HjInventoryDao {
	
	//根据厂家获取库存
	List<HjInventory> getHjInventoryByFactory(@Param("hjFactory")String hjFactory);
	
	//显示所有厂家
	List<String> getHjFactory();
	
	//新建库存记录
	void insertHjInventory(HjInventory hjInventory);
	
	//修改库存记录
	void updateHjInventory(HjInventory hjInventory);
	
	//根据厂家种类获取焊剂库存信息
	List<HjInventory> getHjInventoryByFactoryAndType(@Param("hjFactory")String hjFactory,
			                                         @Param("hjType") String hjType);

	//在修改采购单的时候看看是否已经入库
	boolean whetherRuku(int id);
	
	HjInventory checkHjInventory(int id);

}

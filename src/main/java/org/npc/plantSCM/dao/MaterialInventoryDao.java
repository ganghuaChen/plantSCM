package org.npc.plantSCM.dao;

import org.apache.ibatis.annotations.Param;

public interface MaterialInventoryDao {
	
	//根据种类查询原料库存
	Float getYlremainingInventoryByYlType(String YlType);
	
	//修改原料库存数量
	void modifyYlremainingInventoryByYlType (@Param("ylType") String ylTyp,
			                                 @Param("num") Float num);
	

}

package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.OpenFactory;

public interface OpenFactoryDao {
		
	//根据起始时间、终止日期和型号获取开炉记录
	List<OpenFactory> getOpenFactoryByDateAndModel(@Param("model") String model,
			                                       @Param("beginDate") String beginDate,
			                                       @Param("endDate") String endDate);
	
	//创建一条新的开炉记录
	void insertOpenFactory(OpenFactory openFactory);
	
	//更新一条开炉记录
	void updateOpenFactory(OpenFactory openFactory);
	
	//查找需要修改的记录
	OpenFactory checkOpenFactory(OpenFactory openFactory);
	
   
}

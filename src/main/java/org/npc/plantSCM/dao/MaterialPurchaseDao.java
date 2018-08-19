package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.MaterialPurchase;
import org.npc.plantSCM.po.MaterialPurchaseStatistics;

public interface MaterialPurchaseDao {
	
	//根据日期、厂家、种类获取采购记录
	List<MaterialPurchase> getMaterialPurchase(@Param("ylFactory") String ylFactory,
			                                   @Param("ylSpecies") String ylSpecies,
			                                   @Param("beginDate") String beginDate,
			                                   @Param("endDate") String endDate);
	//新建采购记录
	void insertMaterialPurchase(MaterialPurchase materialPurchase);
	
	//修改采购记录
	void updateMaterialPurchase(MaterialPurchase materialPurchase);
	
	//根据id找到原来的重量
	Float getMaterialPurchasebyId(Integer id);
	
	//根据采购时间获取统计
	List<MaterialPurchaseStatistics> getMaterialPurchaseStatistics(
			                                                 @Param("beginDate") String beginDate,
                                                             @Param("endDate") String endDate);

}

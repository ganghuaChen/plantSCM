package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HjPurchaseStatistics;

public interface HjPurchaseDao {
	
	//新建入库记录
	void insertHjPurchase(HjPurchase hjPurchase);
	
	//根据厂家获取购买记录
	List<HjPurchase> getHjPurchase(@Param("hjFrom") String hjFrom,
			                       @Param("beginDate") String beginDate,
                                   @Param("endDate") String endDate);
	//根据厂家状态获取入库记录
	List<HjPurchase> getHjRuKu(@Param("hjFrom") String hjFrom,
            @Param("hjStorageState") Boolean hjStorageState,
            @Param("beginDate") String beginDate,
            @Param("endDate") String endDate);
	
	void updateHjPurchase(HjPurchase hjPurchase);
	
	//查找需要修改的记录
	HjPurchase checkHjPurchase(HjPurchase hjPurchase);
	
	//根据日期获取统计信息
	List<HjPurchaseStatistics> getHjPurchaseStatistics( @Param("beginDate") String beginDate,
                                                 @Param("endDate") String endDate);
}

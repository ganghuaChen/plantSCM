package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HpPurchase;
import org.npc.plantSCM.po.HpPurchaseStatistics;

public interface HpPurchaseDao {
	
	//根据厂家日期获取购买记录
	List<HpPurchase> getHpPurchase(@Param("hpFactory") String hpFactory,
			                       @Param("beginDate") String beginDate,
                                   @Param("endDate") String endDate);
	
	void insertHpPurchase(HpPurchase hpPurchase);
	
	void updateHpPurchase(HpPurchase hpPurchase);
	
	//获取统计信息
	List<HpPurchaseStatistics> getHpPurchaseStatistics(@Param("beginDate") String beginDate,
                                                       @Param("endDate") String endDate);

}

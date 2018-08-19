package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HjOrderStatistics;

public interface HjOrderDao {
	
	//根据收货人日期状态获取焊剂订单和送货单
	List<HjOrder> getHjOrder(@Param("hjCustomerName") String hjCustomerName,
			                 @Param("hjorderState") String hjorderState,
			                 @Param("beginDate") String beginDate,
			                 @Param("endDate") String endDate);
	
	//插入新焊剂订单和送货单
	void insertHjOrder(HjOrder hjOrder);
	
	//修改订单，和送货单(即删除送货单)
	void updateHjOrder(HjOrder hjOrder);
	
	//获取统计信息
	List<HjOrderStatistics> getHjOrderStatistics(@Param("beginDate") String beginDate,
                                           @Param("endDate") String endDate);
	
	HjOrder checkHjOrder(HjOrder hjOrder);

}

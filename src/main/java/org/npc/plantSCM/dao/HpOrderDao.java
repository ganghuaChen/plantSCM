package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.po.HpOrderStatistics;

public interface HpOrderDao {
	
	//获取订单或送货单
	List<HpOrder> getHpOrder(@Param("hpCustomerName") String hpCustomerName,
			                 @Param("hporderShape") String hporderShape,
			                 @Param("hporderModel") String hporderModel,
			                 @Param("hporderState") String hporderState,
			                 @Param("beginDate") String beginDate,
			                 @Param("endDate") String endDate);
	
	//修改订单或送货单
	void updateHpOrder(HpOrder hpOrder);
	
	//新建订单或送货单
	void insertHpOrder(HpOrder hpOrder);
	
	//获取统计数量
	List<HpOrderStatistics> getHpOrderStatistics(
                                           @Param("beginDate") String beginDate,
                                           @Param("endDate") String endDate);
   
	HpOrder checkHpOrder(HpOrder hpOrder);
	
}

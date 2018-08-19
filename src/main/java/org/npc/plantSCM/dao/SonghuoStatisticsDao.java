package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.SonghuoStatistics;

public interface SonghuoStatisticsDao {
	
	//获取每一收货人的统计信息
	SonghuoStatistics getSonghuoStatistics(@Param("customerName") String customerName,
			                               @Param("beginDate") String beginDate,
                                           @Param("endDate") String endDate);
	//获取所有收货人
	List<String> getAllCustomerName();
 

}

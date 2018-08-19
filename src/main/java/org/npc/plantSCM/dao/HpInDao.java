package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HpIn;

public interface HpInDao {
	
	//新建入库记录
	void insertHpIn(HpIn hpIn);
	
	//根据日期、形状型号规格查询入库记录
	List<HpIn> getHpIn(@Param("beginDate") String beginDate,@Param("endDate") String endDate,
				       @Param("hpShape") String hpShape,@Param("hpModel") String hpModel,
				       @Param("hpstorageState") Boolean hpstorageState);	
	//修改
	void updateHpIn(HpIn hpIn);
	
	//查找需要修改的记录
	HpIn checkHpInByOutId(int id);
	HpIn checkHpInByPurchaseId(int id);

	//根据外键hpOutId删除焊片入库记录
	void deleteHpIn(int id);

}

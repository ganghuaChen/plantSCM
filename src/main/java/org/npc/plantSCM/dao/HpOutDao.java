package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HpOut;

public interface HpOutDao {
	
	//创建一条新的出厂记录
	void insertHpOut(HpOut hpOut);
	
	//根据日期、形状型号规格查询出厂记录
	List<HpOut> getHpOut(@Param("beginDate") String beginDate,@Param("endDate") String endDate,
			       @Param("outShape") String outShape,@Param("outModel") String outModel);
	
	//修改出厂记录
	void updateHpOut(HpOut hpOut);
	
	//查找需要修改的记录
	HpOut checkHpOut(HpOut hpOut);

}

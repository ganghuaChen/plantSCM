package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.Inform;

public interface InformDao {
	
	//根据日期获取通知列表
	List<Inform> getInform();
	
	//新建一条通知
	void insertInform(Inform inform);

}

package org.npc.plantSCM.service;

import org.npc.plantSCM.vo.CommonDTO;


public interface InformService {

	CommonDTO getInformation();//显示所有通知
	public void insertInfo(String informContent);//插入通知

}

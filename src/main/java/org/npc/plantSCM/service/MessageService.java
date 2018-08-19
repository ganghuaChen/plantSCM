package org.npc.plantSCM.service;

import java.util.List;

import org.npc.plantSCM.po.Phone;
import org.npc.plantSCM.vo.CommonDTO;

public interface MessageService {

	public CommonDTO setPhone(List<Phone> phone);
	public CommonDTO getPhone();
	public CommonDTO deletePhone(Integer phone);

	
	
	public void sendMsg(String name,String product, String judge);
	
}

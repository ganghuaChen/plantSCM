package org.npc.plantSCM.dao;

import java.util.List;

import org.npc.plantSCM.po.Phone;

public interface PhoneDao {
	
	List<Phone> getPhone();
	void insertPhone(Phone phone);
	void deletePhone(Integer phone);


}

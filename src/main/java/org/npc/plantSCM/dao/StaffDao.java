package org.npc.plantSCM.dao;

import java.util.List;

import org.npc.plantSCM.po.Permission;
import org.npc.plantSCM.po.Staff;

public interface StaffDao {
	
	//根据账号sAccount获取staff对象
	Staff getStaffBySAccount(String sAccount);
	
	
	//修改送货人手机号码
	void updateShouhuoPhone(String phone);
	
	//获取送货人手机
	String getPhone();

}

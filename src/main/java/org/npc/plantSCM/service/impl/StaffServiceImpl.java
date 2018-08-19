package org.npc.plantSCM.service.impl;

import org.npc.plantSCM.dao.StaffDao;
import org.npc.plantSCM.po.Staff;
import org.npc.plantSCM.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("staffService")
public class StaffServiceImpl implements StaffService{
	
	@Autowired
	StaffDao staffDao;
	
	@Override
	public Staff getStaffBySAccount(String sAccount) {
		return staffDao.getStaffBySAccount(sAccount);
	}

}

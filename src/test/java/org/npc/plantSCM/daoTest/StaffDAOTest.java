package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.StaffDao;
import org.npc.plantSCM.po.Permission;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//在spring容器下执行
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class StaffDAOTest {

	@Resource
	private StaffDao staffDao;
	
	
	@Before
	public void setUp() throws Exception {
	}
	
	@Test
	public void test() {
		System.out.println("员工："+staffDao.getStaffBySAccount("1"));
//		List<Permission> list  = staffDao.getPermissionBySAccount("1");
//		System.out.println("权限:"+list);
//		
	}

}

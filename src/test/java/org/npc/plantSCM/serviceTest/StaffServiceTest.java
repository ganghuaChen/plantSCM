package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;


import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.Staff;
import org.npc.plantSCM.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//在spring容器下执行
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class StaffServiceTest {

	@Autowired
	private StaffService staffService;
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		Staff staff=staffService.getStaffBySAccount("1");
		System.out.println(staff);
	}

}

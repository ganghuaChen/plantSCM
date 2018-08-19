package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.HjInventoryDao;
import org.npc.plantSCM.po.HjInventory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HjInventoryDaoTest {

	@Resource
	private HjInventoryDao hjInventoryDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
	    
		HjInventory h = new HjInventory();
		h.setHjkcId(3);
		h.setHjType("d");
		h.setHjFactory("深圳");
		h.setHjActualNumber(0);
		//hjInventoryDao.updateHjInventory(h);
		
		System.out.println(hjInventoryDao.getHjInventoryByFactory("all"));
	}

}

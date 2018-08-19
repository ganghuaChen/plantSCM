package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.HpInventoryDao;
import org.npc.plantSCM.po.HpInventory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HpInventoryDaoTest {

	@Resource
	private HpInventoryDao hpInventoryDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		System.out.println(hpInventoryDao.getModel());
		//System.out.println(hpInventoryDao.getSpec());
		
		HpInventory h = new HpInventory();
	    h.setHpkcId(9);
		h.setModel("A1");
		h.setShape("直");
		h.setSpec("8*8*8");
		h.setActualNumber(6F);
		//hpInventoryDao.updateHpInventory(h);
	    
		System.out.println(hpInventoryDao.getHpInventoryByHp("all", "all", "all"));
	}

}

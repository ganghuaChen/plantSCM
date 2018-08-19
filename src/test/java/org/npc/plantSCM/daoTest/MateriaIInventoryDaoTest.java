package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.MaterialInventoryDao;
import org.npc.plantSCM.po.MaterialInventory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class MateriaIInventoryDaoTest {

	@Resource
	private MaterialInventoryDao materialInventoryDao ;
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		materialInventoryDao.modifyYlremainingInventoryByYlType("银", 100f);
		System.out.println(materialInventoryDao.getYlremainingInventoryByYlType("银"));
	}

}

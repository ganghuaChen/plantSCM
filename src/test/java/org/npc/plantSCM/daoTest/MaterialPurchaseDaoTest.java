package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.MaterialPurchaseDao;
import org.npc.plantSCM.po.MaterialPurchase;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class MaterialPurchaseDaoTest {

	@Resource private MaterialPurchaseDao materiaIInventoryDao;
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		MaterialPurchase m = new MaterialPurchase();
		m.setId(1);
		m.setYlDate("2015-01-01");
		m.setYlSpecies("铜");
		m.setYlPrice(5f);
		m.setYlTotalPrice(500f);
		m.setYlWeight(100f);
		m.setYlFactory("佛山");
		m.setYlnote("");
		
		//materiaIInventoryDao.updateMaterialPurchase(m);
		
		//System.out.println(materiaIInventoryDao.getMaterialPurchase("all", "all", "2010-01-01", "2040-01-01"));
		
		System.out.println(materiaIInventoryDao.getMaterialPurchasebyId(1));
		
		System.out.println(materiaIInventoryDao.getMaterialPurchaseStatistics("2010-01-01", "2040-01-01"));
	}

}

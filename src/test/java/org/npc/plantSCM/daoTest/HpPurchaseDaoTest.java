package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.HpPurchaseDao;
import org.npc.plantSCM.po.HpPurchase;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HpPurchaseDaoTest {

	@Resource 
	private HpPurchaseDao hpPurchaseDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HpPurchase h = new HpPurchase();
		h.setId(3);
		h.setHpDate("2016-01-01");
		h.setHpShape("直");
		h.setHpModel("C");
		h.setHpSpec("2*2*2");
		h.setHpPrice(5f);
		h.setHpTotalPrice(500f);
		h.setHpWeight(100f);
		h.setHpFactory("广州");
		h.setHpNote("下次");
		
		
		//hpPurchaseDao.updateHpPurchase(h);
	    System.out.println(hpPurchaseDao.getHpPurchase("all", "2010-01-01", "2030-01-01"));	
	    System.out.println(hpPurchaseDao.getHpPurchaseStatistics("2010-01-01", "2030-01-01"));
	    
	}

}

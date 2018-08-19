package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.HjPurchaseDao;
import org.npc.plantSCM.po.HjPurchase;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HjPurchaseDaoTest {

	@Resource 
	private HjPurchaseDao hjPurchaseDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HjPurchase h = new HjPurchase();
		h.setId(1);
		h.setHjDate("2018-01-01");
		h.setHjSpecies("a");
		h.setHjPrice(6f);
		h.setHjNumber(100);
		h.setHjTotalPrice(600f);
		h.setHjFrom("广州");
		h.setHjStorageState(false);
		h.setHjNote("");
		
		//hjPurchaseDao.updateHjPurchase(h);
		System.out.println(hjPurchaseDao.getHjPurchase("all","2010-01-01","2019-01-01"));
		System.out.println(hjPurchaseDao.getHjPurchaseStatistics("2010-01-01", "2019-01-01"));
	}

}

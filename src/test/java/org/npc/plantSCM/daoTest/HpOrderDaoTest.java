package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;


import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.HpOrderDao;
import org.npc.plantSCM.po.HpOrder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HpOrderDaoTest {

	@Resource
	private HpOrderDao hpOrderDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HpOrder h = new HpOrder();
		h.setHporderId(2);
		h.setHporderDate("2018-01-01");
		h.setHpCustomerName("lzt");
		h.setHporderPhone("");
		h.setHporderPerformer("工厂");
		h.setHpdeliveryDate("2018-02-01");
		h.setHporderShape("直");
		h.setHporderSpec("2*2*2");
		h.setHporderModel("A");
		h.setHporderNumber(100);
		h.setHpsongchuNumber(0);
		h.setHpweisongNumber(0);
		h.setActualDate("2018-02-01");
		h.setHporderPrice(5f);
		h.setHporderTotalPrice(500f);
		h.setHporderState("");
		h.setHporderRemark("");
		
	
		//hpOrderDao.insertHpOrder(h);
		//hpOrderDao.updateHpOrder(h);
		System.out.println(hpOrderDao.getHpOrder("all", "all", "all", "all", "2010-01-01", "2030-01-01"));
		System.out.println(hpOrderDao.getHpOrderStatistics("2010-01-01", "2030-01-01"));
	}

}

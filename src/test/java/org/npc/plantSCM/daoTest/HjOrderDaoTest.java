package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.HjOrderDao;
import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpOrder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HjOrderDaoTest {

	@Resource
	private HjOrderDao hjOrderDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HjOrder h = new HjOrder();
		h.setHjorderId(1);
		h.setHjProductDate("2016-01-01");
		h.setHjType("a");
		h.setHjCustomerName("林总");
	
		h.setHjdeliveryDate("2016-01-04");
		h.setHjorderNumber(100);
		h.setHjsongchuNumber(0);
		h.setHjweisongNumber(100);
		h.setActualDate("2016-02-05");
		h.setHjorderFactory("海南");
		h.setHjorderPrice(5f);
		h.setHjorderTotalPrice(500f);
		h.setHjorderState("未送");
		h.setHjorderRemark("");
		
		hjOrderDao.updateHjOrder(h);
		
		System.out.println(hjOrderDao.getHjOrder("all", "all","2010-01-01", "2030-01-01"));
	}

}

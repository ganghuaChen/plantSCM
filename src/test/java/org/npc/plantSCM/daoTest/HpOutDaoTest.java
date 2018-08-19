package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.HpOutDao;
import org.npc.plantSCM.po.HpOut;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HpOutDaoTest {

	@Resource
	private HpOutDao hpOutDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HpOut h = new HpOut();
		h.setId(1);
		h.setOutDate("2015-12-12");
		h.setOutModel("B");
		h.setOutSpec("2*2*2");
		h.setOutWeight(5.0f);
		h.setOutShape("直");
		h.setOutFlow(false);
		h.setCustomerName("zzt");
		h.setCustomerPhone("");
		h.setPrice(100f);
		h.setTotalPrice(500f);
		
		hpOutDao.insertHpOut(h);
		//hpOutDao.updateHpOut(h);
		System.out.println(hpOutDao.checkHpOut(h));
		
		System.out.println(hpOutDao.getHpOut("2010-01-01", "2030-01-01", "all", "all"));
	}

}

package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.HpInDao;
import org.npc.plantSCM.po.HpIn;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HpInDaoTest {

	@Resource
	private HpInDao hpInDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HpIn h = new HpIn();
		h.setId(1);
		h.setHpstorageDate("2018-01-01");
		h.setHpModel("B");
		h.setHpSpec("8*8*8");
		h.setHpstorageWeight(0f);
		h.setHpShape("弯");
		h.setHpFrom(true);
		h.setHpstorageState(false);
		
		//hpInDao.updateHpIn(h);
		
		System.out.println(hpInDao.getHpIn("2014-01-01", "2020-01-01", "all", "all",true));
		
	}

}

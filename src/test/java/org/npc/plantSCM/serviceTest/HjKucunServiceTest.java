package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HjInventory;
import org.npc.plantSCM.service.HjKucunService;
import org.npc.plantSCM.service.HpChuchangService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HjKucunServiceTest {

	@Resource
	private HjKucunService hjKucunService;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HjInventory h = new HjInventory();
		h.setHjkcId(1);
		h.setHjType("a");
		h.setHjFactory("广州");
		h.setHjActualNumber(100);
		hjKucunService.modifyHjKucun(h);
		//System.out.println(hjKucunService.getHjKucun("all"));
	}

}

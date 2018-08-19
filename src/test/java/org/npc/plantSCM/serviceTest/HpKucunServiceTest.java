package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.service.HpKucunService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HpKucunServiceTest {

	@Resource
	private HpKucunService hpKucunService;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HpInventory h = new HpInventory();
	    h.setHpkcId(1);
		h.setModel("A1");
		h.setShape("直");
		h.setSpec("20*20*20");
		h.setActualNumber(5f);
		hpKucunService.modifyHpKucun(h);
		//System.out.println(hpKucunService.getHpKucun("all", "all", "all"));
	}

}

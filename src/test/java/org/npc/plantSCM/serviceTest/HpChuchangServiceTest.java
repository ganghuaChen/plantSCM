package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HpOut;
import org.npc.plantSCM.service.HpChuchangService;
import org.npc.plantSCM.vo.SpecChange;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class HpChuchangServiceTest {

	@Resource
	private HpChuchangService hpChuchangService;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HpOut h = new HpOut();
		h.setId(6);
		h.setOutDate("2016-08-08");
		h.setOutModel("E");
		h.setOutSpec("3*3*3");
		h.setOutWeight(3f);
		h.setOutShape("zhi");
		h.setOutFlow(true);
//		h.setCustomerName("zzt");
//		h.setCustomerPhone("");
//		h.setPrice(100f);
//		h.setTotalPrice(300f);
		
		HpOut h1 = new HpOut();
		h1.setId(5);
		h1.setOutDate("2016-08-08");
		h1.setOutModel("F");
		h1.setOutSpec("3*3*3");
		h1.setOutWeight(3f);
		h1.setOutShape("wan");
		h1.setOutFlow(false);
		h1.setCustomerName("zzt");
		h1.setCustomerPhone("");
		h1.setPrice(100f);
		h1.setTotalPrice(320f);
		List<HpOut> list = new ArrayList<>();
		list.add(h);
		list.add(h1);
		//hpChuchangService.createNewChuchang(list);
	    //System.out.println(h.getOutSpec());
		//System.out.println(hpChuchangService.getChuchangRecord("2010-01-01","2050-01-01" , "all", "all"));
	    hpChuchangService.modifyChuchang(h);
	}

}

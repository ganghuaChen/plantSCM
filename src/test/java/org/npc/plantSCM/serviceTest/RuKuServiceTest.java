package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpIn;
import org.npc.plantSCM.service.RukuService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class RuKuServiceTest {

	@Resource private RukuService r;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		HpIn h = new HpIn();
		h.setId(12);
		h.setHpstorageDate("2018-01-01");
		h.setHpModel("C");
		h.setHpSpec("2*2*2");
		h.setHpstorageWeight(11f);
		h.setHpShape("直");
		h.setHpFrom(false);//来源
		h.setHpstorageState(true);
		h.setHpOutId(2);
		
//		HpIn h1 = new HpIn();
//		h1.setId(11);
//		h1.setHpstorageDate("2018-01-01");
//		h1.setHpModel("B");
//		h1.setHpSpec("8*8*8");
//		h1.setHpstorageWeight(10f);
//		h1.setHpShape("弯");
//		h1.setHpFrom(false);//来源
//		h1.setHpstorageState(false);
//		h1.setHpOutId(2);
		
		List<HpIn> list = new ArrayList<>();
//		list.add(h1);
		list.add(h);
//		r.HanpianQueren(list);
//		System.out.println(r.getHpRukuRecord("2010-01-01", "2030-01-01", "all", "all", true));
//		
		
		HjPurchase h1 = new HjPurchase();
		h1.setId(1);
		h1.setHjDate("2018-01-01");
		h1.setHjSpecies("a");
		h1.setHjPrice(6f);
		h1.setHjNumber(9);
		h1.setHjTotalPrice(600f);
		h1.setHjFrom("广州");
		h1.setHjStorageState(false);
		h1.setHjNote("hi");
		
		HjPurchase h11 = new HjPurchase();
		h11.setId(2);
		h11.setHjDate("2018-01-01");
		h11.setHjSpecies("c");
		h11.setHjPrice(6f);
		h11.setHjNumber(8);
		h11.setHjTotalPrice(600f);
		h11.setHjFrom("广州");
		h11.setHjStorageState(false);
		h11.setHjNote("hi");
		
		List<HjPurchase> list2 = new ArrayList<>();
//		list2.add(h1);
		list2.add(h11);
		r.HanjiQueren(list2);
		
		
		
		
		
	}

}

package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpPurchase;
import org.npc.plantSCM.po.MaterialPurchase;
import org.npc.plantSCM.service.CaigouService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class CaigouServiceTest {

	@Resource private CaigouService c;
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		//原料
		MaterialPurchase m = new MaterialPurchase();
		m.setId(2);
		m.setYlDate("2016-01-01");
		m.setYlSpecies("铜");
		m.setYlPrice(8f);
		m.setYlTotalPrice(500f);
		m.setYlWeight(100f);
		m.setYlFactory("佛山");
		m.setYlnote("hi");
		
		MaterialPurchase m1 = new MaterialPurchase();
		m1.setId(1);
		m1.setYlDate("2015-01-01");
		m1.setYlSpecies("铜");
		m1.setYlPrice(5f);
		m1.setYlTotalPrice(500f);
		m1.setYlWeight(10f);
		m1.setYlFactory("佛山");
		m1.setYlnote("hi");
		
		List<MaterialPurchase> list = new ArrayList<>();
		list.add(m);
		list.add(m1);
		//c.createYuanliaoCaigou(list);
		
		//c.modifyYuanliaoCaigou(m1);
		//System.out.println(c.getYuanliaoCaigou("广州", "铜", "2010-01-01", "2090-01-01"));
	    System.out.println(c.getYUanliaoTongji("2010-01-01", "2090-01-01"));
		
	    //焊剂
		HjPurchase h = new HjPurchase();
		h.setId(1);
		h.setHjDate("2018-01-01");
		h.setHjSpecies("a");
		h.setHjPrice(6f);
		h.setHjNumber(100);
		h.setHjTotalPrice(600f);
		h.setHjFrom("广州");
		h.setHjStorageState(false);
		//h.setHjNote("");
	     
		HjPurchase h1 = new HjPurchase();
		h1.setId(1);
		h1.setHjDate("2018-01-01");
		h1.setHjSpecies("a");
		h1.setHjPrice(6f);
		h1.setHjNumber(100);
		h1.setHjTotalPrice(600f);
		h1.setHjFrom("广州");
		h1.setHjStorageState(false);
		h1.setHjNote("hi");
	
		List<HjPurchase> list1 = new ArrayList<>();
		list1.add(h);
		list1.add(h1);
		//c.createHanjiCaigou(list1);
		//c.modifyHanjiCaigou(h1);
		//System.out.println(c.getHanjiCaigou("all", "2010-01-01", "2090-01-01"));
		
		System.out.println(c.getHanjiTongji("2010-01-01", "2090-01-01"));
		
		//焊片
		HpPurchase hp = new HpPurchase();
		hp.setId(1);
		hp.setHpDate("2016-01-01");
		hp.setHpShape("直");
		hp.setHpModel("C");
		hp.setHpSpec("2*2*2");
		hp.setHpPrice(5f);
		hp.setHpTotalPrice(500f);
		hp.setHpWeight(10f);
		hp.setHpFactory("hangzhou");
		hp.setHpNote("下次");
		
		HpPurchase hp1 = new HpPurchase();
		hp1.setId(4);
		hp1.setHpDate("2016-01-01");
		hp1.setHpShape("直");
		hp1.setHpModel("C");
		hp1.setHpSpec("2*2*2");
		hp1.setHpPrice(5f);
		hp1.setHpTotalPrice(500f);
		hp1.setHpWeight(100f);
		hp1.setHpFactory("广州");
		//hp1.setHpNote("下次");
		
		List<HpPurchase> list2 = new ArrayList<>();
		list2.add(hp);
		list2.add(hp1);
		//c.createHanpianCaigou(list2);
		//c.modifyHanpianCaigou(hp);
		//System.out.println(c.getHanpianCaigou("all", "2010-01-01", "2090-01-01"));
		//System.out.println(c.getHanpianTongji("2010-01-01", "2090-01-01"));
	
	}

}

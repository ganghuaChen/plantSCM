package org.npc.plantSCM.serviceTest;


import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.service.XiadanService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class XiadanServiceTest {
	@Resource private XiadanService xiadanService;
	@Before
	public void setUp() throws Exception {
	}
	@Test
	public void test() {
//	HjOrder h = new HjOrder();
//	h.setActualDate("2018-01-01");
//	h.setHjCustomerName("收货人小张");
//	h.setHjdeliveryDate("2019-11-12");
//	h.setHjorderFactory("焊剂厂家A");
//	h.setHjorderId(2);
//	h.setHjorderNumber(15);
//	h.setHjorderPerformer("送货人小张");
//	h.setHjorderPhone("123456");
//	h.setHjorderPrice(8f);
//	h.setHjorderRemark("没有备注");
//	h.setHjorderState("未送达");
//	h.setHjorderTotalPrice(80f);
//	h.setHjProductDate("2019-10-25");
//	h.setHjsongchuNumber(15);
//	h.setHjType("E");
//	h.setHjweisongNumber(0);
//	List<HjOrder> list = new ArrayList<>();
//	list.add(h);
//	//xiadanService.createHanjiOrder(list);
//	xiadanService.deleteHanjiOrder(2);
////	xiadanService.modifyHanjiOrder(h);
//	System.out.println(xiadanService.getHanjiOrder("all", "all", "2000-01-01", "2100-01-01"));
//		HpOrder h = new HpOrder();
//		h.setHporderId(2);
//		h.setHporderDate("2018-01-01");
//		h.setHpCustomerName("zyh");
//		h.setHporderPhone("");
//		h.setHporderPerformer("工厂");
//		h.setHpdeliveryDate("2018-02-05");
//		h.setHporderShape("直");
//		h.setHporderSpec("2*2*2");
//		h.setHporderModel("C");
//		h.setHporderNumber(100);
//		h.setHpsongchuNumber(100);
//		h.setHpweisongNumber(0);
//		h.setActualDate("2018-02-01");
//		h.setHporderPrice(5f);
//		h.setHporderTotalPrice(500f);
//		h.setHporderState("未送达");
//		h.setHporderRemark("");
//		List<HpOrder> list = new ArrayList<>();
//		list.add(h);
////		xiadanService.createHanpianOrder(list);
////		System.out.println(list);
////	    xiadanService.deleteHanpianOrder(1);
//		xiadanService.modifyHanpianOrder(h);
		System.out.println(xiadanService.getHanpianOrder("all", "all", "all", "all", "2000-01-01", "2100-01-01"));
	}
}

package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.service.SonghuoService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class SonghuoServiceTest {

	@Resource
	private SonghuoService s;
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
		h.setHporderModel("C");
		h.setHporderNumber(100);
		h.setHpsongchuNumber(100);
		h.setHpweisongNumber(0);
		h.setActualDate("2018-02-01");
		h.setHporderPrice(5f);
		h.setHporderTotalPrice(500f);
		h.setHporderState("未送达");
		h.setHporderRemark("");
		
		s.modifyHanpianSonghuo(h);
	}

}

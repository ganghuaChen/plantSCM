package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.MaterialInventory;
import org.npc.plantSCM.po.ProductPd;
import org.npc.plantSCM.service.FactoryPdService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class FactoryPdServiceTest {

	@Resource private FactoryPdService f;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		ProductPd p = new ProductPd();
		p.setId(3);
		p.setModel("B");
		p.setInventoryDate("2017-01-01");
		p.setBeforeBlanks(11f);
		p.setBeforeWaste(11f);
		p.setBeforeBulk(11f);
		p.setBeforeSemi(11f);
		p.setBeforeProduct(11f);
		p.setBeforeDailiao(11f);
		p.setBeforeTotal(11f);
		p.setAfterSale(10);
		p.setAfterWaste(11f);
		p.setAfterBulk(11f);
		p.setAfterSemi(11f);
		p.setAfterProduct(11f);
		p.setAfterDailiao(11f);
		p.setAfterTotal(11f);		
		p.setdValue(11f);
		
		List<ProductPd> list = new ArrayList<>();
		list.add(p);
		f.createPdRecord(list);
		//System.out.println(f.getPdRecord("2010-01-01", "2090-01-01", "all"));
		System.out.println(f.getMaterialInventory());	
		MaterialInventory m = new MaterialInventory();
		m.setYlId(1);
		m.setYlType("银");
		m.setYlremainingInventory(120f);
		//f.modifyMaterialInventory(m);
		
		//f.modifyPdRecord(p);
	}

}

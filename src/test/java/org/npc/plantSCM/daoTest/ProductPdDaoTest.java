package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.ProductPdDao;
import org.npc.plantSCM.po.ProductPd;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class ProductPdDaoTest {

	@Resource
	private ProductPdDao productPdDao;
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		ProductPd p = new ProductPd();
		p.setId(3);
		p.setModel("A");
		p.setInventoryDate("2018-01-01");
		p.setBeforeBlanks(8f);
		p.setBeforeWaste(8f);
		p.setBeforeBulk(8f);
		p.setBeforeSemi(8f);
		p.setBeforeProduct(8f);
		p.setBeforeDailiao(8f);
		p.setBeforeTotal(8f);
		p.setAfterSale(10);
		p.setAfterWaste(8f);
		p.setAfterBulk(8f);
		p.setAfterSemi(8f);
		p.setAfterProduct(8f);
		p.setAfterDailiao(8f);
		p.setAfterTotal(8f);		
		p.setdValue(8f);
		
		//productPdDao.insertProductPd(p);
		//productPdDao.updateProductPd(p);
		System.out.println(productPdDao.getProductPdByDateAndModel("2014-01-01","2019-01-01", "all"));
	}

}

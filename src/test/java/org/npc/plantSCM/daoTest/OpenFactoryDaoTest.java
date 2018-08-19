package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.OpenFactoryDao;
import org.npc.plantSCM.po.OpenFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class OpenFactoryDaoTest {

	@Resource
	private OpenFactoryDao openFactoryDao;
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {

		OpenFactory o = new OpenFactory();
		o.setId(1);
		o.setModel("E");
		o.setOpenDate("2015-01-01");
		o.setAgWeight(4.2332f);
		o.setCuWeight(4.22f);
		o.setZnWeight(4.2f);
		o.setCdWeight(8f);
		o.setSnWeight(8f);
		o.setBatchBlanksWeight(8f);
		o.setWasteWeight(8f);
		o.setBatchYlWeight(8f);
		o.setFireNumber(8);
		o.setAverageConsume(8f);
		o.setProportion(8f);
		//openFactoryDao.updateOpenFactory(o);

		System.out.println(openFactoryDao.getOpenFactoryByDateAndModel("all","2015-01-01",""));
		
		//System.out.println(openFactoryDao.checkOpenFactory(o));
		
	}

}

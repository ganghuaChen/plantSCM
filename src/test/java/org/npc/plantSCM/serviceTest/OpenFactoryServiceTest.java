package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.OpenFactory;
import org.npc.plantSCM.service.OpenFactoryService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//在spring容器下执行
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class OpenFactoryServiceTest {

	@Resource
	private OpenFactoryService openFactoryService;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		OpenFactory o = new OpenFactory();
	    o.setId(8);
		o.setModel("B");
		o.setOpenDate("2015-01-01");
		o.setAgWeight(10f);
		o.setCuWeight(10f);
		o.setZnWeight(10f);
		o.setCdWeight(10f);
		o.setSnWeight(10f);
		o.setBatchBlanksWeight(10f);
		o.setWasteWeight(10f);
		o.setBatchYlWeight(10f);
		o.setFireNumber(5);
		o.setAverageConsume(10f);
		o.setProportion(0.8f);
		
		List<OpenFactory> list = new ArrayList<>();
		list.add(o);
		
		//openFactoryService.createOpenFactory(list);
		openFactoryService.modifyOpenFactory(o);
		
		System.out.println(openFactoryService.getOpenFactoryInfo("all","",""));
		
		
	
	}
	

}

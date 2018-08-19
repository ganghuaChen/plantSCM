package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.service.InformService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class InformServiceTest {

	@Resource
	private InformService informService;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		informService.insertInfo("银不足");
		System.out.println(informService.getInformation());
	}

}

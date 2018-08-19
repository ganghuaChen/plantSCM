package org.npc.plantSCM.serviceTest;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.service.GetSpecificationService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class GetSpecificationServiceTest {

	@Resource private GetSpecificationService g;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		//System.out.println(g.getHpModel());
		System.out.println(g.getHjChangjia());
		
		List<String> list = new ArrayList<>();
		list.add("AA");
		list.add("bb");
//		list.add("c");
//		list.add("s");
		g.insertHpModel(list);
		System.out.println(g.getHpModel());
		
	}

}

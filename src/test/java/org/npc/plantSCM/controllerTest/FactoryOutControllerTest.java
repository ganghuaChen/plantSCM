package org.npc.plantSCM.controllerTest;

import org.junit.Before;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HpOut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.alibaba.fastjson.JSONObject;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class FactoryOutControllerTest {
	@Autowired
	private WebApplicationContext wac;
	private MockMvc mockMvc;
	
	@Before
	public void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();  
	}

	@Test
//	public void testGet1() throws Exception{
//		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/HpOut/getModel")).andReturn();	
//		MockHttpServletResponse response= result.getResponse();
//		System.out.println(response.getContentAsString());
//	}
//	public void testGet() throws Exception{
//		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/HpOut/getHpOutRecord").contentType(MediaType.APPLICATION_JSON)
//				.param("beginDate", "2010-01-01").param("endDate", "2090-01-01").param("outShape","all").param("outModel","all")).andReturn();	
//		MockHttpServletResponse response= result.getResponse();
//		System.out.println(response.getContentAsString());
//	}
	public void testModify() throws Exception{
		HpOut h = new HpOut();
		h.setCustomerName("小李");
		h.setCustomerPhone("123");
		h.setId(1);
		h.setOutDate("2015-06-13");
		h.setOutFlow(true);
		h.setOutModel("B");
		h.setOutShape("弯");
		h.setOutSpec("2*5*10");
		h.setOutWeight(2f);
		h.setPrice(2f);
		h.setTotalPrice(9f);

		String requestJson = JSONObject.toJSONString(h);
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/HpOut/modifyHpOutRecord").contentType(MediaType.APPLICATION_JSON)
				.content(requestJson)).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
	}
}

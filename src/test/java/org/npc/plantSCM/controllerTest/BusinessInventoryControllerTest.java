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
public class BusinessInventoryControllerTest {
	@Autowired
	private WebApplicationContext wac;
	private MockMvc mockMvc;
	
	@Before
	public void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();  
	}
	@Test
	public void testGet() throws Exception{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/BusinessInventory/getAllMaterialInventory")).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
	}
	@Test
	public void testGet2() throws Exception{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/BusinessInventory/getAllHanjiInventory")).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
	}
	@Test
	public void testGetWithPara() throws Exception{

		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/BusinessInventory/getHanpianInventory").contentType(MediaType.APPLICATION_JSON)
				.param("shape", "all").param("model","all")).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
	}
}

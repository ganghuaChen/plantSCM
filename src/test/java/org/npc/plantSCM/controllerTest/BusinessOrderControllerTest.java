package org.npc.plantSCM.controllerTest;
import org.junit.Before;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.po.HjOrder;
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
public class BusinessOrderControllerTest {
	@Autowired
	private WebApplicationContext wac;
	private MockMvc mockMvc;
	
	@Before
	public void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();  
	}
	@Test
	public void testCreat() throws Exception{
		HjOrder h = new HjOrder();
		h.setActualDate("2018-01-01");
		h.setHjCustomerName("收货人小张");
		h.setHjdeliveryDate("2019-11-12");
		h.setHjorderFactory("焊剂厂家A");
//		h.setHjorderId(5);
		h.setHjorderNumber(15);
		h.setHjorderPhone("123");
		h.setHjorderPrice(8f);
		h.setHjorderRemark("没有备注");
		h.setHjorderState("已完成");
		h.setHjorderTotalPrice(80f);
		h.setHjProductDate("2019-10-25");
		h.setHjsongchuNumber(15);
		h.setHjType("E");
		h.setHjweisongNumber(0);
		String requestJson = JSONObject.toJSONString(h);
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/BusinessOrder/creatHanjiOrder").contentType(MediaType.APPLICATION_JSON)
				.content(requestJson)).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
	}
	@Test
	public void testDelete() throws Exception{

		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/BusinessOrder/cancelHanjiOrder").contentType(MediaType.APPLICATION_JSON).param("id", "2")).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
	}
	@Test
	public void testModify() throws Exception{
		HjOrder h = new HjOrder();
		h.setActualDate("2018-07-01");
		h.setHjCustomerName("小林");
		h.setHjdeliveryDate("2018-07-06");
		h.setHjorderFactory("焊剂厂家A");
		h.setHjorderId(4);
		h.setHjorderNumber(15);
		h.setHjorderPhone("123");
		h.setHjorderPrice(8f);
		h.setHjorderRemark("没有备注");
		h.setHjorderState("已完成");
		h.setHjorderTotalPrice(80f);
		h.setHjProductDate("2019-10-25");
		h.setHjsongchuNumber(15);
		h.setHjType("E");
		h.setHjweisongNumber(0);
		String requestJson = JSONObject.toJSONString(h);

		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/BusinessOrder/modifyHanjiOrder").contentType(MediaType.APPLICATION_JSON)
				.content(requestJson)).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
	}
	@Test
	public void testGet() throws Exception{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/BusinessOrder/getModel")).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
	}
	@Test
	public void testGetWithPara() throws Exception{

		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/BusinessOrder/getHanpianOrder").contentType(MediaType.APPLICATION_JSON).param("hpCustomerName", "all")
				.param("hporderShape","all").param("hporderModel", "all").param("hporderState", "all").param("beginDate", "2000-01-01").param("endDate", "2090-01-01")).andReturn();	
		MockHttpServletResponse response= result.getResponse();
		System.out.println(response.getContentAsString());
		System.out.println("hi");
	}
}

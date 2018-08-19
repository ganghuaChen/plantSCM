package org.npc.plantSCM.controller;

import java.text.SimpleDateFormat;


import java.util.Calendar;
import java.util.Date;
import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import org.apache.commons.httpclient.util.DateUtil;
import org.npc.plantSCM.po.OpenFactory;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.service.OpenFactoryService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;

@Controller
public class FactoryOpenController {
	@Autowired
	@Qualifier("OpenFactoryService")
	private OpenFactoryService openFactoryService;
	@Autowired
	@Qualifier("GetSpecificationService")
	private GetSpecificationService getSpecificationService;
	
	//获取产品型号
	@RequestMapping(value="/OpenFactory/getModel",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getModel(){
		try{
			CommonDTO result=getSpecificationService.getHpModel();
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
	//添加开炉登记信息
	@RequestMapping(value="/OpenFactory/createOpenFactory",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO createOpenFactory(@RequestBody List<OpenFactory> list){
		try{
			CommonDTO result=openFactoryService.createOpenFactory(list);
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
	// 修改一条开炉记录
	@RequestMapping(value="/OpenFactory/modifyOpenFactory",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO modifyOpenFactory(@RequestBody OpenFactory OpenFactory){
		try{
			CommonDTO result=openFactoryService.modifyOpenFactory(OpenFactory);
			return result;
		}catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
	
	//根据起始日期、结束日期和型号筛选返回开炉记录信息
	@RequestMapping(value="/OpenFactory/getOpenFactory",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getOpenFactory(@RequestParam String model,
			@RequestParam String beginDate,
			@RequestParam String endDate)
{	
		try{
			
			if(beginDate.isEmpty()) {
				Calendar c1 = Calendar.getInstance(); 
				c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
				beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");

			}
			if(endDate.isEmpty()) {
				Calendar c2 = Calendar.getInstance();
				endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
			}
			
			if(model.isEmpty()||model.equals("全部")) {
				model="all";
			}
			CommonDTO result=openFactoryService.getOpenFactoryInfo(model,beginDate,endDate);
			return result;
		}catch(ParseException e){
			e.printStackTrace();
			return new CommonDTO(Result.TIME_PARSE_ERROR);
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
}

package org.npc.plantSCM.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.httpclient.util.DateUtil;
import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpIn;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.service.RukuService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
public class WarehouseInController {
	@Resource private RukuService rukuService;
	@Resource private GetSpecificationService getSpecificationService; 
	//按条件获取焊片入库记录
	@RequestMapping(value="/WarehouseIn/getHpInRecord",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getHpInRecord(@RequestParam  ("startTime")String beginDate,
			@RequestParam ("endTime")String endDate,
			@RequestParam String hpShape,
			@RequestParam String hpModel,
			@RequestParam Boolean hpstorageState) {
			try {
				System.out.println(endDate);
//				if(beginDate.isEmpty()) {
//					SimpleDateFormat df = new SimpleDateFormat("YYYY-MM-DD");
//					Calendar c = Calendar.getInstance(); 
//					c.add(Calendar.MONTH, 0);
//					c.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期既为本月第一天 
//					String firstDate = df.format(c.getTime());
//					beginDate=firstDate;
//				}
//				if(endDate.isEmpty()) {
//					SimpleDateFormat df = new SimpleDateFormat("YYYY-MM-DD");
//					Date date = new Date();
//					String newDate=df.format(date);
//					endDate=newDate;
//				}
				
				if(hpModel.isEmpty()||hpModel.equals("全部")) {
					hpModel="all";
				}
				if(hpShape.isEmpty()||hpShape.equals("全部")) {
					hpShape="all";
				}
				
				CommonDTO result=rukuService.getHpRukuRecord(beginDate, endDate, hpShape, hpModel, hpstorageState);
				System.out.println(result.toString());
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
	//确认焊片入库信息
	@RequestMapping(value="/WarehouseIn/confirmHpInRecord",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO confirmHpInRecord(@RequestBody List<HpIn> list){
		 
		try{ 
			CommonDTO result = rukuService.HanpianQueren(list);
			return result;

		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}

		
	}
	//初始化焊片入库记录
		@RequestMapping(value="/WarehouseIn/getHpInInitRecord",method=RequestMethod.GET)
		@ResponseBody
		public CommonDTO getHpInInitRecord() {
				try {
					
					String hpShape ="all";
					String hpModel ="all";
					Boolean hpstorageState=false;//默认显示未入库的
					

					Calendar c1 = Calendar.getInstance(); 
					Calendar c2 = Calendar.getInstance();
					c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
					String beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");
					String endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
					
//					System.out.println(hjFrom+hjStorageState+beginDate+endDate);
					
					CommonDTO result=rukuService.getHpRukuRecord(beginDate, endDate, hpShape, hpModel, hpstorageState);
					
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
	//按条件搜索焊剂入库记录
	@RequestMapping(value="/WarehouseIn/getHjInRecord",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getHjInRecord(@RequestParam ("startTime")String beginDate,
			@RequestParam ("endTime")String endDate,
			@RequestParam String hjFrom,
			@RequestParam Boolean hjStorageState) {
			try {
//				if(beginDate.isEmpty()) {
//					SimpleDateFormat df = new SimpleDateFormat("YYYY-MM-DD");
//					Calendar c = Calendar.getInstance(); 
//					c.add(Calendar.MONTH, 0);
//					c.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期既为本月第一天 
//					String firstDate = df.format(c.getTime());
//					beginDate=firstDate;
//				}
//				if(endDate.isEmpty()) {
//					SimpleDateFormat df = new SimpleDateFormat("YYYY-MM-DD");
//					Date date = new Date();
//					String newDate=df.format(date);
//					endDate=newDate;
//				}
//				
				if(hjFrom.isEmpty()||hjFrom.equals("全部")) {
					hjFrom="all";
				}	
				CommonDTO result=rukuService.getHjRukuRecord(hjFrom, hjStorageState, beginDate, endDate);
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
	//初始化焊剂入库记录
	@RequestMapping(value="/WarehouseIn/getHjInInitRecord",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getHjInInitRecord() {
			try {
				
				String hjFrom ="all";
				Boolean hjStorageState=false;//默认显示未入库的
				

				Calendar c1 = Calendar.getInstance(); 
				Calendar c2 = Calendar.getInstance();
				c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
				String beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");
				String endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
				
//				System.out.println(hjFrom+hjStorageState+beginDate+endDate);
				
				CommonDTO result=rukuService.getHjRukuRecord(hjFrom, hjStorageState, beginDate, endDate);
				
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
	//确认焊剂入库信息
	@RequestMapping(value="/WarehouseIn/confirmHjInRecord",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO confirmHjInRecord(@RequestBody List<HjPurchase> list){
		 
		try{ 
			CommonDTO result = rukuService.HanjiQueren(list);
			return result;

		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}

		
	}
	//获取已有焊片型号
	@RequestMapping(value="/WarehouseIn/getModel",method=RequestMethod.GET)
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
	//获取已有焊剂厂家
		@RequestMapping(value="/WarehouseIn/getHjFactory",method=RequestMethod.GET)
		@ResponseBody
		public CommonDTO getHjFactory(){
			try{
				CommonDTO result=getSpecificationService.getHjChangjia();
				return result;
			}
			catch(Exception e){
				e.printStackTrace();
				return new CommonDTO(Result.SYSTEM_EXCEPTION);
			}
		}
}

package org.npc.plantSCM.controller;

import java.text.SimpleDateFormat;


import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.httpclient.util.DateUtil;
import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.service.SonghuoService;
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
public class WarehouseOutController {
	@Resource private SonghuoService songhuoService;
	@Resource private GetSpecificationService getSpecificationService; 

//	//按条件获取焊片焊剂送货任务单
//	@RequestMapping(value="/WarehouseOut/getOutRecord",method=RequestMethod.GET)
//	@ResponseBody
//	public CommonDTO getOutRecord(@RequestParam String CustomerName,
//			@RequestParam("startTime") String beginDate,
//			@RequestParam ("endTime")String endDate,
//			@RequestParam String hporderShape,
//			@RequestParam String hporderModel) {
//			try {
//				if(CustomerName.isEmpty()) {
//					CustomerName="all";
//				}
//				if(hporderModel.isEmpty()||hporderModel.equals("全部")) {
//					hporderModel="all";
//				}
//				if(hporderShape.isEmpty()||hporderShape.equals("全部")) {
//					hporderShape="all";
//				}
//				if(beginDate.isEmpty()) {
//					Calendar c1 = Calendar.getInstance(); 
//					c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
//					beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");
//
//				}
//				if(endDate.isEmpty()) {
//					Calendar c2 = Calendar.getInstance();
//					endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
//				}
//				CommonDTO result=songhuoService.getSonghuo(CustomerName, beginDate, endDate, hporderShape, hporderModel);
//				return result;
//			}catch(ParseException e){
//				e.printStackTrace();
//				return new CommonDTO(Result.TIME_PARSE_ERROR);
//			}
//			catch(Exception e){
//				e.printStackTrace();
//				return new CommonDTO(Result.SYSTEM_EXCEPTION);
//			}
//	}
	//按条件获取焊片送货任务单
	@RequestMapping(value="/WarehouseOut/getHpOutRecord",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getHpOutRecord(@RequestParam String hpCustomerName,
			@RequestParam ("outShape")String hporderShape,
			@RequestParam ("outModel")String hporderModel,
			@RequestParam ("startTime")String beginDate,
			@RequestParam ("endTime")String endDate) {
			try {
				String hporderState="all";
				if(hpCustomerName.isEmpty()||hpCustomerName.equals("全部")) {
					hpCustomerName="all";
				}
				if(hporderModel.isEmpty()||hporderModel.equals("全部")) {
					hporderModel="all";
				}
				if(hporderShape.isEmpty()||hporderShape.equals("全部")) {
					hporderShape="all";
				}
				if(beginDate.isEmpty()) {
					Calendar c1 = Calendar.getInstance(); 
					c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
					beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");

				}
				if(endDate.isEmpty()) {
					Calendar c2 = Calendar.getInstance();
					endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
				}
				CommonDTO result=songhuoService.getHanpianSonghuo(hpCustomerName, hporderShape, hporderModel, hporderState, beginDate, endDate);
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
	//修改焊片送货任务单
	@RequestMapping(value="/WarehouseOut/modifyHpOut",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO modifyHpOut(@RequestBody HpOrder hpOrder){
		 
		try{ 
			CommonDTO result = songhuoService.modifyHanpianSonghuo(hpOrder);
			return result;

		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}

		
	}
	//按条件获取焊剂送货任务单
	@RequestMapping(value="/WarehouseOut/getHjOutRecord",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getHjOutRecord(@RequestParam String hjCustomerName,
			@RequestParam("startTime") String beginDate,
			@RequestParam ("endTime")String endDate) {
			try {
				String hjorderState = "all";
				if(hjCustomerName.isEmpty()||hjCustomerName.equals("全部")) {
					hjCustomerName="all";
				}
				if(beginDate.isEmpty()) {
					Calendar c1 = Calendar.getInstance(); 
					c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
					beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");

				}
				if(endDate.isEmpty()) {
					Calendar c2 = Calendar.getInstance();
					endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
				}
				
				CommonDTO result=songhuoService.getHanjiSonghuo(hjCustomerName, hjorderState, beginDate, endDate);
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
	//修改焊剂送货任务单
	@RequestMapping(value="/WarehouseOut/modifyHjOut",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO modifyHjOut(@RequestBody HjOrder hjOrder){
		 
		try{ 

			CommonDTO result = songhuoService.modifyHanjiSonghuo(hjOrder);
			return result;

		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
	//按条件获取送货统计信息
	@RequestMapping(value="/WarehouseOut/getSonghuoStatistics",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getSonghuoStatistics(@RequestParam String customerName,
			@RequestParam("startTime") String beginDate,
			@RequestParam ("endTime")String endDate
){
		 
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
			
			if(customerName.isEmpty()||customerName.equals("全部")) {
				customerName="all";
			}
			CommonDTO result = songhuoService.getSonghuoTongji(customerName, beginDate, endDate);
			
			return result;

		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
	//获取已有收货人
	@RequestMapping(value="/WarehouseOut/getCustomer",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getCustomer(){
		try{
			CommonDTO result=getSpecificationService.getCustomer();
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
	//获取已有焊片型号
	@RequestMapping(value="/WarehouseOut/getModel",method=RequestMethod.GET)
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
}

package org.npc.plantSCM.controller;

import java.text.SimpleDateFormat;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.httpclient.util.DateUtil;
import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpPurchase;
import org.npc.plantSCM.po.MaterialPurchase;
import org.npc.plantSCM.service.CaigouService;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Purchase;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
public class BusinessPurchaseController {
@Resource private CaigouService caigouService;
@Resource private GetSpecificationService getSpecificationService;
//新建原料焊剂焊片采购订单
@RequestMapping(value="/BusinessPurchase/creatPurchase",method=RequestMethod.POST)
@ResponseBody
public CommonDTO creatPurchase(@RequestBody Purchase purchase){
	 
	try{ 
		System.out.println(purchase);
		CommonDTO result = caigouService.createCaigou(purchase);
//		System.out.println(result.toString());
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
////新建原料采购订单
//@RequestMapping(value="/BusinessPurchase/creatMaterialPurchase",method=RequestMethod.POST)
//@ResponseBody
//public CommonDTO creatMaterialPurchase(@RequestBody List<MaterialPurchase> list){
//	 
//	try{ 
//		CommonDTO result = caigouService.createYuanliaoCaigou(list);
//		return result;
//
//	}
//	catch(Exception e){
//		e.printStackTrace();
//		return new CommonDTO(Result.SYSTEM_EXCEPTION);
//	}
//
//	
//}
//修改原料采购订单
@RequestMapping(value="/BusinessPurchase/modifyMaterialPurchase",method=RequestMethod.POST)
@ResponseBody
public CommonDTO modifyMaterialPurchase(@RequestBody MaterialPurchase materialPurchase){
	 
	try{ 
		CommonDTO result = caigouService.modifyYuanliaoCaigou(materialPurchase);
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
//按条件获取原料采购单
@RequestMapping(value="/BusinessPurchase/getMaterialPurchase",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getMaterialPurchase(@RequestParam String ylFactory,
		@RequestParam String ylSpecies,
		@RequestParam ("startTime")String beginDate,
		@RequestParam ("endTime")String endDate) {
		try {
			
			if(ylFactory.isEmpty()) {
				ylFactory="all";
			}
			if(ylSpecies.equals("全部")) {
				ylSpecies="all";
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
			CommonDTO result=caigouService.getYuanliaoCaigou(ylFactory, ylSpecies, beginDate, endDate);
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
////新建焊剂采购订单
//@RequestMapping(value="/BusinessPurchase/creatHanjiPurchase",method=RequestMethod.POST)
//@ResponseBody
//public CommonDTO creatHanjiPurchase(@RequestBody List<HjPurchase> list){
//	 
//	try{ 
//		CommonDTO result = caigouService.createHanjiCaigou(list);
//		return result;
//
//	}
//	catch(Exception e){
//		e.printStackTrace();
//		return new CommonDTO(Result.SYSTEM_EXCEPTION);
//	}
//
//	
//}
//修改焊剂采购订单
@RequestMapping(value="/BusinessPurchase/modifyHanjiPurchase",method=RequestMethod.POST)
@ResponseBody
public CommonDTO modifyHanjiPurchase(@RequestBody HjPurchase hjCaigou){
	 
	try{ 
		CommonDTO result = caigouService.modifyHanjiCaigou(hjCaigou);
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
//按条件获取焊剂采购单
@RequestMapping(value="/BusinessPurchase/getHanjiPurchase",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanjiPurchase(@RequestParam("from") String hjFrom,
		@RequestParam ("startTime")String beginDate,
		@RequestParam ("endTime")String endDate) {
		try {
			if(hjFrom.isEmpty()) {
				hjFrom="all";
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
			CommonDTO result=caigouService.getHanjiCaigou(hjFrom, beginDate, endDate);
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

////新建焊片采购订单
//@RequestMapping(value="/BusinessPurchase/creatHanpianPurchase",method=RequestMethod.POST)
//@ResponseBody
//public CommonDTO creatHanpianPurchase(@RequestBody List<HpPurchase> list){
//	 
//	try{ 
//		CommonDTO result = caigouService.createHanpianCaigou(list);
//		return result;
//
//	}
//	catch(Exception e){
//		e.printStackTrace();
//		return new CommonDTO(Result.SYSTEM_EXCEPTION);
//	}
//
//	
//}
//修改焊片采购订单
@RequestMapping(value="/BusinessPurchase/modifyHanpianPurchase",method=RequestMethod.POST)
@ResponseBody
public CommonDTO modifyHanpianPurchase(@RequestBody HpPurchase HpPurchase){
	 
	try{ 
		CommonDTO result = caigouService.modifyHanpianCaigou(HpPurchase);
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
//按条件获取焊片采购单
@RequestMapping(value="/BusinessPurchase/getHanpianPurchase",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanpianPurchase(@RequestParam String hpFactory,
		@RequestParam (value="startTime")String beginDate,
		@RequestParam (value="endTime")String endDate) {
		try {
			if(hpFactory.isEmpty()) {
				hpFactory="all";
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
			CommonDTO result=caigouService.getHanpianCaigou(hpFactory, beginDate, endDate);
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
//获取已有焊片型号
@RequestMapping(value="/BusinessPurchase/getModel",method=RequestMethod.GET)
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
//获取原料平均价格
@RequestMapping(value="/BusinessPurchase/getMaterialAveragePrice",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getMaterialAveragePrice(){
	try{
		CommonDTO result=caigouService.getYuanliaoAveragePrice();
		
		return result;
	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}
}
}

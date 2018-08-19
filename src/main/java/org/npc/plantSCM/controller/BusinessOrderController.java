package org.npc.plantSCM.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.httpclient.util.DateUtil;
import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.service.XiadanService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Order;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
public class BusinessOrderController {
@Resource private XiadanService xiadanService;
@Resource private GetSpecificationService getSpecificationService; 
////新建焊剂订单
//@RequestMapping(value="/BusinessOrder/creatHanjiOrder",method=RequestMethod.POST)
//@ResponseBody
//public CommonDTO creatHanjiOrder(@RequestBody List<HjOrder> list){
//	 
//	try{ 
//		CommonDTO result = xiadanService.createHanjiOrder(list);
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
//新建焊片焊剂订单
@RequestMapping(value="/BusinessOrder/creatOrder",method=RequestMethod.POST)
@ResponseBody
public CommonDTO creatOrder(@RequestBody Order order){
	 
	try{
		
		CommonDTO result = xiadanService.createOrder(order);		
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
//修改焊剂订单
@RequestMapping(value="/BusinessOrder/modifyHanjiOrder",method=RequestMethod.POST)
@ResponseBody
public CommonDTO modifyHanjiOrder(@RequestBody HjOrder hjOrder){
	 
	try{ 
		CommonDTO result = xiadanService.modifyHanjiOrder(hjOrder);
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
//取消焊剂订单
@RequestMapping(value="/BusinessOrder/cancelHanjiOrder",method=RequestMethod.GET)
@ResponseBody
public CommonDTO cancelHanjiOrder(@RequestParam Integer id){
	 
	try{ 
		CommonDTO result = xiadanService.deleteHanjiOrder(id);
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
//按收货人获取焊剂订单信息
@RequestMapping(value="/BusinessOrder/getHanjiOrderByCustomer",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanjiOrderByCustomer(@RequestParam String CustomerName) {
		try {

			String hjorderState="all";
			
			Calendar c1 = Calendar.getInstance(); 
			Calendar c2 = Calendar.getInstance();
			c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
			String beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");
			String endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
			
			CommonDTO result=xiadanService.getHanjiFirstOrder(CustomerName, hjorderState, beginDate, endDate);
			
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
//按条件获取焊剂订单信息
@RequestMapping(value="/BusinessOrder/getHanjiOrder",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanjiOrder(@RequestParam String hjCustomerName,
		@RequestParam String hjorderState,
		@RequestParam String beginDate,
		@RequestParam String endDate) {
		try {
			
//			System.out.println(hjCustomerName+hjorderState+beginDate+endDate);
			if(hjCustomerName.isEmpty()) {
				hjCustomerName="all";
			}
			if(hjorderState.isEmpty()||hjorderState.equals("全部")) {
				hjorderState="all";
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
//			System.out.println(hjCustomerName+hjorderState+beginDate+endDate);
			CommonDTO result=xiadanService.getHanjiOrder(hjCustomerName, hjorderState, beginDate, endDate);
//			System.out.println(result.toString());
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
////新建焊片订单
//@RequestMapping(value="/BusinessOrder/creatHanpianOrder",method=RequestMethod.POST)
//@ResponseBody
//public CommonDTO creatHanpianOrder(@RequestBody List<HpOrder> list){
//	 
//	try{ 
//		CommonDTO result = xiadanService.createHanpianOrder(list);
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
//修改焊片订单
@RequestMapping(value="/BusinessOrder/modifyHanpianOrder",method=RequestMethod.POST)
@ResponseBody
public CommonDTO modifyHanpianOrder(@RequestBody HpOrder hpOrder){
	 
	try{ 
		CommonDTO result = xiadanService.modifyHanpianOrder(hpOrder);
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
//取消焊片订单
@RequestMapping(value="/BusinessOrder/cancelHanpianOrder",method=RequestMethod.GET)
@ResponseBody
public CommonDTO cancelHanpianOrder(@RequestParam Integer id){
	 
	try{ 
		CommonDTO result = xiadanService.deleteHanpianOrder(id);
		return result;

	}
	catch(Exception e){
		e.printStackTrace();
		return new CommonDTO(Result.SYSTEM_EXCEPTION);
	}

	
}
//按收货人获取焊片订单信息
@RequestMapping(value="/BusinessOrder/getHanpianOrderByCustomer",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanpianOrderByCustomer(@RequestParam String CustomerName) {
		try {
			String hporderShape="all";
			String hporderModel="all";
			String hporderState="all";
			Calendar c1 = Calendar.getInstance(); 
			Calendar c2 = Calendar.getInstance();
			c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
			String beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");
			String endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");

			CommonDTO result=xiadanService.getHanpianFirstOrder(CustomerName, hporderShape, hporderModel, hporderState, beginDate, endDate);
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
//按条件获取焊片订单信息
@RequestMapping(value="/BusinessOrder/getHanpianOrder",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanpianOrder(@RequestParam String hpCustomerName,
		@RequestParam String hporderShape,
		@RequestParam String hporderModel,
		@RequestParam String hporderState,
		@RequestParam String beginDate,
		@RequestParam String endDate) {
		
		try {
			
			if(hpCustomerName.isEmpty()) {
				hpCustomerName="all";
			}
			if(hporderModel.isEmpty()||hporderModel.equals("全部")) {
				hporderModel="all";
			}
			if(hporderShape.isEmpty()||hporderShape.equals("全部")) {
				hporderShape="all";
			}
			if(hporderState.isEmpty()||hporderState.equals("全部")) {
				hporderState="all";
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
			
			CommonDTO result=xiadanService.getHanpianOrder(hpCustomerName, hporderShape, hporderModel, hporderState, beginDate, endDate);
			
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
@RequestMapping(value="/BusinessOrder/getModel",method=RequestMethod.GET)
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
//获取收货人列表
@RequestMapping(value="/BusinessOrder/getCustomer",method=RequestMethod.GET)
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
}

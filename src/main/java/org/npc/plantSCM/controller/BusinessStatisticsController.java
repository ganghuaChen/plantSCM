package org.npc.plantSCM.controller;

import java.text.SimpleDateFormat;

import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.httpclient.util.DateUtil;
import org.npc.plantSCM.service.CaigouService;
import org.npc.plantSCM.service.XiadanService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
public class BusinessStatisticsController {
@Resource private CaigouService caigouService;
@Resource private XiadanService xiadanService;
//按日期获取原料采购统计
@RequestMapping(value="/BusinessStatistics/getMaterialPurchaseStatistics",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getMaterialPurchaseStatistics(@RequestParam("startTime") String beginDate,
		@RequestParam ("endTime")String endDate) {

		try {
			
			if(beginDate.isEmpty()) {
				Calendar c1 = Calendar.getInstance(); 
				c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
				beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");

			}
			if(endDate.isEmpty()) {
				Calendar c2 = Calendar.getInstance();
				endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
			}
			CommonDTO result=caigouService.getYUanliaoTongji(beginDate, endDate);
			
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
//按日期获取焊剂采购统计
@RequestMapping(value="/BusinessStatistics/getHanjiPurchaseStatistics",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanjiPurchaseStatistics(@RequestParam("startTime") String beginDate,
		@RequestParam ("endTime")String endDate) {
		try {
			if(beginDate.isEmpty()) {
				Calendar c1 = Calendar.getInstance(); 
				c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
				beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");

			}
			if(endDate.isEmpty()) {
				Calendar c2 = Calendar.getInstance();
				endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
			}
			CommonDTO result=caigouService.getHanjiTongji(beginDate, endDate);
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
//按日期获取焊片采购统计
@RequestMapping(value="/BusinessStatistics/getHanpianPurchaseStatistics",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanpianPurchaseStatistics(@RequestParam("startTime") String beginDate,
		@RequestParam ("endTime")String endDate) {
		try {
			if(beginDate.isEmpty()) {
				Calendar c1 = Calendar.getInstance(); 
				c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
				beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");

			}
			if(endDate.isEmpty()) {
				Calendar c2 = Calendar.getInstance();
				endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
			}
			CommonDTO result=caigouService.getHanpianTongji(beginDate, endDate);
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
//按日期获取焊片销售统计
@RequestMapping(value="/BusinessStatistics/getHanpianOrderStatistics",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanpianOrderStatistics(@RequestParam("startTime") String beginDate,
		@RequestParam ("endTime")String endDate) {
		try {
			if(beginDate.isEmpty()) {
				Calendar c1 = Calendar.getInstance(); 
				c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
				beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");

			}
			if(endDate.isEmpty()) {
				Calendar c2 = Calendar.getInstance();
				endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
			}
			CommonDTO result=xiadanService.getHanpianTongji(beginDate, endDate);
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
//按日期获取焊剂销售统计
@RequestMapping(value="/BusinessStatistics/getHanjiOrderStatistics",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanjiOrderStatistics(@RequestParam("startTime") String beginDate,
		@RequestParam ("endTime")String endDate) {
		try {
			if(beginDate.isEmpty()) {
				Calendar c1 = Calendar.getInstance(); 
				c1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期为本月第一天 
				beginDate = DateUtil.formatDate(c1.getTime(),"yyyy-MM-dd");

			}
			if(endDate.isEmpty()) {
				Calendar c2 = Calendar.getInstance();
				endDate = DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd");
			}
			CommonDTO result=xiadanService.getHanjiTongji(beginDate, endDate);
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

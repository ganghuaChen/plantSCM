package org.npc.plantSCM.controller;

import java.text.SimpleDateFormat;




import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.httpclient.util.DateUtil;
import org.npc.plantSCM.po.HpOut;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.service.HpChuchangService;
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
public class FactoryOutController {
	@Resource 
	private HpChuchangService hpChuchangService;
	@Resource
	private GetSpecificationService getSpecificationService;
	//获取已有焊片型号
	@RequestMapping(value="/HpOut/getModel",method=RequestMethod.GET)
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
/*	//获取已有焊片形状
	@RequestMapping(value="/HpOut/getShape",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getSpec(){
		try{
			CommonDTO result=getspecificationservice.getSpec();
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}*/
	//按条件显示出厂记录
	@RequestMapping(value="/HpOut/getHpOutRecord",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getHpOutRecord(@RequestParam String beginDate,
			@RequestParam String endDate,
			@RequestParam String outShape,
			@RequestParam String outModel) {
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
				
				if(outModel.isEmpty()||outModel.equals("全部")) {
					outModel="all";
				}
				if(outShape.isEmpty()||outShape.equals("全部")) {
					outShape="all";
				}
				CommonDTO result=hpChuchangService.getChuchangRecord(beginDate, endDate, outShape, outModel);
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
	//添加焊片出厂信息
		@RequestMapping(value="/HpOut/createHpOutRecord",method=RequestMethod.POST)
		@ResponseBody
		public CommonDTO createHpOutRecord(@RequestBody List<HpOut> list){
			 
			try{ 
//				System.out.println("hi");
//				System.out.println(list.toString());
				CommonDTO result =hpChuchangService.createNewChuchang(list);
				return result;

			}
			catch(Exception e){
				e.printStackTrace();
				return new CommonDTO(Result.SYSTEM_EXCEPTION);
			}
		
			
		}
		// 修改一条焊片出厂记录
				@RequestMapping(value="/HpOut/modifyHpOutRecord",method=RequestMethod.POST)
				@ResponseBody
				public CommonDTO modifyHpOutRecord(@RequestBody HpOut HpOut){
					try{
						CommonDTO result=hpChuchangService.modifyChuchang(HpOut);
						return result;
					}catch(Exception e){
						e.printStackTrace();
						return new CommonDTO(Result.SYSTEM_EXCEPTION);
					}
				}	
}

package org.npc.plantSCM.controller;


import java.text.SimpleDateFormat;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;


import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import org.apache.commons.httpclient.util.DateUtil;
import org.npc.plantSCM.po.MaterialInventory;
import org.npc.plantSCM.po.ProductPd;
import org.npc.plantSCM.service.FactoryPdService;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FactoryPdController {
	@Resource 
	private FactoryPdService factoryPdService;
	@Resource
	private GetSpecificationService getSpecificationService;
	//获取已有焊片型号
		@RequestMapping(value="/FactoryPd/getModel",method=RequestMethod.GET)
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
		//按型号和日期显示盘点清仓记录
			@RequestMapping(value="/FactoryPd/getFactoryPdRecord",method=RequestMethod.GET)
			@ResponseBody
			public CommonDTO getFactoryPdRecord(@RequestParam String beginDate,
					@RequestParam String endDate,
					@RequestParam String Model) {
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
						
						if(Model.isEmpty()||Model.equals("全部")) {
							Model="all";
						}
					
						CommonDTO result=factoryPdService.getPdRecord(beginDate, endDate, Model);
						return result;
					}catch(ParseException e){
						e.printStackTrace();
						return new CommonDTO(Result.TIME_PARSE_ERROR);
					}
					catch(Exception e){;
						e.printStackTrace();
						return new CommonDTO(Result.SYSTEM_EXCEPTION);
					}
			}
			//添加工厂盘点信息
				@RequestMapping(value="/FactoryPd/createFactoryPdRecord",method=RequestMethod.POST)
				@ResponseBody
				public CommonDTO createFactoryPdRecord(@RequestBody List<ProductPd> list){
					 
					try{ 
						CommonDTO result =factoryPdService.createPdRecord(list);
						
								return result;

					}
					catch(Exception e){
						e.printStackTrace();
						return new CommonDTO(Result.SYSTEM_EXCEPTION);
					}
				
					
				}
				// 修改一条焊片出厂记录
						@RequestMapping(value="/FactoryPd/modifyFactoryPdRecord",method=RequestMethod.POST)
						@ResponseBody
						public CommonDTO modifyFactoryPdRecord(@RequestBody ProductPd productpd){
							try{
								CommonDTO result=factoryPdService.modifyPdRecord(productpd);
								return result;
							}catch(Exception e){
								e.printStackTrace();
								return new CommonDTO(Result.SYSTEM_EXCEPTION);
							}
		
}
			//获取原料库存信息
						@RequestMapping(value="/FactoryPd/getMaterialInventory",method=RequestMethod.GET)
						@ResponseBody
						public CommonDTO getMaterialInventory(){
							try{
								CommonDTO result=factoryPdService.getMaterialInventory();
								return result;
							}
							catch(Exception e){
								e.printStackTrace();
								return new CommonDTO(Result.SYSTEM_EXCEPTION);
							}
						}
					
						
			//原料盘点			
						@RequestMapping(value="/FactoryPd/modifyMaterialInventory",method=RequestMethod.POST)
						@ResponseBody
						public CommonDTO modifyMaterialInventory(@RequestBody MaterialInventory materialInventory){
							try{
								CommonDTO result=factoryPdService.modifyMaterialInventory(materialInventory);
								return result;
							}catch(Exception e){
								e.printStackTrace();
								return new CommonDTO(Result.SYSTEM_EXCEPTION);
							}
						}	
}

package org.npc.plantSCM.controller;


import javax.annotation.Resource;


import org.npc.plantSCM.po.HjInventory;
import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.service.HjKucunService;
import org.npc.plantSCM.service.HpKucunService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
public class WarehouseInventoryController {
	@Resource private HpKucunService hpKucunService;
	@Resource private HjKucunService hjKucunService;
	@Resource private GetSpecificationService getSpecificationService; 
	//按条件获取焊片库存记录
	@RequestMapping(value="/WarehouseInventory/getHpInventoryRecord",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getHpInventoryRecord() {
			try {
				String shape ="all";
				String model ="all";
				String spec ="all";
			
				CommonDTO result=hpKucunService.getHpKucun(shape, model, spec);
				return result;
			}
			catch(Exception e){
				e.printStackTrace();
				return new CommonDTO(Result.SYSTEM_EXCEPTION);
			}
	}
	//修改焊片库存记录
	@RequestMapping(value="/WarehouseInventory/modifyHpInventoryRecord",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO modifyHpInventoryRecord(@RequestBody HpInventory hpInventory){
		 
		try{ 
			System.out.println(hpInventory);
			CommonDTO result = hpKucunService.modifyHpKucun(hpInventory);
			return result;

		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}

		
	}
	//按条件获取焊剂库存记录
	@RequestMapping(value="/WarehouseInventory/getHjInventoryRecord",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getHjInventoryRecord() {
			try {
				String hjFactory ="all";
				CommonDTO result=hjKucunService.getHjKucun(hjFactory);
				return result;
			}
			catch(Exception e){
				e.printStackTrace();
				return new CommonDTO(Result.SYSTEM_EXCEPTION);
			}
	}
	//修改焊剂库存记录
	@RequestMapping(value="/WarehouseInventory/modifyHjInventoryRecord",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO modifyHjInventoryRecord(@RequestBody HjInventory hjInventory){
		 
		try{ 
			
			CommonDTO result = hjKucunService.modifyHjKucun(hjInventory);
			return result;

		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}

		
	}
//	//获取已有焊片型号
//	@RequestMapping(value="/WarehouseInventory/getModel",method=RequestMethod.GET)
//	@ResponseBody
//	public CommonDTO getModel(){
//		try{
//			CommonDTO result=getSpecificationService.getHpModel();
//			return result;
//		}
//		catch(Exception e){
//			e.printStackTrace();
//			return new CommonDTO(Result.SYSTEM_EXCEPTION);
//		}
//	}
}

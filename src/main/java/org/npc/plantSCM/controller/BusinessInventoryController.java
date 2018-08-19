package org.npc.plantSCM.controller;

import javax.annotation.Resource;

import org.npc.plantSCM.service.FactoryPdService;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.service.HjKucunService;
import org.npc.plantSCM.service.HpKucunService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
public class BusinessInventoryController {
@Resource private FactoryPdService factoryPdService;
@Resource private HpKucunService hpKucunService;
@Resource private HjKucunService hjKucunService;
@Resource private GetSpecificationService getSpecificationService;
 
//查看所有原料库存
@RequestMapping(value="/BusinessInventory/getAllMaterialInventory",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getAllMaterialInventory() {
		try {
			
			CommonDTO result=factoryPdService.getMaterialInventory();
		
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
}
//查看所有焊剂库存
@RequestMapping(value="/BusinessInventory/getAllHanjiInventory",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getAllHanjiInventory() {
		try {
			String hjFactory="all";
			CommonDTO result=hjKucunService.getHjKucun(hjFactory);
//			System.out.println(result.toString());
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
}
//按形态型号查看焊片库存
@RequestMapping(value="/BusinessInventory/getHanpianInventory",method=RequestMethod.GET)
@ResponseBody
public CommonDTO getHanpianInventory(@RequestParam("outShape") String shape,
		@RequestParam ("outModel")String model) {
		try {
			if(shape.isEmpty()||shape.equals("全部")) {
				shape="all";
			}
			if(model.isEmpty()||model.equals("全部")) {
				model="all";
			}
			String spec="all";
			CommonDTO result=hpKucunService.getHpKucun(shape, model, spec);
//			System.out.println(result.toString());
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
}
//获取已有焊片型号
@RequestMapping(value="/BusinessInventory/getModel",method=RequestMethod.GET)
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

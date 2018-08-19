package org.npc.plantSCM.controller;

import java.util.List;

import javax.annotation.Resource;

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
public class ModelSettingController {
	@Resource private GetSpecificationService getSpecificationService;
	@RequestMapping(value="/GetModel",method=RequestMethod.GET)
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

	@RequestMapping(value="/InsertModel",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO insertModel(@RequestBody List<String> model){
		try{
			CommonDTO result=getSpecificationService.insertHpModel(model);
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}

	@RequestMapping(value="/DeleteModel",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO deleteModel(@RequestParam ("outModel")String model){
		try{
			CommonDTO result=getSpecificationService.deleteHpModel(model);
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
}

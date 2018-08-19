package org.npc.plantSCM.controller;

import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.po.Phone;
import org.npc.plantSCM.po.Staff;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.service.InformService;
import org.npc.plantSCM.service.MessageService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MessageSettingController {
	@Resource private MessageService messageService;
	
	@RequestMapping(value="/GetPhone",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getPhoneNum(){
		try{
			CommonDTO result=messageService.getPhone();
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}

	
	//增加
	@RequestMapping(value="/SetPhone",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO setPhoneNum(@RequestBody List<Phone> phone){
		try{
			CommonDTO result=messageService.setPhone(phone);
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
	
	@RequestMapping(value="/DeletePhone",method=RequestMethod.POST)
	@ResponseBody
	public CommonDTO deleteModel(Phone  temp){
		try{
			System.out.println(temp);
			CommonDTO result=messageService.deletePhone(temp.getId());
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}
}

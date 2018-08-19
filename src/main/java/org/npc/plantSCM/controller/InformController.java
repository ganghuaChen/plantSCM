package org.npc.plantSCM.controller;

import javax.annotation.Resource;


import org.npc.plantSCM.service.InformService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
public class InformController {
	@Resource private InformService informService;
	//获取全部通知
	@RequestMapping(value="/GetInform",method=RequestMethod.GET)
	@ResponseBody
	public CommonDTO getInform(){
		try{
			CommonDTO result=informService.getInformation();
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			return new CommonDTO(Result.SYSTEM_EXCEPTION);
		}
	}

}

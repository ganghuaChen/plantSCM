package org.npc.plantSCM.service.impl;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.InformDao;
import org.npc.plantSCM.po.Inform;
import org.npc.plantSCM.service.InformService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Service;

@Service("InformService")
public class InformServiceImpl implements InformService{

	@Resource
	private InformDao informDao;
	
	public InformServiceImpl() {
		
	}
	//获取全部通知
	@Override
	public CommonDTO getInformation() {
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(informDao.getInform());
		return result;
	}

	//插入一条通知
	@Override
	public void insertInfo(String informContent) {
		Inform inform = new Inform();
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Shanghai")); 
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		inform.setInformTime((String)df.format(new Date()));
		inform.setInformContent(informContent);
		informDao.insertInform(inform);
	}

}

package org.npc.plantSCM.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.OpenFactoryDao;
import org.npc.plantSCM.po.OpenFactory;
import org.npc.plantSCM.service.OpenFactoryService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.npc.plantSCM.dao.MaterialInventoryDao;
import org.springframework.stereotype.Service;


@Service("OpenFactoryService")
public class OpenFactoryServiceImpl implements OpenFactoryService {
	
	@Resource
	private OpenFactoryDao openFactoryDao;
	
	@Resource
	private MaterialInventoryDao materialInventory;
	
	@Override
	public CommonDTO getOpenFactoryInfo(String model, String beginDate, String endDate)//查看开炉信息
	{
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(openFactoryDao.getOpenFactoryByDateAndModel(model,beginDate,endDate));
		return result;
		
	}
	
	
	//新建开炉信息
	@Override
	public CommonDTO createOpenFactory(List<OpenFactory> list) {
		
		
		for(OpenFactory openfactory:list)
		{
			if(openfactory.getAgWeight()<0||
			openfactory.getCuWeight()<0||
			openfactory.getZnWeight()<0||
			openfactory.getCdWeight()<0||
			openfactory.getSnWeight()<0)
				return new CommonDTO(Result.OPENFACTORY_WEIGHT_TOOLOW);
		}//原料重量不小于0
		
		float total_ag=0;
		float total_cu=0;
		float total_zn=0;
		float total_cd=0;
		float total_sn=0; //计算一批list需要的原料重量
		
		for(OpenFactory openfactory:list)
		{
			total_ag+=openfactory.getAgWeight();
			total_cu+=openfactory.getCuWeight();
			total_zn+=openfactory.getZnWeight();
			total_cd+=openfactory.getCdWeight();
			total_sn+=openfactory.getSnWeight();			
		}//计算list所需原料总量
		
		if (total_ag>materialInventory.getYlremainingInventoryByYlType("银")
				||total_cu>materialInventory.getYlremainingInventoryByYlType("铜")
				||total_zn>materialInventory.getYlremainingInventoryByYlType("锌")
				||total_cd>materialInventory.getYlremainingInventoryByYlType("镉")
				||total_sn>materialInventory.getYlremainingInventoryByYlType("锡"))
		
			return new CommonDTO(Result.MATERIAL_NOT_ENOUGH);
		//任一原料不足，报错
		
		
		for(OpenFactory openfactory:list)
		{
		  openFactoryDao.insertOpenFactory(openfactory);
	    }//写入每一条开炉
	
		materialInventory.modifyYlremainingInventoryByYlType("银",materialInventory.getYlremainingInventoryByYlType("银")-total_ag);
		materialInventory.modifyYlremainingInventoryByYlType("铜",materialInventory.getYlremainingInventoryByYlType("铜")-total_cu);
		materialInventory.modifyYlremainingInventoryByYlType("锌",materialInventory.getYlremainingInventoryByYlType("锌")-total_zn);
		materialInventory.modifyYlremainingInventoryByYlType("镉",materialInventory.getYlremainingInventoryByYlType("镉")-total_cd);
		materialInventory.modifyYlremainingInventoryByYlType("锡",materialInventory.getYlremainingInventoryByYlType("锡")-total_sn);
		//修改原料库存
		
		return new CommonDTO(Result.CREATE_BLOWONRECORD_SUCCESS);
		
	}
	
	@Override
	public CommonDTO modifyOpenFactory(OpenFactory openFactory)//修改开炉登记
	{
		
		if(openFactory.getAgWeight()<0||
				openFactory.getCuWeight()<0||
				openFactory.getZnWeight()<0||
				openFactory.getCdWeight()<0||
				openFactory.getSnWeight()<0)
		        
					return new CommonDTO(Result.OPENFACTORY_WEIGHT_TOOLOW);
			//原料重量不小于0
	
		float TempAg=openFactory.getAgWeight();//保留的新记录的原料重量
		float TempCu=openFactory.getCuWeight();
		float TempSn=openFactory.getSnWeight();
		float TempZn=openFactory.getZnWeight(); 
		float TempCd=openFactory.getCdWeight();		
		
		OpenFactory openFactoryTemp=new OpenFactory(openFactory);
		openFactory=openFactoryDao.checkOpenFactory(openFactory);//传回原来登记的数据
		
		if (materialInventory.getYlremainingInventoryByYlType("银")<TempAg-openFactory.getAgWeight()
				||materialInventory.getYlremainingInventoryByYlType("铜")<TempCu-openFactory.getCuWeight()
				||materialInventory.getYlremainingInventoryByYlType("锌")<TempZn-openFactory.getZnWeight()
				||materialInventory.getYlremainingInventoryByYlType("镉")<TempCd-openFactory.getCdWeight()
				||materialInventory.getYlremainingInventoryByYlType("锡")<TempSn-openFactory.getSnWeight())//判断修改后库存原料够不够
			return new CommonDTO(Result.MATERIAL_NOT_ENOUGH);
		
		
		
		materialInventory.modifyYlremainingInventoryByYlType("银",materialInventory.getYlremainingInventoryByYlType("银")+openFactory.getAgWeight()-TempAg);
		materialInventory.modifyYlremainingInventoryByYlType("铜",materialInventory.getYlremainingInventoryByYlType("铜")+openFactory.getCuWeight()-TempCu);
		materialInventory.modifyYlremainingInventoryByYlType("锌",materialInventory.getYlremainingInventoryByYlType("锌")+openFactory.getZnWeight()-TempZn);
		materialInventory.modifyYlremainingInventoryByYlType("镉",materialInventory.getYlremainingInventoryByYlType("镉")+openFactory.getCdWeight()-TempCd);
		materialInventory.modifyYlremainingInventoryByYlType("锡",materialInventory.getYlremainingInventoryByYlType("锡")+openFactory.getSnWeight()-TempSn);//改库存
		openFactoryDao.updateOpenFactory(openFactoryTemp);
		return new CommonDTO(Result.UPDATE_BLOWONRECORD_SUCCESS);
	}


	
	}
	
	


package org.npc.plantSCM.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.HjInventoryDao;
import org.npc.plantSCM.dao.HpInventoryDao;
import org.npc.plantSCM.dao.HpModelDao;
import org.npc.plantSCM.dao.SonghuoStatisticsDao;
import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.service.GetSpecificationService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Service;

@Service("GetSpecificationService")
public class GetSpecificationServiceImpl implements GetSpecificationService {

	
	@Resource 
	private HpInventoryDao hpInventoryDao;
	
	@Resource 
	private HjInventoryDao  hjInventoryDao;
	
	@Resource
	private SonghuoStatisticsDao songhuoStatisticsDao;
	
	@Resource
	private HpModelDao hpModalDao;
	
	//获取焊片型号
	@Override
	public CommonDTO getHpModel() {
		
		CommonDTO result=new CommonDTO(Result.SUCCESS);
	    result.setResult(hpInventoryDao.getModel());
		return result;
	}

	//获取焊片规格
	@Override
	public CommonDTO getSpec() {	
		CommonDTO result=new CommonDTO(Result.SUCCESS);
	    result.setResult(hpInventoryDao.getSpec());
		return result;
	}

	@Override
	public CommonDTO getHjChangjia() {
		CommonDTO result=new CommonDTO(Result.SUCCESS);
	    result.setResult(hjInventoryDao.getHjFactory());
		return result;
	}

	@Override
	public CommonDTO getCustomer() {
		CommonDTO result=new CommonDTO(Result.SUCCESS);
	    result.setResult(songhuoStatisticsDao.getAllCustomerName());
		return result;
	}

	@Override
	public CommonDTO insertHpModel(List<String> model) {
		//现有型号
		List<String> getHpModel=hpInventoryDao.getModel();
		List<String> froModel=new ArrayList<String>(model);
		List<String> Model=new  ArrayList<String>();
		for(String temp2:model){
			temp2=temp2.replaceAll(" ", "");
			Model.add(temp2);
		}		
		Model.removeAll(getHpModel);		
//		for(String temp:Model){
//			
//			boolean alreadyExist=false;
//	
//			for(String temp1:getHpModel) {
//			
//				if(temp1.equals(temp)) {
//					alreadyExist=true;
//					
//					break;
//					}
//			}
//
//			if(!alreadyExist) {
//				hpModalDao.insertModel(temp);
//			   
//			}
//		}
		for(String temp:Model){
			hpModalDao.insertModel(temp);
		}
	if(Model.size()==froModel.size()-getHpModel.size())
		return new CommonDTO(Result.CREATE_PRODUCTMODELINFO_SUCCESS); 
	else	
		return new CommonDTO(Result.PRODUCTMODELINFO_FAILURE);
	}

	@Override
	public CommonDTO deleteHpModel(String model) {
		List<HpInventory> temp=new ArrayList<HpInventory>();
		temp=hpInventoryDao.getHpInventoryByHp("all", model, "all");
		float totalNum = 0;
		for(HpInventory hp:temp) {
			totalNum+=hp.getActualNumber();
			}
		if(totalNum>0)
			return new CommonDTO(Result.INVENTORY_OVER_ZERO); 
		
		hpModalDao.deleteModel(model);
		return new CommonDTO(Result.UPDATE_PRODUCTMODELINFO_SUCCESS); 
	}
	

}

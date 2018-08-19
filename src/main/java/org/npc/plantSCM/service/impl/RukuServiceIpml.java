package org.npc.plantSCM.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.HjInventoryDao;
import org.npc.plantSCM.dao.HjPurchaseDao;
import org.npc.plantSCM.dao.HpInDao;
import org.npc.plantSCM.dao.HpInventoryDao;
import org.npc.plantSCM.po.HjInventory;
import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpIn;
import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.service.RukuService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Service;


@Service("QuerenRukuService")
public class RukuServiceIpml implements RukuService {

	@Resource private HjPurchaseDao hjPurchaseDao;
	
	@Resource private HjInventoryDao hjInventoryDao;
	
	@Resource private HpInDao hpInDao;
	
	@Resource private HpInventoryDao hpInventoryDao;
	
	
	@Override
	public CommonDTO HanjiQueren(List<HjPurchase> list) {
		for(HjPurchase hjPurchase:list) {

			//System.out.println(hjPurchase);
			if(hjPurchase.getHjStorageState()==true)
				continue;
			
			//入库状态设为true并修改采购和入库记录
			hjPurchase.setHjStorageState(true);
			hjPurchaseDao.updateHjPurchase(hjPurchase);
//			System.out.println(hjPurchase.getHjStorageState());
			//找这家厂和这个规格的库存
			List<HjInventory> tempList=new ArrayList<HjInventory>();		
			tempList=hjInventoryDao.getHjInventoryByFactoryAndType(hjPurchase.getHjFrom(),hjPurchase.getHjSpecies());
			//System.out.println(tempList);
	
			//库存格式和传入的格式不同
			HjInventory tempHj=new HjInventory();
			
			tempHj.setHjFactory(hjPurchase.getHjFrom());
			tempHj.setHjType(hjPurchase.getHjSpecies());
			tempHj.setHjActualNumber(hjPurchase.getHjNumber());
			
			//如果数据库没有这种规格的库存，直接新增。
			if(tempList.isEmpty())
			{			
				hjInventoryDao.insertHjInventory(tempHj);
			}
			
			//如果之前已经有
			else
			{
				tempHj.setHjkcId(tempList.get(0).getHjkcId());
				tempHj.setHjActualNumber(hjPurchase.getHjNumber()+tempList.get(0).getHjActualNumber());
				hjInventoryDao.updateHjInventory(tempHj);			
			}
			
		}
		return new CommonDTO(Result.CONFIRM_HANJIIN_SUCCESS);
	}

	@Override
	public CommonDTO HanpianQueren(List<HpIn> list) {
		
		for(HpIn hpIn:list) {
			
			if(hpIn.getHpstorageState()==true)
				continue;
			
			//入库状态设为true并修改记录
			hpIn.setHpstorageState(true);
			//System.out.println(hpIn.toString());
		    System.out.println("调用updateHpIn之前的hp_purchase_id"+hpIn.getHpPurchaseId());
			hpInDao.updateHpIn(hpIn);
			System.out.println("调用updateHpIn之后的hp_purchase_id"+hpIn.getHpPurchaseId());
			//找这家厂和这个规格的库存
			List<HpInventory> tempList=new ArrayList<HpInventory>();		
			tempList=hpInventoryDao.getHpInventoryByHp(hpIn.getHpShape(), hpIn.getHpModel(), hpIn.getHpSpec());
			
			//库存格式和传入的格式不同
			HpInventory tempHp=new HpInventory();
		
			tempHp.setModel(hpIn.getHpModel());
			tempHp.setShape(hpIn.getHpShape());
			tempHp.setSpec(hpIn.getHpSpec());
			tempHp.setActualNumber(hpIn.getHpstorageWeight());
					
			//如果数据库没有这种规格的库存，直接新增。
			if(tempList.isEmpty())
			{
				
				hpInventoryDao.insertHpInventory(tempHp);
			}	
										
		
		//如果之前已经有
		else
		{
			tempHp.setHpkcId(tempList.get(0).getHpkcId());
			tempHp.setActualNumber(hpIn.getHpstorageWeight()+tempList.get(0).getActualNumber());
			hpInventoryDao.updateHpInventory(tempHp);
		}
	}
        return new CommonDTO(Result.CONFIRM_HANPIANIN_SUCCESS);
    }

	@Override
	public CommonDTO getHpRukuRecord(String beginDate, String endDate, String hpShape, String hpModel,
			Boolean hpstorageState) {
		
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(hpInDao.getHpIn(beginDate, endDate, hpShape, hpModel, hpstorageState));
		return result;
		
	}



	@Override
	public CommonDTO getHjRukuRecord(String hjFrom, Boolean hjStorageState, String beginDate, String endDate) {
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(hjPurchaseDao.getHjRuKu(hjFrom, hjStorageState, beginDate, endDate));
//		System.out.println(result.toString());
		return result;
	}
}

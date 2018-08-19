package org.npc.plantSCM.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.HjInventoryDao;
import org.npc.plantSCM.po.HjInventory;
import org.npc.plantSCM.service.HjKucunService;
import org.npc.plantSCM.service.InformService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Service;

@Service("HjKucunService")
public class HjKucunServiceImpl implements HjKucunService {

	@Resource private HjInventoryDao hjInventoryDao;
	
	@Resource private InformService informService;
	
	@Override
	public CommonDTO getHjKucun(String hjFactory) {

		
		List<HjInventory> hasEmpty=new ArrayList<HjInventory>();
		hasEmpty=hjInventoryDao.getHjInventoryByFactory(hjFactory);//获取所有符合条件的库存，包含0
		
		List<HjInventory> noneEmpty=new ArrayList<HjInventory>();
		
		//剔除0
		for(int i=0;i<hasEmpty.size();i++)
		{
			if(hasEmpty.get(i).getHjActualNumber()!=0)
				noneEmpty.add(hasEmpty.get(i));				
		}
		
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(noneEmpty);
		return result;
	}

	//修改焊剂库存，超级权限
	@Override
	public CommonDTO modifyHjKucun(HjInventory hjInventory) {
		System.out.println(hjInventory);
		informService.insertInfo("焊剂 "+hjInventory.getHjFactory()+" "+hjInventory.getHjType()+" "
		+"仓库库存由"+hjInventoryDao.checkHjInventory(hjInventory.getHjkcId()).getHjActualNumber()+"直接修改为"+hjInventory.getHjActualNumber());
		hjInventoryDao.updateHjInventory(hjInventory);
		return new CommonDTO(Result.UPDATE_CHECKWJR_SUCCESS);
	}

}

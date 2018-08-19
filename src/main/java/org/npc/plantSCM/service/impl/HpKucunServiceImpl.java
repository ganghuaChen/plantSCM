package org.npc.plantSCM.service.impl;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;

import org.npc.plantSCM.dao.HpInventoryDao;
import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.service.HpKucunService;
import org.npc.plantSCM.service.InformService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Service;

@Service("HpKucunService")
public class HpKucunServiceImpl implements HpKucunService{

	@Resource private HpInventoryDao hpInventoryDao;
	
	@Resource private InformService informService;
	
	//获取焊片库存，通过三个参数确定,库存为0不显示
	@Override
	public CommonDTO getHpKucun(String shape, String model, String spec) {
		
		List<HpInventory> hasEmpty=new ArrayList<HpInventory>();
		hasEmpty=hpInventoryDao.getHpInventoryByHp(shape, model, spec);//获取所有符合条件的库存，包含0
		
		List<HpInventory> noneEmpty=new ArrayList<HpInventory>();
		//剔除0
		for(int i=0;i<hasEmpty.size();i++)
		{
			if(hasEmpty.get(i).getActualNumber()!=0)
				noneEmpty.add(hasEmpty.get(i));				
		}
		
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(noneEmpty);
		return result;
	}

	//修改焊片库存，超级权限
	@Override
	public CommonDTO modifyHpKucun(HpInventory hpInventory) {		
		informService.insertInfo("焊片 "+hpInventory.getShape()+" "+hpInventory.getModel()+" "+hpInventory.getSpec()+"仓库库存由"+hpInventoryDao.checkHpInventory(hpInventory.getHpkcId()).getActualNumber()+"直接修改为"+hpInventory.getActualNumber());
		hpInventoryDao.updateHpInventory(hpInventory);
		return new CommonDTO(Result.UPDATE_CHECKWAR_SUCCESS);
	}
}

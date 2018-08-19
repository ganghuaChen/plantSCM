package org.npc.plantSCM.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.MaterialInventoryDao;
import org.npc.plantSCM.dao.ProductPdDao;
import org.npc.plantSCM.po.MaterialInventory;
import org.npc.plantSCM.po.ProductPd;
import org.npc.plantSCM.service.FactoryPdService;
import org.npc.plantSCM.service.InformService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Service;

@Service("FactoryPdService")
public class FactoryPdServiceImpl implements FactoryPdService{

	@Resource
	private ProductPdDao productPdDao;
	
	@Resource 
	private MaterialInventoryDao materialInventoryDao;
	
	@Resource
	private InformService informService;
	
	//新增工厂模块盘点清仓
	@Override
	public CommonDTO createPdRecord(List<ProductPd> list) {
	
		for(ProductPd productPd:list)
		{
			productPdDao.insertProductPd(productPd);
		}		
		return new CommonDTO(Result.CREATE_CHECKWPR_SUCCESS);
	}

	//修改工厂模块修改盘点清仓记录
	@Override
	public CommonDTO modifyPdRecord(ProductPd productpd) {

        productPdDao.updateProductPd(productpd);
		return new CommonDTO(Result.UPDATE_CHECKWPR_SUCCESS);
	} 

	//根据搜索条件返回指定的盘点清仓记录
	@Override
	public CommonDTO getPdRecord(String beginDate, String endDate, String model) {
		
		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(productPdDao.getProductPdByDateAndModel(beginDate, endDate, model));
		return result;
	}

	
	@Override
	public CommonDTO modifyMaterialInventory(MaterialInventory materialInventory) {
		float oldKucun=materialInventoryDao.getYlremainingInventoryByYlType(materialInventory.getYlType());
		materialInventoryDao.modifyYlremainingInventoryByYlType(materialInventory.getYlType(),materialInventory.getYlremainingInventory());
		informService.insertInfo("原料库存"+materialInventory.getYlType()+"由"+oldKucun+"直接修改为"+materialInventory.getYlremainingInventory());
		return new CommonDTO(Result.UPDATE_CHECKWOR_SUCCESS);			
	}

	//返回五种金属的库存
	@Override
	public CommonDTO getMaterialInventory() {
		List<MaterialInventory> m=new ArrayList<MaterialInventory>();//
		String[] str= {"银","铜","锌","镉","锡"};
		
		
		for(int i=0;i<5;i++)
		{
			MaterialInventory temp=new MaterialInventory();
			temp.setYlId(i+1);
			temp.setYlType(str[i]);
			temp.setYlremainingInventory(materialInventoryDao.getYlremainingInventoryByYlType(str[i]));
			m.add(temp);
		}
		
		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(m);
		return result;
		
	}

}

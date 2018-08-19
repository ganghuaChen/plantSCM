package org.npc.plantSCM.service.impl;

import java.math.BigDecimal;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.MaterialPurchaseDao;
import org.npc.plantSCM.po.HjInventory;
import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpIn;
import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.po.HpPurchase;
import org.npc.plantSCM.po.MaterialInventory;
import org.npc.plantSCM.po.MaterialPurchase;
import org.npc.plantSCM.service.CaigouService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Purchase;
import org.npc.plantSCM.vo.Result;
import org.npc.plantSCM.vo.SpecChange;
import org.npc.plantSCM.dao.HjInventoryDao;
import org.npc.plantSCM.dao.HjPurchaseDao;
import org.npc.plantSCM.dao.HpInDao;
import org.npc.plantSCM.dao.HpInventoryDao;
import org.npc.plantSCM.dao.HpPurchaseDao;
import org.npc.plantSCM.dao.MaterialInventoryDao;
import org.springframework.stereotype.Service;

@Service("CaigouService")
public class CaigouServiceImpl implements CaigouService{

	@Resource private MaterialPurchaseDao materialPurchaseDao;
	
	@Resource private MaterialInventoryDao materialInventoryDao;
	
	@Resource private HjPurchaseDao hjPurchaseDao;
	
	@Resource private HjInventoryDao hjInventoryDao;
	
	@Resource private HpPurchaseDao hpPurchaseDao; 
	
	@Resource private HpInventoryDao hpInventoryDao; 
	
	@Resource private HpInDao hpInDao; 
	

	//新建原料焊剂焊片采购单
	@Override
	public CommonDTO createCaigou(Purchase purchase) {
		List<MaterialPurchase> materialPurchaseList=purchase.getMaterialPurchase();
		List<HjPurchase> hjPurchaseList=purchase.getHjPurchase();
		List<HpPurchase> hpPurchaseList=purchase.getHpPurchase();
		
		
		for(HpPurchase hpPurchase:hpPurchaseList) {
			
			SpecChange spec=new SpecChange(hpPurchase.getHpSpec());
			CommonDTO temp= spec.getResult();
			if(temp.getCode()==0)
				hpPurchase.setHpSpec((String)temp.getResult());
			else
				return temp;
			
			//插入采购列表，获得返回值
			int purId;
			hpPurchaseDao.insertHpPurchase(hpPurchase);
			purId=hpPurchase.getId();
			
			HpIn tempHpIn=new HpIn();
			tempHpIn.setHpFrom(false);
			tempHpIn.setHpModel(hpPurchase.getHpModel());
			tempHpIn.setHpShape(hpPurchase.getHpShape());
			tempHpIn.setHpSpec(hpPurchase.getHpSpec());
			tempHpIn.setHpstorageDate(hpPurchase.getHpDate());
			tempHpIn.setHpstorageState(false);
			tempHpIn.setHpstorageWeight(hpPurchase.getHpWeight());
			tempHpIn.setHpPurchaseId(purId);
			
			//插入仓库入库表
			hpInDao.insertHpIn(tempHpIn);
			
			//找这家厂和这个规格的库存
			List<HpInventory> tempList=new ArrayList<HpInventory>();		
			tempList=hpInventoryDao.getHpInventoryByHp(hpPurchase.getHpShape(),hpPurchase.getHpModel(), hpPurchase.getHpSpec());
			
			if(tempList.isEmpty())
			{
			//库存格式和传入的格式不同
			HpInventory tempHp=new HpInventory();
		
			tempHp.setModel(hpPurchase.getHpModel());
			tempHp.setShape(hpPurchase.getHpShape());
			tempHp.setSpec(hpPurchase.getHpSpec());
			tempHp.setActualNumber((float)0);
					
			//如果数据库没有这种规格的库存，直接新增。				
				hpInventoryDao.insertHpInventory(tempHp);
			}	
			
		}
		for(MaterialPurchase materialPurchase:materialPurchaseList)
		{
			//写入采购记录
			materialPurchaseDao.insertMaterialPurchase(materialPurchase);
			//修改库存
			materialInventoryDao.modifyYlremainingInventoryByYlType(materialPurchase.getYlSpecies(), materialPurchase.getYlWeight()+materialInventoryDao.getYlremainingInventoryByYlType(materialPurchase.getYlSpecies()));
		}
		
		
		for(HjPurchase hjPurchase:hjPurchaseList)
		{
			
			hjPurchase.setHjStorageState(false);
			//写入采购记录
			hjPurchaseDao.insertHjPurchase(hjPurchase);
			
			List<HjInventory> tempList=new ArrayList<HjInventory>();		
			tempList=hjInventoryDao.getHjInventoryByFactoryAndType(hjPurchase.getHjFrom(),hjPurchase.getHjSpecies());
	
			if(tempList.isEmpty())
			{
			
				//库存格式和传入的格式不同
			HjInventory tempHj=new HjInventory();
			
			tempHj.setHjFactory(hjPurchase.getHjFrom());
			tempHj.setHjType(hjPurchase.getHjSpecies());
			tempHj.setHjActualNumber(0);
			
			//如果数据库没有这种规格的库存，新增。						
			hjInventoryDao.insertHjInventory(tempHj);
			}
			
		}

		return new CommonDTO(Result.CREATE_PURCHASE_SUCCESS);
		
	}
//	//新建原料采购单
//	@Override
//	public CommonDTO createYuanliaoCaigou(List<MaterialPurchase> list) {
//		
//		for(MaterialPurchase materialPurchase:list)
//		{
//			//写入采购记录
//			materialPurchaseDao.insertMaterialPurchase(materialPurchase);
//			//修改库存
//			materialInventoryDao.modifyYlremainingInventoryByYlType(materialPurchase.getYlSpecies(), materialPurchase.getYlWeight()+materialInventoryDao.getYlremainingInventoryByYlType(materialPurchase.getYlSpecies()));
//		}
//		return new CommonDTO(Result.SUCCESS);
//		
//	}

	@Override
	public CommonDTO modifyYuanliaoCaigou(MaterialPurchase materialPurchase) {
        
		float originalWeight=0;
		//获取原来采购记录的重量
		originalWeight=materialPurchaseDao.getMaterialPurchasebyId(materialPurchase.getId());
		//根据修改后的采购记录修改库存
		materialInventoryDao.modifyYlremainingInventoryByYlType(materialPurchase.getYlSpecies(),materialInventoryDao.getYlremainingInventoryByYlType(materialPurchase.getYlSpecies())-originalWeight+materialPurchase.getYlWeight());
		//重新写入采购记录
		materialPurchaseDao.updateMaterialPurchase(materialPurchase);
		
		return new CommonDTO(Result.UPDATE_PURCHASEYUANLIAO_SUCCESS);
		
				
	}

	@Override
	public CommonDTO getYuanliaoCaigou(String ylFactory, String ylSpecies, String beginDate, String endDate) {

		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(materialPurchaseDao.getMaterialPurchase(ylFactory, ylSpecies, beginDate, endDate));
		return result;
	}

	@Override
	public CommonDTO getYUanliaoTongji(String beginDate, String endDate) {
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(materialPurchaseDao.getMaterialPurchaseStatistics(beginDate, endDate));
		return result;
	}
	
//	@Override
//	public CommonDTO createHanjiCaigou(List<HjPurchase> list) {
//		
//		for(HjPurchase hjPurchase:list)
//		{
//			
//			hjPurchase.setHjStorageState(false);
//			//写入采购记录
//			hjPurchaseDao.insertHjPurchase(hjPurchase);
//			
//		}
//		return new CommonDTO(Result.SUCCESS);
//	}

	
	@Override
	public CommonDTO modifyHanjiCaigou(HjPurchase hjPurchase) {
		boolean whetherRuku=hjInventoryDao.whetherRuku(hjPurchase.getId());
		//已确认入库的无法修改
		if(whetherRuku==true)
			return new CommonDTO(Result.HAS_ALREADY_RUKU);
		else
			hjPurchaseDao.updateHjPurchase(hjPurchase);
		return new CommonDTO(Result.UPDATE_PURCHASEHANJI_SUCCESS);
	}

	//焊剂采购信息
	@Override
	public CommonDTO getHanjiCaigou(String hjFrom, String beginDate, String endDate) {
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(hjPurchaseDao.getHjPurchase(hjFrom, beginDate, endDate));
		return result;
	}

	//焊剂采购统计
	@Override
	public CommonDTO getHanjiTongji(String beginDate, String endDate) {
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(hjPurchaseDao.getHjPurchaseStatistics(beginDate, endDate));
		return result;
	}

//	//新建焊片采购
//	@Override
//	public CommonDTO createHanpianCaigou(List<HpPurchase> list) {
//		for(HpPurchase hpPurchase:list) {
//			
//			SpecChange spec=new SpecChange(hpPurchase.getHpSpec());
//			CommonDTO temp= spec.getResult();
//			if(temp.getCode()==0)
//				hpPurchase.setHpSpec((String)temp.getResult());
//			else
//				return temp;
//			
//			//插入采购列表，获得返回值
//			int purId;
//			hpPurchaseDao.insertHpPurchase(hpPurchase);
//			purId=hpPurchase.getId();
//			
//			HpIn tempHpIn=new HpIn();
//			tempHpIn.setHpFrom(false);
//			tempHpIn.setHpModel(hpPurchase.getHpModel());
//			tempHpIn.setHpShape(hpPurchase.getHpShape());
//			tempHpIn.setHpSpec(hpPurchase.getHpSpec());
//			tempHpIn.setHpstorageDate(hpPurchase.getHpDate());
//			tempHpIn.setHpstorageState(false);
//			tempHpIn.setHpstorageWeight(hpPurchase.getHpWeight());
//			tempHpIn.setHpPurchaseId(purId);
//			
//			//插入仓库入库表
//			hpInDao.insertHpIn(tempHpIn);
//			
//		}
//		
//		return new CommonDTO(Result.SUCCESS);
//	}

	@Override
	public CommonDTO modifyHanpianCaigou(HpPurchase hpPurchase) {
		
		SpecChange spec=new SpecChange(hpPurchase.getHpSpec());
		CommonDTO temp= spec.getResult();
		if(temp.getCode()==0)
			hpPurchase.setHpSpec((String)temp.getResult());
		else
			return temp;
		
		HpIn tempHpIn=new HpIn();
		tempHpIn=hpInDao.checkHpInByPurchaseId(hpPurchase.getId());
		
		if(tempHpIn.getHpstorageState()==true)
			return new CommonDTO(Result.HAS_ALREADY_RUKU);
		
		tempHpIn.setHpFrom(false);
		tempHpIn.setHpModel(hpPurchase.getHpModel());
		tempHpIn.setHpShape(hpPurchase.getHpShape());
		tempHpIn.setHpSpec(hpPurchase.getHpSpec());
		tempHpIn.setHpstorageDate(hpPurchase.getHpDate());
		tempHpIn.setHpstorageState(false);
		tempHpIn.setHpstorageWeight(hpPurchase.getHpWeight());
		tempHpIn.setHpPurchaseId(hpPurchase.getId());
		
		hpPurchaseDao.updateHpPurchase(hpPurchase);
		//修改仓库入库表
		hpInDao.updateHpIn(tempHpIn);
		
		return new CommonDTO(Result.UPDATE_PURCHASEHANPIAN_SUCCESS);
	}

	@Override
	public CommonDTO getHanpianCaigou(String hpFactory, String beginDate, String endDate) {
		
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(hpPurchaseDao.getHpPurchase(hpFactory, beginDate, endDate));
		return result;
	}

	@Override
	public CommonDTO getHanpianTongji(String beginDate, String endDate) {
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(hpPurchaseDao.getHpPurchaseStatistics(beginDate, endDate));
		return result;
	}
	@Override
	public CommonDTO getYuanliaoAveragePrice() {
		String[] type= {"银","铜","锌","镉","锡"}; 
		float[] weight=new float[5];
		float[] remainWeight=new float[5];
		float[] totalPrice=new float[5];
		float[] averPrice=new float[5];
		
		for(int i=0;i<type.length;i++) {
			weight[i]=materialInventoryDao.getYlremainingInventoryByYlType(type[i]);
			remainWeight[i]=weight[i]; 
			totalPrice[i]=0;
			averPrice[i]=0;
		}
		
		List<MaterialPurchase> yin= materialPurchaseDao.getMaterialPurchase("all","银", "2000-01-01", "2030-12-31");
		List<MaterialPurchase> tong= materialPurchaseDao.getMaterialPurchase("all","铜", "2000-01-01", "2030-12-31");
		List<MaterialPurchase> xin= materialPurchaseDao.getMaterialPurchase("all","锌", "2000-01-01", "2030-12-31");
		List<MaterialPurchase> ge= materialPurchaseDao.getMaterialPurchase("all","镉", "2000-01-01", "2030-12-31");
		List<MaterialPurchase> xi= materialPurchaseDao.getMaterialPurchase("all","锡", "2000-01-01", "2030-12-31");
		
			
        for(int i=0;i<yin.size();i++) {
        	if(remainWeight[0]>=yin.get(i).getYlWeight()) {
        		totalPrice[0]+=yin.get(i).getYlTotalPrice();
        		remainWeight[0]-=yin.get(i).getYlWeight();
        		continue;
        	}
        	else {
        		totalPrice[0]+=(remainWeight[0]*yin.get(i).getYlPrice());
        		remainWeight[0]=0;
        		break;
        	}
        }
        
        for(int i=0;i<tong.size();i++) {
        	if(remainWeight[1]>=tong.get(i).getYlWeight()) {
        		totalPrice[1]+=tong.get(i).getYlTotalPrice();
        		remainWeight[1]-=tong.get(i).getYlWeight();
        		continue;
        	}
        	else {
        		totalPrice[1]+=(remainWeight[1]*tong.get(i).getYlPrice());
        		remainWeight[1]=0;
        		break;
        	}
        }
        
        for(int i=0;i<xin.size();i++) {
        	if(remainWeight[2]>=xin.get(i).getYlWeight()) {
        		totalPrice[2]+=xin.get(i).getYlTotalPrice();
        		remainWeight[2]-=xin.get(i).getYlWeight();
        		continue;
        	}
        	else {
        		totalPrice[2]+=(remainWeight[2]*xin.get(i).getYlPrice());
        		remainWeight[2]=0;
        		break;
        	}
        }
        
        for(int i=0;i<ge.size();i++) {
        	if(remainWeight[3]>=ge.get(i).getYlWeight()) {
        		totalPrice[3]+=ge.get(i).getYlTotalPrice();
        		remainWeight[3]-=ge.get(i).getYlWeight();
        		continue;
        	}
        	else {
        		totalPrice[3]+=(remainWeight[3]*ge.get(i).getYlPrice());
        		remainWeight[3]=0;
        		break;
        	}
        }
        
        for(int i=0;i<xi.size();i++) {
        	if(remainWeight[4]>=xi.get(i).getYlWeight()) {
        		totalPrice[4]+=xi.get(i).getYlTotalPrice();
        		remainWeight[4]-=xi.get(i).getYlWeight();
        		continue;
        	}
        	else {
        		totalPrice[4]+=(remainWeight[4]*xi.get(i).getYlPrice());
        		remainWeight[4]=0;
        		break;
        	}
        }
		
		
		for(int i=0;i<type.length;i++) {
			if(weight[i]-remainWeight[i]==0) {
				averPrice[i]=0;
				continue;
			}			
			averPrice[i]=totalPrice[i]/(weight[i]-remainWeight[i]);
			BigDecimal b=new BigDecimal(averPrice[i]);  
			averPrice[i]=b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();  
		}
		
		
		MaterialInventory yin1=new MaterialInventory("银",averPrice[0]);
		MaterialInventory tong1=new MaterialInventory("铜",averPrice[1]);
		MaterialInventory xin1=new MaterialInventory("锌",averPrice[2]);
		MaterialInventory ge1=new MaterialInventory("镉",averPrice[3]);
		MaterialInventory xi1=new MaterialInventory("锡",averPrice[4]);
        
		List<MaterialInventory> list=new ArrayList<MaterialInventory>();
		list.add(yin1);
		list.add(tong1);
		list.add(xin1);
		list.add(ge1);
		list.add(xi1);
		
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(list);
		return result;
		
	}

	
}

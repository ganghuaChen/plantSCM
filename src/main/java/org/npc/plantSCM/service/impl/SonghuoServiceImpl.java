package org.npc.plantSCM.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.HjInventoryDao;
import org.npc.plantSCM.dao.HjOrderDao;
import org.npc.plantSCM.dao.HpInventoryDao;
import org.npc.plantSCM.dao.HpOrderDao;
import org.npc.plantSCM.dao.SonghuoStatisticsDao;
import org.npc.plantSCM.po.HjInventory;
import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.po.SonghuoStatistics;
import org.npc.plantSCM.service.SonghuoService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Order;
import org.npc.plantSCM.vo.Result;
import org.springframework.stereotype.Service;

@Service("SonghuoService")
public class SonghuoServiceImpl implements SonghuoService {

	@Resource private HpOrderDao hpOrderDao;
	
	@Resource private HjOrderDao hjOrderDao;
	
	@Resource private HjInventoryDao hjInventoryDao;
	
	@Resource private HpInventoryDao hpInventoryDao;
	
	@Resource private SonghuoStatisticsDao songhuoStatisticsDao;
	
	
	@Override
	public CommonDTO modifyHanjiSonghuo(HjOrder hjOrder) {
		
		HjOrder hjTemp=new HjOrder();
		hjTemp.setHjorderId(hjOrder.getHjorderId());
		hjTemp = hjOrderDao.checkHjOrder(hjTemp);
		
		if(hjTemp.getHjorderState()=="已送达")
			return new CommonDTO(Result.HAS_ALREADY_SONGHUO);
		
		//送出数量发生变化
		if(hjTemp.getHjsongchuNumber()!=hjOrder.getHjsongchuNumber()) {		
			
			List<HjInventory> list = hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType());
			HjInventory hjInventory = list.get(0);
			
			int oldNum=hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).get(0).getHjActualNumber();
			oldNum=oldNum+hjTemp.getHjsongchuNumber()-hjOrder.getHjsongchuNumber();
			if(oldNum<0)
				return new CommonDTO(Result.SONGHUO_KUCUN_NOTENOUGH);

			hjInventory.setHjActualNumber(oldNum);
			hjInventoryDao.updateHjInventory(hjInventory);		
		}
		hjOrderDao.updateHjOrder(hjOrder);
		return new CommonDTO(Result.UPDATE_HANJIDELIVERY_SUCCESS);
		
	}

	@Override
	public CommonDTO getHanjiSonghuo(String hjCustomerName, String hjorderState, String beginDate, String endDate) {
		
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(hjOrderDao.getHjOrder(hjCustomerName, hjorderState, beginDate, endDate));
		return result;
	}

	@Override
	public CommonDTO modifyHanpianSonghuo(HpOrder hpOrder) {
		
		HpOrder hpTemp=new HpOrder();
		hpTemp.setHporderId(hpOrder.getHporderId());
		hpTemp = hpOrderDao.checkHpOrder(hpTemp);
		
		if(hpTemp.getHporderState()=="已送达") 	
			return new CommonDTO(Result.HAS_ALREADY_SONGHUO);
	
		
		if(hpTemp.getHporderState()=="工厂送货")
			return new CommonDTO(Result.GONGCHANG_DELIVER);
			
		
		if(hpOrder.getHpsongchuNumber()!=hpTemp.getHpsongchuNumber()) {
			
			List<HpInventory> list  = hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(),hpOrder.getHporderModel(), hpOrder.getHporderSpec());
			HpInventory hpInventory=list.get(0);
			
			float oldNum=hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(), hpOrder.getHporderModel(), hpOrder.getHporderSpec()).get(0).getActualNumber();
			System.out.println(oldNum+" "+hpTemp.getHpsongchuNumber()+" "+hpOrder.getHpsongchuNumber());
			oldNum=oldNum+hpTemp.getHpsongchuNumber()-hpOrder.getHpsongchuNumber();
			if(oldNum<0)
				return new CommonDTO(Result.SONGHUO_KUCUN_NOTENOUGH);

			hpInventory.setActualNumber(oldNum);
			
			hpInventoryDao.updateHpInventory(hpInventory);			
		}
		hpOrderDao.updateHpOrder(hpOrder);
		return new CommonDTO(Result.UPDATE_HANPIANDELIVERY_SUCCESS);
	}

	@Override
	public CommonDTO getHanpianSonghuo(String hpCustomerName, String hporderShape, String hporderModel,
			String hporderState, String beginDate, String endDate) {
			
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(hpOrderDao.getHpOrder(hpCustomerName, hporderShape, hporderModel, hporderState, beginDate, endDate));
		return result;
	}


	@Override
	public CommonDTO getSonghuoTongji(String customerName, String beginDate, String endDate) {
		
		List<SonghuoStatistics> list=new ArrayList<SonghuoStatistics>();
	
		if(customerName=="all") {
			List<String> name =songhuoStatisticsDao.getAllCustomerName();
			for(int i=0;i<name.size();i++) 
				list.add(songhuoStatisticsDao.getSonghuoStatistics(name.get(i), beginDate, endDate));
		}
		else {
			list.add(songhuoStatisticsDao.getSonghuoStatistics(customerName, beginDate, endDate));
		}
		
		CommonDTO result=new CommonDTO(Result.SUCCESS);
		result.setResult(list);
		return result;
	}
}
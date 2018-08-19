package org.npc.plantSCM.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.HjInventoryDao;
import org.npc.plantSCM.dao.HjOrderDao;
import org.npc.plantSCM.dao.HpInventoryDao;
import org.npc.plantSCM.dao.HpOrderDao;
import org.npc.plantSCM.dao.PhoneDao;
import org.npc.plantSCM.dao.StaffDao;
import org.npc.plantSCM.po.HjInventory;
import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.po.Phone;
import org.npc.plantSCM.service.InformService;
import org.npc.plantSCM.service.MessageService;
import org.npc.plantSCM.service.XiadanService;
import org.npc.plantSCM.util.SMSUtils;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Order;
import org.npc.plantSCM.vo.Result;
import org.npc.plantSCM.vo.SpecChange;
import org.springframework.stereotype.Service;

@Service("XiadanService")
public class XiadanServiceImpl implements XiadanService {

	@Resource private HpOrderDao hpOrderDao;
	
	@Resource private HjOrderDao hjOrderDao;
	
	@Resource private HjInventoryDao hjInventoryDao;
	
	@Resource private HpInventoryDao hpInventoryDao;
	
	@Resource private InformService informService;
	
	@Resource private MessageService message;
	
	@Resource private PhoneDao phoneDao;
	

	@Override
	public CommonDTO modifyHanjiOrder(HjOrder hjOrder) {

        HjOrder hjTemp=new HjOrder();
		hjTemp.setHjorderId(hjOrder.getHjorderId());
		hjTemp=hjOrderDao.checkHjOrder(hjTemp);
		
		//如果已经送达，无法修改
		if(hjTemp.getHjorderState()=="已送达"||hjTemp.getHjorderState()=="部分送达") 
			return new CommonDTO(Result.HAS_ALREADY_SONGHUO);
	
		
		hjOrderDao.updateHjOrder(hjOrder);
		
		//如果数量形态发生变化，重新查一遍库存
		if(!((hjOrder.getHjorderNumber()==hjTemp.getHjorderNumber())&&
			hjOrder.getHjorderFactory()==hjTemp.getHjorderFactory()&&
			hjOrder.getHjType()==hjOrder.getHjType())) {
			
			if(hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).isEmpty()||
		       hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).get(0).getHjActualNumber()<hjOrder.getHjorderNumber()) {		
				informService.insertInfo("焊剂库存不足："+hjOrder.getHjCustomerName()+" 前台修改订单 "+hjOrder.getHjorderFactory()+" "+hjOrder.getHjType()+" 数量 "+hjOrder.getHjorderNumber()+" 现有库存"+ hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).get(0).getHjActualNumber());
					}
		}
		return new CommonDTO(Result.UPDATE_HANJIORDER_SUCCESS);
		
	}
	
	@Override
	public CommonDTO deleteHanjiOrder(int id) {
		 
		HjOrder hjTemp=new HjOrder();
		hjTemp.setHjorderId(id);
		hjTemp=hjOrderDao.checkHjOrder(hjTemp);
		
		//已送达不修改
		if(hjTemp.getHjorderState()=="已送达"||hjTemp.getHjorderState()=="部分送达")
			return new CommonDTO(Result.HAS_ALREADY_SONGHUO);
		
		//状态写入已取消
		hjTemp.setHjorderState("已取消");
		hjOrderDao.updateHjOrder(hjTemp);
		
		return new CommonDTO(Result.CANCLE_HANJIORDER_SUCCESS);
		
	}

	
	@Override
	public CommonDTO getHanjiOrder(String hjCustomerName, String hjorderState, String beginDate, String endDate) {
		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(hjOrderDao.getHjOrder(hjCustomerName, hjorderState, beginDate, endDate));
		return result;
	}
	
	@Override
	public CommonDTO getHanjiFirstOrder(String hjCustomerName, String hjorderState, String beginDate, String endDate) {
		
		//获得历史订单
				List<HjOrder> list=new ArrayList<HjOrder>();
				List<HjOrder> getHistory=hjOrderDao.getHjOrder(hjCustomerName,hjorderState, beginDate, endDate);
				
				//取最近日期的记录
				for(int i=0;i<getHistory.size();i++) {
					HjOrder tempOrder=new HjOrder();
					tempOrder=getHistory.get(i);
					list.add(tempOrder);
					if(i!=getHistory.size()-1) {
					if(getHistory.get(i).getHjProductDate()!=getHistory.get(i+1).getHjProductDate())
						break;		
					}
				}
		
		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(list);
		return result;
	}

	
	@Override
	public CommonDTO getHanjiTongji(String beginDate, String endDate) {
		
		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(hjOrderDao.getHjOrderStatistics(beginDate, endDate));
		return result;
	}
	

	
	@Override
	public CommonDTO modifyHanpianOrder(HpOrder hpOrder) {
		 HpOrder hpTemp=new HpOrder();
			hpTemp.setHporderId(hpOrder.getHporderId());
			hpTemp=hpOrderDao.checkHpOrder(hpTemp);
			
			if(hpTemp.getHporderState()=="已送达"||hpTemp.getHporderState()=="部分送达")
				return new CommonDTO(Result.HAS_ALREADY_SONGHUO);
			
			
			SpecChange spec=new SpecChange(hpOrder.getHporderSpec());
			CommonDTO temp= spec.getResult();
			if(temp.getCode()==0)
				hpOrder.setHporderSpec((String)temp.getResult());
			else
				return temp;
			
			hpOrderDao.updateHpOrder(hpOrder);
			
			//如果形态发生变化，重新通知
			if(!((hpOrder.getHporderNumber()==hpTemp.getHporderNumber())&&
				(hpOrder.getHporderModel()==hpTemp.getHporderModel())&&
				(hpOrder.getHporderShape()==hpTemp.getHporderShape())&&
				(hpOrder.getHporderSpec()==hpTemp.getHporderSpec()))) {
				
				if(hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(), hpOrder.getHporderModel(), hpOrder.getHporderSpec()).isEmpty()||
			       hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(), hpOrder.getHporderModel(), hpOrder.getHporderSpec()).get(0).getActualNumber()<hpOrder.getHporderNumber()) {		
					informService.insertInfo("焊片库存不足："+hpOrder.getHpCustomerName()+" 前台修改订单 "+hpOrder.getHporderShape()+" "+hpOrder.getHporderModel()+" "+ hpOrder.getHporderSpec()+" 数量 "+hpOrder.getHporderNumber()+" 现有库存"+hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(), hpOrder.getHporderModel(), hpOrder.getHporderSpec()).get(0).getActualNumber());
						}
			}
			return new CommonDTO(Result.UPDATE_HANPIANORDER_SUCCESS);
	}

	
	@Override
	public CommonDTO deleteHanpianOrder(int id) {
		HpOrder hpTemp=new HpOrder();
		hpTemp.setHporderId(id);
		hpTemp=hpOrderDao.checkHpOrder(hpTemp);
		
		if(hpTemp.getHporderState()=="部分送达"||hpTemp.getHporderState()=="已送达")
			return new CommonDTO(Result.HAS_ALREADY_SONGHUO);
		
		hpTemp.setHporderState("已取消");
		hpOrderDao.updateHpOrder(hpTemp);
		
		return new CommonDTO(Result.CANCLE_HANPIANORDER_SUCCESS);
	}

	
	@Override
	public CommonDTO getHanpianOrder(String hpCustomerName, String hporderShape, String hporderModel,
			String hporderState, String beginDate, String endDate) {
		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(hpOrderDao.getHpOrder(hpCustomerName, hporderShape, hporderModel, hporderState, beginDate, endDate));
		return result;
	}
	
	@Override
	public CommonDTO getHanpianFirstOrder(String hpCustomerName, String hporderShape, String hporderModel,
		String hporderState, String beginDate, String endDate) {
		
		//获得历史订单
		List<HpOrder> list=new ArrayList<HpOrder>();
		List<HpOrder> getHistory=hpOrderDao.getHpOrder(hpCustomerName, hporderShape, hporderModel, hporderState, beginDate, endDate);
		
		//取最近日期的记录
		for(int i=0;i<getHistory.size();i++) {
			HpOrder tempOrder=new HpOrder();
			tempOrder=getHistory.get(i);
			list.add(tempOrder);
			if(i!=getHistory.size()-1) {
			if(getHistory.get(i).getHporderDate()!=getHistory.get(i+1).getHporderDate())
				break;	
			}
		}
		
		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(list);
		return result;
	}

	
	@Override
	public CommonDTO getHanpianTongji(String beginDate, String endDate) {
		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(hpOrderDao.getHpOrderStatistics(beginDate, endDate));
		return result;
	}



	@Override
	public CommonDTO createOrder(Order order) {
		List<HjOrder> listHj=order.getHjOrder();
		List<HpOrder> listHp=order.getHpOrder();
		
		//短信内容控制
		String Ordercustomer="";
		String Ordertrade="";
		String Ordernum="";
		String Orderjudge="";
		
		if(listHj.isEmpty())
			Ordercustomer=listHp.get(0).getHpCustomerName();
		else
			Ordercustomer=listHj.get(0).getHjCustomerName();
		
		
		CommonDTO result=new CommonDTO(Result.CREATE_ORDER_SUCCESS);
		
          	for(HpOrder hpOrder:listHp) {
			
			
			
			
			SpecChange spec=new SpecChange(hpOrder.getHporderSpec());
			CommonDTO temp= spec.getResult();
			if(temp.getCode()==0)
				hpOrder.setHporderSpec((String)temp.getResult());
			else
				return temp;
			
			//执行人是工厂，状态选用工厂送货
			if(hpOrder.getHporderPerformer().equals("工厂")) {
				hpOrder.setHporderState("工厂送货");
				hpOrder.setHpsongchuNumber(hpOrder.getHporderNumber());
				hpOrder.setHpweisongNumber(0);
			}
			else {
				hpOrder.setHporderState("未送达");
				//送出填0，防止送货service减法报错
				hpOrder.setHpsongchuNumber(0);
				hpOrder.setHpweisongNumber(hpOrder.getHporderNumber());
			}
			
			hpOrderDao.insertHpOrder(hpOrder);
			
			//库存原来没有这种东西
			if(hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(), hpOrder.getHporderModel(), hpOrder.getHporderSpec()).isEmpty()) {				
				HpInventory hpInventory=new HpInventory();
				hpInventory.setModel(hpOrder.getHporderModel());
				hpInventory.setShape(hpOrder.getHporderShape());
				hpInventory.setSpec(hpOrder.getHporderSpec());
				hpInventory.setActualNumber((float) 0);
				hpInventoryDao.insertHpInventory(hpInventory);
			}
			
			//库存不足插入通知
			if(hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(), hpOrder.getHporderModel(), hpOrder.getHporderSpec()).get(0).getActualNumber()<hpOrder.getHporderNumber()) {		
				
				informService.insertInfo("焊片库存不足："+hpOrder.getHpCustomerName()+" 新订单 "+hpOrder.getHporderShape()+" "+hpOrder.getHporderModel()+" "+hpOrder.getHporderSpec()+" 数量 "+hpOrder.getHporderNumber()+" 现有库存"+hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(), hpOrder.getHporderModel(), hpOrder.getHporderSpec()).get(0).getActualNumber());
			
				result.setCode(114);
				result.setMsg("下单成功。部分库存不足，已写入通知提醒");
			}

			
			Ordertrade+=hpOrder.getHporderModel()+hpOrder.getHporderShape()+hpOrder.getHporderSpec()+",";
			Ordernum+=hpOrder.getHporderNumber()+",";
			Orderjudge+=hpInventoryDao.getHpInventoryByHp(hpOrder.getHporderShape(), hpOrder.getHporderModel(), hpOrder.getHporderSpec()).get(0).getActualNumber()+",";

		}
          	
          	for(HjOrder hjOrder:listHj) {
			
			//新建时送出数量填0，避免送货service减法报错
			hjOrder.setHjsongchuNumber(0);
			hjOrder.setHjweisongNumber(hjOrder.getHjorderNumber());
			hjOrder.setHjorderState("未送达");

			hjOrderDao.insertHjOrder(hjOrder);

			//库存原来没有这种东西
			if(hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).isEmpty()) {				
				HjInventory hjInventory=new HjInventory();
				hjInventory.setHjFactory(hjOrder.getHjorderFactory());
				hjInventory.setHjType(hjOrder.getHjType());
				hjInventory.setHjActualNumber(0);
				hjInventoryDao.insertHjInventory(hjInventory);
			}
			
			//库存不足插入通知
			if(hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).get(0).getHjActualNumber()<hjOrder.getHjorderNumber()) {		
				informService.insertInfo("焊剂库存不足："+hjOrder.getHjCustomerName()+" 新订单 "+hjOrder.getHjorderFactory()+" "+hjOrder.getHjType()+" 数量 "+hjOrder.getHjorderNumber()+" 现有库存"+hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).get(0).getHjActualNumber());
				Orderjudge+=hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).get(0).getHjActualNumber();
				result.setCode(114);
				result.setMsg("下单成功。部分库存不足，已写入通知提醒");
			}
				
				
			Ordertrade+=hjOrder.getHjorderFactory()+" "+hjOrder.getHjType()+",";
			Ordernum+=hjOrder.getHjorderNumber()+",";
			Orderjudge+=hjInventoryDao.getHjInventoryByFactoryAndType(hjOrder.getHjorderFactory(), hjOrder.getHjType()).get(0).getHjActualNumber()+",";
		}
         // System.out.println(Ordercustomer+"新增订单"+Ordertrade+"数量"+Ordernum+"库存"+Orderjudge);
        //发短信
          	List<Phone> phone=phoneDao.getPhone();
          	for(Phone sendMsg:phone) {
          	try {
             	SMSUtils.sendSMS(sendMsg.getPhone(), Ordercustomer+"新增订单"+Ordertrade+"数量"+Ordernum+"库存"+Orderjudge);
             }catch (Exception e) {
     			e.printStackTrace();
     		}
          	}
          	
		return result;
		}


}

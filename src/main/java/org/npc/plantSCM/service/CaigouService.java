package org.npc.plantSCM.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpPurchase;
import org.npc.plantSCM.po.MaterialPurchase;
import org.npc.plantSCM.po.MaterialPurchaseStatistics;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Purchase;

public interface CaigouService {

//	public CommonDTO createYuanliaoCaigou(List<MaterialPurchase> list);//新建原料采购订单
	public CommonDTO modifyYuanliaoCaigou(MaterialPurchase materialPurchase);//修改原料采购订单
	public CommonDTO getYuanliaoCaigou(String ylFactory,String ylSpecies,String beginDate,String endDate);//Controller和Dao商量好默认值
	public CommonDTO getYUanliaoTongji(String beginDate,String endDate);
	
//	public CommonDTO createHanjiCaigou(List<HjPurchase> list);//新建焊剂采购订单
	public CommonDTO modifyHanjiCaigou(HjPurchase hjPurchase);//修改焊剂采购订单
	public CommonDTO getHanjiCaigou(String hjFrom,String beginDate, String endDate);//Controller和Dao商量好默认值，返回List
	public CommonDTO getHanjiTongji( String beginDate,String endDate);//Controller和Dao商量好默认值，返回List
	
//	public CommonDTO createHanpianCaigou(List<HpPurchase> list);//新建焊片采购订单
	public CommonDTO modifyHanpianCaigou(HpPurchase hpPurchase);//修改焊片采购订单
	public CommonDTO getHanpianCaigou(String hpFactory,String beginDate, String endDate);//Controller和Dao商量好默认值，返回List
	public CommonDTO getHanpianTongji(String beginDate,String endDate);//Controller和Dao商量好默认值，返回List
	public CommonDTO createCaigou(Purchase purchase);//新建原料焊剂焊片采购单
	public CommonDTO getYuanliaoAveragePrice();//原料平均价格
	
	
}

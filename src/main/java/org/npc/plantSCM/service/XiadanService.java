package org.npc.plantSCM.service;

import java.util.List;

import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Order;


public interface XiadanService {

	public CommonDTO modifyHanjiOrder(HjOrder hjOrder);
	public CommonDTO deleteHanjiOrder(int id);
	public CommonDTO getHanjiOrder(String hjCustomerName,String hjorderState,String beginDate,String endDate);
	public CommonDTO getHanjiTongji(String beginDate,String endDate);

	public CommonDTO modifyHanpianOrder(HpOrder hpOrder);
	public CommonDTO deleteHanpianOrder(int id);
	public CommonDTO getHanpianOrder(String hpCustomerName,String hporderShape,String hporderModel, String hporderState,String beginDate,String endDate);
	public CommonDTO getHanpianTongji(String beginDate,String endDate);
	
	public CommonDTO createOrder(Order order);
	
	public CommonDTO getHanpianFirstOrder(String hpCustomerName, String hporderShape, String hporderModel, String hporderState,
			String beginDate, String endDate);
	public CommonDTO getHanjiFirstOrder(String hjCustomerName, String hjorderState, String beginDate, String endDate);
}

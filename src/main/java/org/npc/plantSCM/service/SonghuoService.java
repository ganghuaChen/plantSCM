package org.npc.plantSCM.service;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.HjOrder;
import org.npc.plantSCM.po.HpOrder;
import org.npc.plantSCM.vo.CommonDTO;

public interface SonghuoService {

	public CommonDTO modifyHanjiSonghuo(HjOrder hjOrder);
	public CommonDTO getHanjiSonghuo(String hjCustomerName,String hjorderState,String beginDate, String endDate);
	
	public CommonDTO modifyHanpianSonghuo(HpOrder hpOrder);
	public CommonDTO getHanpianSonghuo(String hpCustomerName,String hporderShape,String hporderModel,String hporderState, String beginDate,String endDate);
//	public CommonDTO getSonghuo(String CustomerName, String beginDate, String endDate, String hporderShape,
//			String hporderModel);

	public CommonDTO getSonghuoTongji(String customerName, String beginDate, String endDate);




	
}

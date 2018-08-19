package org.npc.plantSCM.service;

import java.util.List;

import org.npc.plantSCM.po.HjPurchase;
import org.npc.plantSCM.po.HpIn;
import org.npc.plantSCM.vo.CommonDTO;

public interface RukuService {
		public CommonDTO HanjiQueren (List<HjPurchase> list);
		public CommonDTO HanpianQueren (List<HpIn> list);
		
		//入库表的显示，和Dao商量默认值
		public CommonDTO getHpRukuRecord(String beginDate,String endDate,String hpShape,String hpModel,Boolean hpstorageState);
		public CommonDTO getHjRukuRecord(String hjFrom, Boolean hjStorageState, String beginDate, String endDate);
}

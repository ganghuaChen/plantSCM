package org.npc.plantSCM.service;

import java.util.List;

import org.npc.plantSCM.po.HpOut;
import org.npc.plantSCM.vo.CommonDTO;

public interface HpChuchangService {
	
    public CommonDTO createNewChuchang(List<HpOut> list);//新建焊片出厂记录
    public CommonDTO modifyChuchang(HpOut hpOut);//修改焊片出厂记录
    public CommonDTO getChuchangRecord(String beginDate, String endDate,String outShape, String outModel);//搜索获取焊片出厂记录，commonDTO包内为List<>。Controller调用记得加上默认参数,并告知Dao管理员默认值

}

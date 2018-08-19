package org.npc.plantSCM.service;

import org.npc.plantSCM.po.HjInventory;
import org.npc.plantSCM.vo.CommonDTO;


public interface HjKucunService {

	public CommonDTO getHjKucun(String hjFactory);//获取焊剂库存,库存为0不显示。Controller调用记得加上默认参数,并告知Dao管理员默认值
	public CommonDTO modifyHjKucun(HjInventory hjInventory);//修改焊片库存，超级权限
}

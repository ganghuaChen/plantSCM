package org.npc.plantSCM.service;

import org.npc.plantSCM.po.HpInventory;
import org.npc.plantSCM.vo.CommonDTO;

public interface HpKucunService {
	
	public CommonDTO getHpKucun(String shape, String model, String spec);//获取焊片库存,库存为0不显示。Controller调用记得加上默认参数,并告知Dao管理员默认值
	public CommonDTO modifyHpKucun(HpInventory hpInventory);//修改焊片库存，超级权限

}

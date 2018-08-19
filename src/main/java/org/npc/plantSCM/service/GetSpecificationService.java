package org.npc.plantSCM.service;

import java.util.List;

import org.npc.plantSCM.vo.CommonDTO;

//前端下拉框调用的东西
public interface GetSpecificationService {

	public CommonDTO getHpModel();//获取焊片型号
	public CommonDTO getSpec();//获取焊片形状（直弯）
	public CommonDTO getHjChangjia();//获取焊剂厂家
	public CommonDTO getCustomer();//获取所有收货人
	
	
	public CommonDTO deleteHpModel(String model);//删除焊片型号
	public CommonDTO insertHpModel(List<String> model);
	
	
}

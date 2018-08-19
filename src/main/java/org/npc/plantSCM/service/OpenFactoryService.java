package org.npc.plantSCM.service;
import org.npc.plantSCM.vo.*;
import org.npc.plantSCM.po.OpenFactory;
import java.util.List;


public interface OpenFactoryService  {

	public CommonDTO getOpenFactoryInfo(String model, String beginDate,String endDate);//按条件显示工厂模块历史开炉登记
	public CommonDTO createOpenFactory(List<OpenFactory> list);//新建开炉登记
	public CommonDTO modifyOpenFactory(OpenFactory openFactory );//修改已存在的开炉登记
}

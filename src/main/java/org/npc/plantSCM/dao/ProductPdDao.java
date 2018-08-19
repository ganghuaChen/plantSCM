package org.npc.plantSCM.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.npc.plantSCM.po.ProductPd;

public interface ProductPdDao {
	
	//增加盘点记录
	void insertProductPd(ProductPd productPd);
	
	//修改盘点记录
	void updateProductPd(ProductPd productPd);
	
	//根据盘点日期型号获取盘点记录
	List<ProductPd> getProductPdByDateAndModel(@Param("beginDate") String beginDate,
			                             @Param("endDate") String endDate,
			                             @Param("model") String model);

}

package org.npc.plantSCM.vo;

public enum Result {
	
	SUCCESS(0,"成功"),
	
	CREATE_ORDER_SUCCESS(0,"新建订单成功"),//
	CANCLE_HANJIORDER_SUCCESS(0,"取消焊剂订单成功"),//
	CANCLE_HANPIANORDER_SUCCESS(0,"取消焊片订单成功"),//
	UPDATE_HANJIORDER_SUCCESS(0,"修改焊剂订单成功"),//
	UPDATE_HANPIANORDER_SUCCESS(0,"修改焊片订单成功"),//
	CREATE_PURCHASE_SUCCESS(0,"新建采购单成功"),//
	UPDATE_PURCHASEYUANLIAO_SUCCESS(0,"修改原料采购单成功"),//
	UPDATE_PURCHASEHANPIAN_SUCCESS(0,"修改焊片采购单成功"),//
	UPDATE_PURCHASEHANJI_SUCCESS(0,"修改焊剂采购单成功"),//
	CREATE_WAREHOUSEINSTORAGE_SUCCESS(0,"入库成功"),
	UPDATE_WAREHOUSEINSTORAGE_SUCCESS(0,"修改焊片出厂入库记录成功"),//
	UPDATE_STORAGE_SUCCESS(0,"修改焊片出厂发货记录成功"),//
	CREATE_DELIVERY_SUCCESS(0,"配送成功"),
	UPDATE_HANJIDELIVERY_SUCCESS(0,"修改焊剂送货记录成功"),//
	UPDATE_HANPIANDELIVERY_SUCCESS(0,"修改焊片送货记录成功"),//

	CREATE_BLOWONRECORD_SUCCESS(0,"添加开炉记录成功"),//
	UPDATE_BLOWONRECORD_SUCCESS(0,"修改开炉记录成功"),//
	CREATE_BLANKRECORD_SUCCESS(0,"添加胚料记录成功"),
	UPDATE_BLANKRECORD_SUCCESS(0,"修改胚料记录成功"),
	CREATE_CHECKWOR_SUCCESS(0,"添加清仓记录成功"),
	UPDATE_CHECKWOR_SUCCESS(0,"修改原料库存成功"),//
	UPDATE_CHECKWAR_SUCCESS(0,"修改焊片库存成功"),//
	UPDATE_CHECKWJR_SUCCESS(0,"修改焊剂库存成功"),//
	CONFIRM_HANJIIN_SUCCESS(0,"焊剂确认入库成功"),//
	CONFIRM_HANPIANIN_SUCCESS(0,"焊片确认入库成功"),//
	CREATE_CHECKWPR_SUCCESS(0,"添加焊片盘点清仓成功"),//
	UPDATE_CHECKWPR_SUCCESS(0,"修改焊片盘点清仓成功"),//
	CREATE_FACTORYOSR_SUCCESS(0,"添加焊片出厂记录成功"),//
	UPDATE_FACTORYOSR_SUCCESS(0,"修改焊片出厂记录成功"),//
	CREATE_PRODUCTMODELINFO_SUCCESS(0,"添加产品型号记录成功"),//
	UPDATE_PRODUCTMODELINFO_SUCCESS(0,"删除产品型号记录成功"),//
	
	

	UNKNOWN_ACCOUNT_ERROR(1,"账号或密码错误"),
	SPEC_CHANGE_ERROR(110,"规格输入有误"),//用
	HAS_ALREADY_RUKU(111,"订单已经入库，无法修改"),//用
	HAS_ALREADY_SONGHUO(112,"订单已经送货，无法修改"),//用
	GONGCHANG_DELIVER(113,"工厂送货单，无法修改"),//用
	KUCUN_NOTENOUGH(114,"下单成功。库存不足，已写入通知提醒"),//用
	MATERIAL_NOT_ENOUGH(206,"原料库存不足，无法开炉"),//用
	PRODUCTMODELINFO_FAILURE(207,"存在重复型号，该型号添加失败"),//
	OPENFACTORY_WEIGHT_TOOLOW(209,"输入重量不应小于0"),//
	TIME_PARSE_ERROR(201,"时间格式错误"),
	INVENTORY_OVER_ZERO(203,"库存大于0，无法删除"),
	SONGHUO_KUCUN_NOTENOUGH(202,"库存不足，无法送货"),
	SYSTEM_EXCEPTION(500,"系统异常，请联系管理员"), 
	
	UNAUTHORIZED(401,"未授权");
	
	
	private int code;
	private String msg;
	
	private Result(){
		
	}
	
	private Result(int code,String msg){
		this.code=code;
		this.msg=msg;
	}

	public int getCode() {
		return code;
	}

	public String getMsg() {
		return msg;
	}
	
	
	
	
}
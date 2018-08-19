package org.npc.plantSCM.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.npc.plantSCM.dao.HpInDao;
import org.npc.plantSCM.dao.HpOutDao;
import org.npc.plantSCM.po.HpIn;
import org.npc.plantSCM.po.HpOut;
import org.npc.plantSCM.service.HpChuchangService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.npc.plantSCM.vo.SpecChange;
import org.springframework.stereotype.Service;

@Service("HpChuchangService")
public class HpChuchangServiceImpl implements HpChuchangService {

	@Resource private HpOutDao hpOutDao;
	
	@Resource private HpInDao hpInDao;
		
	@Override
	public CommonDTO createNewChuchang(List<HpOut> list) {	
		
		for(HpOut hpOut:list) {
		//修改spec格式(x*y*z)
		SpecChange spec=new SpecChange(hpOut.getOutSpec());
		CommonDTO temp= spec.getResult();
		if(temp.getCode()==0)
			hpOut.setOutSpec((String)temp.getResult());
		else
			return temp;
		
		//插入出场纪录
		int outId;
		hpOutDao.insertHpOut(hpOut);
	    outId=hpOut.getId();
	    		
		//如果去往仓库
		if(hpOut.getOutFlow()==true) {
			HpIn tempHpIn=new HpIn();
			tempHpIn.setHpFrom(true);
			tempHpIn.setHpModel(hpOut.getOutModel());
			tempHpIn.setHpShape(hpOut.getOutShape());
			tempHpIn.setHpSpec(hpOut.getOutSpec());
			tempHpIn.setHpstorageDate(hpOut.getOutDate());
			tempHpIn.setHpstorageState(false);
			tempHpIn.setHpstorageWeight(hpOut.getOutWeight());
			tempHpIn.setHpOutId(outId);
			hpInDao.insertHpIn(tempHpIn);
		}
	}
		return new CommonDTO(Result.CREATE_FACTORYOSR_SUCCESS);		
	}
	
	@Override
	public CommonDTO modifyChuchang(HpOut hpOut)
	{
		//修改spec格式(x*y*z)
		SpecChange spec=new SpecChange(hpOut.getOutSpec());
		CommonDTO temp= spec.getResult();
		if(temp.getCode()==0)
			hpOut.setOutSpec((String)temp.getResult());
		else
			return temp;
		
		//找回原来数据库的记录
		HpOut outTemp=new HpOut();
		outTemp.setId(hpOut.getId());
		outTemp=hpOutDao.checkHpOut(outTemp);
		
		//如果原来出厂入库，现在还是出厂入库
		if(outTemp.getOutFlow()==true&&hpOut.getOutFlow()==true)
		{
			//已经入库
			if(hpInDao.checkHpInByOutId(outTemp.getId()).getHpstorageState()==true)
				return new CommonDTO(Result.HAS_ALREADY_RUKU);
			
			else {
				HpIn inTemp=new HpIn();
			    inTemp=hpInDao.checkHpInByOutId(outTemp.getId());
			    inTemp.setHpFrom(true);
			    inTemp.setHpModel(hpOut.getOutModel());
			    inTemp.setHpShape(hpOut.getOutShape());
			    inTemp.setHpSpec(hpOut.getOutSpec());
			    inTemp.setHpstorageDate(hpOut.getOutDate());
			    inTemp.setHpstorageState(false);
			    inTemp.setHpstorageWeight(hpOut.getOutWeight());
			    inTemp.setHpOutId(outTemp.getId());
			    System.out.println("调用updateHpIn之前的hp_out_id"+inTemp.getHpOutId());
			    hpInDao.updateHpIn(inTemp);
			    System.out.println("调用updateHpIn之后的hp_out_id"+inTemp.getHpOutId());
				hpOutDao.updateHpOut(hpOut);
			}
			return new CommonDTO(Result.UPDATE_WAREHOUSEINSTORAGE_SUCCESS);	
		}
		
		//如果原来出厂直接发货，现在还是出厂直接发货
		if(outTemp.getOutFlow()==false&&hpOut.getOutFlow()==false) {
			hpOutDao.updateHpOut(hpOut);
		}
		
		//如果原来出厂直接发货，现在改为入库
		if(outTemp.getOutFlow()==false&&hpOut.getOutFlow()==true) {
			hpOutDao.updateHpOut(hpOut);
			HpIn tempHpIn=new HpIn();
			tempHpIn.setHpFrom(true);
			tempHpIn.setHpModel(hpOut.getOutModel());
			tempHpIn.setHpShape(hpOut.getOutShape());
			tempHpIn.setHpSpec(hpOut.getOutSpec());
			tempHpIn.setHpstorageDate(hpOut.getOutDate());
			tempHpIn.setHpstorageState(false);
			tempHpIn.setHpstorageWeight(hpOut.getOutWeight());
			tempHpIn.setHpOutId(hpOut.getId());
			hpInDao.insertHpIn(tempHpIn);
		}
		
		//如果原来出厂入库，现在出厂发货
		if(outTemp.getOutFlow()==true&&hpOut.getOutFlow()==false) {
			hpOutDao.updateHpOut(hpOut);
			hpInDao.deleteHpIn(outTemp.getId());
		}
		
		 return new CommonDTO(Result.UPDATE_STORAGE_SUCCESS);

	}

	//获取出厂记录
	@Override
	public CommonDTO getChuchangRecord(String beginDate, String endDate, String outShape, String outModel) {

		CommonDTO result= new CommonDTO(Result.SUCCESS);
		result.setResult(hpOutDao.getHpOut(beginDate, endDate, outShape, outModel));
		return result;
	}

}

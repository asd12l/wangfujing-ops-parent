package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wangfj.wms.domain.entity.SalesMsg;
import com.wangfj.wms.domain.view.saleMsgVO;
import com.wangfj.wms.persistence.SalesMsgMapper;
import com.wangfj.wms.service.ISaleMsgService;


@Service("saleMsgService")
public class SaleMsgServiceImpl implements ISaleMsgService {
	@Autowired
	private SalesMsgMapper salesMsgMapper;

	@Override
	public Integer selectCountByParms(saleMsgVO record) {
		
		return this.salesMsgMapper.selectCountByParms(record);
	}

	@Override
	public List<SalesMsg> selectByPrams(saleMsgVO record) {
		
		return this.salesMsgMapper.selectByPrams(record);
	}

	@Override
	public int insertSaleMsg(SalesMsg slm) {
		return this.salesMsgMapper.insert(slm);
	}

	@Override
	public int deleteByPrimaryKey(Integer sid) {
		return this.salesMsgMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public SalesMsg selectByPrimaryKey(Integer sid) {
		return this.salesMsgMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateSaleMsg(SalesMsg sm) {
		return this.salesMsgMapper.updateByPrimaryKey(sm);
	}

}

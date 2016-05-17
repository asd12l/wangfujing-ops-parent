package com.wangfj.wms.persistence;


import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.LogisticsUser;

/**
 * @Class Name BackUserMapper
 * @Author wwb
 * @Create In 2014-12-2
 */
@WangfjMysqlMapper
public interface LogisticsUserMapper {
	
	int insertLogiticsUser(LogisticsUser logisticsUser);
	

}

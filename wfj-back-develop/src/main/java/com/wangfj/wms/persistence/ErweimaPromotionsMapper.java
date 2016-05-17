package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.ErweimaPromotions;
import com.wangfj.wms.domain.view.ErweimaPromotionsVO;

@WangfjMysqlMapper
public interface ErweimaPromotionsMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(ErweimaPromotions record);

    int insertSelective(ErweimaPromotions record);

    ErweimaPromotions selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ErweimaPromotions record);

    int updateByPrimaryKey(ErweimaPromotions record);

	int selectCountByPrams(ErweimaPromotionsVO key);

	List<ErweimaPromotions> selectByPrams(ErweimaPromotionsVO key);
}
package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.PromotionCornerPic;
import com.wangfj.wms.domain.view.CornerPicVO;


@WangfjMysqlMapper
public interface PromotionCornerPicMapper {
	
	List<PromotionCornerPic> selectAllCorners();
	
    int deleteByPrimaryKey(Integer sid);

    int insert(PromotionCornerPic record);

	List<PromotionCornerPic> selectByPrams(CornerPicVO key);

	int selectCountByPrams(CornerPicVO key);
   
	int insertSelective(PromotionCornerPic record);

    PromotionCornerPic selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PromotionCornerPic record);

    int updateByPrimaryKey(PromotionCornerPic record);

	Integer queryMaxSid();

}
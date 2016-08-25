package com.wangfj.back.mapper;

import java.util.List;

import com.wangfj.back.entity.po.Captcha;

public interface CaptchaMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(Captcha record);

    int insertSelective(Captcha record);

    Captcha selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Captcha record);

    int updateByPrimaryKey(Captcha record);
    
    List<Captcha> selectBySelective(Captcha record);
    
    int selectCountBySelective(Captcha record);
}
/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.util.PromotionsUtil.java
 * @Create By chengsj
 * @Create In 2013-8-30 下午4:50:33
 * TODO
 */
package com.wangfj.wms.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.wangfj.wms.domain.entity.MobileFlashPromotions;


/**
 * @Class Name PromotionsUtil
 * @Author chengsj
 * @Create In 2013-8-30
 */
public class MobileFlashPromotionsUtil {

	public static MobileFlashPromotions mobileflashpromotionResult(MobileFlashPromotionsKey key)
			throws ParseException {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		MobileFlashPromotions mfpromotions = new MobileFlashPromotions();

		if (key.getSid() != null && !"".equals(key.getSid())) {
			mfpromotions.setSid(Integer.valueOf(key.getSid()));
		}
		if (key.getTitle() != null
				&& !"".equals(key.getTitle())) {
			mfpromotions.setTitle(key
					.getTitle());
		}
		if (key.getProDesc() != null
				&& !"".equals(key.getProDesc())) {
			mfpromotions.setProDesc(key.getProDesc());
		}
		if (key.getLink() != null
				&& !"".equals(key.getLink())) {
			mfpromotions.setLink(key.getLink());
		}
		if (key.getPict() != null
				&& !"".equals(key.getPict())) {
			mfpromotions.setPict(key.getPict());
		}
		if (key.getSeq() != null
				&& !"".equals(key.getSeq())) {
			mfpromotions.setSeq(Integer.valueOf(key.getSeq()));
		}
		if (key.getCreater() != null
				&& !"".equals(key.getCreater())) {
			mfpromotions.setCreater(key.getCreater());
		}
		if (key.getCreateShopName() != null
				&& !"".equals(key.getCreateShopName())) {
			mfpromotions.setCreateShopName(key
					.getCreateShopName());
		}
		if (key.getCreateShopSid() != null
				&& !"".equals(key.getCreateShopSid())) {
			mfpromotions.setCreateShopSid(Integer.valueOf(key
					.getCreateShopSid()));
		}
		
		if (key.getPromotionType() != null
				&& !"".equals(key.getPromotionType())) {
			mfpromotions.setPromotionType(key
					.getPromotionType());
		}
		if (key.getPromotionTypeSid() != null
				&& !"".equals(key.getPromotionTypeSid())) {
			mfpromotions.setPromotionTypeSid(Integer.valueOf(key
					.getPromotionTypeSid()));
		}
		if (key.getFlag() != null
				&& !"".equals(key.getFlag())) {
			mfpromotions.setFlag(Integer.valueOf(key.getFlag()));
		}
		
		if (key.getStartTime() != null
				&& !"".equals(key.getStartTime())) {
			mfpromotions.setStartTime(sdf.parse(key
					.getStartTime()));
		}
		if (key.getEndTime() != null
				&& !"".equals(key.getEndTime())) {
			mfpromotions
					.setEndTime(sdf.parse(key.getEndTime()));
		}
		if (key.getCreateTime() != null
				&& !"".equals(key.getCreateTime())) {
			mfpromotions
					.setCreateTime(sdf.parse(key.getCreateTime()));
		}
		

		return mfpromotions;
	}

	public static MobileFlashPromotions setPromotions(String key, String value,
			String sid) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		MobileFlashPromotions pro = new MobileFlashPromotions();
		if (key.equals("title") && value != null && !"".equals(value)) {
			pro.setTitle(value);
		}
		if (key.equals("proDesc") && value != null
				&& !"".equals(value)) {
			pro.setProDesc(value);
		}
		if (key.equals("creater") && value != null && !"".equals(value)) {
			pro.setCreater(value);
		}
		if (key.equals("createShopName") && value != null && !"".equals(value)) {
			pro.setCreateShopName(value);
		}
		if (key.equals("createShopSid") && value != null && !"".equals(value)) {
			pro.setCreateShopSid(Integer.valueOf(value));
		}
		if (key.equals("promotionType") && value != null && !"".equals(value)) {
			pro.setPromotionType(value);
		}
		if (key.equals("promotionTypeSid") && value != null && !"".equals(value)) {
			pro.setPromotionTypeSid(Integer.valueOf(value));
		}
		if (key.equals("seq") && value != null && !"".equals(value)) {
			pro.setSeq(Integer.valueOf(value));
		}
		if (key.equals("link")) {
			if (value != null && !"".equals(value)) {
				pro.setLink(value);
			} else {
				pro.setLink("/mfpromotion/" + sid + ".html");
			}
		}
		if (key.equals("startTime") && value != null
				&& !"".equals(value)) {
			pro.setStartTime(sdf.parse(value));
		}
		
		if (key.equals("endTime") && value != null
				&& !"".equals(value)) {
			pro.setEndTime(sdf.parse(value));
		}
		if (key.equals("createTime") && value != null
				&& !"".equals(value)) {
			pro.setCreateTime(sdf.parse(value));
		}
		if (sid != null && !"".equals(sid)) {
			pro.setSid(Integer.valueOf(sid));
		}
		return pro;

	}
}

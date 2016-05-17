/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.entity.voProBestDetailVO.java
 * @Create By chengsj
 * @Create In 2013-5-13 上午11:27:55
 * TODO
 */
package com.wangfj.back.entity.vo;

import com.framework.AbstractVOEntity;

/**
 * @Class Name ProBestDetailVO
 * @Author chengsj
 * @Create In 2013-5-13
 */
public class ProBestDetailVO extends AbstractVOEntity{
	
	private  Integer  productListSid ; 
	private  Integer pageLayoutSid;
	private  Integer orderNumber;
	
	public Integer getProductListSid() {
		return productListSid;
	}
	public void setProductListSid(Integer productListSid) {
		this.productListSid = productListSid;
	}
	public Integer getPageLayoutSid() {
		return pageLayoutSid;
	}
	public void setPageLayoutSid(Integer pageLayoutSid) {
		this.pageLayoutSid = pageLayoutSid;
	}
	public Integer getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(Integer orderNumber) {
		this.orderNumber = orderNumber;
	}
	@Override
	public String toString() {
		return "ProBestDetailVO [productListSid=" + productListSid
				+ ", pageLayoutSid=" + pageLayoutSid + ", orderNumber="
				+ orderNumber + "]";
	}
	

	
	

}

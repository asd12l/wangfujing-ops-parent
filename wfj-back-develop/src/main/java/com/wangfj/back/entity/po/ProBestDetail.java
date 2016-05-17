/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.entity.condProBestDetail.java
 * @Create By chengsj
 * @Create In 2013-5-13 上午9:59:36
 * TODO
 */
package com.wangfj.back.entity.po;

import com.framework.AbstractPOEntity;

/**
 * @Class Name ProBestDetail
 * @Author chengsj
 * @Create In 2013-5-13
 */
public class ProBestDetail extends AbstractPOEntity{
	
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
	
	
	
}

package com.wangfj.wms.controller.floor.support;

import java.io.Serializable;

public class PcmFloorPara implements Serializable {

	private Long sid;

	private String code;

	private String name;

	private Integer floorStatus;

	private Long shopSid;

	private String fromSystem;

	private String floorName; /* 楼层名称 */

	private String floorCode; /* 楼层编码 */

	private String optUserSid; /* 最后一次修改人 */

	private String createName; /* 创建人 */

	private Integer currentPage;// 当前页数

	private Integer pageSize;// 每页大小

	public String getFloorName() {
		return floorName;
	}

	public void setFloorName(String floorName) {
		this.floorName = floorName;
	}

	public String getFloorCode() {
		return floorCode;
	}

	public void setFloorCode(String floorCode) {
		this.floorCode = floorCode;
	}

	public String getOptUserSid() {
		return optUserSid;
	}

	public void setOptUserSid(String optUserSid) {
		this.optUserSid = optUserSid;
	}

	public String getCreateName() {
		return createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getFloorStatus() {
		return floorStatus;
	}

	public void setFloorStatus(Integer floorStatus) {
		this.floorStatus = floorStatus;
	}

	public Long getShopSid() {
		return shopSid;
	}

	public void setShopSid(Long shopSid) {
		this.shopSid = shopSid;
	}

	public String getFromSystem() {
		return fromSystem;
	}

	public void setFromSystem(String fromSystem) {
		this.fromSystem = fromSystem;
	}

}

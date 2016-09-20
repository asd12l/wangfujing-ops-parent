package com.wangfj.order.controller.suppot.sale;

public class OfSaleHistoryDto {
	private Long sid;

    private String saleNo;

    private String priviousStatus;

    private String currentStatus;

    private String currentStatusDesc;

    private String updateMan;

    private String remark;

    private String operatorSource;
    
    private String updateTimeStr;

    public Long getSid() {
        return sid;
    }

    public void setSid(Long sid) {
        this.sid = sid;
    }

    public String getSaleNo() {
        return saleNo;
    }

    public void setSaleNo(String saleNo) {
        this.saleNo = saleNo;
    }

    public String getPriviousStatus() {
        return priviousStatus;
    }

    public void setPriviousStatus(String priviousStatus) {
        this.priviousStatus = priviousStatus;
    }

    public String getCurrentStatus() {
        return currentStatus;
    }

    public void setCurrentStatus(String currentStatus) {
        this.currentStatus = currentStatus;
    }

    public String getCurrentStatusDesc() {
        return currentStatusDesc;
    }

    public void setCurrentStatusDesc(String currentStatusDesc) {
        this.currentStatusDesc = currentStatusDesc;
    }

    public String getUpdateMan() {
        return updateMan;
    }

    public void setUpdateMan(String updateMan) {
        this.updateMan = updateMan;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getOperatorSource() {
        return operatorSource;
    }

    public void setOperatorSource(String operatorSource) {
        this.operatorSource = operatorSource;
    }

	public String getUpdateTimeStr() {
		return updateTimeStr;
	}

	public void setUpdateTimeStr(String updateTimeStr) {
		this.updateTimeStr = updateTimeStr;
	}
}

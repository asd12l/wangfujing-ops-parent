package com.wangfj.order.controller.suppot;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ExcelRefundVo {
	private Long sid;

	private BigDecimal totalDiscount;
	private BigDecimal quanAmount;
	
    public BigDecimal getTotalDiscount() {
		return totalDiscount;
	}
	public void setTotalDiscount(BigDecimal totalDiscount) {
		this.totalDiscount = totalDiscount;
	}
	public BigDecimal getQuanAmount() {
		return quanAmount;
	}
	public void setQuanAmount(BigDecimal quanAmount) {
		this.quanAmount = quanAmount;
	}
	private String accountNo;//账号

    private String memberNo;//会员编号

    private String refundNo;//退货单号

    private String refundApplyNo;//退货申请单号

    private String originalSalesNo;//原销售单号

    private String orderNo;//订单号

    private String externalRefundNo;//第三方退货单号

    private Date refundTime;//退货时间

    private String refundStatus;//退货单状态

    private String refundTarget;//退款路径

    private Integer refundType;//退货单类型

    private String refundClass;//退货单类别

    private BigDecimal refundAmount;//应退金额

    private Integer refundNum;//退货总数

    private BigDecimal needRefundAmount;//实际退款金额

    private String shopNo;//门店编号

    private String shopName;//门店名称

    private String supplyNo;//供应商编号

    private String supplyName;//供应商名称

    private String shoppeNo;//专柜编号

    private String shoppeName;//专柜名称

    private BigDecimal shippingFee;//快递费用

    private String createMode;//退货单创建方式

    private String exchangeNo;//换货单号

    private String originalDeliveryNo;//原交货单号

    private String sendToPoserp;//是否发送到poserp

    private String sendToSaperp;//是否发送到saperp

    private String operator;//受理人

    private String operatorStore;//受理门店

    private String salesPaymentNo;//款机流水单号

    private Date createdTime;//创建时间

    private Date latestUpdateTime;//最后"更新时间

    private String latestUpdateMan;//最后更新人

    private BigDecimal returnShippingFee;//实退运费

    private Integer refundToBit;//是否整单退

    private String rebateStatus;//退货单状态
    private String employeeNo;//导购号
    private String casherNo;//款机号
    private String calcBillid;
    private BigDecimal bankServiceCharge;
    private String refundPath;//退货途径
    private String warehouseAddress;//退货仓地址
    private String employeeName;//营业员姓名
    private String memberCardNo;//会员卡号
    private String memberShipCardNo;//会员卡卡面号
    private String memberCardType;//卡类型(vip金卡等) 
    private String expressCompanyCode;//快递公司编码
    private String expressCompanyName;//快递公司名称
    private String courierNumber;//快递单号
    private Integer start;
    private Integer limit;
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	public Long getSid() {
		return sid;
	}
	public void setSid(Long sid) {
		this.sid = sid;
	}
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public String getRefundNo() {
		return refundNo;
	}
	public void setRefundNo(String refundNo) {
		this.refundNo = refundNo;
	}
	public String getRefundApplyNo() {
		return refundApplyNo;
	}
	public void setRefundApplyNo(String refundApplyNo) {
		this.refundApplyNo = refundApplyNo;
	}
	public String getOriginalSalesNo() {
		return originalSalesNo;
	}
	public void setOriginalSalesNo(String originalSalesNo) {
		this.originalSalesNo = originalSalesNo;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getExternalRefundNo() {
		return externalRefundNo;
	}
	public void setExternalRefundNo(String externalRefundNo) {
		this.externalRefundNo = externalRefundNo;
	}
	public Date getRefundTime() {
		return refundTime;
	}
	public void setRefundTime(Date refundTime) {
		this.refundTime = refundTime;
	}
	public String getRefundStatus() {
		return refundStatus;
	}
	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}
	public String getRefundTarget() {
		return refundTarget;
	}
	public void setRefundTarget(String refundTarget) {
		this.refundTarget = refundTarget;
	}
	public Integer getRefundType() {
		return refundType;
	}
	public void setRefundType(Integer refundType) {
		this.refundType = refundType;
	}
	public String getRefundClass() {
		return refundClass;
	}
	public void setRefundClass(String refundClass) {
		this.refundClass = refundClass;
	}
	public BigDecimal getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(BigDecimal refundAmount) {
		this.refundAmount = refundAmount;
	}
	public Integer getRefundNum() {
		return refundNum;
	}
	public void setRefundNum(Integer refundNum) {
		this.refundNum = refundNum;
	}
	public BigDecimal getNeedRefundAmount() {
		return needRefundAmount;
	}
	public void setNeedRefundAmount(BigDecimal needRefundAmount) {
		this.needRefundAmount = needRefundAmount;
	}
	public String getShopNo() {
		return shopNo;
	}
	public void setShopNo(String shopNo) {
		this.shopNo = shopNo;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getSupplyNo() {
		return supplyNo;
	}
	public void setSupplyNo(String supplyNo) {
		this.supplyNo = supplyNo;
	}
	public String getSupplyName() {
		return supplyName;
	}
	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}
	public String getShoppeNo() {
		return shoppeNo;
	}
	public void setShoppeNo(String shoppeNo) {
		this.shoppeNo = shoppeNo;
	}
	public String getShoppeName() {
		return shoppeName;
	}
	public void setShoppeName(String shoppeName) {
		this.shoppeName = shoppeName;
	}
	public BigDecimal getShippingFee() {
		return shippingFee;
	}
	public void setShippingFee(BigDecimal shippingFee) {
		this.shippingFee = shippingFee;
	}
	public String getCreateMode() {
		return createMode;
	}
	public void setCreateMode(String createMode) {
		this.createMode = createMode;
	}
	public String getExchangeNo() {
		return exchangeNo;
	}
	public void setExchangeNo(String exchangeNo) {
		this.exchangeNo = exchangeNo;
	}
	public String getOriginalDeliveryNo() {
		return originalDeliveryNo;
	}
	public void setOriginalDeliveryNo(String originalDeliveryNo) {
		this.originalDeliveryNo = originalDeliveryNo;
	}
	public String getSendToPoserp() {
		return sendToPoserp;
	}
	public void setSendToPoserp(String sendToPoserp) {
		this.sendToPoserp = sendToPoserp;
	}
	public String getSendToSaperp() {
		return sendToSaperp;
	}
	public void setSendToSaperp(String sendToSaperp) {
		this.sendToSaperp = sendToSaperp;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getOperatorStore() {
		return operatorStore;
	}
	public void setOperatorStore(String operatorStore) {
		this.operatorStore = operatorStore;
	}
	public String getSalesPaymentNo() {
		return salesPaymentNo;
	}
	public void setSalesPaymentNo(String salesPaymentNo) {
		this.salesPaymentNo = salesPaymentNo;
	}
	public Date getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	public Date getLatestUpdateTime() {
		return latestUpdateTime;
	}
	public void setLatestUpdateTime(Date latestUpdateTime) {
		this.latestUpdateTime = latestUpdateTime;
	}
	public String getLatestUpdateMan() {
		return latestUpdateMan;
	}
	public void setLatestUpdateMan(String latestUpdateMan) {
		this.latestUpdateMan = latestUpdateMan;
	}
	public BigDecimal getReturnShippingFee() {
		return returnShippingFee;
	}
	public void setReturnShippingFee(BigDecimal returnShippingFee) {
		this.returnShippingFee = returnShippingFee;
	}
	public Integer getRefundToBit() {
		return refundToBit;
	}
	public void setRefundToBit(Integer refundToBit) {
		this.refundToBit = refundToBit;
	}
	public String getRebateStatus() {
		return rebateStatus;
	}
	public void setRebateStatus(String rebateStatus) {
		this.rebateStatus = rebateStatus;
	}
	public String getEmployeeNo() {
		return employeeNo;
	}
	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}
	public String getCasherNo() {
		return casherNo;
	}
	public void setCasherNo(String casherNo) {
		this.casherNo = casherNo;
	}
	public String getCalcBillid() {
		return calcBillid;
	}
	public void setCalcBillid(String calcBillid) {
		this.calcBillid = calcBillid;
	}
	public BigDecimal getBankServiceCharge() {
		return bankServiceCharge;
	}
	public void setBankServiceCharge(BigDecimal bankServiceCharge) {
		this.bankServiceCharge = bankServiceCharge;
	}
	public String getRefundPath() {
		return refundPath;
	}
	public void setRefundPath(String refundPath) {
		this.refundPath = refundPath;
	}
	public String getWarehouseAddress() {
		return warehouseAddress;
	}
	public void setWarehouseAddress(String warehouseAddress) {
		this.warehouseAddress = warehouseAddress;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getMemberCardNo() {
		return memberCardNo;
	}
	public void setMemberCardNo(String memberCardNo) {
		this.memberCardNo = memberCardNo;
	}
	public String getMemberShipCardNo() {
		return memberShipCardNo;
	}
	public void setMemberShipCardNo(String memberShipCardNo) {
		this.memberShipCardNo = memberShipCardNo;
	}
	public String getMemberCardType() {
		return memberCardType;
	}
	public void setMemberCardType(String memberCardType) {
		this.memberCardType = memberCardType;
	}
	public String getExpressCompanyCode() {
		return expressCompanyCode;
	}
	public void setExpressCompanyCode(String expressCompanyCode) {
		this.expressCompanyCode = expressCompanyCode;
	}
	public String getExpressCompanyName() {
		return expressCompanyName;
	}
	public void setExpressCompanyName(String expressCompanyName) {
		this.expressCompanyName = expressCompanyName;
	}
	public String getCourierNumber() {
		return courierNumber;
	}
	public void setCourierNumber(String courierNumber) {
		this.courierNumber = courierNumber;
	}
	@Override
	public String toString() {
		return "ExcelRefundVo [sid=" + sid + ", accountNo=" + accountNo + ", memberNo="
				+ memberNo + ", refundNo=" + refundNo + ", refundApplyNo=" + refundApplyNo
				+ ", originalSalesNo=" + originalSalesNo + ", orderNo=" + orderNo
				+ ", externalRefundNo=" + externalRefundNo + ", refundTime=" + refundTime
				+ ", refundStatus=" + refundStatus + ", refundTarget=" + refundTarget
				+ ", refundType=" + refundType + ", refundClass=" + refundClass
				+ ", refundAmount=" + refundAmount + ", refundNum=" + refundNum
				+ ", needRefundAmount=" + needRefundAmount + ", shopNo=" + shopNo
				+ ", shopName=" + shopName + ", supplyNo=" + supplyNo + ", supplyName="
				+ supplyName + ", shoppeNo=" + shoppeNo + ", shoppeName=" + shoppeName
				+ ", shippingFee=" + shippingFee + ", createMode=" + createMode
				+ ", exchangeNo=" + exchangeNo + ", originalDeliveryNo=" + originalDeliveryNo
				+ ", sendToPoserp=" + sendToPoserp + ", sendToSaperp=" + sendToSaperp
				+ ", operator=" + operator + ", operatorStore=" + operatorStore
				+ ", salesPaymentNo=" + salesPaymentNo + ", createdTime=" + createdTime
				+ ", latestUpdateTime=" + latestUpdateTime + ", latestUpdateMan="
				+ latestUpdateMan + ", returnShippingFee=" + returnShippingFee
				+ ", refundToBit=" + refundToBit + ", rebateStatus=" + rebateStatus
				+ ", employeeNo=" + employeeNo + ", casherNo=" + casherNo + ", calcBillid="
				+ calcBillid + ", bankServiceCharge=" + bankServiceCharge + ", refundPath="
				+ refundPath + ", warehouseAddress=" + warehouseAddress + ", employeeName="
				+ employeeName + ", memberCardNo=" + memberCardNo + ", memberShipCardNo="
				+ memberShipCardNo + ", memberCardType=" + memberCardType
				+ ", expressCompanyCode=" + expressCompanyCode + ", expressCompanyName="
				+ expressCompanyName + ", courierNumber=" + courierNumber + "]";
	}
		
}
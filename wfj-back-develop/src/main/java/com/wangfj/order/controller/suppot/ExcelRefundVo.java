package com.wangfj.order.controller.suppot;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.wangfj.order.controller.suppot.refund.OfDeductionDto;
import com.wangfj.order.controller.suppot.refund.OfReturnPaymentsDTO;
import com.wangfj.order.controller.suppot.refund.SaveOfRefundItemDTO;

public class ExcelRefundVo {
	
	private String refundStatusDesc;
	private String latestUpdateTimeStr;// 最后"更新时间
	private String createdTimeStr;// 创建时间
	private String productType;// 商品类别
	private BigDecimal incomeAmount;
	private BigDecimal tax;
	private String managerCateNo;//
	private String staticsCateNo;// 统计分类
	private String saleItemNo;//销售单item
	private Integer isSynchronous;
    private String createdMode;
	private Date createdTimeStart;
	private Date createdTimeEnd;
    private String startRefundTimeStr;
    private String endRefundTimeStr;
	private String problemDesc;
	private String packStatus;//包装情况
    private String productsStatus;//商品情况
    private String orderchannel;
    private BigDecimal paymentAmountSum;
    private String sysValue; //脱敏标识
	
	
	public String getRefundStatusDesc() {
		return refundStatusDesc;
	}
	public void setRefundStatusDesc(String refundStatusDesc) {
		this.refundStatusDesc = refundStatusDesc;
	}
	public String getLatestUpdateTimeStr() {
		return latestUpdateTimeStr;
	}
	public void setLatestUpdateTimeStr(String latestUpdateTimeStr) {
		this.latestUpdateTimeStr = latestUpdateTimeStr;
	}
	public String getCreatedTimeStr() {
		return createdTimeStr;
	}
	public void setCreatedTimeStr(String createdTimeStr) {
		this.createdTimeStr = createdTimeStr;
	}
	public String getProductType() {
		return productType;
	}
	public void setProductType(String productType) {
		this.productType = productType;
	}
	public BigDecimal getIncomeAmount() {
		return incomeAmount;
	}
	public void setIncomeAmount(BigDecimal incomeAmount) {
		this.incomeAmount = incomeAmount;
	}
	public BigDecimal getTax() {
		return tax;
	}
	public void setTax(BigDecimal tax) {
		this.tax = tax;
	}
	public String getManagerCateNo() {
		return managerCateNo;
	}
	public void setManagerCateNo(String managerCateNo) {
		this.managerCateNo = managerCateNo;
	}
	public String getStaticsCateNo() {
		return staticsCateNo;
	}
	public void setStaticsCateNo(String staticsCateNo) {
		this.staticsCateNo = staticsCateNo;
	}
	public String getSaleItemNo() {
		return saleItemNo;
	}
	public void setSaleItemNo(String saleItemNo) {
		this.saleItemNo = saleItemNo;
	}
	public Integer getIsSynchronous() {
		return isSynchronous;
	}
	public void setIsSynchronous(Integer isSynchronous) {
		this.isSynchronous = isSynchronous;
	}
	public String getCreatedMode() {
		return createdMode;
	}
	public void setCreatedMode(String createdMode) {
		this.createdMode = createdMode;
	}
	public Date getCreatedTimeStart() {
		return createdTimeStart;
	}
	public void setCreatedTimeStart(Date createdTimeStart) {
		this.createdTimeStart = createdTimeStart;
	}
	public Date getCreatedTimeEnd() {
		return createdTimeEnd;
	}
	public void setCreatedTimeEnd(Date createdTimeEnd) {
		this.createdTimeEnd = createdTimeEnd;
	}
	public String getStartRefundTimeStr() {
		return startRefundTimeStr;
	}
	public void setStartRefundTimeStr(String startRefundTimeStr) {
		this.startRefundTimeStr = startRefundTimeStr;
	}
	public String getEndRefundTimeStr() {
		return endRefundTimeStr;
	}
	public void setEndRefundTimeStr(String endRefundTimeStr) {
		this.endRefundTimeStr = endRefundTimeStr;
	}
	public String getProblemDesc() {
		return problemDesc;
	}
	public void setProblemDesc(String problemDesc) {
		this.problemDesc = problemDesc;
	}
	public String getPackStatus() {
		return packStatus;
	}
	public void setPackStatus(String packStatus) {
		this.packStatus = packStatus;
	}
	public String getProductsStatus() {
		return productsStatus;
	}
	public void setProductsStatus(String productsStatus) {
		this.productsStatus = productsStatus;
	}
	public String getOrderchannel() {
		return orderchannel;
	}
	public void setOrderchannel(String orderchannel) {
		this.orderchannel = orderchannel;
	}
	public BigDecimal getPaymentAmountSum() {
		return paymentAmountSum;
	}
	public void setPaymentAmountSum(BigDecimal paymentAmountSum) {
		this.paymentAmountSum = paymentAmountSum;
	}
	public String getSysValue() {
		return sysValue;
	}
	public void setSysValue(String sysValue) {
		this.sysValue = sysValue;
	}
	private String productClass;// 大中小类
	private Date refundTimeStart;
	private Date refundTimeEnd;
	
	public String getProductClass() {
		return productClass;
	}
	public void setProductClass(String productClass) {
		this.productClass = productClass;
	}
	public Date getRefundTimeStart() {
		return refundTimeStart;
	}
	public void setRefundTimeStart(Date refundTimeStart) {
		this.refundTimeStart = refundTimeStart;
	}
	public Date getRefundTimeEnd() {
		return refundTimeEnd;
	}
	public void setRefundTimeEnd(Date refundTimeEnd) {
		this.refundTimeEnd = refundTimeEnd;
	}
	private String fromSystem;
	
	public String getFromSystem() {
		return fromSystem;
	}
	public void setFromSystem(String fromSystem) {
		this.fromSystem = fromSystem;
	}
	public List<SaveOfRefundItemDTO> getProducts() {
		return products;
	}
	public void setProducts(List<SaveOfRefundItemDTO> products) {
		this.products = products;
	}
	public List<OfDeductionDto> getDeduction() {
		return deduction;
	}
	public void setDeduction(List<OfDeductionDto> deduction) {
		this.deduction = deduction;
	}
	public List<OfReturnPaymentsDTO> getReturnPayments() {
		return returnPayments;
	}
	public void setReturnPayments(List<OfReturnPaymentsDTO> returnPayments) {
		this.returnPayments = returnPayments;
	}
	private List<SaveOfRefundItemDTO> products; // 商品详情
	private List<OfDeductionDto> deduction;// 扣款介质
	private List<OfReturnPaymentsDTO> returnPayments;// 退货单支付介质
	
	private Long sid;
	private String refundReasionNo;
	private String outOrderNo;
	private String receptPhone;
	
public String getOutOrderNo() {
		return outOrderNo;
	}
	public void setOutOrderNo(String outOrderNo) {
		this.outOrderNo = outOrderNo;
	}
	public String getReceptPhone() {
		return receptPhone;
	}
	public void setReceptPhone(String receptPhone) {
		this.receptPhone = receptPhone;
	}
public String getRefundReasionNo() {
		return refundReasionNo;
	}
	public void setRefundReasionNo(String refundReasionNo) {
		this.refundReasionNo = refundReasionNo;
	}
private String shoppeProName;

	public String getShoppeProName() {
	return shoppeProName;
}
public void setShoppeProName(String shoppeProName) {
	this.shoppeProName = shoppeProName;
}
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
		return "ExcelRefundVo [refundStatusDesc=" + refundStatusDesc + ", latestUpdateTimeStr="
				+ latestUpdateTimeStr + ", createdTimeStr=" + createdTimeStr + ", productType="
				+ productType + ", incomeAmount=" + incomeAmount + ", tax=" + tax
				+ ", managerCateNo=" + managerCateNo + ", staticsCateNo=" + staticsCateNo
				+ ", saleItemNo=" + saleItemNo + ", isSynchronous=" + isSynchronous
				+ ", createdMode=" + createdMode + ", createdTimeStart=" + createdTimeStart
				+ ", createdTimeEnd=" + createdTimeEnd + ", startRefundTimeStr="
				+ startRefundTimeStr + ", endRefundTimeStr=" + endRefundTimeStr + ", problemDesc="
				+ problemDesc + ", packStatus=" + packStatus + ", productsStatus=" + productsStatus
				+ ", orderchannel=" + orderchannel + ", paymentAmountSum=" + paymentAmountSum
				+ ", sysValue=" + sysValue + ", productClass=" + productClass + ", refundTimeStart="
				+ refundTimeStart + ", refundTimeEnd=" + refundTimeEnd + ", fromSystem="
				+ fromSystem + ", products=" + products + ", deduction=" + deduction
				+ ", returnPayments=" + returnPayments + ", sid=" + sid + ", refundReasionNo="
				+ refundReasionNo + ", outOrderNo=" + outOrderNo + ", receptPhone=" + receptPhone
				+ ", shoppeProName=" + shoppeProName + ", totalDiscount=" + totalDiscount
				+ ", quanAmount=" + quanAmount + ", accountNo=" + accountNo + ", memberNo="
				+ memberNo + ", refundNo=" + refundNo + ", refundApplyNo=" + refundApplyNo
				+ ", originalSalesNo=" + originalSalesNo + ", orderNo=" + orderNo
				+ ", externalRefundNo=" + externalRefundNo + ", refundTime=" + refundTime
				+ ", refundStatus=" + refundStatus + ", refundTarget=" + refundTarget
				+ ", refundType=" + refundType + ", refundClass=" + refundClass + ", refundAmount="
				+ refundAmount + ", refundNum=" + refundNum + ", needRefundAmount="
				+ needRefundAmount + ", shopNo=" + shopNo + ", shopName=" + shopName + ", supplyNo="
				+ supplyNo + ", supplyName=" + supplyName + ", shoppeNo=" + shoppeNo
				+ ", shoppeName=" + shoppeName + ", shippingFee=" + shippingFee + ", createMode="
				+ createMode + ", exchangeNo=" + exchangeNo + ", originalDeliveryNo="
				+ originalDeliveryNo + ", sendToPoserp=" + sendToPoserp + ", sendToSaperp="
				+ sendToSaperp + ", operator=" + operator + ", operatorStore=" + operatorStore
				+ ", salesPaymentNo=" + salesPaymentNo + ", createdTime=" + createdTime
				+ ", latestUpdateTime=" + latestUpdateTime + ", latestUpdateMan=" + latestUpdateMan
				+ ", returnShippingFee=" + returnShippingFee + ", refundToBit=" + refundToBit
				+ ", rebateStatus=" + rebateStatus + ", employeeNo=" + employeeNo + ", casherNo="
				+ casherNo + ", calcBillid=" + calcBillid + ", bankServiceCharge="
				+ bankServiceCharge + ", refundPath=" + refundPath + ", warehouseAddress="
				+ warehouseAddress + ", employeeName=" + employeeName + ", memberCardNo="
				+ memberCardNo + ", memberShipCardNo=" + memberShipCardNo + ", memberCardType="
				+ memberCardType + ", expressCompanyCode=" + expressCompanyCode
				+ ", expressCompanyName=" + expressCompanyName + ", courierNumber=" + courierNumber
				+ ", start=" + start + ", limit=" + limit + "]";
	}
		
}
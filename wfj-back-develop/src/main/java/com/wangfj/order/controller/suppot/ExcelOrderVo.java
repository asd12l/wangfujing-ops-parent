package com.wangfj.order.controller.suppot;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.wangfj.order.controller.suppot.order.CpsInfoDto;
import com.wangfj.order.controller.suppot.order.OrderItemDto;
import com.wangfj.order.controller.suppot.order.PaymentItemDto;
import com.wangfj.order.controller.suppot.order.PrSaleDto;


public class ExcelOrderVo {
	private String orderNo;//订单号

	private String outOrderNo;//外部订单号

	private String paymentNo;//支付中台号

	private String accountNo;//账号

	private String memberNo;//会员编号

	private String salesPaymentNo;//支付中台流水号

	private String orderSource;//订单来源

	private String orderType;//订单类型

	private String paymentClass;//支付类型

	private Date saleTime;//销售时间

	private Date delayTime;//延迟时间

	private String orderStatus;//订单状态 

	private String orderStatusDesc;//订单状态描述

	private String delivetyStatus;//物流状态 

	private String delivetyStatusDesc;//物流状态描述

	private String payStatus;//支付状态

	private Date payTime;//支付时间

	private String deliveryMode;//配送方式

	private String deliveryModeName;//配送方式名称

	private String needInvoice;//是否开发票

	private BigDecimal needSendCost;//应收运费
	
	private BigDecimal sendCost;//实际运费

	private BigDecimal salesAmount;//商品销售总额

	private Integer saleSum;//销售数量

	private Integer refundSum;//退货数量

	private Integer sendSum;//发货数量

	private BigDecimal sendAmount;//发货金额

	private BigDecimal paymentAmount;//订单应付金额
	
	private BigDecimal couponAmount; //使用优惠券金额
    
    private String integral; //积分

	private BigDecimal cashAmount;//订单现金类支付金额

	private BigDecimal cashIncome;//收银损益

	private BigDecimal accountBalanceAmount;//使用余额总额

	private BigDecimal promotionAmount;//订单优惠总额

	private String cancelReasonNo;//取消原因编号

	private String cancelReason;//取消原因

	private String customerComments;//客户备注

	private String callCenterComments;//客服备注

	private String receptPhone;//收件人电话

	private String receptName;//收件人姓名

	private String receptCityNo;//收件人城市编号

	private String receptCityName;//收件人城市名称

	private String receptCityCode;//收件城市邮编

	private String receptProvNo;//收件地区省份编号

	private String receptProvName;//收件地区省份名称

	private String receptAddress;//收货地址

	private Integer extractFlag;//提货类型

	private Integer recoveryFlag;//是否进入回收站

	private Integer promFlag;//是否参加促销

	private String version;//版本号

	private Integer memberType;//会员类型
	
	private Integer isCod;//是否是COD订单 
	 
	private String receptDistrictNo;//收件人区名称
	    
	private String receptDistrictName;//收件人区名称
	
	private String invoiceTitle;//发票抬头

	private String saleTimeStr;
	
	private String payTimeStr;
	private String delayTimeStr;
	
	private String latestUpdateMan;
	
	private String contactNumber;//收件人联系电话
	
	private String requiredDeliveryDate;//客户要求送货时间 
	
	private String realName; //真实姓名
    
    private String identityCard; //身份证号
    
    private CpsInfoDto cpsOrder;//cps信息
    
    private String calcBillId;//订单在富基的唯一标识 
    private String shoppeProName; //商品名称
    
    private Date createdTime;  //创建时间
	
	public String getShoppeProName() {
		return shoppeProName;
	}

	public void setShoppeProName(String shoppeProName) {
		this.shoppeProName = shoppeProName;
	}

	private List<OrderItemDto> orderItemList;
	
	private List<PaymentItemDto> paymentItems;
	
	private List<PrSaleDto> saleOrders;
	
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOutOrderNo() {
		return outOrderNo;
	}

	public void setOutOrderNo(String outOrderNo) {
		this.outOrderNo = outOrderNo;
	}

	public String getPaymentNo() {
		return paymentNo;
	}

	public void setPaymentNo(String paymentNo) {
		this.paymentNo = paymentNo;
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

	public String getSalesPaymentNo() {
		return salesPaymentNo;
	}

	public void setSalesPaymentNo(String salesPaymentNo) {
		this.salesPaymentNo = salesPaymentNo;
	}

	public String getOrderSource() {
		return orderSource;
	}

	public void setOrderSource(String orderSource) {
		this.orderSource = orderSource;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getPaymentClass() {
		return paymentClass;
	}

	public void setPaymentClass(String paymentClass) {
		this.paymentClass = paymentClass;
	}

	public Date getSaleTime() {
		return saleTime;
	}

	public void setSaleTime(Date saleTime) {
		this.saleTime = saleTime;
	}

	public Date getDelayTime() {
		return delayTime;
	}

	public void setDelayTime(Date delayTime) {
		this.delayTime = delayTime;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getOrderStatusDesc() {
		return orderStatusDesc;
	}

	public void setOrderStatusDesc(String orderStatusDesc) {
		this.orderStatusDesc = orderStatusDesc;
	}

	public String getDelivetyStatus() {
		return delivetyStatus;
	}

	public void setDelivetyStatus(String delivetyStatus) {
		this.delivetyStatus = delivetyStatus;
	}

	public String getDelivetyStatusDesc() {
		return delivetyStatusDesc;
	}

	public void setDelivetyStatusDesc(String delivetyStatusDesc) {
		this.delivetyStatusDesc = delivetyStatusDesc;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public String getDeliveryMode() {
		return deliveryMode;
	}

	public void setDeliveryMode(String deliveryMode) {
		this.deliveryMode = deliveryMode;
	}

	public String getDeliveryModeName() {
		return deliveryModeName;
	}

	public void setDeliveryModeName(String deliveryModeName) {
		this.deliveryModeName = deliveryModeName;
	}

	public String getNeedInvoice() {
		return needInvoice;
	}

	public void setNeedInvoice(String needInvoice) {
		this.needInvoice = needInvoice;
	}

	public BigDecimal getNeedSendCost() {
		return needSendCost;
	}

	public void setNeedSendCost(BigDecimal needSendCost) {
		this.needSendCost = needSendCost;
	}

	public BigDecimal getSalesAmount() {
		return salesAmount;
	}

	public void setSalesAmount(BigDecimal salesAmount) {
		this.salesAmount = salesAmount;
	}

	public Integer getSaleSum() {
		return saleSum;
	}

	public void setSaleSum(Integer saleSum) {
		this.saleSum = saleSum;
	}

	public Integer getRefundSum() {
		return refundSum;
	}

	public void setRefundSum(Integer refundSum) {
		this.refundSum = refundSum;
	}

	public Integer getSendSum() {
		return sendSum;
	}

	public void setSendSum(Integer sendSum) {
		this.sendSum = sendSum;
	}

	public BigDecimal getSendAmount() {
		return sendAmount;
	}

	public void setSendAmount(BigDecimal sendAmount) {
		this.sendAmount = sendAmount;
	}

	public BigDecimal getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(BigDecimal paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public BigDecimal getCashAmount() {
		return cashAmount;
	}

	public void setCashAmount(BigDecimal cashAmount) {
		this.cashAmount = cashAmount;
	}

	public BigDecimal getCashIncome() {
		return cashIncome;
	}

	public void setCashIncome(BigDecimal cashIncome) {
		this.cashIncome = cashIncome;
	}

	public BigDecimal getAccountBalanceAmount() {
		return accountBalanceAmount;
	}

	public void setAccountBalanceAmount(BigDecimal accountBalanceAmount) {
		this.accountBalanceAmount = accountBalanceAmount;
	}

	public BigDecimal getPromotionAmount() {
		return promotionAmount;
	}

	public void setPromotionAmount(BigDecimal promotionAmount) {
		this.promotionAmount = promotionAmount;
	}

	public String getCancelReasonNo() {
		return cancelReasonNo;
	}

	public void setCancelReasonNo(String cancelReasonNo) {
		this.cancelReasonNo = cancelReasonNo;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public String getCustomerComments() {
		return customerComments;
	}

	public void setCustomerComments(String customerComments) {
		this.customerComments = customerComments;
	}

	public String getCallCenterComments() {
		return callCenterComments;
	}

	public void setCallCenterComments(String callCenterComments) {
		this.callCenterComments = callCenterComments;
	}

	public String getReceptPhone() {
		return receptPhone;
	}

	public void setReceptPhone(String receptPhone) {
		this.receptPhone = receptPhone;
	}

	public String getReceptName() {
		return receptName;
	}

	public void setReceptName(String receptName) {
		this.receptName = receptName;
	}

	public String getReceptCityNo() {
		return receptCityNo;
	}

	public void setReceptCityNo(String receptCityNo) {
		this.receptCityNo = receptCityNo;
	}

	public String getReceptCityName() {
		return receptCityName;
	}

	public void setReceptCityName(String receptCityName) {
		this.receptCityName = receptCityName;
	}

	public String getReceptCityCode() {
		return receptCityCode;
	}

	public void setReceptCityCode(String receptCityCode) {
		this.receptCityCode = receptCityCode;
	}

	public String getReceptProvNo() {
		return receptProvNo;
	}

	public void setReceptProvNo(String receptProvNo) {
		this.receptProvNo = receptProvNo;
	}

	public String getReceptProvName() {
		return receptProvName;
	}

	public void setReceptProvName(String receptProvName) {
		this.receptProvName = receptProvName;
	}

	public String getReceptAddress() {
		return receptAddress;
	}

	public void setReceptAddress(String receptAddress) {
		this.receptAddress = receptAddress;
	}

	public Integer getExtractFlag() {
		return extractFlag;
	}

	public void setExtractFlag(Integer extractFlag) {
		this.extractFlag = extractFlag;
	}

	public Integer getRecoveryFlag() {
		return recoveryFlag;
	}

	public void setRecoveryFlag(Integer recoveryFlag) {
		this.recoveryFlag = recoveryFlag;
	}

	public Integer getPromFlag() {
		return promFlag;
	}

	public void setPromFlag(Integer promFlag) {
		this.promFlag = promFlag;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public Integer getMemberType() {
		return memberType;
	}

	public void setMemberType(Integer memberType) {
		this.memberType = memberType;
	}

	public String getSaleTimeStr() {
		return saleTimeStr;
	}

	public void setSaleTimeStr(String saleTimeStr) {
		this.saleTimeStr = saleTimeStr;
	}

	public List<OrderItemDto> getOrderItemList() {
		return orderItemList;
	}

	public void setOrderItemList(List<OrderItemDto> orderItemList) {
		this.orderItemList = orderItemList;
	}

	public List<PrSaleDto> getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(List<PrSaleDto> saleOrders) {
		this.saleOrders = saleOrders;
	}

	public List<PaymentItemDto> getPaymentItems() {
		return paymentItems;
	}

	public void setPaymentItems(List<PaymentItemDto> paymentItems) {
		this.paymentItems = paymentItems;
	}

	public String getLatestUpdateMan() {
		return latestUpdateMan;
	}

	public void setLatestUpdateMan(String latestUpdateMan) {
		this.latestUpdateMan = latestUpdateMan;
	}

	public Integer getIsCod() {
		return isCod;
	}

	public void setIsCod(Integer isCod) {
		this.isCod = isCod;
	}

	
	
	public String getPayTimeStr() {
		return payTimeStr;
	}

	public void setPayTimeStr(String payTimeStr) {
		this.payTimeStr = payTimeStr;
	}

	public String getDelayTimeStr() {
		return delayTimeStr;
	}

	public void setDelayTimeStr(String delayTimeStr) {
		this.delayTimeStr = delayTimeStr;
	}

	public String getReceptDistrictNo() {
		return receptDistrictNo;
	}

	public void setReceptDistrictNo(String receptDistrictNo) {
		this.receptDistrictNo = receptDistrictNo;
	}

	public String getReceptDistrictName() {
		return receptDistrictName;
	}

	public void setReceptDistrictName(String receptDistrictName) {
		this.receptDistrictName = receptDistrictName;
	}

	public BigDecimal getSendCost() {
		return sendCost;
	}

	public void setSendCost(BigDecimal sendCost) {
		this.sendCost = sendCost;
	}
	public String getInvoiceTitle() {
		return invoiceTitle;
	}

	public void setInvoiceTitle(String invoiceTitle) {
		this.invoiceTitle = invoiceTitle;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getRequiredDeliveryDate() {
		return requiredDeliveryDate;
	}

	public void setRequiredDeliveryDate(String requiredDeliveryDate) {
		this.requiredDeliveryDate = requiredDeliveryDate;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public BigDecimal getCouponAmount() {
		return couponAmount;
	}

	public void setCouponAmount(BigDecimal couponAmount) {
		this.couponAmount = couponAmount;
	}

	public String getIntegral() {
		return integral;
	}

	public void setIntegral(String integral) {
		this.integral = integral;
	}

	public CpsInfoDto getCpsOrder() {
		return cpsOrder;
	}

	public void setCpsOrder(CpsInfoDto cpsOrder) {
		this.cpsOrder = cpsOrder;
	}

	public String getCalcBillId() {
		return calcBillId;
	}

	public void setCalcBillId(String calcBillId) {
		this.calcBillId = calcBillId;
	}

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	@Override
	public String toString() {
		return "ExcelOrderVo [orderNo=" + orderNo + ", outOrderNo=" + outOrderNo + ", paymentNo="
				+ paymentNo + ", accountNo=" + accountNo + ", memberNo=" + memberNo
				+ ", salesPaymentNo=" + salesPaymentNo + ", orderSource=" + orderSource
				+ ", orderType=" + orderType + ", paymentClass=" + paymentClass + ", saleTime="
				+ saleTime + ", delayTime=" + delayTime + ", orderStatus=" + orderStatus
				+ ", orderStatusDesc=" + orderStatusDesc + ", delivetyStatus=" + delivetyStatus
				+ ", delivetyStatusDesc=" + delivetyStatusDesc + ", payStatus=" + payStatus
				+ ", payTime=" + payTime + ", deliveryMode=" + deliveryMode + ", deliveryModeName="
				+ deliveryModeName + ", needInvoice=" + needInvoice + ", needSendCost="
				+ needSendCost + ", sendCost=" + sendCost + ", salesAmount=" + salesAmount
				+ ", saleSum=" + saleSum + ", refundSum=" + refundSum + ", sendSum=" + sendSum
				+ ", sendAmount=" + sendAmount + ", paymentAmount=" + paymentAmount
				+ ", couponAmount=" + couponAmount + ", integral=" + integral + ", cashAmount="
				+ cashAmount + ", cashIncome=" + cashIncome + ", accountBalanceAmount="
				+ accountBalanceAmount + ", promotionAmount=" + promotionAmount
				+ ", cancelReasonNo=" + cancelReasonNo + ", cancelReason=" + cancelReason
				+ ", customerComments=" + customerComments + ", callCenterComments="
				+ callCenterComments + ", receptPhone=" + receptPhone + ", receptName=" + receptName
				+ ", receptCityNo=" + receptCityNo + ", receptCityName=" + receptCityName
				+ ", receptCityCode=" + receptCityCode + ", receptProvNo=" + receptProvNo
				+ ", receptProvName=" + receptProvName + ", receptAddress=" + receptAddress
				+ ", extractFlag=" + extractFlag + ", recoveryFlag=" + recoveryFlag + ", promFlag="
				+ promFlag + ", version=" + version + ", memberType=" + memberType + ", isCod="
				+ isCod + ", receptDistrictNo=" + receptDistrictNo + ", receptDistrictName="
				+ receptDistrictName + ", invoiceTitle=" + invoiceTitle + ", saleTimeStr="
				+ saleTimeStr + ", payTimeStr=" + payTimeStr + ", delayTimeStr=" + delayTimeStr
				+ ", latestUpdateMan=" + latestUpdateMan + ", contactNumber=" + contactNumber
				+ ", requiredDeliveryDate=" + requiredDeliveryDate + ", realName=" + realName
				+ ", identityCard=" + identityCard + ", cpsOrder=" + cpsOrder + ", calcBillId="
				+ calcBillId + ", shoppeProName=" + shoppeProName + ", createdTime=" + createdTime
				+ "]";
	}
}

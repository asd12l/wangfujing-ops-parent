package com.wangfj.order.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *	货到付款监控表   数据库cod_handover
 * @author zhaosh
 * @date 2013-10-14
 */
public class CodHandover implements Serializable{
	
	private static final long serialVersionUID = 2605153109738645996L;
	private long sid;
	private String orderNo;//订单号
	private Date saleTime;//下单时间
	private String deliveryNo;//运单号
	private double orderMoneySum;//订单金额（包含运费）
	private double saleMoneySum;//订单商品金额
	private double needSendCost;//顾客支付运费
	private double sendMoneySum;//实际发货金额(含运费)
	private double paySendCost;//支付快递公司运费
	private String inceptProvince;//省
	private String inceptCity;//市
	private String inceptArea;//县/区
	private int deliveryComSid;//发货方式SID（快递公司SID）
	private String deliveryComName;//快递公司
	private int orderNum;//订单商品数
	private int sendNum;//实际发货商品数
	private Date printTime;//打印时间
	private long sendRecordSid;//交接单主表SID
	private int diffType;//差异类型
	private int diffCheck;//差异处理
	private Date sendTime;//发货时间
	private Date backTime;//第一次反馈时间
	private int sendStatus;//配送状态
	private int sendInfo;//投递异常具体情况
	private Date confirmTime;//签收日期
	private Date refundTime;//退货日期
	private Date checkTime;//对账日期
	private Date backMoneyTime;//返款日期
	private String backOptUser;//返款确认人
	private Date sendMoneyConfirmTime;//运费结算日期
	private double sendDiffMoney;//运费差额
	private int needBill;//是否需要发票
	private int acceptRealNum;//顾客实收货物数量
	private double acceptRealMoney;//顾客实收货物金额
	private int realRefundNum;//顾客实退货物数量
	private double realRefundMoney;//顾客实退货物金额
	private double orderWeight;//订单重量
	private double realWeight;//实际总量
	private int sendJoinStatus;//交接单状态
	private String remark;//'备注
	private int paymentTypeSid;//支付方式
	private int returnMoneyStatus;//回款状态
	private double payAccount;//应付账目
	private double factorage;//手续费
	private double backFare;//退货运费
	private double safeCost;//保险费用
	private Date lastTime;//最后修改时间
	private String lastUser;//最后修改人
	private String ticketSn;//优惠券
	private double needSaleMoney;//需要支付的钱数、、发货金额
	private String parentOrderNo;
	public String getParentOrderNo() {
		return parentOrderNo;
	}
	public void setParentOrderNo(String parentOrderNo) {
		this.parentOrderNo = parentOrderNo;
	}
	public long getSid() {
		return sid;
	}
	public void setSid(long sid) {
		this.sid = sid;
	}
	public double getNeedSaleMoney() {
		return needSaleMoney;
	}
	public void setNeedSaleMoney(double needSaleMoney) {
		this.needSaleMoney = needSaleMoney;
	}
	public Date getSaleTime() {
		return saleTime;
	}
	public void setSaleTime(Date saleTime) {
		this.saleTime = saleTime;
	}
	public String getDeliveryNo() {
		return deliveryNo;
	}
	public void setDeliveryNo(String deliveryNo) {
		this.deliveryNo = deliveryNo;
	}
	public String getTicketSn() {
		return ticketSn;
	}
	public void setTicketSn(String ticketSn) {
		this.ticketSn = ticketSn;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getDelivetyNo() {
		return deliveryNo;
	}
	public void setDelivetyNo(String delivetyNo) {
		this.deliveryNo = delivetyNo;
	}
	public double getOrderMoneySum() {
		return orderMoneySum;
	}
	public void setOrderMoneySum(double orderMoneySum) {
		this.orderMoneySum = orderMoneySum;
	}
	public double getSaleMoneySum() {
		return saleMoneySum;
	}
	public void setSaleMoneySum(double saleMoneySum) {
		this.saleMoneySum = saleMoneySum;
	}
	public double getNeedSendCost() {
		return needSendCost;
	}
	public void setNeedSendCost(double needSendCost) {
		this.needSendCost = needSendCost;
	}
	public double getSendMoneySum() {
		return sendMoneySum;
	}
	public void setSendMoneySum(double sendMoneySum) {
		this.sendMoneySum = sendMoneySum;
	}
	public double getPaySendCost() {
		return paySendCost;
	}
	public void setPaySendCost(double paySendCost) {
		this.paySendCost = paySendCost;
	}
	public String getInceptProvince() {
		return inceptProvince;
	}
	public void setInceptProvince(String inceptProvince) {
		this.inceptProvince = inceptProvince;
	}
	public String getInceptCity() {
		return inceptCity;
	}
	public void setInceptCity(String inceptCity) {
		this.inceptCity = inceptCity;
	}
	public String getInceptArea() {
		return inceptArea;
	}
	public void setInceptArea(String inceptArea) {
		this.inceptArea = inceptArea;
	}
	public int getDeliveryComSid() {
		return deliveryComSid;
	}
	public void setDeliveryComSid(int deliveryComSid) {
		this.deliveryComSid = deliveryComSid;
	}
	public String getDeliveryComName() {
		return deliveryComName;
	}
	public void setDeliveryComName(String deliveryComName) {
		this.deliveryComName = deliveryComName;
	}
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public int getSendNum() {
		return sendNum;
	}
	public void setSendNum(int sendNum) {
		this.sendNum = sendNum;
	}
	public Date getPrintTime() {
		return printTime;
	}
	public void setPrintTime(Date printTime) {
		this.printTime = printTime;
	}
	public long getSendRecordSid() {
		return sendRecordSid;
	}
	public void setSendRecordSid(long sendRecordSid) {
		this.sendRecordSid = sendRecordSid;
	}
	public int getDiffType() {
		return diffType;
	}
	public void setDiffType(int diffType) {
		this.diffType = diffType;
	}
	public int getDiffCheck() {
		return diffCheck;
	}
	public void setDiffCheck(int diffCheck) {
		this.diffCheck = diffCheck;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	public Date getBackTime() {
		return backTime;
	}
	public void setBackTime(Date backTime) {
		this.backTime = backTime;
	}
	public int getSendStatus() {
		return sendStatus;
	}
	public void setSendStatus(int sendStatus) {
		this.sendStatus = sendStatus;
	}
	public int getSendInfo() {
		return sendInfo;
	}
	public void setSendInfo(int sendInfo) {
		this.sendInfo = sendInfo;
	}
	public Date getConfirmTime() {
		return confirmTime;
	}
	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
	}
	public Date getRefundTime() {
		return refundTime;
	}
	public void setRefundTime(Date refundTime) {
		this.refundTime = refundTime;
	}
	public Date getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}
	public Date getBackMoneyTime() {
		return backMoneyTime;
	}
	public void setBackMoneyTime(Date backMoneyTime) {
		this.backMoneyTime = backMoneyTime;
	}
	public String getBackOptUser() {
		return backOptUser;
	}
	public void setBackOptUser(String backOptUser) {
		this.backOptUser = backOptUser;
	}
	public Date getSendMoneyConfirmTime() {
		return sendMoneyConfirmTime;
	}
	public void setSendMoneyConfirmTime(Date sendMoneyConfirmTime) {
		this.sendMoneyConfirmTime = sendMoneyConfirmTime;
	}
	public double getSendDiffMoney() {
		return sendDiffMoney;
	}
	public void setSendDiffMoney(double sendDiffMoney) {
		this.sendDiffMoney = sendDiffMoney;
	}
	public int getNeedBill() {
		return needBill;
	}
	public void setNeedBill(int needBill) {
		this.needBill = needBill;
	}
	public int getAcceptRealNum() {
		return acceptRealNum;
	}
	public void setAcceptRealNum(int acceptRealNum) {
		this.acceptRealNum = acceptRealNum;
	}
	public double getAcceptRealMoney() {
		return acceptRealMoney;
	}
	public void setAcceptRealMoney(double acceptRealMoney) {
		this.acceptRealMoney = acceptRealMoney;
	}
	public int getRealRefundNum() {
		return realRefundNum;
	}
	public void setRealRefundNum(int realRefundNum) {
		this.realRefundNum = realRefundNum;
	}
	public double getRealRefundMoney() {
		return realRefundMoney;
	}
	public void setRealRefundMoney(double realRefundMoney) {
		this.realRefundMoney = realRefundMoney;
	}
	public double getOrderWeight() {
		return orderWeight;
	}
	public void setOrderWeight(double orderWeight) {
		this.orderWeight = orderWeight;
	}
	public double getRealWeight() {
		return realWeight;
	}
	public void setRealWeight(double realWeight) {
		this.realWeight = realWeight;
	}
	public int getSendJoinStatus() {
		return sendJoinStatus;
	}
	public void setSendJoinStatus(int sendJoinStatus) {
		this.sendJoinStatus = sendJoinStatus;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getPaymentTypeSid() {
		return paymentTypeSid;
	}
	public void setPaymentTypeSid(int paymentTypeSid) {
		this.paymentTypeSid = paymentTypeSid;
	}
	public int getReturnMoneyStatus() {
		return returnMoneyStatus;
	}
	public void setReturnMoneyStatus(int returnMoneyStatus) {
		this.returnMoneyStatus = returnMoneyStatus;
	}
	public double getPayAccount() {
		return payAccount;
	}
	public void setPayAccount(double payAccount) {
		this.payAccount = payAccount;
	}
	public double getFactorage() {
		return factorage;
	}
	public void setFactorage(double factorage) {
		this.factorage = factorage;
	}
	public double getBackFare() {
		return backFare;
	}
	public void setBackFare(double backFare) {
		this.backFare = backFare;
	}
	public double getSafeCost() {
		return safeCost;
	}
	public void setSafeCost(double safeCost) {
		this.safeCost = safeCost;
	}
	public Date getLastTime() {
		return lastTime;
	}
	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}
	public String getLastUser() {
		return lastUser;
	}
	public void setLastUser(String lastUser) {
		this.lastUser = lastUser;
	}
	
}

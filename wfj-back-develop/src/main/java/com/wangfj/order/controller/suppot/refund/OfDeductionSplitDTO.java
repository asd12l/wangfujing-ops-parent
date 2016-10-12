package com.wangfj.order.controller.suppot.refund;

public class OfDeductionSplitDTO {
	private Long sid;

    private String refundItemNo;//

    private Integer rowNo;//付款唯一行号

    private String flag;//扣回支付行

    private String payType;//二级支付方式ZKKH-折扣扣回

    private String paycode;//付款代码，如果是被退款抵扣等于退款行付款代码

    private String payname;//扣回名称

    private String coptype;//返券扣回对应的扣回券种

    private String couponGroup;//返券扣回对应的扣回账户类型

    private Double amount;//扣回金额

    private Double money;//扣回金额抵扣退款支付金额

    private Double rate;//返券扣回时折现冲抵的比例

    private String payno;//扣回返券号

    private String consumersId;//用于支付扣券的会员账号

    private String couponEventId;//扣回返券的返券活动ID

	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String getRefundItemNo() {
		return refundItemNo;
	}

	public void setRefundItemNo(String refundItemNo) {
		this.refundItemNo = refundItemNo;
	}

	public Integer getRowNo() {
		return rowNo;
	}

	public void setRowNo(Integer rowNo) {
		this.rowNo = rowNo;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getPaycode() {
		return paycode;
	}

	public void setPaycode(String paycode) {
		this.paycode = paycode;
	}

	public String getPayname() {
		return payname;
	}

	public void setPayname(String payname) {
		this.payname = payname;
	}

	public String getCoptype() {
		return coptype;
	}

	public void setCoptype(String coptype) {
		this.coptype = coptype;
	}

	public String getCouponGroup() {
		return couponGroup;
	}

	public void setCouponGroup(String couponGroup) {
		this.couponGroup = couponGroup;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Double getRate() {
		return rate;
	}

	public void setRate(Double rate) {
		this.rate = rate;
	}

	public String getPayno() {
		return payno;
	}

	public void setPayno(String payno) {
		this.payno = payno;
	}

	public String getConsumersId() {
		return consumersId;
	}

	public void setConsumersId(String consumersId) {
		this.consumersId = consumersId;
	}

	public String getCouponEventId() {
		return couponEventId;
	}

	public void setCouponEventId(String couponEventId) {
		this.couponEventId = couponEventId;
	}

	@Override
	public String toString() {
		return "OfDeductionSplitDTO [sid=" + sid + ", refundItemNo=" + refundItemNo
				+ ", rowNo=" + rowNo + ", flag=" + flag + ", payType=" + payType + ", paycode="
				+ paycode + ", payname=" + payname + ", coptype=" + coptype + ", couponGroup="
				+ couponGroup + ", amount=" + amount + ", money=" + money + ", rate=" + rate
				+ ", payno=" + payno + ", consumersId=" + consumersId + ", couponEventId="
				+ couponEventId + ", getSid()=" + getSid() + ", getRefundItemNo()="
				+ getRefundItemNo() + ", getRowNo()=" + getRowNo() + ", getFlag()=" + getFlag()
				+ ", getPayType()=" + getPayType() + ", getPaycode()=" + getPaycode()
				+ ", getPayname()=" + getPayname() + ", getCoptype()=" + getCoptype()
				+ ", getCouponGroup()=" + getCouponGroup() + ", getAmount()=" + getAmount()
				+ ", getMoney()=" + getMoney() + ", getRate()=" + getRate() + ", getPayno()="
				+ getPayno() + ", getConsumersId()=" + getConsumersId()
				+ ", getCouponEventId()=" + getCouponEventId() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
}

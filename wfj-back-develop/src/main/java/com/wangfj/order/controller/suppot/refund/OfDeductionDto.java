package com.wangfj.order.controller.suppot.refund;

public class OfDeductionDto {
	private String refundNo;

    private Integer rowNo;

    private String flag;

    private String payType;

    private String paycode;

    private String payname;

    private String coptype;

    private String couponGroup;

    private Double amount;

    private Double money;

    private Double rate;

    private String payno;

    private String consumersId;

    private String couponEventId;

	public String getRefundNo() {
		return refundNo;
	}

	public void setRefundNo(String refundNo) {
		this.refundNo = refundNo;
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
		return "PrDeductionDto [refundNo=" + refundNo + ", rowNo=" + rowNo + ", flag=" + flag
				+ ", payType=" + payType + ", paycode=" + paycode + ", payname=" + payname
				+ ", coptype=" + coptype + ", couponGroup=" + couponGroup + ", amount=" + amount
				+ ", money=" + money + ", rate=" + rate + ", payno=" + payno + ", consumersId="
				+ consumersId + ", couponEventId=" + couponEventId + ", getRefundNo()="
				+ getRefundNo() + ", getRowNo()=" + getRowNo() + ", getFlag()=" + getFlag()
				+ ", getPayType()=" + getPayType() + ", getPaycode()=" + getPaycode()
				+ ", getPayname()=" + getPayname() + ", getCoptype()=" + getCoptype()
				+ ", getCouponGroup()=" + getCouponGroup() + ", getAmount()=" + getAmount()
				+ ", getMoney()=" + getMoney() + ", getRate()=" + getRate() + ", getPayno()="
				+ getPayno() + ", getConsumersId()=" + getConsumersId() + ", getCouponEventId()="
				+ getCouponEventId() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
}

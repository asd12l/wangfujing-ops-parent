package com.wangfj.wms.domain.view;

public class BarcodeDto {
	private String originLand;/* 产地 */
	private Integer type;// 条码类型
	private String barcode;// 条码

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

	public String getOriginLand() {
		return originLand;
	}

	public void setOriginLand(String originLand) {
		this.originLand = originLand;
	}

	@Override
	public String toString() {
		return "BarcodeDto [originLand=" + originLand + ", type=" + type + ", barcode=" + barcode
				+ "]";
	}

}

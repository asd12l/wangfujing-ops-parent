package com.wangfj.wms.domain.view;

/**
 * sku集合VO
 * 
 * @Class Name SkuListVO
 * @Author wangsy
 * @Create In 2015年9月8日
 */
public class SkuListVO {

	private String colorCode;/* 色码（吊牌或者外包装上的色码对应的字典编码,如果没有，必须传空） */
	private String colorName;/* 颜色描述（一般情况下颜色描述=色码） */
	private String proColor;/* 色系 */
	private String sizeCode;/* 尺码/规格 */
	private String features;/* 特性 */
	private String modelNum;/* 货号(吊牌或者外包装的货号，一般情况下货号是到款色规的编码，或者货号=款号) */

	public String getProColor() {
		return proColor;
	}

	public void setProColor(String proColor) {
		this.proColor = proColor;
	}

	public String getColorCode() {
		return colorCode;
	}

	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}

	public String getSizeCode() {
		return sizeCode;
	}

	public void setSizeCode(String sizeCode) {
		this.sizeCode = sizeCode;
	}

	public String getFeatures() {
		return features;
	}

	public void setFeatures(String features) {
		this.features = features;
	}

	public String getColorName() {
		return colorName;
	}

	public void setColorName(String colorName) {
		this.colorName = colorName;
	}

	public String getModelNum() {
		return modelNum;
	}

	public void setModelNum(String modelNum) {
		this.modelNum = modelNum;
	}

	@Override
	public String toString() {
		return "SkuListVO [colorCode=" + colorCode + ", colorName=" + colorName + ", proColor="
				+ proColor + ", sizeCode=" + sizeCode + ", features=" + features + ", modelNum="
				+ modelNum + "]";
	}
}

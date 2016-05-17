package com.wangfj.wms.controller.product.support;

/**
 * 专柜商品导出Excel VO
 * Created by wangxuan on 2016-03-31 0031.
 */
public class ExcelShoppeProductVo {

    private String productCode;//专柜商品编码

    private String skuCode;//SKU编码

    private String productName;//商品名称

    private String storeName;//门店

    private String counterName;//专柜

    private String supplierName;//供应商

    private String brandName;//门店品牌

    private String isSale;//状态

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getSkuCode() {
        return skuCode;
    }

    public void setSkuCode(String skuCode) {
        this.skuCode = skuCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getCounterName() {
        return counterName;
    }

    public void setCounterName(String counterName) {
        this.counterName = counterName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getIsSale() {
        return isSale;
    }

    public void setIsSale(String isSale) {
        this.isSale = isSale;
    }

    @Override
    public String toString() {
        return "ExcelShoppeProductVo{" +
                "productCode='" + productCode + '\'' +
                ", skuCode='" + skuCode + '\'' +
                ", productName='" + productName + '\'' +
                ", storeName='" + storeName + '\'' +
                ", counterName='" + counterName + '\'' +
                ", supplierName='" + supplierName + '\'' +
                ", brandName='" + brandName + '\'' +
                ", isSale='" + isSale + '\'' +
                '}';
    }
}

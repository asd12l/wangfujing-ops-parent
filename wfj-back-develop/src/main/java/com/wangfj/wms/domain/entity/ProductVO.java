package com.wangfj.wms.domain.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.framework.page.Page;

/**
 * Description:商品VO
 * 对应实体类： ProductList
 * History: 2010-1-25 modify by Peter Wei:添加调整属性
 */
public class ProductVO extends Page implements Serializable {
    //商品ID
    private String sid;
    //品牌sid
    private String brandSid;
    //单品分类
    private String proClassSid;
    //商品sku
    private String proSku;
    //商品最大重量 默认值26
    private String proWeightSid;
    //商品描述
    private String proDesc;
    //商品描述
    private String proPageDesc;
    //是否启用0未启用 1启用 默认 1
    private String proActiveBit;
    //是否上架0未上架 1上架 默认 0
    private String proSelling;
    //商品类型（是否是正式商品） 0 非正式商品 1 正式商品
    private String proType;
    //商品名称,默认值  款式+材质(显示名称)+2及分类+sku
    private String productName;
    //会员级别id
    private String membersLevelSid;

    //上架时间，数据库新增
    private Date proSellingTime;

    //商品价格
    private ProductPriceVO proPrice;

    //商品图片
    private ProductPicVO proPicture;

    //品牌
    private BrandVO brand;

    private String productCateSid;

    //分类,不允许自动映射的属性,改名
    private List<ProductCateVO> productCates;

    //商品图片列表,不允许自动映射的属性,改名
    private List<ProductPicVO> proPics;




    /*
    private Date proWriTime;      //商品录入时间
    private String sexSid;
    private String ageSid;
    private String occasionWearSid;
    private String materialStyleSid;
    private String seasonSid;
    private String whichyear;
    private String optUserSid;
    private String optRealName;
    private Date optUpdateTime;
    private Set<ProDetailVO> proDetails;
    */

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getBrandSid() {
        return brandSid;
    }

    public void setBrandSid(String brandSid) {
        this.brandSid = brandSid;
    }

    public String getProClassSid() {
        return proClassSid;
    }

    public void setProClassSid(String proClassSid) {
        this.proClassSid = proClassSid;
    }

    public String getProSku() {
        return proSku;
    }

    public void setProSku(String proSku) {
        this.proSku = proSku;
    }

    public String getProWeightSid() {
        return proWeightSid;
    }

    public void setProWeightSid(String proWeightSid) {
        this.proWeightSid = proWeightSid;
    }

    public String getProDesc() {
        return proDesc;
    }

    public void setProDesc(String proDesc) {
        this.proDesc = proDesc;
    }

    public String getProPageDesc() {
        return proPageDesc;
    }

    public void setProPageDesc(String proPageDesc) {
        this.proPageDesc = proPageDesc;
    }

    public String getProActiveBit() {
        return proActiveBit;
    }

    public void setProActiveBit(String proActiveBit) {
        this.proActiveBit = proActiveBit;
    }

    public String getProSelling() {
        return proSelling;
    }

    public void setProSelling(String proSelling) {
        this.proSelling = proSelling;
    }

    public String getProType() {
        return proType;
    }

    public void setProType(String proType) {
        this.proType = proType;
    }

    public String getProductName() {
        String proName = "";
        if (brand != null) {
            if (brand.getBrandName() != null) {
                proName = proName + brand.getBrandName();
            }
        }
        proName = proName + "专柜正品";
        proName = proName + productName;
        return proName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Date getProSellingTime() {
        return proSellingTime;
    }

    public void setProSellingTime(Date proSellingTime) {
        this.proSellingTime = proSellingTime;
    }

    public ProductPriceVO getProPrice() {
        return proPrice;
    }

    public void setProPrice(ProductPriceVO proPrice) {
        this.proPrice = proPrice;
    }

    public ProductPicVO getProPicture() {
        return proPicture;
    }

    public void setProPicture(ProductPicVO proPicture) {
        this.proPicture = proPicture;
    }

    public BrandVO getBrand() {
        return brand;
    }

    public void setBrand(BrandVO brand) {
        this.brand = brand;
    }

    public List<ProductCateVO> getProductCates() {
        return productCates;
    }

    public void setProductCates(List<ProductCateVO> productCates) {
        this.productCates = productCates;
    }

    public List<ProductPicVO> getProPics() {
        return proPics;
    }

    public void setProPics(List<ProductPicVO> proPics) {
        this.proPics = proPics;
    }

    public String getMembersLevelSid() {
        return membersLevelSid;
    }

    public void setMembersLevelSid(String membersLevelSid) {
        this.membersLevelSid = membersLevelSid;
    }

    public String getProductCateSid() {
        if (productCates != null && productCates.size() > 0) {
            return productCates.get(0).getSid();
        }
        return "";
    }

    public void setProductCateSid(String productCateSid) {
        this.productCateSid = productCateSid;
    }

    @Override
    public String toString() {
        return "ProductVO{" +
                "sid='" + sid + '\'' +
                ", brandSid='" + brandSid + '\'' +
                ", proSku='" + proSku + '\'' +
                ", proWeightSid='" + proWeightSid + '\'' +
                ", proDesc='" + proDesc + '\'' +
                ", proActiveBit='" + proActiveBit + '\'' +
                ", proSelling='" + proSelling + '\'' +
                ", proType='" + proType + '\'' +
                ", productName='" + productName + '\'' +
                ", proSellingTime=" + proSellingTime +
                ", proPrice=" + proPrice +
                ", proPicture=" + proPicture +
                ", brand=" + brand +
                '}';
    }
}

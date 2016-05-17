package com.wangfj.wms.domain.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: chengsj
 * Date: 2010-1-20
 * Time: 15:38:21
 * 商品价格
 * <p/>
 * 实体类：VSupplyMinPrice
 */
public class ProductPriceVO implements Serializable {
    private String sid;
    private String productSid;
    private String currentPrice;     //现价 保留2位小数
    private String originalPrice;    //原价 保留2位小数
    //private String saleCodeSid;
    private double offValue;         //折扣值PROMOTION_PRICE/ORIGINAL_PRICE
    private String promotionPrice;   //促销价格 缺省为现价
    private Date promotionBeginTime; //促销开始时间
    private Date promotionEndTime;   //促销结束时间
    private int proSum;//当前价格下的商品数量

    private long remainSeconds;

    private double saveMoney;
    //private ProductVO product;       //相关商品
    /*
    private Date proWriTime;     //录入时间
    private String optUserSid;
    private String optRealName;
    private Date optUpdateTime;
    */

    public String getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(String currentPrice) {
        this.currentPrice = currentPrice;
    }

    public double getOffValue() {
        return new BigDecimal(offValue)
                .setScale(2, BigDecimal.ROUND_HALF_UP)
                .multiply(new BigDecimal(10))
                .doubleValue();
    }

    public void setOffValue(double offValue) {
        this.offValue = offValue;
    }

    public String getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(String originalPrice) {
        this.originalPrice = originalPrice;
    }

    public String getProductSid() {
        return productSid;
    }

    public void setProductSid(String productSid) {
        this.productSid = productSid;
    }

    public Date getPromotionBeginTime() {
        return promotionBeginTime;
    }

    public void setPromotionBeginTime(Date promotionBeginTime) {
        this.promotionBeginTime = promotionBeginTime;
    }

    public Date getPromotionEndTime() {
        return promotionEndTime;
    }

    public void setPromotionEndTime(Date promotionEndTime) {
        this.promotionEndTime = promotionEndTime;
    }

    public String getPromotionPrice() {
        return promotionPrice;
    }

    public void setPromotionPrice(String promotionPrice) {
        this.promotionPrice = promotionPrice;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public int getProSum() {
        return proSum;
    }

    public void setProSum(int proSum) {
        this.proSum = proSum;
    }

    public long getRemainSeconds() {
        if (promotionEndTime != null) {
            return (promotionEndTime.getTime() - new Date().getTime()) / 1000;
        } else {
            return 0;
        }
    }

    public void setRemainSeconds(long remainSeconds) {
        if (promotionEndTime != null) {
            this.remainSeconds = (promotionEndTime.getTime() - new Date().getTime()) / 1000;
        }
    }

    public double getSaveMoney() {
        return new BigDecimal(originalPrice).subtract(new BigDecimal(promotionPrice)).doubleValue();
    }

    public void setSaveMoney(double saveMoney) {
        this.saveMoney = saveMoney;
    }

    @Override
    public String toString() {
        return "ProductPriceVO{" +
                "currentPrice=" + currentPrice +
                ", sid='" + sid + '\'' +
                ", productSid='" + productSid + '\'' +
                ", originalPrice=" + originalPrice +
                ", offValue=" + offValue +
                ", promotionPrice=" + promotionPrice +
                ", promotionBeginTime=" + promotionBeginTime +
                ", promotionEndTime=" + promotionEndTime +
                '}';
    }
}

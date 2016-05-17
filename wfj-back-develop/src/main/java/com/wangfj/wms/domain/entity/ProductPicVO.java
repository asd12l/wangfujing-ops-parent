package com.wangfj.wms.domain.entity;

import java.io.Serializable;

/**
 * Description:
 * User: chengsj
 * Date: 2010-1-22
 * Time: 17:21:57
 * <p/>
 * 实体类：VProPicture
 * History: 2010-1-25 modify by Peter Wei:添加VO属性
 */
public class ProductPicVO implements Serializable {
    //图片ID
    private String sid;
    //商品SID
    private String productSid;
    //图片文件名称
    private String proPictName;
    //图片存放目录
    private String proPictDir;
    //图片顺序号
    private String proPictOrder;
    //是否是模特 1 是 0不是  默认0
    private String pictureModelBit;
    //是否主图  1 是 0不是 默认0
    private String pictureMastBit;
    //色码表SID
    private String proColorSid;
    //图片尺寸类型表
    private String proPictureSizeSid;


    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getProductSid() {
        return productSid;
    }

    public void setProductSid(String productSid) {
        this.productSid = productSid;
    }

    public String getProPictName() {
        return proPictName;
    }

    public void setProPictName(String proPictName) {
        this.proPictName = proPictName;
    }

    public String getProPictDir() {
        return proPictDir;
    }

    public void setProPictDir(String proPictDir) {
        this.proPictDir = proPictDir;
    }

    public String getProPictOrder() {
        return proPictOrder;
    }

    public void setProPictOrder(String proPictOrder) {
        this.proPictOrder = proPictOrder;
    }

    public String getPictureModelBit() {
        return pictureModelBit;
    }

    public void setPictureModelBit(String pictureModelBit) {
        this.pictureModelBit = pictureModelBit;
    }

    public String getPictureMastBit() {
        return pictureMastBit;
    }

    public void setPictureMastBit(String pictureMastBit) {
        this.pictureMastBit = pictureMastBit;
    }

    public String getProColorSid() {
        return proColorSid;
    }

    public void setProColorSid(String proColorSid) {
        this.proColorSid = proColorSid;
    }

    public String getProPictureSizeSid() {
        return proPictureSizeSid;
    }

    public void setProPictureSizeSid(String proPictureSizeSid) {
        this.proPictureSizeSid = proPictureSizeSid;
    }


    @Override
    public String toString() {
        return "ProductPicVO{" +
                "pictureMastBit='" + pictureMastBit + '\'' +
                ", sid='" + sid + '\'' +
                ", productSid='" + productSid + '\'' +
                ", proPictName='" + proPictName + '\'' +
                ", proPictDir='" + proPictDir + '\'' +
                ", proPictOrder='" + proPictOrder + '\'' +
                ", pictureModelBit='" + pictureModelBit + '\'' +
                ", proColorSid='" + proColorSid + '\'' +
                ", proPictureSizeSid='" + proPictureSizeSid + '\'' +
                '}';
    }
}

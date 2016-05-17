package com.wangfj.wms.domain.entity;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: chengsj
 * Date: 2010-1-17
 * Time: 16:14:03
 * History: 2010-1-25 modify by Peter Wei:添加调整属性
 * 实体类： Brand
 * <p/>
 * 品牌
 * Modify by:chengsj
 * Date: 2011-03-07
 * 添加了FactoryStore的相关属性
 */
public class BrandVO implements Serializable {
	//是否高亮显示
	private String flag;
	
    public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	//品牌ID
    private String sid;
    //品牌名称
    private String brandName;
    //品牌链接
    private String brandLink;
    //图片链接
    private String pictureUrl;
    //别名
    private String brandNameSecond;
    //品牌是否启用  0 不启用  1 启用 默认1;
    private String brandActiveBit;
    //品牌注册号
    private String brandno;
	//品牌所属公司
    private String brandcorp;
    //品牌图片1地址
    private String brandpic1;
    //品牌图片2地址
    private String brandpic2;
    //品牌图片
    private String brandPict;
    //品牌父节点
    private String parentSid;
    //是否叶子节点
    private String endBit;
    //拼音
    private String spell;
    //品牌描述, 使用BrandDisplay中的信息.
    private String brandDesc;
    //创建国家
    private String brandCreateCountry;
    //创建时间
    private String brandCreateTime;
    //品牌特点
    private String brandSpecialty;
    //适合人群
    private String brandSuitability;
    
    //品牌下的商品数量
    private String productCount;

     //是否是工厂店，1是工厂店，0不是工厂店（即，是品牌）
    private int isFactoryStore;

    //工厂店大图片，只保存图片地址
    private String factoryBicPic;

    //工厂店的上级工厂店
    //0表示为主工厂店，1表示为旗下工厂店
    private Integer parentFactoryStore;
    
    
    
    public String getBrandLink() {
		return brandLink;
	}

	public void setBrandLink(String brandLink) {
		this.brandLink = brandLink;
	}

    public Integer getParentFactoryStore() {
        return parentFactoryStore;
    }

    public void setParentFactoryStore(Integer parentFactoryStore) {
        this.parentFactoryStore = parentFactoryStore;
    }

    public int getFactoryStore() {
        return isFactoryStore;
    }

    public void setFactoryStore(int factoryStore) {
        isFactoryStore = factoryStore;
    }

    public String getFactoryBicPic() {
        return factoryBicPic;
    }

    public void setFactoryBicPic(String factoryBicPic) {
        this.factoryBicPic = factoryBicPic;
    }

    public String getFactorySmallPic() {
        return factorySmallPic;
    }

    public void setFactorySmallPic(String factorySmallPic) {
        this.factorySmallPic = factorySmallPic;
    }

    public String getActivityBigPic() {
        return activityBigPic;
    }

    public void setActivityBigPic(String activityBigPic) {
        this.activityBigPic = activityBigPic;
    }

    public String getActivitySmallPic() {
        return activitySmallPic;
    }

    public void setActivitySmallPic(String activitySmallPic) {
        this.activitySmallPic = activitySmallPic;
    }

    public int getFactoryOrder() {
        return factoryOrder;
    }

    public void setFactoryOrder(int factoryOrder) {
        this.factoryOrder = factoryOrder;
    }

    //工厂店缩略图
    private String factorySmallPic;

    //活动大图片
    private String activityBigPic;

    //活动小图地址
    private String activitySmallPic;

    //工厂店排序字段，用来对页面显示的工厂店进行排序用
    private int factoryOrder;



    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public String getBrandNameSecond() {
        return brandNameSecond;
    }

    public void setBrandNameSecond(String brandNameSecond) {
        this.brandNameSecond = brandNameSecond;
    }

    public String getBrandActiveBit() {
        return brandActiveBit;
    }

    public void setBrandActiveBit(String brandActiveBit) {
        this.brandActiveBit = brandActiveBit;
    }

    public String getBrandno() {
        return brandno;
    }

    public void setBrandno(String brandno) {
        this.brandno = brandno;
    }

    public String getBrandcorp() {
        return brandcorp;
    }

    public void setBrandcorp(String brandcorp) {
        this.brandcorp = brandcorp;
    }

    public String getBrandpic1() {
        return brandpic1;
    }

    public void setBrandpic1(String brandpic1) {
        this.brandpic1 = brandpic1;
    }

    public String getBrandpic2() {
        return brandpic2==null?"/defBrand.jpg":brandpic2;
    }

    public void setBrandpic2(String brandpic2) {
        this.brandpic2 = brandpic2;
    }

    public String getBrandPict() {
        return brandPict;
    }

    public void setBrandPict(String brandPict) {
        this.brandPict = brandPict;
    }

    public String getParentSid() {
        return parentSid;
    }

    public void setParentSid(String parentSid) {
        this.parentSid = parentSid;
    }

    public String getEndBit() {
        return endBit;
    }

    public void setEndBit(String endBit) {
        this.endBit = endBit;
    }

    public String getSpell() {
        return spell;
    }

    public void setSpell(String spell) {
        this.spell = spell;
    }

    public String getBrandDesc() {
        return brandDesc;
    }

    public void setBrandDesc(String brandDesc) {
        this.brandDesc = brandDesc;
    }

    public String getProductCount() {
        return productCount;
    }

    public void setProductCount(String productCount) {
        this.productCount = productCount;
    }

    public String getBrandCreateCountry() {
        return brandCreateCountry;
    }

    public void setBrandCreateCountry(String brandCreateCountry) {
        this.brandCreateCountry = brandCreateCountry;
    }

    public String getBrandCreateTime() {
        return brandCreateTime;
    }

    public void setBrandCreateTime(String brandCreateTime) {
        this.brandCreateTime = brandCreateTime;
    }

    public String getBrandSpecialty() {
        return brandSpecialty;
    }

    public void setBrandSpecialty(String brandSpecialty) {
        this.brandSpecialty = brandSpecialty;
    }

    public String getBrandSuitability() {
        return brandSuitability;
    }

    public void setBrandSuitability(String brandSuitability) {
        this.brandSuitability = brandSuitability;
    }

    @Override
    public String toString() {
        return "BrandVO{" +
                "sid='" + sid + '\'' +
                ", brandName='" + brandName + '\'' +
                ", pictureUrl='" + pictureUrl + '\'' +
                ", brandNameSecond='" + brandNameSecond + '\'' +
                ", brandActiveBit='" + brandActiveBit + '\'' +
                ", brandno='" + brandno + '\'' +
                ", brandcorp='" + brandcorp + '\'' +
                ", brandpic1='" + brandpic1 + '\'' +
                ", brandpic2='" + brandpic2 + '\'' +
                ", parentSid='" + parentSid + '\'' +
                ", endBit='" + endBit + '\'' +
                ", spell='" + spell + '\'' +
                ", brandDesc='" + brandDesc + '\'' +
                ", productCount='" + productCount + '\'' +
                '}';
    }


 //用来从flex接受工厂店搜索
    private String factoryName;
    public String getFactoryName() {
        return factoryName;
    }

    public void setFactoryName(String factoryName) {
        this.factoryName = factoryName;
    }
}

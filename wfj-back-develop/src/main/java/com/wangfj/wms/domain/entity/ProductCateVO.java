package com.wangfj.wms.domain.entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;
import java.util.TreeMap;

/**
 * Created by IntelliJ IDEA.
 * User: chengsj
 * Date: 2010-1-17
 * Time: 17:04:04
 * 实体类：ProductClass
 * <p/>
 * 商品类别
 */
public class ProductCateVO implements Serializable {
    private String sid;
    private String serialNumber;  //分类编码
    private String nodeName;      //节点名称
    private String fatherNodeSid; //父节点
    private String rootNodeSid;   //第一级节点
    private String nodeSeq;       //顺序
    private String nodeLevel;
    private String isDisplay;     //是否显示
    private String memo;          //备注
    private int productCount;   //品类商品数量
    private ProductCateVO parentCate; //父分类
    private Map<String,ProductCateVO> childCatesMap = new TreeMap<String,ProductCateVO>();//子品类
    private Collection<ProductCateVO> childCates;//子品类列表

    //private Set<ProductVO> productLists;


    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getNodeName() {
        return nodeName;
    }

    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }

    public String getFatherNodeSid() {
        return fatherNodeSid;
    }

    public void setFatherNodeSid(String fatherNodeSid) {
        this.fatherNodeSid = fatherNodeSid;
    }

    public String getRootNodeSid() {
        return rootNodeSid;
    }

    public void setRootNodeSid(String rootNodeSid) {
        this.rootNodeSid = rootNodeSid;
    }

    public String getNodeLevel() {
        return nodeLevel;
    }

    public void setNodeLevel(String nodeLevel) {
        this.nodeLevel = nodeLevel;
    }

    public String getNodeSeq() {
        return nodeSeq;
    }

    public void setNodeSeq(String nodeSeq) {
        this.nodeSeq = nodeSeq;
    }

    public String getDisplay() {
        return isDisplay;
    }

    public void setDisplay(String display) {
        isDisplay = display;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Override
    public String toString() {
        return "ProductCateVO{" +
                "sid='" + sid + '\'' +
                ", nodeName='" + nodeName + '\'' +
                ", productCount='" + productCount + '\'' +
                ", cateList=" + childCates +
                '}';
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    public ProductCateVO getParentCate() {
        return parentCate;
    }

    public void setParentCate(ProductCateVO parentCate) {
        this.parentCate = parentCate;
    }

    public Map<String,ProductCateVO> getChildCatesMap() {
        return childCatesMap;
    }

    public void setChildCatesMap(Map<String,ProductCateVO> childCatesMap) {
        this.childCatesMap = childCatesMap;
    }

    public Collection<ProductCateVO> getChildCates() {
        return childCatesMap.values();
    }

    public void setChildCates(Collection<ProductCateVO> childCates) {
        this.childCates = childCatesMap.values();
    }
}

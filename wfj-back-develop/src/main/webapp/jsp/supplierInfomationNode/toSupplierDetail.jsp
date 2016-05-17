<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript">
        __ctxPath = "${pageContext.request.contextPath}";
        $(function(){
            $("#close").click(function(){
                $("#pageBody").load(__ctxPath+"/jsp/supplierInfomationNode/SupplierInfomationNode.jsp");
            });
        });
    </script>
</head>
<body>
<div class="page-body">
<div class="row">
<div class="col-lg-12 col-sm-12 col-xs-12">
<div class="row">
<div class="col-lg-12 col-sm-12 col-xs-12">
<div class="widget radius-bordered">
<div class="widget-header">
    <span class="widget-caption">供应商详情</span>
</div>
<div class="widget-body">
<form id="theForm" method="post" class="form-horizontal">
<input type="hidden" name="sid" id="sid" value="${json.sid }"/>
<input type="hidden" name="userName" value="${json.lastOptUser }"/>
<h5><strong>单位基本信息</strong></h5>
<hr class="wide" style="margin-top: 0;">
<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">供应商名称：</label>
        <div class="col-lg-6">
            <label class="control-label" id="supplyName">${json.supplyName }</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">供应商编码：</label>
        <div class="col-lg-6">
            <label class="control-label" id="supplyCode">${json.supplyCode }</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">门店编码：</label>
        <div class="col-lg-6">
            <label class="control-label" id="shopSid">${json.shopSid}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">供应商简称：</label>
        <div class="col-lg-6">
            <label class="control-label" id="shortName">${json.shortName}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">供应商状态：</label>
        <div class="col-lg-6">
            <label class="control-label" id="status">
                <c:if test="${json.status == 'Y'}">正常</c:if>
                <c:if test="${json.status == 'T'}">未批准</c:if>
                <c:if test="${json.status == 'N'}">终止</c:if>
                <c:if test="${json.status == 'L'}">待审批</c:if>
                <c:if test="${json.status == '3'}">淘汰</c:if>
                <c:if test="${json.status == '4'}">停货</c:if>
                <c:if test="${json.status == '5'}">停款</c:if>
                <c:if test="${json.status == '6'}">冻结</c:if>
            </label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">重点供应商：</label>
        <div class="col-lg-6">
            <label class="control-label" id="keySupplier">
                <c:if test="${json.keySupplier == '0'}">否</c:if>
                <c:if test="${json.keySupplier == '1'}">是</c:if>
            </label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">供应商类型：</label>
        <div class="col-lg-6">
            <label class="control-label" id="supplyType">
                <c:if test="${json.supplyType == '0'}">门店供应商</c:if>
                <c:if test="${json.supplyType == '1'}">集团供应商</c:if>
            </label>
        </div>
    </div>

    <div class="col-md-6">
        <label class="col-lg-3 control-label">经营方式：</label>
        <div class="col-lg-6">
            <label class="control-label" id="businessPattern">
                <c:if test="${json.businessPattern == '0'}">经销</c:if>
                <c:if test="${json.businessPattern == '1'}">代销</c:if>
                <c:if test="${json.businessPattern == '2'}">联营</c:if>
                <c:if test="${json.businessPattern == '3'}">平台服务</c:if>
                <c:if test="${json.businessPattern == '4'}">租赁</c:if>
            </label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">所属行业：</label>
        <div class="col-lg-6">
            <label class="control-label" id="industry">${json.industry}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">经营范围：</label>
        <div class="col-lg-6">
            <label class="control-label" id="businessScope">${json.businessScope}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">企业性质：</label>
        <div class="col-lg-6">
            <label class="control-label" id="enterpriseProperty">${json.enterpriseProperty}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">企业类别：</label>
        <div class="col-lg-6">
            <label class="control-label" id="businessCategory">${json.businessCategory}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">通讯地址：</label>
        <div class="col-lg-9">
            <label class="control-label" id="street">${json.street}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">企业代码：</label>
        <div class="col-lg-6">
            <label class="control-label" id="orgCode">${json.orgCode}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">邮编：</label>
        <div class="col-lg-6">
            <label class="control-label" id="postcode">${json.postcode}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">邮箱：</label>
        <div class="col-lg-6">
            <label class="control-label" id="email">${json.email}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">联系电话：</label>
        <div class="col-lg-6">
            <label class="control-label" id="phone">${json.phone}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">传真：</label>
        <div class="col-lg-6">
            <label class="control-label" id="fax">${json.fax}</label>
        </div>
    </div>
</div>
&nbsp;
<h5><strong>工商与税务信息</strong></h5>
<hr class="wide" style="margin-top: 0;">
<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">营业执照号：</label>
        <div class="col-lg-6">
            <label class="control-label" id="bizCertificateNo">${json.bizCertificateNo}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">入准日期：</label>
        <div class="col-lg-6">
            <label class="control-label" id="admissionDate">${json.admissionDate}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">注册资本：</label>
        <div class="col-lg-6">
            <label class="control-label" id="registeredCapital">${json.registeredCapital}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">税率：</label>
        <div class="col-lg-6">
            <label class="control-label" id="taxRates">${json.taxRates}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">纳税类别：</label>
        <div class="col-lg-6">
            <label class="control-label" id="taxType">
                <c:if test="${json.taxType == '1'}">增值税一般纳税人</c:if>
                <c:if test="${json.taxType == '2'}">小规模纳税人</c:if>
                <c:if test="${json.taxType == '3'}">交纳营业税</c:if>
                <c:if test="${json.taxType == '4'}">零税率</c:if>
                <c:if test="${json.taxType == '5'}">增值税一般纳税人</c:if>
                <c:if test="${json.taxType == '1'}">自然人</c:if>
            </label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">税号：</label>
        <div class="col-lg-6">
            <label class="control-label" id="taxNumbe">${json.taxNumbe}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">银行：</label>
        <div class="col-lg-6">
            <label class="control-label" id="bank">${json.bank}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-3 control-label">银行帐号：</label>
        <div class="col-lg-6">
            <label class="control-label" id="bankNo">${json.bankNo}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-3 control-label">组织结构代码：</label>
        <div class="col-lg-6">
            <label class="control-label" id="field1">${json.field1}</label>
        </div>
    </div>
</div>
&nbsp;

<h5><strong>相关人员信息</strong></h5>
<hr class="wide" style="margin-top: 0;">
<div class="form-group">
    <div class="col-md-4">
        <label class="col-lg-5 control-label">法人代表：</label>
        <div class="col-lg-7">
            <label class="control-label" id="legalPerson">${json.legalPerson}</label>
        </div>
    </div>
    <div class="col-md-4">
        <label class="col-lg-5 control-label">法人联系人：</label>
        <div class="col-lg-7">
            <label class="control-label" id="legalPersonContact">${json.legalPersonContact}</label>
        </div>
    </div>
    <div class="col-md-4">
        <label class="col-lg-5 control-label">法人身份证号：</label>
        <div class="col-lg-7">
            <label class="control-label" id="legalPersonIcCode">${json.legalPersonIcCode}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-4">
        <label class="col-lg-5 control-label">代理人：</label>
        <div class="col-lg-7">
            <label class="control-label" id="agent">${json.agent}</label>
        </div>
    </div>
    <div class="col-md-4">
        <label class="col-lg-5 control-label">代理人联系方式：</label>
        <div class="col-lg-7">
            <label class="control-label" id="agentContact">${json.agentContact}</label>
        </div>
    </div>
    <div class="col-md-4">
        <label class="col-lg-5 control-label">代理人身份证号：</label>
        <div class="col-lg-7">
            <label class="control-label" id="agentIcCode">${json.agentIcCode}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-4">
        <label class="col-lg-5 control-label">联系人：</label>
        <div class="col-lg-7">
            <label class="control-label" id="contact">${json.contact}</label>
        </div>
    </div>
    <div class="col-md-4">
        <label class="col-lg-5 control-label">联系人身份证号：</label>
        <div class="col-lg-7">
            <label class="control-label" id="contactIcCode">${json.contactIcCode}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-4">
        <label class="col-lg-5 control-label">联系人职务：</label>
        <div class="col-lg-7">
            <label class="control-label" id="contactTitle">${json.contactTitle}</label>
        </div>
    </div>
    <div class="col-md-4">
        <label class="col-lg-5 control-label">联系人联系方式：</label>
        <div class="col-lg-7">
            <label class="control-label" id="contactWay">${json.contactWay}</label>
        </div>
    </div>
</div>

&nbsp;
<h5><strong>其他信息</strong></h5>
<hr class="wide" style="margin-top: 0;">
<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-5 control-label">退货至供应商 ：</label>
        <div class="col-lg-6">
            <label class="control-label" id="returnSupply">
                <c:if test="${json.returnSupply == '0'}">否</c:if>
                <c:if test="${json.returnSupply == '1'}">是</c:if>
            </label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-5 control-label">联营商品客退地点：</label>
        <div class="col-lg-6">
            <label class="control-label" id="joinSite">${json.joinSite}</label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-5 control-label">供应商的门店ERP或电商编码：</label>
        <div class="col-lg-6">
            <label class="control-label" id="erpSupplierCode">${json.erpSupplierCode}</label>
        </div>
    </div>
    <div class="col-md-6">
        <label class="col-lg-5 control-label">区分奥莱和其它虚库标识：</label>
        <div class="col-lg-6">
            <label class="control-label" id="dropship">
                <c:if test="${json.dropship == '0'}">否</c:if>
                <c:if test="${json.dropship == '1'}">是</c:if>
            </label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <label class="col-lg-5 control-label">操作人：</label>
        <div class="col-lg-6">
            <label class="control-label" id="lastOptUser">${json.lastOptUser}</label>
        </div>
    </div>
    <c:if test="${json.shopSid == 'D001'}">
        <div class="col-md-6">
            <label class="col-lg-5 control-label">拆单标识：</label>
            <div class="col-lg-6">
                <label class="control-label" id="apartOrder">
                    <c:if test="${json.apartOrder == '0'}">否</c:if>
                    <c:if test="${json.apartOrder == '1'}">是</c:if>
                </label>
            </div>
        </div>
    </c:if>
</div>

<c:if test="${json.shopSid == 'D001'}">
    <div class="form-group">
        <div class="col-md-6">
            <label class="col-lg-5 control-label">虚库标志：</label>
            <div class="col-lg-6">
                <label class="control-label" id="zlyFlag">
                    <c:if test="${json.zlyFlag == 'Y'}">虚库</c:if>
                    <c:if test="${json.zlyFlag == 'N'}">自库</c:if>
                </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-6">
            <label class="col-lg-5 control-label">先销后采：</label>
            <div class="col-lg-6">
                <label class="control-label" id="zzxxhcFlag">
                    <c:if test="${json.zzxxhcFlag == 'Y'}">是</c:if>
                    <c:if test="${json.zzxxhcFlag == 'N'}">否</c:if>
                </label>
            </div>
        </div>
    </div>
</c:if>
<div class="form-group">
    <div class="col-lg-offset-4 col-lg-6">
        <input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="返回" />
    </div>
</div>
</form>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<!-- /Page Body -->
<script>
</script>
</body>
</html>
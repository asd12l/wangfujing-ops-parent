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
  		
  		$("#supplyName").text(supplyName_);
  		$("#postcode").text(postcode_);
  		$("#city").text(city_);
  		$("#country").text(country_);
  		$("#zone").text(zone_);
  		$("#shopRegion").text(shopRegion_);
  		$("#address").text(address_);
  		$("#phone").text(phone_);
  		$("#fax").text(fax_);
  		$("#email").text(email_);
  		$("#lastOptUser").text(lastOptUser_);
  		$("#shopSid").text(shopSid_);
        if("D001" == shopSid_){
            $("#apartOrderDiv").css("display","block");
        }
  		$("#supplyCode").text(supplyCode_);
  		var supplyTypeTxt = "";
  		if (supplyType_ == "0") {
			supplyTypeTxt = "门店供应商";
		}
  		if (supplyType_ == "1") {
			supplyTypeTxt = "集团供应商";
		}
  		$("#supplyType").text(supplyTypeTxt);
  		var statusTxt = "";
		if ("Y" == status_) {
			statusTxt = "正常";
		}
		if ("T" == status_) {
			statusTxt = "未批准";
		}
		if ("N" == status_) {
			statusTxt = "终止";
		}
		if ("L" == status_) {
			statusTxt = "待审批";
		}
		if ("3" == status_) {
			statusTxt = "淘汰";
		}
		if ("4" == status_) {
			statusTxt = "停货";
		}
		if ("5" == status_) {
			statusTxt = "停款";
		}
		if ("6" == status_) {
			statusTxt = "冻结";
		}
  		$("#status").text(statusTxt);
  		$("#shortName").text(shortName_);
  		var businessPatternTxt = "";
		if ("0" == businessPattern_) {
			businessPatternTxt = "经销";
		}
		if ("1" == businessPattern_) {
			businessPatternTxt = "代销";
		}
		if ("2" == businessPattern_) {
			businessPatternTxt = "联营";
		}
		if ("3" == businessPattern_) {
			businessPatternTxt = "平台服务";
		}
		if ("4" == businessPattern_) {
			businessPatternTxt = "租赁";
		}
  		$("#businessPattern").text(businessPatternTxt);
  		$("#street").text(street_);
  		$("#orgCode").text(orgCode_);
  		$("#industry").text(industry_);
  		$("#bizCertificateNo").text(bizCertificateNo_);
  		var taxTypeTxt = "";
		if ("1" == taxType_) {
			taxTypeTxt = "增值税一般纳税人";
		}
		if ("2" == taxType_) {
			taxTypeTxt = "小规模纳税人";
		}
		if ("3" == taxType_) {
			taxTypeTxt = "交纳营业税";
		}
		if ("4" == taxType_) {
			taxTypeTxt = "零税率";
		}
		if ("5" == taxType_) {
			taxTypeTxt = "自然人";
		}
  		$("#taxType").text(taxTypeTxt);
  		$("#taxNumbe").text(taxNumbe_);
  		$("#bank").text(bank_);
  		$("#bankNo").text(bankNo_);
  		$("#registeredCapital").text(registeredCapital_);
  		$("#enterpriseProperty").text(enterpriseProperty_);
  		$("#businessCategory").text(businessCategory_);
  		$("#legalPerson").text(legalPerson_);
  		$("#legalPersonContact").text(legalPersonContact_);
  		$("#legalPersonIcCode").text(legalPersonIcCode_);
  		$("#agent").text(agent_);
  		$("#agentIcCode").text(agentIcCode_);
  		$("#agentContact").text(agentContact_);
  		$("#contact").text(contact_);
  		$("#contactTitle").text(contactTitle_);
  		$("#contactIcCode").text(contactIcCode_);
  		$("#contactWay").text(contactWay_);
  		$("#businessScope").text(businessScope_);
  		var keySupplierTxt = "";
		if ("0" == keySupplier_) {
			keySupplierTxt = "不是";
		}
		if ("1" == keySupplier_) {
			keySupplierTxt = "是";
		}
  		$("#keySupplier").text(keySupplierTxt);
  		$("#taxRates").text(taxRateStr_);
  		$("#inOutCity").text(inOutCity_);
  		$("#admissionDate").text(admissionDate_);
  		var returnSupplyTxt = "";
		if (returnSupply_ == "0") {
			returnSupplyTxt = "不是";
		}
		if (returnSupply_ == "1") {
			returnSupplyTxt = "是";
		}
  		$("#returnSupply").text(returnSupplyTxt);
  		$("#joinSite").text(joinSite_);
  		var apartOrderTxt = "";
		if (apartOrder_ == "0") {
			apartOrderTxt = "自库";
		}
		if (apartOrder_ == "1") {
			apartOrderTxt = "虚库";
		}
  		$("#apartOrder").text(apartOrderTxt);
  		var dropshipTxt = "";
		if (dropship_ == "0") {
			dropshipTxt = "不是";
		}
		if (dropship_ == "1") {
			dropshipTxt = "是";
		}
  		$("#dropship").text(dropshipTxt);
  		$("#erpSupplierCode").text(erpSupplierCode_);
  		
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/supplierInfomationNode/SupplierInfomationNode.jsp");
  		});
	});

  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/supplierInfomationNode/SupplierInfomationNode.jsp");
	}
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
									<input type="hidden" name="sid" id="sid" value="${json.record.sid }"/>
									<input type="hidden" name="userName" value="${json.record.lastOptUser }"/>
									<h5><strong>单位基本信息</strong></h5>
									<hr class="wide" style="margin-top: 0;">
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商名称：</label>
											<div class="col-lg-6">
												<label class="control-label" id="supplyName"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商编码：</label>
											<div class="col-lg-6">
												<label class="control-label" id="supplyCode"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">门店编码：</label>
											<div class="col-lg-6">
												<label class="control-label" id="shopSid"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商简称：</label>
											<div class="col-lg-6">
												<label class="control-label" id="shortName"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商状态：</label>
											<div class="col-lg-6">
												<label class="control-label" id="status"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">重点供应商：</label>
											<div class="col-lg-6">
												<label class="control-label" id="keySupplier"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商类型：</label>
											<div class="col-lg-6">
												<label class="control-label" id="supplyType"></label>
											</div>
										</div>
										
										<div class="col-md-6">
											<label class="col-lg-3 control-label">经营方式：</label>
											<div class="col-lg-6">
												<label class="control-label" id="businessPattern"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">所属行业：</label>
											<div class="col-lg-6">
												<label class="control-label" id="industry"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">经营范围：</label>
											<div class="col-lg-6">
												<label class="control-label" id="businessScope"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">企业性质：</label>
											<div class="col-lg-6">
												<label class="control-label" id="enterpriseProperty"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">企业类别：</label>
											<div class="col-lg-6">
												<label class="control-label" id="businessCategory"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">通讯地址：</label>
											<div class="col-lg-9">
												<label class="control-label" id="street"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">企业代码：</label>
											<div class="col-lg-6">
												<label class="control-label" id="orgCode"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
	        							<div class="col-md-6">
											<label class="col-lg-3 control-label">邮编：</label>
											<div class="col-lg-6">
												<label class="control-label" id="postcode"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">邮箱：</label>
											<div class="col-lg-6">
												<label class="control-label" id="email"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">联系电话：</label>
											<div class="col-lg-6">
												<label class="control-label" id="phone"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">传真：</label>
											<div class="col-lg-6">
												<label class="control-label" id="fax"></label>
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
												<label class="control-label" id="bizCertificateNo"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">入准日期：</label>
											<div class="col-lg-6">
												<label class="control-label" id="admissionDate"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">注册资本：</label>
											<div class="col-lg-6">
												<label class="control-label" id="registeredCapital"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">税率：</label>
											<div class="col-lg-6">
												<label class="control-label" id="taxRates"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">纳税类别：</label>
											<div class="col-lg-6">
												<label class="control-label" id="taxType"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">税号：</label>
											<div class="col-lg-6">
												<label class="control-label" id="taxNumbe"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">银行：</label>
											<div class="col-lg-6">
												<label class="control-label" id="bank"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">银行帐号：</label>
											<div class="col-lg-6">
												<label class="control-label" id="bankNo"></label>
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
												<label class="control-label" id="legalPerson"></label>
											</div>
										</div>
										<div class="col-md-4">
											<label class="col-lg-5 control-label">法人联系人：</label>
											<div class="col-lg-7">
												<label class="control-label" id="legalPersonContact"></label>
											</div>
										</div>
										<div class="col-md-4">
											<label class="col-lg-5 control-label">法人身份证号：</label>
											<div class="col-lg-7">
												<label class="control-label" id="legalPersonIcCode"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
									<div class="col-md-4">
										<label class="col-lg-5 control-label">代理人：</label>
										<div class="col-lg-7">
											<label class="control-label" id="agent"></label>
										</div>
									</div>
									<div class="col-md-4">
										<label class="col-lg-5 control-label">代理人联系方式：</label>
										<div class="col-lg-7">
											<label class="control-label" id="agentContact"></label>
										</div>
									</div>
									<div class="col-md-4">
										<label class="col-lg-5 control-label">代理人身份证号：</label>
										<div class="col-lg-7">
											<label class="control-label" id="agentIcCode"></label>
										</div>
									</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-4">
											<label class="col-lg-5 control-label">联系人：</label>
											<div class="col-lg-7">
												<label class="control-label" id="contact"></label>
											</div>
										</div>
										<div class="col-md-4">
											<label class="col-lg-5 control-label">联系人身份证号：</label>
											<div class="col-lg-7">
												<label class="control-label" id="contactIcCode"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-4">
											<label class="col-lg-5 control-label">联系人职务：</label>
											<div class="col-lg-7">
												<label class="control-label" id="contactTitle"></label>
											</div>
										</div>
										<div class="col-md-4">
											<label class="col-lg-5 control-label">联系人联系方式：</label>
											<div class="col-lg-7">
												<label class="control-label" id="contactWay"></label>
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
												<label class="control-label" id="returnSupply"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-5 control-label">联营商品客退地点：</label>
											<div class="col-lg-6">
												<label class="control-label" id="joinSite"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
                                        <div class="col-md-6">
                                            <label class="col-lg-5 control-label">供应商的门店ERP或电商编码：</label>
                                            <div class="col-lg-6">
                                                <label class="control-label" id="erpSupplierCode"></label>
                                            </div>
                                        </div>
										<div class="col-md-6">
											<label class="col-lg-5 control-label">区分奥莱和其它虚库标识：</label>
											<div class="col-lg-6">
												<label class="control-label" id="dropship"></label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-5 control-label">操作人：</label>
											<div class="col-lg-6">
												<label class="control-label" id="lastOptUser"></label>
											</div>
										</div>
                                        <div class="col-md-6" id="apartOrderDiv" style="display: none;">
                                            <label class="col-lg-5 control-label">拆单标识：</label>
                                            <div class="col-lg-6">
                                                <label class="control-label" id="apartOrder"></label>
                                            </div>
                                        </div>
									</div>
									<%-- <div class="form-group">
										<label class="col-lg-3 control-label">城市：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="city" name="city" value="${json.record.city }" readonly="readonly"/>
										</div>
									</div>
        							<div class="form-group">
										<label class="col-lg-3 control-label">国家：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="country" name="country" value="${json.record.country }" readonly="readonly"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">地区代码：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="zone" name="zone" value="${json.record.zone }" readonly="readonly"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">门店地区：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="shopRegion" name="shopRegion" value="${json.record.shopRegion }" readonly="readonly"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">企业地址：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="address" name="address" value="${json.record.address }" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">市内外：</label>
										<div class="col-lg-6">
											<select class="form-control" id="inOutCity" name="inOutCity" disabled="disabled">
												<option value="1" <c:if test="${json.record.inOutCity==1 }"> selected="selected"</c:if>>市内</option>
												<option value="2" <c:if test="${json.record.inOutCity==2 }"> selected="selected"</c:if>>省内市外</option>
												<option value="3" <c:if test="${json.record.inOutCity==3 }"> selected="selected"</c:if>>国内省外</option>
												<option value="4" <c:if test="${json.record.inOutCity==4 }"> selected="selected"</c:if>>国外</option>
											</select>
										</div>
									</div>
									 --%>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
  	$(function(){
  		//查询门店
  		var organizationCode = $("#organizationCode");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/organization/queryListOrganization",
			dataType: "json",
			 data: "organizationType=3", 
			success: function(response) {
				var result = response.list;
				//organizationCode.html("<option value='-1'>全部</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					if(ele.organizationStatus=='0'){
						var option = $("<option value='" + ele.organizationCode + "'>"
								+ ele.organizationName + "</option>");
						option.appendTo(organizationCode);
					}
				}
				return;
			},
			error: function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					$("#warning2Body").text(buildErrorMessage("","系统出错！"));
					$("#warning2").show();
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
  		
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/supplierInfomationNode/SupplierInfomationNode.jsp");
  		});
	});
  	//保存数据
  	$('#theForm').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		submitHandler : function(validator, form, submitButton) {
			// Do nothing
			var url = __ctxPath + "/supplierDisplay/updateOrInsertSupplier";
	  		$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: url,
				dataType:"json",
		        ajaxStop: function() {
		          //隐藏加载提示
		          setTimeout(function() {
		       	        $("#loading-container").addClass("loading-inactive")
		       	  },300);
		        },

				data: $("#theForm").serialize(),
				success: function(response) {
					if(response.success=="true"){
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
	 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
					}else{
						$("#warning2Body").text(buildErrorMessage("","添加失败！"));
						$("#warning2").show();
					}
					return;
				},
				error: function(XMLHttpRequest, textStatus) {		      
					var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
					if(sstatus != "sessionOut"){
						$("#warning2Body").text(buildErrorMessage("","系统出错！"));
						$("#warning2").show();
					}
					if(sstatus=="sessionOut"){     
		            	 $("#warning3").css('display','block');     
		             }
				}
			});
		},
		fields : {
			supplyName : {
				validators : {
					notEmpty : {
						message : '供应商名称不能为空'
					}
				}
			},
			supplyCode : {
				validators : {
					notEmpty : {
						message : '供应商编码不能为空'
					}
				}
			}

		}

	}).find('button[data-toggle]').on(
			'click',
			function() {
				var $target = $($(this).attr('data-toggle'));
				$target.toggle();
				if (!$target.is(':visible')) {
					$('#theForm').data('bootstrapValidator')
							.disableSubmitButtons(false);
				}
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
								<span class="widget-caption">添加供应商</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="userName" value=""/>
									<script type="text/javascript">
										$("input[name='userName']").val(getCookieValue("username"));
									</script>
									<h5><strong>单位基本信息</strong></h5>
									<hr class="wide" style="margin-top: 0;">
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商名称：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="supplyName" name="supplyName" value="${json.record.supplyName }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商编码：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="supplyCode" name="supplyCode" value="${json.record.supplyCode }"/>
											</div>
										</div>
										
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">门店名称：</label>
											<div class="col-lg-6">
											<select class="form-control" id="organizationCode" name="shopSid" data-bv-field="country">
													<!-- <option value="">全部</option> -->
												</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商简称：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="shortName" name="shortName" value="${json.record.shortName }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商状态：</label>
											<div class="col-lg-6">
												<select class="form-control" id="status" name="status" >
													<option value="Y" <c:if test="${json.record.status==Y }"> selected="selected"</c:if> >正常</option>
													<option value="T" <c:if test="${json.record.status==T }"> selected="selected"</c:if> >未批准</option>
													<option value="N" <c:if test="${json.record.status==N }"> selected="selected"</c:if> >终止</option>
													<option value="L" <c:if test="${json.record.status==L }"> selected="selected"</c:if> >待审批</option>
													<option value="3" <c:if test="${json.record.status==3 }"> selected="selected"</c:if> >淘汰</option>
													<option value="4" <c:if test="${json.record.status==4 }"> selected="selected"</c:if> >停货</option>
													<option value="5" <c:if test="${json.record.status==5 }"> selected="selected"</c:if> >停款</option>
													<option value="6" <c:if test="${json.record.status==6 }"> selected="selected"</c:if> >冻结</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">重点供应商：</label>
											<div class="col-lg-6">
												<select class="form-control" id="keySupplier" name="keySupplier" >
													<option value="1" <c:if test="${json.record.keySupplier==1 }"> selected="selected"</c:if>>是</option>
													<option value="0" <c:if test="${json.record.keySupplier==0 }"> selected="selected"</c:if>>不是</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="form-group">
	        							<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商性质：</label>
											<div class="col-lg-6">
												<select class="form-control" id="title" name="title">
													<option value="公司" <c:if test="${json.record.title==公司 }"> selected="selected"</c:if> >公司</option>
													<option value="自营"<c:if test="${json.record.title==自营 }"> selected="selected"</c:if> >自营</option>
													<option value="供应商开发平台"<c:if test="${json.record.title==供应商开发平台 }"> selected="selected"</c:if> >供应商开发平台</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商类型：</label>
											<div class="col-lg-6">
												 <select class="form-control" id="supplyType" name="supplyType">
													<option value="0" >门店供应</option>
													<option value="1" selected="selected">电商供应</option>
												</select>	
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">所属行业：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="industry" name="industry" value="${json.record.industry }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">经营范围：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="businessScope" name="businessScope" value="${json.record.businessScope }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">企业性质：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="enterpriseProperty" name="enterpriseProperty" value="${json.record.enterpriseProperty }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">企业类别：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="businessCategory" name="businessCategory" value="${json.record.businessCategory }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">营销方式：</label>
											<div class="col-lg-6">
												<select class="form-control" id="businessPattern" name="businessPattern" >
													<option value="0" <c:if test="${json.record.businessPattern==0 }"> selected="selected"</c:if> >经销</option>
													<option value="1"  <c:if test="${json.record.businessPattern==1 }"> selected="selected"</c:if> >代销</option>
													<option value="2" <c:if test="${json.record.businessPattern==2 }"> selected="selected"</c:if> >联营</option>
													<option value="3" <c:if test="${json.record.businessPattern==3 }"> selected="selected"</c:if> >平台服务</option>
													<option value="4" <c:if test="${json.record.businessPattern==4 }"> selected="selected"</c:if> >租赁</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">企业代码：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="orgCode" name="orgCode" value="${json.record.orgCode }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
	        							<div class="col-md-6">
											<label class="col-lg-3 control-label">邮编：</label>
											<div class="col-lg-6">
											<input type="text" class="form-control" id="postcode" name="postcode" value="${json.record.postcode }"/>
											
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">邮箱：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="email" name="email" value="${json.record.email }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">联系电话：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="phone" name="phone" value="${json.record.phone }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">传真：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="fax" name="fax" value="${json.record.fax }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">通讯地址：</label>
											<div class="col-lg-9">
												<input type="text" class="form-control" id="street" name="street" value="${json.record.street }"/>
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
												<input type="text" class="form-control" id="bizCertificateNo" name="bizCertificateNo" value="${json.record.bizCertificateNo }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">入准日期：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="admissionDate" name="admissionDate" value="${json.record.admissionDate }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">注册资本：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="registeredCapital" name="registeredCapital" value="${json.record.registeredCapital }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">税率：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="taxRates" name="taxRates" value="${json.record.taxRateStr }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">纳税类别：</label>
											<div class="col-lg-6">
												<select class="form-control" id="taxType" name="taxType" >
													<option value="1" <c:if test="${json.record.taxType==1 }"> selected="selected"</c:if> >增值税一般纳税人</option>
													<option value="2" <c:if test="${json.record.taxType==2 }"> selected="selected"</c:if>  >小规模纳税人</option>
													<option value="3" <c:if test="${json.record.taxType==3 }"> selected="selected"</c:if> >交纳营业税</option>
													<option value="4" <c:if test="${json.record.taxType==4 }"> selected="selected"</c:if> >零税率</option>
													<option value="5" <c:if test="${json.record.taxType==5 }"> selected="selected"</c:if> >自然人</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">税号：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="taxNumbe" name="taxNumbe" value="${json.record.taxNumbe }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">银行：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="bank" name="bank" value="${json.record.bank }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">银行帐号：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="bankNo" name="bankNo" value="${json.record.bankNo }"/>
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
												<input type="text" class="form-control" id="legalPerson" name="legalPerson" value="${json.record.legalPerson }"/>
											</div>
										</div>
										<div class="col-md-4">
											<label class="col-lg-5 control-label">法人联系人：</label>
											<div class="col-lg-7">
												<input type="text" class="form-control" id="legalPersonContact" name="legalPersonContact" value="${json.record.legalPersonContact }"/>
											</div>
										</div>
										<div class="col-md-4">
											<label class="col-lg-5 control-label">法人身份证号：</label>
											<div class="col-lg-7">
												<input type="text" class="form-control" id="legalPersonIcCode" name="legalPersonIcCode" value="${json.record.legalPersonIcCode }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
									<div class="col-md-4">
										<label class="col-lg-5 control-label">代理人：</label>
										<div class="col-lg-7">
											<input type="text" class="form-control" id="agent" name="agent" value="${json.record.agent }"/>
										</div>
									</div>
									<div class="col-md-4">
										<label class="col-lg-5 control-label">代理人联系方式：</label>
										<div class="col-lg-7">
											<input type="text" class="form-control" id="agentContact" name="agentContact" value="${json.record.agentContact }"/>
										</div>
									</div>
									<div class="col-md-4">
										<label class="col-lg-5 control-label">代理人身份证号：</label>
										<div class="col-lg-7">
											<input type="text" class="form-control" id="agentIcCode" name="agentIcCode" value="${json.record.agentIcCode }"/>
										</div>
									</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">联系人：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="contact" name="contact" value="${json.record.contact }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-5 control-label">联系人身份证号：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="contactIcCode" name="contactIcCode" value="${json.record.contactIcCode }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">联系人职务：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="contactTitle" name="contactTitle" value="${json.record.contactTitle }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-5 control-label">联系人联系方式：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="contactWay" name="contactWay" value="${json.record.contactWay }"/>
											</div>
										</div>
									</div>
									
									&nbsp;
									<h5><strong>其他信息</strong></h5>
									<hr class="wide" style="margin-top: 0;">
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">退货至供应商 ：</label>
											<div class="col-lg-6">
												<select class="form-control" id="returnSupply" name="returnSupply">
													<option value="1" <c:if test="${json.record.returnSupply==1 }"> selected="selected"</c:if>>不是</option>
													<option value="2" <c:if test="${json.record.returnSupply==2 }"> selected="selected"</c:if>>是</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">联营商品客退地点：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="joinSite" name="joinSite" value="${json.record.joinSite }"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">拆单标识：</label>
											<div class="col-lg-6">
												<select class="form-control" id="apartOrder" name="apartOrder">
													<option value="1" <c:if test="${json.record.apartOrder==1 }"> selected="selected"</c:if>>不是</option>
													<option value="0" <c:if test="${json.record.apartOrder==2 }"> selected="selected"</c:if>>是</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">区分奥莱和其它虚库标识：</label>
											<div class="col-lg-6">
												<select class="form-control" id="dropship" name="dropship">
													<option value="0" <c:if test="${json.record.dropship==0 }"> selected="selected"</c:if>>不是</option>
													<option value="1" <c:if test="${json.record.dropship==1 }"> selected="selected"</c:if>>是</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">供应商的门店ERP或者电商ERP编码：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="erpSupplierCode" name="erpSupplierCode" value="${json.record.erpSupplierCode }"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">操作人：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="lastOptUser" name="lastOptUser" value="${json.record.lastOptUser }"/>
											</div>
										</div>
									</div>
									
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;"
												id="save" type="submit" >保存</button>&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消" />
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
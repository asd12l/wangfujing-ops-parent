<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!--Page Related Scripts-->
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
    <script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
    <script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
    <!--Bootstrap Date Range Picker-->
    <script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
    <script src="${pageContext.request.contextPath}/js/member/coupon/editCouponApply.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="page-body" id="productSaveBody">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">编辑优惠券申请</span>
							</div>
							<div class="widget-body">
								<div class="tabbable">
									<!-- BaseMessage start -->
									<div class="tab-content">
										<div id="base" class="tab-pane in active">
											<form id="baseForm" method="post" class="form-horizontal">
												<div class="col-md-12">
													<input type="text" id="editSid" name="editSid" value="" style="display: none;"/>
														<div class="col-md-11" style="padding: 2px 100px;">
	                               							<label class="col-md-3 control-label" style="line-height: 20px; text-align: right;">客户登录账号：</label>
							                                <div class="col-md-6">
							                                    <input type="text" class="form-control" name="login_name" id="login_name" />
							                                    <span id="login_msg" style="color:red;display:none;" class="add_msg">不能为空!</span>
							                                </div>	
                            							</div>
								                        <div class="col-md-11"  style="padding: 2px 100px;">
							                                <label class="col-md-3 control-label"  style="line-height: 20px; text-align: right;">申请类型：</label>
							                                <div class="radio">
							                                	<label>
								                                    <input class="basic divtype cart_flag" type="radio" id="apply_type_1" name="apply_type" value="1"> 
								                                    <span class="text">客服：服务投诉补偿</span>
							                                	</label>
							                                	<label>
								                                	<input class="basic divtype cart_flag" type="radio" id="apply_type_2" name="apply_type" value="2">
								                                    <span class="text">客服：外呼关怀回访</span>
							                                	</label>
																<label>
												                 	<input class="basic divtype cat_flag" type="radio" id="apply_type_3" name="apply_type" value="3">
								                                    <span class="text">客服：系统原因补券</span>
																</label>
							                            	</div>
								                        </div>
														<div class="col-md-6">
															<label class="col-md-3 control-label">凭证类型：</label>
															<div class="col-md-9">
																<div class="btn-group" style="width: 100%" id="baseBtnGroup">
																	<select id="source_type" name="source_type" style="width: 100%">
																		<option value="1">订单号</option>
																		<option value="2">退换货单号</option>
																	</select>
																</div>
															</div>
														</div>
														<div class="col-md-6">
															<label class="col-md-3 control-label">优惠券模板：</label>
															<div class="col-md-9 js-data-example-ajax">
																<select id="coupon_template" name="coupon_template" style="width: 100%">
																</select>
															</div>
															&nbsp;
														</div>
														
													<div class="col-md-6" id="productNumDiv">
														<label class="col-md-3 control-label">优惠券类型：</label>
														<div class="col-md-9">
															<input type="text" class="form-control" readonly="readonly" id="coupon_type" name="coupon_type" />
														</div>
													</div>
													
													<div class="col-md-6">
														<label class="col-md-3 control-label">优惠券批次：</label>
														<div class="col-md-9 js-data-example-ajax">
															<select id="coupon_batch" name="coupon_batch" style="width: 100%">
															</select>
														</div>
														&nbsp;
													</div>
													<div class="col-md-6" id="mainAttributeDiv">
														<label class="col-md-3 control-label">优惠券名称：</label>
														<div class="col-md-9">
															<input type="text" class="form-control" readonly="readonly" id="coupon_name" name="coupon_name" />
														</div>
														&nbsp;
													</div>
												</div>
												<div class="col-md-12">		
													<div class="col-md-12">										
														<label class="col-md-2 control-label">优惠券描述：</label>
														<div class="col-md-10">
															<textarea class="form-control" rows="3" readonly="readonly" id="coupon_memo" name="coupon_memo"></textarea>
															
														</div>
													</div>	
													<div class="col-md-6">
														<label class="col-md-3 control-label">优惠券金额：</label>
														<div class="col-md-3">
															<input type="text" class="form-control" id="" name="" oninput="value.replace(/[\u4E00-\u9FA5]/g,'');" onkeydown="if(event.keyCode==13)event.keyCode=9" />
														</div>
													</div>
													<div class="col-md-12">	
														<label class="col-md-2 control-label">申请理由：</label>
														<div class="col-md-10">
															<textarea class="form-control" rows="3" id="apply_reason" name="apply_reason"></textarea>
														</div>
													</div>
												</div>
												<div  style="height: 447px;overflow-x: auto;"></div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="saveEditCoupon" type="button" value="保存" />&emsp;&emsp; 
														<input class="btn btn-danger" style="width: 25%;" id="closeEditCoupon" type="button" value="取消" />
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
			</div>
		</div>
	</div>
</body>
</html>
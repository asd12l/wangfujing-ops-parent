<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!--Page Related Scripts-->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
    <style type="text/css">
        .trClick>td,.trClick>th{
            color:red;
        }
    </style>
    <script type="text/javascript">
	    __ctxPath = "${pageContext.request.contextPath}";
	    image="http://images.shopin.net/images";
	    saleMsgImage="http://images.shopin.net/images";
	    ctx="http://www.shopin.net";
        function successBtn(){
            $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
            $("#pageBody").load(__ctxPath+"/jsp/mem/CouponApplyView.jsp");
        }
        function closeEditIntegral(){
            $("#deitCouponApplyDiv").hide();
        }

        //审核积分申请
        function showCheckApply(){
            $("#checkName_msg").hide();
            var checkboxArray=[];
            $("input[type='checkbox']:checked").each(function(i,team){
                var sid=$(this).val();
                checkboxArray.push(sid);
            });
            if (checkboxArray.length > 1) {
                $("#warning2Body").text("只能选择一条申请记录!");
                $("#warning2").show();
                return;
            } else if (checkboxArray.length == 0) {
                $("#warning2Body").text("请选择要审核的申请!");
                $("#warning2").show();
                return;
            }
            var sid=checkboxArray[0];
            var checkStatus=$("#check_status_"+sid).text().trim();
            if(checkStatus=="审核通过"){
                $("#warning2Body").text("审核通过不能取消!");
                $("#warning2").show();
                return;
            }
            $("#check_sid").val(sid);
            $("#checkIntegralDiv").show();
        }
        function closeCheckApply(){
            $("#checkIntegralDiv").hide();
        }
        function checkIntegralApply(){
            var sid=$("#check_sid").val().trim();
            var checkName=$("#checkName").val().trim();
            var checkStatus=$("input[name='check_status']:checked").val().trim();
            var checkMemo=$("#check_memo").val().trim();
            if(checkName==""||checkName==null){
                $("#checkName_msg").show();
                return false;
            }
            var url = __ctxPath+"/memberIntegral/checkMemberIntegral";
            $.ajax({
                type : "post",
                contentType : "application/x-www-form-urlencoded;charset=utf-8",
                url : url,
                dataType : "json",
                ajaxStart : function() {
                    $("#loading-container").attr(
                            "class",
                            "loading-container");
                },
                ajaxStop : function() {
                    //隐藏加载提示
                    setTimeout(
                            function() {
                                $("#loading-container")
                                        .addClass(
                                        "loading-inactive")
                            }, 300);
                },
                data :{"sid":sid,"checkName":checkName,"checkStatus":checkStatus,"checkMemo":checkMemo},
                success : function(response) {
                    if (response.success == "true") {
                        $("#modal-body-success")
                                .html(
                                "<div class='alert alert-success fade in'><strong>审核操作成功，返回列表页!</strong></div>");
                        $("#modal-success")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-success"
                                });
                        $("#checkIntegralDiv").hide();

                    } else  {
                        $("#model-body-warning")
                                .html(
                                "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                                + "操作失败!"
                                + "</strong></div>");
                        $("#modal-warning")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-warning"
                                });
                    }
                    return;
                },
                error : function() {
                    $("model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
                    $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
                }

            });
        }

        //取消积分申请
        function cancleApply(){
            var checkboxArray=[];
            $("input[type='checkbox']:checked").each(function(i,team){
                var sid=$(this).val();
                checkboxArray.push(sid);
            });
            if (checkboxArray.length > 1) {
                $("#warning2Body").text("只能选择一条申请记录!");
                $("#warning2").show();
                return;
            } else if (checkboxArray.length == 0) {
                $("#warning2Body").text("请选择要取消的积分申请!");
                $("#warning2").show();
                return;
            }
            var sid=checkboxArray[0];
            var checkStatus=$("#check_status_"+sid).text().trim();
            if(checkStatus=="审核通过"){
                $("#warning2Body").text("审核通过不能取消!");
                $("#warning2").show();
                return;
            }
            var url = __ctxPath+"/memberIntegral/cancleMemberIntegral";
            $.ajax({
                type : "post",
                contentType : "application/x-www-form-urlencoded;charset=utf-8",
                url : url,
                dataType : "json",
                ajaxStart : function() {
                    $("#loading-container").attr(
                            "class",
                            "loading-container");
                },
                ajaxStop : function() {
                    //隐藏加载提示
                    setTimeout(
                            function() {
                                $("#loading-container")
                                        .addClass(
                                        "loading-inactive")
                            }, 300);
                },
                data :{"sid":sid},
                success : function(response) {
                    if (response.success == "true") {
                        $("#modal-body-success")
                                .html(
                                "<div class='alert alert-success fade in'><strong>取消成功，返回列表页!</strong></div>");
                        $("#modal-success")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-success"
                                });
                        $("#checkIntegralDiv").hide();

                    } else  {
                        $("#model-body-warning")
                                .html(
                                "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                                + "操作失败!"
                                + "</strong></div>");
                        $("#modal-warning")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-warning"
                                });
                    }
                    return;
                },
                error : function() {
                    $("model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
                    $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
                }

            });
        }
    </script>
    <!-- 加载样式 -->
    <script type="text/javascript">
        function tab(data) {
            if (data == 'pro') {//基本
                if ($("#pro-i").attr("class") == "fa fa-minus") {
                    $("#pro-i").attr("class", "fa fa-plus");
                    $("#pro").css({
                        "display" : "none"
                    });
                } else {
                    $("#pro-i").attr("class", "fa fa-minus");
                    $("#pro").css({
                        "display" : "block"
                    });
                }
            }
        }
    </script>
</head>
<body>
<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
<!-- Main Container -->
<div class="main-container container-fluid">
    <!-- Page Container -->
    <div class="page-container">
        <!-- Page Body -->
        <div class="page-body" id="pageBodyRight">
            <div class="row">
                <div class="col-xs-12 col-md-12">
                    <div class="widget">
                        <div class="widget-header ">
                            <h5 class="widget-caption">优惠券申请</h5>
                            <div class="widget-buttons">
                                <a href="#" data-toggle="maximize"></a> <a href="#"
                                                                           data-toggle="collapse" onclick="tab('pro');"> <i
                                    class="fa fa-minus" id="pro-i"></i>
                            </a> <a href="#" data-toggle="dispose"></a>
                            </div>
                        </div>
                        <div class="widget-body" id="pro">
                            <div class="table-toolbar">
                                <ul class="topList clearfix">
                                    <li class="col-md-4"><label class="titname">客户账号：</label>
                                        <input type="text" id="login_name" /></li>
                                    <li class="col-md-4"><label class="titname">单据号：</label>
                                        <input type="text" id="sid" /></li>
                                    <li class="col-md-4"><label class="titname">子订单号/退货单号：</label>
                                        <input type="text" id="order_input" /></li>
                                    <li class="col-md-4"><label class="titname">申请时间：</label>
                                        <input type="text" id="reservationAp" /></li>
                                    <li class="col-md-4"><label class="titname">审核时间：</label>
                                        <input type="text" id="reservationCh" /></li>
                                    <li class="col-md-4"><label class="titname">申请人：</label>
                                        <input type="text" id="applyName_input" /></li>
                                    <li class="col-md-4"><label class="titname">单据状态：</label>
                                     	<select id="checkStatus">
                                     		<option value="">请选择</option>
                                     		<option value="1">待审核</option>
                                     		<option value="2">审核通过</option>
                                     		<option value="3">审核不通过</option>
                                     		<option value="4">取消</option>
                                     	</select></li>
                                    <li class="col-md-6">
                                        <a onclick="query();" class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询</a>
                                        <a onclick="reset();"class="btn btn-primary"> <i class="fa fa-random"></i> 重置</a>
                                    </li>
                                </ul>
                                <div class="mtb10">
                                    <a onclick="showCouPonDetail();" class="btn btn-info"> <i class="fa fa-wrench"></i>查看优惠券申请</a>&nbsp;&nbsp;
                                    <a onclick="showAddCouPon();" class="btn btn-info"> <i class="fa fa-wrench"></i>新建优惠券申请</a>&nbsp;&nbsp;
                                    <a onclick="editCouPonApply();" class="btn btn-info"> <i class="fa fa-wrench"></i>编辑优惠券申请</a>&nbsp;&nbsp;
                                    <a id="checkCouPonApply" class="btn btn-info"> <i class="fa fa-wrench"></i>审核优惠券申请</a>&nbsp;&nbsp;
                                    <a id="cancleCouPonApply" class="btn btn-info"> <i class="fa fa-wrench"></i>取消优惠券申请</a>&nbsp;&nbsp;
                                </div>
                                <table class="table table-bordered table-striped table-condensed table-hover flip-content"
                                       id="olv_tab"  style=" width: 240%; background-color: #fff;margin-bottom: 0;">		<!-- 	width: 120%; -->
                                    <thead>
                                    <tr role="row" style='height:35px;'>
                                        <th style="text-align: center;" width="10%">选择</th>
                                        <th style="text-align: center;" width="10%">申请单号</th>
                                       	<th style="text-align: center;" width="10%">申请时间</th>
                                        <th style="text-align: center;" width="10%">账号</th>
               							<th style="text-align: center;" width="10%">昵称</th>	
               							<th style="text-align: center;" width="10%">真实姓名</th>
               							<th style="text-align: center;" width="10%">会员等级</th>
               							<th style="text-align: center;" width="10%">手机</th>
               							<th style="text-align: center;" width="10%">邮箱</th>
               							<th style="text-align: center;" width="10%">申请类型</th>
               							<th style="text-align: center;" width="10%">凭证类型</th>
               							<th style="text-align: center;" width="10%">券模板</th>
               							<th style="text-align: center;" width="10%">券批次</th>
               							<th style="text-align: center;" width="10%">券类型</th>
               							<th style="text-align: center;" width="10%">券名称</th>
               							<th style="text-align: center;" width="10%">金额</th>
               							<th style="text-align: center;" width="10%">剩余金额</th>
               							<th style="text-align: center;" width="10%">单据状态</th>
               							<th style="text-align: center;" width="10%">审核时间</th>
               							<th style="text-align: center;" width="10%">相关订单号</th>
               							<th style="text-align: center;" width="10%">申请理由</th>
               							<th style="text-align: center;" width="10%">备注</th>
               							<th style="text-align: center;" width="10%">优惠券描述</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                <div class="pull-left" style="padding: 10px 0;">
                                    <form id="product_form" action="">
                                        <input type="hidden" id="login_from" name="login" />
                                        <input type="hidden" id="sid_from" name="sid" />
                                        <input type="hidden" id="order_from" name="order" />
                                        <input type="hidden" id="m_timeApStartDate_form" name="m_timeApStartDate"/>
                                        <input type="hidden" id="m_timeApEndDate_form" name="m_timeApEndDate"/>
                                        <input type="hidden" id="m_timeChStartDate_form" name="m_timeChStartDate"/>
                                        <input type="hidden" id="m_timeChEndDate_form" name="m_timeChEndDate"/>
                                        <input type="hidden" id="applyName_from" name="applyName" />
                                        <input type="hidden" id="check_Status" name = "checkStatus" />
                                        <input type="hidden" id="cache" name="cache" value="1" />
                                    </form>
                                </div>
                                <div id="olvPagination"></div>
                            </div>
                            <!-- Templates -->
                            <p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													{#if $T.Result.check_status == "2" || $T.Result.check_status == "3" || $T.Result.check_status == "4"}
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}"  disabled="disabled"  />
																<span class=    "text"></span>
															</label>
														</div>
													</td>
													{#/if} 
													{#if $T.Result.check_status == "1"}
														<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																	<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}"/>
																<span class=    "text"></span>
															</label>
														</div>
													</td>
													{#/if}
													<td align="center" id="sid_{$T.Result.sid}">
														{#if $T.Result.sid == "" || $T.Result.sid == null}--
													    {#else}{$T.Result.sid}
													    {#/if}
													</td>
													<td align="center" id="apply_time_{$T.Result.sid}">
														{#if $T.Result.apply_time == "" || $T.Result.apply_time == null}--
													    {#else}{$T.Result.apply_time}
													    {#/if}
													</td>
													<td align="center" id="login_name_{$T.Result.sid}">
														{#if $T.Result.login_name == "" || $T.Result.login_name == null}--
													    {#else}{$T.Result.login_name}
													    {#/if}
													</td>
													
													<td align="center" id="xxx_{$T.Result.sid}">			<!-- 昵称 -->
														{#if $T.Result.nicheng == "" || $T.Result.nicheng == null}--
													    {#else}{$T.Result.nicheng}
													    {#/if}
													</td>
													<td align="center" id="xxxx_{$T.Result.sid}">			<!-- 真实姓名 -->
														{#if $T.Result.xxx == "" || $T.Result.xxx == null}--
													    {#else}{$T.Result.xxx}
													    {#/if}
													</td>
													<td align="center" id="xxxx_{$T.Result.sid}">			<!-- 会员等级 -->
														{#if $T.Result.xxx == "" || $T.Result.xxx == null}--
													    {#else}{$T.Result.xxx}
													    {#/if}
													</td>
													<td align="center" id="xxxx_{$T.Result.sid}">			<!-- 手机 -->
														{#if $T.Result.xxx == "" || $T.Result.xxx == null}--
													    {#else}{$T.Result.xxx}
													    {#/if}
													</td>
													<td align="center" id="xxxx_{$T.Result.sid}">			<!-- 邮箱-->
														{#if $T.Result.xxx == "" || $T.Result.xxx == null}--
													    {#else}{$T.Result.xxx}
													    {#/if}
													</td>
													<td align="center" id="apply_type_{$T.Result.sid}">
														{#if $T.Result.apply_type == "" || $T.Result.apply_type == null}
															--
														{#/if}
												  		{#if $T.Result.apply_type == "1"}
												  			 服务投诉补偿
												  		{#/if}
												  		{#if $T.Result.apply_type == "2"} 
												  			外呼关怀回访
												  		{#/if}	
												  		{#if $T.Result.apply_type == "3"} 
												  			系统原因补券
												  		{#/if}	
													</td>					
													<td align="center" id="source_type_{$T.Result.sid}">			
														{#if $T.Result.source_type == "" || $T.Result.source_type == null}
															--
													    {#/if}
												    	{#if $T.Result.source_type == "1"} 
												    		订单号
												    	{#/if}
												    	{#if $T.Result.source_type == "2"} 
												    		退货单号
												    	{#/if}
													</td>
													<td align="center" id="coupon_template_{$T.Result.sid}">			
														{#if $T.Result.coupon_template == "" || $T.Result.coupon_template == null}--
													    {#else}{$T.Result.coupon_template}
													    {#/if}
													</td>
													<td align="center" id="coupon_batch_{$T.Result.sid}">			
														{#if $T.Result.coupon_batch == "" || $T.Result.coupon_batch == null}--
													    {#else}{$T.Result.coupon_batch}
													    {#/if}
													</td>
													<td align="center" id="coupon_type_{$T.Result.sid}">			
														{#if $T.Result.coupon_type == "" || $T.Result.coupon_type == null}--
													    {#else}{$T.Result.coupon_type}
													    {#/if}
													</td>
													<td align="center" id="coupon_name_{$T.Result.sid}">			
														{#if $T.Result.coupon_name == "" || $T.Result.coupon_name == null}--
													    {#else}{$T.Result.coupon_name}
													    {#/if}
													</td>
													<td align="center" id="xxx_{$T.Result.sid}">					<!-- 金额 -->
														{#if $T.Result.xxxxxx == "" || $T.Result.xx == null}--
													    {#else}{$T.Result.xx}
													    {#/if}
													</td>
													<td align="center" id="xxx_{$T.Result.sid}">					<!-- 剩余金额 -->
														{#if $T.Result.xx == "" || $T.Result.xx == null}--
													    {#else}{$T.Result.xx}
													    {#/if}
													</td>
													<td align="center" id="check_status_{$T.Result.sid}">				
														{#if $T.Result.check_status == "" || $T.Result.check_status == null}--
													    {#/if}
												    	{#if $T.Result.check_status == "1"}
												    		待审核
												    	{#/if}
												    	{#if $T.Result.check_status == "2"}
												    		审核通过
												    	{#/if}
												    	{#if $T.Result.check_status == "3"}
												    		审核不通过
												    	{#/if}
												    	{#if $T.Result.check_status == "4"}
												    		取消审核
												    	{#/if}
													</td>
													<td align="center" id="check_time_{$T.Result.sid}">					
														{#if $T.Result.check_time == "" || $T.Result.check_time == null}--
													    {#else}{$T.Result.check_time}
													    {#/if}
													</td>
													<td align="center" id="from_order_{$T.Result.sid}">					
														{#if $T.Result.from_order == "" || $T.Result.from_order == null}--
													    {#else}{$T.Result.from_order}
													    {#/if}
													</td>													
													<td align="center" id="apply_reason_{$T.Result.sid}">					
														{#if $T.Result.apply_reason == "" || $T.Result.apply_reason == null}--
													    {#else}{$T.Result.apply_reason}
													    {#/if}
													</td>	
													<td align="center" id="check_memo_{$T.Result.sid}">					
														{#if $T.Result.check_memo == "" || $T.Result.check_memo == null}--
													    {#else}{$T.Result.check_memo}
													    {#/if}
													</td>
													<td align="center" id="coupon_memo_{$T.Result.sid}">					
														{#if $T.Result.coupon_memo == "" || $T.Result.coupon_memo == null}--
													    {#else}{$T.Result.coupon_memo}
													    {#/if}
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}
									</textarea>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
    <!-- /Page Container -->
    <!-- Main Container -->
</div>
<!--查看优惠券申请 -->
<div class="modal modal-darkorange" id="CouponDetailDiv">
    <div class="modal-dialog" style="width: 800px; height: auto; margin: 4% auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"  type="button" onclick="closeMerchant();">×</button>
                <h4 class="modal-title" id="divTitle">查看优惠券</h4>
            </div>
            <div class="page-body">
                <div class="row">
                    <form method="post" class="form-horizontal" id="editForm">
                        <div class="col-xs-12 col-md-12">
                            <input type="hidden" name="id" id="merchant_id">
                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">单据号：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name" id="sid" />
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label" style="line-height: 20px; text-align: right;">用户编号：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="feeCostRate" id="apply_cid" />
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label" style="line-height: 20px; text-align: right;">申请人：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="apply_name" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">申请类型：</label>
                                <div class="radio">
                                    <label> 
                                    	<input class="basic divtype cart_flag" type="radio" id="apply_type_0" name="apply_type" value="1" checked="checked" onclick="return false;"> 
                                    	<span class="text">增积分</span>
                                    </label>
                                    <label> 
                                    	<input class="basic divtype cart_flag" type="radio" id="apply_type_1" name="apply_type" value="2" onclick="return false;"> 
                                    	<span class="text">减积分</span>
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">凭证类型：</label>
                                <div class="radio">
                                    <label> 
                                    	<input class="basic divtype cart_flag" type="radio" id="source_type_0" name="source_type" value="1" checked="checked" onclick="return false;"> 
                                    	<span class="text">订单号</span>
                                    </label>
                                    <label> 
                                    	<input class="basic divtype cart_flag" type="radio" id="source_type_1" name="source_type" value="2" onclick="return false;"> 
                                    	<span class="text">退货单号</span>
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;" id="old_input">
                                <label class="col-md-5 control-label" style="line-height: 20px; text-align: right;">积分数量：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="apply_num" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;" id="old_input">
                                <label class="col-md-5 control-label" style="line-height: 20px; text-align: right;">申请理由：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control" id="apply_reason" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;" id="old_input">
                                <label class="col-md-5 control-label" style="line-height: 20px; text-align: right;">审核备注：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control" id="check_status" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                        </div>
                        <br>&nbsp;
                        <div class="form-group">
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            <input class="btn btn-danger" onclick="closeMerchant();" style="width: 25%;" id="submitEdit" type="button" value="关闭" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<!--审核优惠券 审核状态 和备注 -->
<div class="modal modal-darkorange" id="checkCouponStatusDiv">
	<div class="modal-dialog" style="width: 600px; height: auto; margin: 4% auto;">
        <div class="modal-content">
            <div class="page-body">
                <div class="row">
                    <form method="post" class="form-horizontal" id="editForm">
                        <div class="col-xs-12 col-md-12">
                            <div class="col-md-12"  style="padding: 10px 100px;" id="old_input">
                                <label class="col-md-5 control-label" style="line-height: 20px; text-align: right;">审核状态：</label>
                                <div class="col-md-6">
                                    <select id="checkStatus_">
                                    	<option value="2">审核通过</option>
                                    	<option value="3">审核不通过</option>
                                    </select>
                                </div>
                                <br>&nbsp;
                            </div>
                            <div class="col-md-12"  style="padding: 10px 100px;" id="old_input">
                                <label class="col-md-5 control-label" style="line-height: 20px; text-align: right;">审核备注：</label>
                                <div class="col-md-6">
                                    <textarea class="form-control" rows="3" readonly="readonly" id="checkMemo_" name="checkMemo_"></textarea>
                                </div>
                                <br>&nbsp;
                            </div>

                        </div>
                        <br>&nbsp;
                        <div class="form-group">
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            <input class="btn btn-danger" id="commitCheckCoupon" style="width: 25%;" id="submitEdit" type="button" value="审核" />
                            <input class="btn btn-danger" onclick="closeMerchant();" style="width: 25%;" id="submitEdit" type="button" value="关闭" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
<!-- /.modal-dialog -->
</div>


<!--编辑积分申请 -->
<div class="modal modal-darkorange" id="deitCouponApplyDiv">
</div>
<!-- 审核积分申请-->
<!-- div class="modal modal-darkorange"
     id="checkIntegralDiv">
    <div class="modal-dialog"
         style="width: 800px; height: auto; margin: 4% auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button" onclick="closeCheckApply();">×</button>
                <h4 class="modal-title">审核积分申请</h4>
            </div>
            <div class="page-body">
                <div class="row">
                    <form method="post" class="form-horizontal">
                        <input type="hidden" id="check_sid"/>
                        <div class="col-xs-12 col-md-12">
                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">审核人：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name"
                                           id="checkName" />
                                    <span id="checkName_msg" style="color:red;display:none;" class="check_msg">不能为空!</span>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">审核状态：</label>
                                <div class="radio">
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="check_status" value="1" checked="checked"> <span
                                            class="text">待审核</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="check_status" value="2"> <span
                                            class="text">通过</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="check_status" value="3"> <span
                                            class="text">驳回</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="check_status" value="4"> <span
                                            class="text">取消</span>
                                    </label>
                                </div>
                            </div>


                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">审核备注：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control" name="memo"
                                           id="check_memo" />
                                </div>
                                <br>&nbsp;
                            </div>

                        </div>
                        <br>&nbsp;
                        <div class="form-group">
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            <input class="btn btn-danger" onclick="checkIntegralApply();" style="width: 25%;"
                                   id="submitCheck" type="button" value="确定" />
                        </div>
                </form>
            </div>
        </div>
    </div>
    /.modal-content
</div>
/.modal-dialog
</div> -->
    <script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
    <script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
    <script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
	<!-- jquery validate 本地化信息文件 -->
	<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
    <!--Bootstrap Date Range Picker-->	
    <script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
    <script src="${pageContext.request.contextPath}/js/member/coupon/CouponApplyView.js"></script>
    <script src="${pageContext.request.contextPath}/js/member/coupon/CouponApplyEntity.js"></script>
</body>
</html>
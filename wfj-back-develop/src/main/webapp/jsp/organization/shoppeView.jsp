<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<style type="text/css">
    .listInfo li {
        float: left;
        height: 35px;
        margin: 1px 1px 1px 0;
        overflow: hidden;
    }
</style>

<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var shoppePagination;
	$(function() {
		//查询集团
		//$("#groupSid_select").one("click",function(){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/organization/queryListOrganization?organizationType=0",
				dataType: "json",
				async : false,
				success: function(response) {
					var result = response;
					if(result.success == "true"){
						var groupSid = $("#groupSid_select");
						for ( var i = 0; i < result.list.length; i++) {
							var ele = result.list[i];
							var option;
							option = $("<option value='" + ele.sid + "'>"
									+ ele.organizationName + "</option>");
							option.appendTo(groupSid);
						}
					}
					return;
				}
			});
		//});
		$("#groupSid_select").select2();

		queryShop();
		$("#shopSid_select").select2();

		querySupplier();
		$("#supplySid_select").select2();

		$("#pageSelect").change(shoppeQuery);
        $("#groupSid_select").change(shoppeQuery);
        $("#groupSid_select").change(queryShop);
        $("#shopSid_select").change(shoppeQuery);
        $("#shopSid_select").change(querySupplier);
        $("#supplySid_select").change(shoppeQuery);

		initShoppe();
	});

	function queryShop(){
		//查询门店
		$.ajax({
			type : "post",
			url : __ctxPath + "/shoppe/queryShopListAddPermission",
			dataType : "json",
			async:false,
			data: {
				"groupSid" : $("#groupSid_select option:selected").val().trim()
			},
			success : function(response) {
				$("#shopSid_select").html("<option value='' organizationCode=''>亲选择</option>");
				if(response.success == "true"){
					var result = response.list;
					var option = "";
					$("#shopSid_select").html("");
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						option += "<option value='"+ele.sid+"' organizationCode='" + ele.organizationCode + "'>"
								+ ele.organizationName + "</option>";
					}
					$("#shopSid_select").append(option);
				}
				return;
			}
		});
	}

	function querySupplier(){
		//查询供应商
		var supplySid_select = $("#supplySid_select");
		supplySid_select.html("<option value=''>请选择</option>");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/supplierDisplay/findListSupplier",
			dataType : "json",
			async : false,
			data : {
				"shopCode" : $("#shopSid_select option:selected").attr("organizationCode")
			},
			success : function(response) {
				var result = response.list;
				if(typeof(result) != "undefined"){
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.supplyName + "</option>");
						option.appendTo(supplySid_select);
					}
				}
				return;
			},
			error : function(XMLHttpRequest, textStatus) {
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
	}

	function shoppeQuery() {
		$("#shoppeName_form").val($("#shoppeName_input").val());
		$("#shoppeCode_form").val($("#shoppeCode_input").val());
		$("#floorName_form").val($("#floorName_input").val());
		$("#floorCode_form").val($("#floorCode_input").val());
		$("#shopSid_form").val($("#shopSid_select").val());
		$("#groupSid_form").val($("#groupSid_select").val());
		$("#supplySid_form").val($("#supplySid_select").val());
		$("#supplyCode_form").val($("#supplyCode_input").val());
		var params = $("#shoppe_form").serialize();
        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('shoppe.queryShoppe', '专柜查询：' + params, getCookieValue("username"),  sessionId);
		params = decodeURI(params);
		shoppePagination.onLoad(params);
	}

	function find() {
		shoppeQuery();
	}

	function reset() {
		$("#groupSid_select").select2().select2("val","");
		$("#shopSid_select").val($("#shopSid_select option:eq(0)").val()).select2();
		$("#supplySid_select").select2().select2("val","");
		$("#supplyCode_input").val("");
		$("#shoppeCode_input").val("");
		$("#shoppeName_input").val("");
		$("#floorCode_input").val("");
		$("#floorName_input").val("");
		shoppeQuery();
	}
	//只选一个
	function selectOne(one){
		$("input[type='checkbox']:checked").each(function(){
			if(this != one){
				$(this).attr("checked",false);
			}
		});
	}
	//初始化
	function initShoppe() {
		var url = $("#ctxPath").val() + "/shoppe/queryShoppe";
		shoppePagination = $("#shoppePagination").myPagination(
			{
				panel : {
					tipInfo_on : true,
					tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
					tipInfo_css : {
						width : '25px',
						height : "20px",
						border : "2px solid #f0f0f0",
						padding : "0 0 0 5px",
						margin : "0 5px 0 5px",
						color : "#48b9ef"
					}
				},
				debug : false,
				ajax : {
					on : true,
					url : url,
					dataType : 'json',
					param : "shopSid=" + $("#shopSid_select option:selected").val(),
					ajaxStart: function() {
				       	 $("#loading-container").attr("class","loading-container");
				        },
				        ajaxStop: function() {
				          //隐藏加载提示
				          setTimeout(function() {
				       	        $("#loading-container").addClass("loading-inactive");
				       	 },300);
				     },
					
					callback : function(data) {
						//使用模板
						$("#shoppe_tab tbody").setTemplateElement("shoppe-list").processTemplate(data);
					}
				}
			});
	}
	function addShoppe() {
		var url = __ctxPath + "/jsp/organization/addShoppe.jsp";
		$("#pageBody").load(url);
	}
	function editShoppe() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一行！"));
	        $("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选取要修改的行！"));
	        $("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid = value;
		groupSid_ = $("#groupSid_" + value).text().trim();
		shopSid_ = $("#shopSid_" + value).text().trim();
		shopCode_ = $("#shopCode_" + value).text().trim();
		shopName_ = $("#shopName_" + value).text().trim();
		shoppeCode_ = $("#shoppeCode_" + value).text().trim();
		shoppeName_ = $("#shoppeName_" + value).text().trim();
		shoppeStatus_ = $("#shoppeStatus_" + value).attr("shoppeStatus").trim();
		shoppeType_ = $("#shoppeType_" + value).attr("shoppeType").trim();
		shoppeShippingPoint_ = $("#shoppeShippingPoint_" + value).text().trim();
		floorSid_ = $("#floorSid_" + value).text().trim();
        supplySid_ = $("#supplySid_" + value).text().trim();
		industryConditionSid_ = $("#industryConditionSid_" + value).attr("industryConditionSid").trim();
		isShippingPoint_ = $("#isShippingPoint_" + value).attr("isShippingPoint").trim();
		goodsManageType_ = $("#goodsManageType_" + value).text().trim();
        businessPattern_ = $("#businessPattern_" + value).text().trim();
		negativeStock_ = $("#negativeStock_" + value).attr("negativeStock").trim();
		createName_ = $("#createName_" + value).text().trim();
		
		var url = __ctxPath + "/jsp/organization/editShoppe.jsp";
		$("#pageBody").load(url);
	}
    //查看专柜详情
    function getShoppeDetail(value) {
        sid = value;
        groupSid_ = $("#groupSid_" + value).text().trim();
        shopSid_ = $("#shopSid_" + value).text().trim();
        shopCode_ = $("#shopCode_" + value).text().trim();
        shopName_ = $("#shopName_" + value).text().trim();
        shoppeCode_ = $("#shoppeCode_" + value).text().trim();
        shoppeName_ = $("#shoppeName_" + value).text().trim();
        floorName_ = $("#floorName_" + value).text().trim();
        supplyName_ = $("#supplyName_" + value).text().trim();
        supplyCode_ = $("#supplyCode_" + value).text().trim();
        shoppeStatus_ = $("#shoppeStatus_" + value).attr("shoppeStatus").trim();
        shoppeType_ = $("#shoppeType_" + value).attr("shoppeType").trim();
        shoppeShippingPoint_ = $("#shoppeShippingPoint_" + value).text().trim();
        shoppeShippingPointName_ = $("#shoppeShippingPointName_" + value).text().trim();
        floorSid_ = $("#floorSid_" + value).text().trim();
        floorCode_ = $("#floorCode_" + value).text().trim();
        industryConditionSid_ = $("#industryConditionSid_" + value).attr("industryConditionSid").trim();
        isShippingPoint_ = $("#isShippingPoint_" + value).attr("isShippingPoint").trim();
        goodsManageType_ = $("#goodsManageType_" + value).text().trim();
        businessPattern_ = $("#businessPattern_" + value).text().trim();
        negativeStock_ = $("#negativeStock_" + value).attr("negativeStock").trim();
        createName_ = $("#createName_" + value).text().trim();

        var url = __ctxPath + "/jsp/organization/getShoppeDetail.jsp";
        $("#pageBody").load(url);
    }

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
	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/organization/shoppeView.jsp");
	}
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
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
								<h5 class="widget-caption">专柜管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
                                <div class="clearfix">
                                    <a onclick="addShoppe();" class="btn btn-primary">
                                        <i class="fa fa-plus"></i>
                                        添加专柜
                                    </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <a onclick="editShoppe();" class="btn btn-info">
                                        <i class="fa fa-wrench"></i>
                                        修改专柜
                                    </a>
                                </div>
                                <div class="table-toolbar">
                                    <ul class="listInfo clearfix">
                                        <li>
                                            <span>集团：</span>
                                            <select id="groupSid_select" style="width: 200px;height: 25px;">
                                                <option value="" selected="selected">请选择</option>
                                            </select>
                                        </li>
                                        <li>
                                            <span>门店：</span>
                                            <select id="shopSid_select" style="width: 200px;height: 25px;">
                                            </select>
                                        </li>
                                        <li>
                                            <span>供应商：</span>
                                            <select id="supplySid_select" style="width: 200px;height: 25px;">
                                                <option value="" selected="selected">请选择</option>
                                            </select>
                                        </li>
                                        <li>
                                            <span>供应商编码：</span>
                                            <input maxlength="20" type="text" id="supplyCode_input" style="width: 200px;height: 23px;"/>
                                        </li>
                                        <li>
                                            <span>专柜名称：</span>
                                            <input maxlength="20" type="text" id="shoppeName_input" style="width: 200px;height: 23px;"/>
                                        </li>
                                        <li>
                                            <span>专柜编码：</span>
                                            <input maxlength="20" type="text" id="shoppeCode_input" style="width: 200px;height: 23px;"/>
                                        </li>
                                        <li>
                                            <span>楼层名称：</span>
                                            <input maxlength="20" type="text" id="floorName_input" style="width: 200px;height: 23px;"/>
                                        </li>
                                        <li>
                                            <span>楼层编码：</span>
                                            <input maxlength="20" type="text" id="floorCode_input" style="width: 200px;height: 23px;"/>
                                        </li>
                                        <li>
                                            <a class="btn btn-default shiny" onclick="find();" style="margin-left: 10px;">查询</a>
                                            <a class="btn btn-default shiny" onclick="reset();" style="margin-left: 10px;">重置</a>
                                        </li>
                                    </ul>
                                </div>
								<!-- <div class="table-scrollable"> -->
									<table class="table table-bordered table-striped table-condensed table-hover flip-content"
										id="shoppe_tab">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;" width="5%">选择</th>
												<th style="text-align: center;">名称</th>
												<th style="text-align: center;">编码</th>
												<th style="text-align: center;">状态</th>
												<th style="text-align: center;">类型</th>
												<th style="text-align: center;">门店</th>
												<th style="text-align: center;">楼层</th>
												<th style="text-align: center;">业态</th>
												<th style="text-align: center;">供应商</th>
												<th style="text-align: center;">供应商编码</th>
												<th style="text-align: center;" width="7%">是否有集货地点</th>
												<%--<th style="text-align: center;" width="10%">集货地点</th>--%>
												<!-- <th style="text-align: center;" width="7%">专柜库存管理类型</th> -->
												<th style="text-align: center;" width="7%">是否负库存销售</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								<!-- </div> -->
								<div class="pull-left" style="margin-top: 5px;">
										<form id="shoppe_form" action="">
											<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
											<input type="hidden" id="groupSid_form" name="groupSid" />
											<input type="hidden" id="shopSid_form" name="shopSid" />
											<input type="hidden" id="supplySid_form" name="supplySid" />
											<input type="hidden" id="supplyCode_form" name="supplyCode" />
											<input type="hidden" id="shoppeName_form" name="shoppeName" />
											<input type="hidden" id="shoppeCode_form" name="shoppeCode" />
											<input type="hidden" id="floorName_form" name="floorName" />
											<input type="hidden" id="floorCode_form" name="floorCode" />
										</form>
									</div>
								<div id="shoppePagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="shoppe-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:3px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" onclick="selectOne(this);">
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">
                                                        <a id="shoppeName_{$T.Result.sid}" onclick="getShoppeDetail({$T.Result.sid});" style="cursor:pointer;">
                                                            {#if $T.Result.shoppeName != '[object Object]'}
                                                                {$T.Result.shoppeName}
                                                            {#/if}
                                                        </a>
													</td>
													<td align="center">
													    <a id="shoppeCode_{$T.Result.sid}" onclick="getShoppeDetail({$T.Result.sid});" style="cursor:pointer;">
													        {$T.Result.shoppeCode}
													    </a>
													</td>
													<td align="center" id="shoppeStatus_{$T.Result.sid}" shoppeStatus="{$T.Result.shoppeStatus}">
														{#if $T.Result.shoppeStatus== 1}
															<span>正常</span>
														{#elseif $T.Result.shoppeStatus == 2}
															<span>停用</span>
														{#elseif $T.Result.shoppeStatus == 3}
															<span>撤销</span>
														{#/if}
													</td>
													<td align="center" id="shoppeType_{$T.Result.sid}" shoppeType="{$T.Result.shoppeType}">
														{#if $T.Result.shoppeType== 01}
															<span>全渠道单品专柜</span>
														{#elseif $T.Result.shoppeType == 02}
															<span>非全渠道单品专柜</span>
														{#/if}
													</td>
													<td align="center" id="shopName_{$T.Result.sid}">
                                                        {#if $T.Result.shopName != '[object Object]'}
                                                            {$T.Result.shopName}
                                                        {#/if}
													</td>
													<td align="center" id="floorName_{$T.Result.sid}">
                                                        {#if $T.Result.floorName != '[object Object]'}
                                                            {$T.Result.floorName}
                                                        {#/if}
													</td>
													<td align="center" id="industryConditionSid_{$T.Result.sid}" industryConditionSid="{$T.Result.industryConditionSid}">
														{#if $T.Result.industryConditionSid== 0}
															<span>百货 </span>
														{#elseif $T.Result.industryConditionSid == 1}
															<span>超市 </span>
														{#elseif $T.Result.industryConditionSid == 2}
															<span>电商 </span>
														{#/if}
													</td>
													<td align="center" id="supplyName_{$T.Result.sid}">
                                                        {#if $T.Result.supplyName != '[object Object]'}
                                                            {$T.Result.supplyName}
                                                        {#/if}
													</td>
													<td align="center" id="supplyCode_{$T.Result.sid}">
                                                        {#if $T.Result.supplyCode != '[object Object]'}
                                                            {$T.Result.supplyCode}
                                                        {#/if}
													</td>
													<td align="center" id="isShippingPoint_{$T.Result.sid}" isShippingPoint="{$T.Result.isShippingPoint}">
														{#if $T.Result.isShippingPoint == 0}
															<span class="label label-success graded">是</span>
														{#elseif $T.Result.isShippingPoint == 1}
															<span class="label label-lightyellow graded">否</span>
														{#/if}
													</td>
													<td align="center" style="display:none;" id="shoppeShippingPoint_{$T.Result.sid}">
                                                        {#if $T.Result.shoppeShippingPoint != '[object Object]'}
                                                            {$T.Result.shoppeShippingPoint}
                                                        {#/if}
													</td>
													<td align="center" style="display:none;" id="shoppeShippingPointName_{$T.Result.sid}">
                                                        {#if $T.Result.shoppeShippingPointName != '[object Object]'}
                                                            {$T.Result.shoppeShippingPointName}
                                                        {#/if}
													</td>
													
													<td align="center" id="negativeStock_{$T.Result.sid}" negativeStock="{$T.Result.negativeStock}">
														{#if $T.Result.negativeStock == 0}
															<span>允许</span>
														{#elseif $T.Result.negativeStock == 1}
															<span>不允许</span>
														{#/if}
													</td>
													<td align="center" style="display:none;" id="groupSid_{$T.Result.sid}">{$T.Result.groupSid}</td>
													<td align="center" style="display:none;" id="shopCode_{$T.Result.sid}">{$T.Result.shopCode}</td>
													<td align="center" style="display:none;" id="shopSid_{$T.Result.sid}">{$T.Result.shopSid}</td>
													<td align="center" style="display:none;" id="floorSid_{$T.Result.sid}">{$T.Result.floorSid}</td>
													<td align="center" style="display:none;" id="supplySid_{$T.Result.sid}">{$T.Result.supplySid}</td>
													<td align="center" style="display:none;" id="floorCode_{$T.Result.sid}">{$T.Result.floorCode}</td>
													<td align="center" style="display:none;" id="goodsManageType_{$T.Result.sid}">{$T.Result.goodsManageType}</td>
													<td align="center" style="display:none;" id="businessPattern_{$T.Result.sid}">{$T.Result.businessPattern}</td>
													<td align="center" style="display:none;" id="createName_{$T.Result.sid}">{$T.Result.createName}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
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
</body>
</html>
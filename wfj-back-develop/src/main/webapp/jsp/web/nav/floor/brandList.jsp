<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String id = request.getParameter("sid");
	request.setAttribute("sid", id);
	String pageLayoutSid = request.getParameter("pageLayoutSid");
	request.setAttribute("pageLayoutSid", pageLayoutSid);
%>

<!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";
	var t;
	var brandPagination;
	var brandType_ = $("#brandType_from").val($("#brandType_input").val());
	$(function() {
			initBrand();
			$("#pageSelect").change(brandQuery);
			$("#brandType_input").change(brandQuery);
	});
	function brandQuery() {
		$("#brandName_from").val($("#brandName_input").val());
		$("#brandType_from").val($("#brandType_input").val());
		if($("#brandType_input").val()==1){
			$("#two").show();
			$("#two2").show();
		}else{
			$("#two").hide();
			$("#two2").hide();
		}
		var params = $("#brand_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		brandPagination.onLoad(params);
	}
	function find() {
		/* $("#brandName_input").change(brandQuery); */ 
		brandQuery();
	}
	function reset() {
		$("#brandName_input").val("");
		brandQuery();
	}
	//初始化商品列表
	function initBrand() {
		var url = $("#ctxPath").val() + "/brandDisplay/queryBrand";
		brandPagination = $("#brandPagination").myPagination(
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
				async: false,
				ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive");
					}, 300);
				},
				callback : function(data) {
					$("#brand_tab tbody").setTemplateElement("brand-list").processTemplate(data);
				}
			}
		});
		if(t==1){
			$("#brandType_input").val(1);
			brandQuery();
			return;
		}
	}
	
	function back(){
		var url =  __ctxPath+"/jsp/nav/GetChannelTree.jsp";
		$("#pageBody").load(url);
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
								<h5 class="widget-caption">品牌管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
								<span> <a id="enterFloor" onclick="back();" 
									class="btn btn-info glyphicon glyphicon-wrench">返回楼层列表 </a></span>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
										<a id="editabledatatable_new" onclick="addBrand();" class="btn btn-primary"> <i class="fa fa-plus"></i> 添加</a>&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
									<div class="mtb10">
										<span>品牌类型：</span>
										<select id="brandType_input" style="width:200px;padding: 0px 0px">
											<option value=0 selected="selected">集团</option>
											<option value=1>门店</option>
										</select>&nbsp;&nbsp;&nbsp;&nbsp;
										<span>品牌名称：</span> 
										<input type="text" id="brandName_input" />&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>									
								</div>
										<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="brand_tab">
                                        <thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;" width="75px;">选择</th>
												<th style="text-align: center;">品牌编码</th>
												<th style="text-align: center;">品牌名称</th>
												<th style="text-align: center;">品牌类型</th>
												<th id="two" style="text-align: center; display: none;">门店类型</th>
												<th id="two2" style="text-align: center; display: none;">所属集团品牌</th>
												<th style="text-align: center;">拼音</th>
												<th style="text-align: center;">中文名称</th>
												<th style="text-align: center;">英文名称</th>
												<!-- <th style="text-align: center;">有效标记</th> -->
												<th style="text-align: center;">是否展示</th>
												<!-- <th style="text-align: center;">门店Sid</th>
												<th style="text-align: center;">品牌公司</th>
												<th style="text-align: center;">品牌描述</th>
												<th style="text-align: center;">品牌特点</th>
												<th style="text-align: center;">适合人群</th>
												<th style="text-align: center;">操作人</th>
												<th style="text-align: center;">操作时间</th> -->
												<!-- <th style="text-align: center;">创建时间</th> -->
												<!-- <th style="text-align: center;">查询次数</th> -->
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="brand_form" action="">
										<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										<input type="hidden" id="brandName_from" name="brandName" />
										<input type="hidden" id="brandType_from" name="brandType" />
									</form>
								</div>
								<div id="brandPagination"></div>
							</div>

							<!-- Templates -->
							<p style="display: none">
								<textarea id="brand-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="brandSid_{$T.Result.sid}">{$T.Result.brandSid}</td>
													<td align="center" id="brandName_{$T.Result.sid}">{$T.Result.brandName}</td>
													<td align="center" id="brandType_{$T.Result.sid}">
														{#if $T.Result.brandType == 0}
															<span>集团品牌</span>
														{#elseif $T.Result.brandType == 1}
															<span>门店品牌</span>
														{#/if}
														<input type="hidden" id="brand_url" value="{$T.Result.url}"  />
														<input type="hidden" id="brandpic1_{$T.Result.sid}" value="{$T.Result.brandpic1}"  />
														<input type="hidden" id="brandpic2_{$T.Result.sid}" value="{$T.Result.brandpic2}"  />
													</td>
													
													{#if $T.Result.brandType == 1}
														<td align="center" id="shopType_{$T.Result.sid}">
															{#if $T.Result.shopType == 0}
																<span>北京</span>
															{#elseif $T.Result.shopType == 1}
																<span>外埠</span>
															{#elseif $T.Result.shopType == 2}
																<span>电商erp</span>
															{#/if}
														</td>
														<td align="center" id="brandFatherName_{$T.Result.sid}">{$T.Result.brandFatherName}</td>
													{#/if}
													<td align="center" style="display:none;" id="shopSid_{$T.Result.sid}">{$T.Result.shopSid}</td>
													<td align="center" style="display:none;" id="status_{$T.Result.sid}">{$T.Result.status}</td>
													<td align="center" style="display:none;" id="parentSid_{$T.Result.sid}">{$T.Result.parentSid}</td>
													<td align="center" style="display:none;" id="shopType_{$T.Result.sid}">{$T.Result.shopType}</td>
													<td align="center" style="display:none;" id="shopSid_{$T.Result.sid}">{$T.Result.shopSid}</td>
													<td align="center" id="spell_{$T.Result.sid}">{$T.Result.spell}</td>
													<td align="center" id="brandNameSecond_{$T.Result.sid}">{$T.Result.brandNameSecond}</td>
													<td align="center" id="brandNameEn_{$T.Result.sid}">{$T.Result.brandNameEn}</td>
													<td align="center" style="display:none;" id="status_{$T.Result.sid}">
														{#if $T.Result.status == 0}
															<span>有效</span>
														{#elseif $T.Result.status == 1}
															<span>无效</span>
														{#/if}
													</td>
													<td align="center" id="isDisplay_{$T.Result.sid}">
														{#if $T.Result.isDisplay == 0}
															<span class="label label-success graded">是</span>
														{#elseif $T.Result.isDisplay == 1}
															<span class="label label-lightyellow graded">否</span>
														{#/if}
													</td>
													<td align="center" style="display:none;" id="brandcorp_{$T.Result.sid}">{$T.Result.brandcorp}</td>
													<td align="center" style="display:none;" id="brandDesc_{$T.Result.sid}">{$T.Result.brandDesc}</td>
													<td align="center" style="display:none;" id="brandSpecialty_{$T.Result.sid}">{$T.Result.brandSpecialty}</td>
													<td align="center" style="display:none;" id="brandSuitability_{$T.Result.sid}">{$T.Result.brandSuitability}</td>
													<td align="center" style="display:none;" id="optRealName_{$T.Result.sid}">{$T.Result.optRealName}</td>
													<td align="center" style="display:none;" id="optUpdateTimeStr_{$T.Result.sid}">{$T.Result.optUpdateTimeStr}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
							</p>
						</div>
						<!-- 创建时间和查询次数 备用-->
						<!-- 
							<td align="center" id="brandCreateTime_{$T.Result.sid}">{$T.Result.brandCreateTime}</td>
							<td align="center" id="aveSome_{$T.Result.sid}">{$T.Result.aveSome}</td>
						 -->
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
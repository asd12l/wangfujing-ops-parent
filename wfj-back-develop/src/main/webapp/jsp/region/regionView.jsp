<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" ></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var regionPagination;
	$(function() {
	    initRegion();
	    $("#pageSelect").change(regionQuery);
	});
	function regionQuery(){
		var provinceSid = $("#province").val();
		var citySid = $("#city").val();
		var parentId = "";
		if (provinceSid != "") {
			parentId = provinceSid;
		}
		if (citySid != "") {
			parentId = citySid;
		}
		$("#parentId_form").val(parentId);
		$("#regionName_form").val($("#regionName_input").val());
		$("#regionInnerCode_form").val($("#regionInnerCode_input").val());
		$("#regionCode_form").val($("#regionCode_input").val());
        var params = $("#region_form").serialize();
        params = decodeURI(params);
        regionPagination.onLoad(params);
   	}
	function find() {
        //查询不需要用regionLevel
        $("#regionLevel_form").val("");
		regionQuery();
	}
	function reset(){
		$("#province").val("");
		$("#city").val("");
		$("#regionName_input").val("");
		$("#regionInnerCode_input").val("");
		$("#regionCode_input").val("");
        //重置，默认查询省
        $("#regionLevel_form").val("0");
		regionQuery();
	}
 	function initRegion() {
		var url = $("#ctxPath").val()+"/region/queryPageRegion";
		regionPagination = $("#regionPagination").myPagination({
			panel: {
				tipInfo_on: true,
				tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
				tipInfo_css: {
					width: '25px',
					height: "20px",
					border: "2px solid #f0f0f0",
					padding: "0 0 0 5px",
					margin: "0 5px 0 5px",
					color: "#48b9ef"
				}
			},
			debug: false,
			ajax: {
				on: true,
				url: url,
				dataType: 'json',
                param: "regionLevel=" + $("#regionLevel_form").val(),
				ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
				ajaxStop: function() {
					setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
				},
				callback: function(data) {
					$("#region_tab tbody").setTemplateElement("region-list").processTemplate(data);
				}
			}
		});
	}
 	
 	//点击事件，获取省的信息
 	$("#province").one("click",function(){
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/region/queryListRegion",
			dataType: "json",
			data: "regionLevel=0",
			success: function(response) {
			    if(response.success != "false"){
					var result = response.list;
			  		var province = $("#province");
			  		province.html("<option value=''>请选择</option>");
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.regionName + "</option>");
						option.appendTo(province);
					}
			    }else{
					$("#warning2Body").text("没有省的信息!");
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
	});
 	
 	//选择省查询市
 	function classifyOne(){
 		var city = $("#city");
		city.html("<option value=''>请选择</option>");
		var sid = $("#province").val();
        if(sid == ""){
            return;
        }
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/region/queryListRegion",
			dataType: "json",
			data: "parentId="+sid,
			success: function(response) {
			    if(response.success != "false"){
					var result = response.list;
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.regionName + "</option>");
						option.appendTo(city);
					}
			    }else{
					$("#warning2Body").text("当前省下没有市信息!");
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
	}
 	
</script>
<!-- 添加 -->
<script type="text/javascript">
	function addRegion(){
		var url = __ctxPath+"/jsp/region/addRegion.jsp";
		$("#pageBody").load(url);
	}
</script>
<!-- 修改 -->
<script type="text/javascript">
	function editRegion() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
		    $("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
		    $("#warning2Body").text("请选取要查看的行!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid_ = $("#tdCheckbox_" + value).val().trim();
		parentId_ = $("#parentId_" + value).text().trim();
		regionCode_= $("#regionCode_" + value).text().trim();
		regionInnerCode_= $("#regionInnerCode_" + value).text().trim();
		regionName_= $("#regionName_" + value).text().trim();
		regionNameEn_= $("#regionNameEn_" + value).text().trim();
		regionShortnameEn_ = $("#regionShortnameEn_" + value).text().trim();
		regionLevel_= $("#regionLevel_" + value).attr("regionLevel");
		var url = __ctxPath + "/jsp/region/editRegion.jsp";
		$("#pageBody").load(url);
	}
</script>
<!-- 删除 -->
<script type="text/javascript">
	function delSupplierInfo(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
		    $("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
		    $("#warning2Body").text("请选取要删除的行!");
			$("#warning2").show();
			return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/supplierDisplay/deleteSupplier";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
	    ajaxStop: function() {
	      //隐藏加载提示
	      setTimeout(function() {
	   	        $("#loading-container").addClass("loading-inactive");
	   	 },300);
	    },
			data: {
				"sid":value
			},
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>删除成功，返回列表页!</strong></div>");
					$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(buildErrorMessage("","删除失败！"));
                	$("#warning2").show();
				}
				return;
			}
		});
	}
</script>
<!-- 基本控制 -->
<script type="text/javascript">
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/region/regionView.jsp");
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
                                    <h5 class="widget-caption">行政区域管理</h5>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                        <a onclick="addRegion();" class="btn btn-primary">
                                            <i class="fa fa-plus"></i>
                                            添加行政区域
                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a onclick="editRegion();" class="btn btn-info">
                                            <i class="fa fa-wrench"></i>
                                            修改行政区域
                                        </a>
                                    </div>

                                    <div class="table-toolbar" style="width: 100%;float: left;">
                                        <div class="col-md-3" style="width: 25%;">
                                            <label style="width: 20%;text-align: right;">省：</label>
                                            <select onchange="classifyOne();" id="province" style="width: 70%;">
                                                <option value="">请选择</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3" style="width: 25%;">
                                            <label style="width: 20%;text-align: right;">市：</label>
                                            <select id="city" style="width: 70%;">
                                                <option value="">请选择</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3" style="width: 25%;">
                                            <label style="width: 20%;text-align: right;">名称：</label>
                                            <input type="text" id="regionName_input" style="width: 70%;"/>
                                        </div>
                                    </div>

                                    <div class="table-toolbar" style="width: 100%;float: left;">
                                        <div class="col-md-3" style="width: 25%;">
                                            <label style="width: 20%;text-align: right;">编码：</label>
                                            <input type="text" id="regionInnerCode_input" style="width: 70%;"/>
                                        </div>
                                        <%--<div class="col-md-3" style="width: 25%;">
                                            <label style="width: 20%;text-align: right;">邮编：</label>
                                            <input type="text" id="regionCode_input" style="width: 70%;"/>
                                        </div>--%>
                                        <div class="col-md-3" style="width: 25%;">
                                            <a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a class="btn btn-default shiny" onclick="reset();">重置</a>
                                        </div>
                                    </div>

                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="region_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                                <th width="5%" style="text-align: center;">选择</th>
                                                <th style="text-align: center;">名称</th>
                                                <%--<th style="text-align: center;">邮编</th>--%>
                                                <th style="text-align: center;">编码</th>
                                                <th style="text-align: center;">等级</th>
                                                <th style="text-align: center;">名称拼音</th>
                                                <th style="text-align: center;">名称拼音简称</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                   <div class="pull-left" style="margin-top: 5px;">
										<form id="region_form" action="">
											<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp;
                                            <input type="hidden" id="regionLevel_form" name="regionLevel" value="0"/>
											<input type="hidden" id="parentId_form" name="parentId" />  
											<input type="hidden" id="regionName_form" name="regionName" />
											<input type="hidden" id="regionInnerCode_form" name="regionInnerCode" />
											<input type="hidden" id="regionCode_form" name="regionCode" />
										</form>
									</div>
                                    <div id="regionPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="region-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="regionName_{$T.Result.sid}">
														{#if $T.Result.regionName != '[object Object]'}
															{$T.Result.regionName}
														{#/if}
													</td>
													<td align="center" id="regionInnerCode_{$T.Result.sid}">
														{#if $T.Result.regionInnerCode != '[object Object]'}
															{$T.Result.regionInnerCode}
														{#/if}
													</td>
													<td align="center" id="regionLevel_{$T.Result.sid}" regionLevel="{$T.Result.regionLevel}">
														{#if $T.Result.regionLevel == 0}
															省
														{#elseif $T.Result.regionLevel == 1}
															市
														{#elseif $T.Result.regionLevel == 3}
															区/县
														{#elseif $T.Result.regionLevel == 4}
															镇
														{#/if}
													</td>
													<td align="center" style="display:none;" id="parentId_{$T.Result.sid}">
														{#if $T.Result.parentId != '[object Object]'}
															{$T.Result.parentId}
														{#/if}
													</td>
													<td align="center"  id="regionNameEn_{$T.Result.sid}">
														{#if $T.Result.regionNameEn != '[object Object]'}
															{$T.Result.regionNameEn}
														{#/if}
													</td>
													<td align="center" id="regionShortnameEn_{$T.Result.sid}">
														{#if $T.Result.regionShortnameEn != '[object Object]'}
															{$T.Result.regionShortnameEn}
														{#/if}
													</td>
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
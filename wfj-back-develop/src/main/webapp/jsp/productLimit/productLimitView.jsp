<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<script	src="${pageContext.request.contextPath}/assets/js/select2/selectAjax.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/selectAjax.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var productLimitPagination;
	
	var setting = {
		data : {
			key : {
				title : "t"
			},
			simpleData : {
				enable : true
			}
		},
		async : {
			enable : true,
			url : __ctxPath + "/category/ajaxAsyncList",
			dataType : "json",
			autoParam : [ "id", "categoryType" ],
			otherParam : {},
			dataFilter : filter
		},
		callback : {
			beforeClick : beforeClick,
			onClick : onClick,
			asyncSuccess : zTreeOnAsyncSuccess,//异步加载成功的fun
			asyncError : zTreeOnAsyncError
		//加载错误的fun 
		}
	};
		
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	function zTreeOnAsyncError(event, treeId, treeNode) {
		$("#warning2Body").text("异步加载失败!");
		$("#warning2").show();
	}
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		$("#warning2Body").text("异步加载成功!");
		$("#warning2").show();
	}
	var log, className = "dark";
	function beforeClick(treeId, treeNode, clickFlag) {
		className = (className === "dark" ? "" : "dark");
		showLog("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
		return (treeNode.click != false);
	}
	function showLog(str) {
		if (!log)
			log = $("#log");
		log.append("<li class='"+className+"'>" + str + "</li>");
		if (log.children("li").length > 8) {
			log.get(0).removeChild(log.children("li")[0]);
		}
	}
	function getTime() {
		var now = new Date(), h = now.getHours(), m = now.getMinutes(), s = now.getSeconds();
		return (h + ":" + m + ":" + s);
	}
	var parametersLength = "";
	var categorySid = "";
	var categoryName = "";
	function onClick(event, treeId, treeNode, clickFlag) {
		if (treeNode.isLeaf == "Y") {
			if (treeNode.categoryType == 0) {
				// 更换请选择
				$("#baseA").html(treeNode.name);
				$("#categorySid_form").val(treeNode.id);
				$("#treeDown").attr("treeDown", "true");
			} 
			$("#baseBtnGroup").attr("class", "btn-group");
		} else {
			$("#warning2Body").text("请选择末级分类!");
			$("#warning2").attr("style", "z-index:9999;");
			$("#warning2").show();
		}
	}
	
	// 控制tree
	$("#treeDown").click(function() {
		if ($(this).attr("treeDown") == "true") {
			$(this).attr("treeDown", "false");
			$("#baseBtnGroup").attr("class", "btn-group open");
		} else {
			$(this).attr("treeDown", "true");
			$("#baseBtnGroup").attr("class", "btn-group");
		}
	});
	
	// Tree工业分类请求
	function treeGetCategory() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/list",
			async : false,
			data : {
				"categoryType" : 0
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			success : function(response) {
				$.fn.zTree.init($("#treeDemo"), setting, response);
			}
		});
	}
	
	$("#treeDown").click(function(){
		treeGetCategory();
	});
	
	$(function() {
	    initProductLimit();
	    $("#pageSelect").change(productLimitQuery);
	    $("#BrandCode").change(productLimitQuery);
	    $("#BrandCode_input").keyup(function(e){
	    	var e = e || event;
			var code = e.keyCode;
			if(code != 32 && !(code >=37 && code <= 40) && !(code >=16 && code <= 18) && code != 93){
				seachData($("#BrandCode_input").val());
			}
		});
	});
	
	/* $("#brandSid_select").one("click",function(){
		$.ajax({
			type : "post",
			url : __ctxPath + "/brandDisplay/queryBrandGroupList",
			async : false,
			dataType : "json",
			success : function(response) {
				var list = response.list;
				for (var i = 0; i < list.length; i++) {
					var ele = list[i];
					var option = "<option value='"+ele.sid+"'>" + ele.brandName + "</option>";
					$("#brandSid_select").append(option);
				}
				return;
			},
			error : function(XMLHttpRequest, textStatus) {
				var sstatus = XMLHttpRequest
						.getResponseHeader("sessionStatus");
				if (sstatus != "sessionOut") {
					$("#warning2Body").text(buildErrorMessage("","系统出错！"));
					$("#warning2").show();
				}
				if (sstatus == "sessionOut") {
					$("#warning3").css('display', 'block');
				}
			}
		});
	}); */
	
	function productLimitQuery(){
		$("#brandSid_form").val($("#BrandCode").val());
        var params = $("#productLimit_form").serialize();
        params = decodeURI(params);
        productLimitPagination.onLoad(params);
   	}
	function find() {
		productLimitQuery();
	}
	function reset(){
		$("#BrandCode").html("<option value='' sid=''>请选择</option>");
		$("#BrandCode_input").val("");
		$("#categorySid_form").val("");
		$("#baseA").text("请选择");
		productLimitQuery();
	}
 	function initProductLimit() {
		var url = $("#ctxPath").val()+"/productlimit/queryPageLimit";
		productLimitPagination = $("#productLimitPagination").myPagination({
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
             async : false,
             dataType: 'json',
             ajaxStart: function() {
		       	 $("#loading-container").attr("class","loading-container");
		     },
	         ajaxStop: function() {
	          //隐藏加载提示
	          	setTimeout(function() {
	       	        $("#loading-container").addClass("loading-inactive");
	       	  	},500);
	         },

             callback: function(data) {
               //使用模板
               $("#productLimit_tab tbody").setTemplateElement("productLimit-list").processTemplate(data);
             }
           }
         });
    }
	function addProductLimit(){
		var url = __ctxPath+"/jsp/productLimit/addProductLimit.jsp";
		$("#pageBody").load(url);
	}
	function editProductLimit() {
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
			$("#warning2Body").text("请选取要修改的行!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid_ = $("#tdCheckbox_" + value).val().trim();
		brandName_ = $("#brandName_" + value).text().trim();
		brandCode_ = $("#brandCode_" + value).text().trim();
		brandSid_ = $("#brandSid_" + value).text().trim();
		categoryName_ = $("#categoryName_" + value).text().trim();
		categoryCode_ = $("#categoryCode_" + value).text().trim();
		categorySid_ = $("#categorySid_" + value).text().trim();
		limitValue_ = $("#limitValue_" + value).text().trim();
		status_ = $("#status_" + value).val().trim();
		
		var url = __ctxPath + "/jsp/productLimit/editProductLimit.jsp";
		$("#pageBody").load(url);
	}
    
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
		$("#pageBody").load(__ctxPath+"/jsp/productLimit/productLimitView.jsp");
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
                                    <h5 class="widget-caption">库存阀值管理</h5>
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
                                    	<a onclick="addProductLimit();" class="btn btn-primary">
                                        	<i class="fa fa-plus"></i>
											添加库存阀值
                                        </a>&nbsp;&nbsp;
                                    	<a onclick="editProductLimit();" class="btn btn-info">
                                    		<i class="fa fa-wrench"></i>
											修改库存阀值
                                        </a>&nbsp;&nbsp;
                                    </div>
                                     <div class="table-toolbar">
                                    	<span>集团品牌名称：</span>                                  	
										<!-- <select id="brandSid_select" name="brandSid">
											<option value="">请选择</option>
										</select> -->
										<select id="BrandCode" name="brandSid"
											style="width: 100%;display: none;">
											<option value="" sid="">请选择</option>	
										</select>
										<input id="BrandCode_input" class="_input" type="text"
											   value="" placeholder="请输入集团品牌" autocomplete="off" style="padding: 0 0;width: 200px;height: 33px;">
										<div id="dataList_hidden" class="_hiddenDiv" style="width:200px;margin-left: 95px;">
											<ul></ul>
										</div>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<span>工业分类名称：</span>
										<div class="btn-group" id="baseBtnGroup" style="width: 25%">
											<a href="javascript:void(0);" class="btn btn-default" id="baseA" style="width: 80%;">请选择</a> 
											<a id="treeDown" href="javascript:void(0);" class="btn btn-default" treeDown="true">
												<i class="fa fa-angle-down"></i>
											</a>
											<ul id="treeDemo" class="dropdown-menu ztree form-group" style="margin-left: 0; width: 98%; position: absolute;"></ul>
										</div>
                                    	<a class="btn btn-default shiny" onclick="find();" style="height: 32px; margin-top: -4px;">查询</a>&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="reset();" style="height: 32px; margin-top: -4px;">重置</a>
                                    </div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="productLimit_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                            	<th style="text-align: center;" width="7.5%">选择</th>  
                                                <th style="text-align: center;">集团品牌名称</th>
                                                <th style="text-align: center;">集团品牌编码</th>
                                                <th style="text-align: center;">工业分类名称</th>
                                                <th style="text-align: center;">工业分类编码</th>
                                                <th style="text-align: center;">下限阀值</th>
                                                <th style="text-align: center;">状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                   <div class="pull-left" style="margin-top: 5px;">
										<form id="productLimit_form" action="">
											<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp;  
											<input type="hidden" id="brandSid_form" name="brandSid" />
											<input type="hidden" id="categorySid_form" name="categorySid" />
										</form>
									</div>
                                    <div id="productLimitPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="productLimit-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="brandName_{$T.Result.sid}">
														{#if $T.Result.brandName != '[object Object]'}
															{$T.Result.brandName}
														{#/if}
													</td>
													<td align="center" id="brandCode_{$T.Result.sid}">
														{#if $T.Result.brandCode != '[object Object]'}
															{$T.Result.brandCode}
														{#/if}
													</td>
													<td align="center" id="brandSid_{$T.Result.sid}" style="display:none">
														{#if $T.Result.brandSid != '[object Object]'}
															{$T.Result.brandSid}
														{#/if}
													</td>
													<td align="center" id="categoryName_{$T.Result.sid}">
														{#if $T.Result.categoryName != '[object Object]'}
															{$T.Result.categoryName}
														{#/if}
													</td>
													<td align="center" id="categoryCode_{$T.Result.sid}">
														{#if $T.Result.categoryCode != '[object Object]'}
															{$T.Result.categoryCode}
														{#/if}
													</td>
													<td align="center" id="categorySid_{$T.Result.sid}" style="display:none">
														{#if $T.Result.categorySid != '[object Object]'}
															{$T.Result.categorySid}
														{#/if}
													</td>
													<td align="center" id="limitValue_{$T.Result.sid}">
														{#if $T.Result.limitValue != '[object Object]'}
															{$T.Result.limitValue}
														{#/if}
													</td>
													<td align="center">
														<input type="hidden" id="status_{$T.Result.sid}" value="{$T.Result.status}"/>
														{#if $T.Result.status == 0}
															<span class="label label-success graded">启用</span>
														{#elseif $T.Result.status == 1}
														    <span class="label label-darkorange graded">禁用</span>
														{#/else}
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
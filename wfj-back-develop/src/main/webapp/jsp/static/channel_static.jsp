<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">
	
</script>
<!-- zTree -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
<script
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js">
<!-- 导航tree -->
	<script src="${pageContext.request.contextPath}/js/customize/nav/navZtree/navZtree.js">
</script>
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script
	src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>

<script
	src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-contextmenu.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var sessionId = "<%=request.getSession().getId() %>";

	var root = "";
	var tree = [];
	var productPagination;
	var nodeId = "";

	var channelId = "";
	var navSid = "";
	var parentId = "";
	var channelName = "";
	var channelPath = "";
	var tplChannel = "";
	var priority = "";
	var display = "";
	var rcNodeId = "";
	var indexFlag = "";
	$(function() {
		$("#pageSelect").change(recordQuery);
		loadLogJs();
	});
	function initTree() {
		initChannelTree();
		initOperationRecord();
	}
	function initChannelTree() {
		/* 		$.ajax({
		 type : "post",
		 contentType : "application/x-www-form-urlencoded;charset=utf-8",
		 url : __ctxPath + "/web/getAllLimitResources",
		 data : {
		 "_site_id_param" : siteSid
		 },
		 dataType : "json",
		 success : function(response) {
		 $('#channel_tree').treeview({

		 data : response.children,
		 //levels:1,
		 expandIcon : 'glyphicon glyphicon-plus',
		 collapseIcon : 'glyphicon glyphicon-minus',
		 emptyIcon : 'glyphicon glyphicon-file',
		 nodeIcon : 'success',
		 onNodeSelected : function(event, node) {
		 channelId = node.id;
		 siteId = node.siteId;
		 indexFlag = node.indexFlag;
		 //toNav(node.id);
		 //toStatic();
		 }
		 });
		 }
		 }); */

		$.fn.zTree.init($("#channelTree"), {
			async : {
				enable : true,
				url : __ctxPath + "/web/getAllLimitResources?_site_id_param="
						+ siteSid,
				dataType : "json",
				autoParam : [ "id" ],// 请求下一级参数ID
				dataFilter : filter
			},
			view : {
				showIcon : true,
				dblClickExpand : false,
				fontCss : setFontCss
			},
			callback : {
				onClick : zTreeChannelOnClick
			}
		});
	}
	function loadLogJs(){
        $.ajax({
            type : "get",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/loadSystemParam/findValueFronSystemParamByKey",
            async : false,
            data : {
                "key" : "log_js"
            },
            dataType : "json",
            ajaxStart : function() {
                $("#loading-container").prop("class", "loading-container");
            },
            ajaxStop : function() {
                $("#loading-container").addClass("loading-inactive");
            },
            success : function(response) {
                if(response.success){
                    var logjs_url = response.value;
                    var _script=document.createElement('script');
                    _script.setAttribute('charset','gbk');
                    _script.setAttribute('type','text/javascript');
                    _script.setAttribute('src',logjs_url);
                    document.getElementsByTagName('head')[0].appendChild(_script);
                } else {
                    $("#warning2Body").text(response.msg);
                    $("#warning2").show();
                }
            }
        });
    }
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for ( var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	};
	/**
	 * 控制节点颜色
	 * @param treeId
	 * @param treeNode
	 * @returns
	 */
	function setFontCss(treeId, treeNode) {
		return treeNode.isShow == 0 ? {
			color : "red"
		} : {
			color : "green"
		};
	};
	/**
	 * 点击事件
	 * @param event
	 * @param treeId
	 * @param treeNode
	 */
	function zTreeChannelOnClick(event, treeId, node) {
		 channelId = node.id;
		 siteId = node.siteId;
		 indexFlag = node.indexFlag;
		 //toNav(node.id);
		 //toStatic();
	};
	function recordQuery() {
		var params = $("#product_form").serialize();
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	function reload() {
		initOperationRecord();
	}
	function initOperationRecord() {
		var url = __ctxPath + "/statics/getRecordList?_site_id_param="
				+ siteSid;
		productPagination = $("#productPagination").myPagination(
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
						contentType : "application/json;charset=utf-8",
						url : url,
						dataType : 'json',
						data : {
							"_site_id_param" : siteSid
						},
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {
							$("#operation_tab tbody").setTemplateElement(
									"operation-list").processTemplate(data);
						}
					}
				});
		/* $.ajax({
			on : true,
			contentType : "application/json;charset=utf-8",
			url : __ctxPath + "/statics/getRecordList",
			dataType : 'json',
			data:{
				"_site_id_param":siteSid
			},
			ajaxStart : function() {
				//ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					ZENG.msgbox.hide();
				}, 300);
			},  
			success : function(data) {
				$("#operation_tab tbody").setTemplateElement(
						"operation-list")
						.processTemplate(data);
			}
		}); */
	}
	function toStatic() {
		userName = getCookieValue("username");
    	LA.sysCode = '53';
		LA.log('channelstatic-toStatic', '生成频道页静态化', userName,  sessionId);
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/statics/index",
					dataType : "json",
					data : {
						"channelId" : channelId,
						"indexFlag" : indexFlag,
						"_site_id_param" : siteSid
					},
					success : function(response) {
						if (response.success == 'true') {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa-fw fa fa-times'></i><strong>成功创建，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
													+ response.message
													+ "</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
						return;
					}
				});
	}
	function siteStatic() {
		userName = getCookieValue("username");
    	LA.sysCode = '53';
		LA.log('channelstatic-siteStatic', '全站点静态化', userName,  sessionId);
		$
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/statics/site_static",
					dataType : "json",
					data : {
						"_site_id_param" : siteSid
					},
					success : function(response) {
						if (response.success == 'true') {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa-fw fa fa-times'></i><strong>成功创建，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
													+ response.message
													+ "</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
						return;
					}
				});
	}
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#modal-warning").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-warning"
		});
		//$("#pageBody").load(__ctxPath+"/jsp/nav/GetChannelTree.jsp");
	}
</script>
<script
	src="${pageContext.request.contextPath}/js/customize/common/common.js"></script>
</head>
<body>
	<div class="page-body">
		<!-- 引入站点切换页面 -->
		<%@ include file="../web/site/site_chose.jsp"%>
		<div class="widget-body">
			<div class="row">
				<div class="col-lg-3 col-sm-3 col-xs-3">
					<div class="web-header">频道目录</div>
					<div class="m10">
						<a onclick="toStatic();" class="btn btn-default shiny">生成频道页</a> <a
							onclick="siteStatic();" class="btn btn-default shiny">全站静态化</a>
					</div>
					<div id="channel_tree" class="tree web-tree">
						<ul id="channelTree" class="ztree"></ul>
					</div>
				</div>
				<div class="col-lg-9 col-sm-9 col-xs-9 p0 rightdiv">

					<div class="widget-header">
						<h5 class="widget-caption">操作记录</h5>
						<div class="widget-buttons">
							<a href="#" data-toggle="collapse" onclick="reload();" title="刷新">
								<i class="fa fa-refresh"></i> </a>
						</div>
					</div>
					<div>
						<table
							class="table table-bordered table-striped table-condensed table-hover"
							id="operation_tab">
							<thead class="flip-content bordered-darkorange">
								<tr>
									<th style="text-align: center;" width="7.5%">选择</th>
									<th style="text-align: center;">编码</th>
									<th style="text-align: center;">操作内容</th>
									<th style="text-align: center;">操作结果</th>
									<th style="text-align: center;">操作人</th>
									<th style="text-align: center;">开始时间</th>
									<th style="text-align: center;">结束时间</th>
									<th style="text-align: center;">查看</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div class="pull-left" style="padding: 10px 0;">
							<form id="product_form" action="">
								<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
									<option>5</option>
									<option selected="selected">10</option>
									<option>15</option>
									<option>20</option>
								</select>&nbsp; <input type="hidden" id="skuCode_from" name="skuCode" />
								<input type="hidden" id="skuName_from" name="skuName" /> <input
									type="hidden" id="proType_from" name="proType" /> <input
									type="hidden" id="cache" name="cache" value="1" />
							</form>
						</div>
						<div id="productPagination"></div>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="operation-list" rows="0" cols="0">
								<!-- 
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX">
											<td align="left">
												<div class="checkbox">
													<label>
														<input type="checkbox" id="logId_{$T.Result.logId}" value="{$T.Result.logId}" >
														<span class="text"></span>
													</label>
												</div>
											</td>
											<input type='hidden' id='operatinInfo_{$T.Result.logId}' value='{$T.Result.operatinInfo}'/>
											<td align="center" id="id_{$T.Result.logId}">{$T.Result.logId}</td>
											<td align="center" id="operationModule_{$T.Result.logId}">{$T.Result.operationModule}</td>
											{#if $T.Result.status==2}
												<td align="center" id="divType_{$T.Result.sid}">正在静态化</td>
											{#elseif $T.Result.status==1}
												<td align="center" id="divType_{$T.Result.sid}">成功</td>
											{#else}
												<td align="center" id="divType_{$T.Result.sid}">失败</td>
											{#/if}
											<td align="center" id="operationName_{$T.Result.logId}">{$T.Result.operationName}</td>
											<td align="center" id="statictime_{$T.Result.logId}">{$T.Result.staticTime}</td>
											<td align="center" id="endtime_{$T.Result.logId}">{$T.Result.endTime}</td>
											{#if $T.Result.status==1}
												<td align="center"><a href="{$T.Result.resultPath}" target="_blank">查看:{$T.Result.resultPath}</a></td>
							       			{#else}
												<td align="center">— —</td>
											{#/if}
							       		</tr>
									{#/for}
							    {#/template MAIN}	 -->
							</textarea>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<html>
<head>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link
	href="${pageContext.request.contextPath}/jsp/edi/css/bootstrap-dialog.min.css"
	rel="stylesheet" type="text/css"/>
<script
	src="${pageContext.request.contextPath}/jsp/edi/js/bootstrap/bootstrap-dialog.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<script
	src="${pageContext.request.contextPath}/jsp/edi/js/jquery/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/jsp/edi/js/util.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


</head>

<script type="text/javascript">

	var userName;
	var logJs;

	__ctxPath = "${pageContext.request.contextPath}";
	
	function getFontCss(treeId, treeNode) {
		return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
	}
	
		
	function zTreeOnClick(e, treeId, treeNode) {
		var _resId = treeNode.id;
		if (treeNode.level == 0) {
			util.msg("这一级不能匹配哦");
			return;
		}
		console.log(treeNode);
		util.clearData($("#settingTable"));
		var _requestData = {
			"id" : _resId
		};
		$.ajax({
			type : "post",
			url : __ctxPath+"/express/queryExpressInfo",
			data : _requestData,
			dataType : "json",
			success : function(resJSON) {
				if (resJSON == null) {
					util.msg("无法识别地区对应！！");
					return;
				}
				userName = resJSON.userName ;
				logJs = resJSON.logJs;
				reloadjs();
				_$paramForm.find("#paramName").val(resJSON.expressName);
				_$paramForm.find("#paramCode").val(resJSON.expressCode);
				_$paramForm.find("#tWfjParamName").val(resJSON.wfjExpressName);
				_$paramForm.find("#tWfjParamName").attr({
					"level" : treeNode.level
				});
				_$paramForm.find("#tWfjParamCode").val(resJSON.wfjExpressCode);
				if (resJSON.status == 1) {
					_$paramForm.find("input[name='stat'][value='1']").attr(
							"checked", true);
				} else {
					_$paramForm.find("input[name='stat'][value='0']").attr(
							"checked", true);
				}
				_$paramForm.find("#p_id").val(resJSON.id);
				/* var url = util.serviceURL
						+ "parameter/queryWFJProperties?type=JUMEI_AREA";
				$.ajax({
					type : "post",
					url : url,
					dataType : "json",
					success : function(roleJSON) {
						_$paramForm.find("#brandList").html(
								_lookbackBrand(roleJSON));
						util.page(_$paramForm.find("#brandList"), url,
								_lookbackBrand, roleJSON, lookbackResult);
					},
					error : function() {
						//util.msg("未找到合适的匹配对象");
					}
				}); */
			}
		});
		_requestData = {
			"parent_ID" : _resId
		};
		_paramFromValidate();
		BootstrapDialog.show({
			title : '修改地区',
			message : _$paramForm,
			type : BootstrapDialog.TYPE_WARNING,
			buttons : [ {
				label : '修改',
				cssClass: 'btn-large btn-success',
				action : function(dialogRef) {
					if (_$paramForm.valid()) {
						_updateParam(dialogRef.close());
					}
				}
			}, {
				label : '关闭',
				cssClass: 'btn-large btn-danger',
				action : function(dialogRef) {
					dialogRef.close();
				}
			} ]
		})

	}
	
	
	var _paramFormInit = function() {
		var _paramForm = [];
		_paramForm.push('<form id="paramForm">');
		_paramForm.push('<table class="table table-bordered">');
		_paramForm.push('<tr>');
		_paramForm
				.push('<td style="vertical-align: middle;text-align: center;">名称</td>');
		_paramForm
				.push('<td><input type="text" style="border-style:none;height:38px;" class="customTex" id="paramName" name="paramName" readOnly><input type="hidden" id="p_id"></td><td style="vertical-align: middle;text-align: center;">编码</td><td><input type="text" style="border-style:none;height:38px;" class="customTex" id="paramCode" name="paramCode" readOnly></td>');
		_paramForm
				.push('<td rowspan="2" style="vertical-align: middle;text-align: center;">状态</td>');
		_paramForm
				.push('<td rowspan="2" style="vertical-align: middle;text-align: right;"><label><input type="radio" name="stat" value="1" checked="checked"><span class="text">启用</span></label>');
		_paramForm
				.push('<br/><label><input type="radio" name="stat" value="0"><span class="text">停用</span></label></td>');
		_paramForm.push('</tr>');
		_paramForm.push('<tr>');
		_paramForm
				.push('<td style="vertical-align: middle;text-align: center;" >王府井参数名称</td>');
		_paramForm
				.push('<td><input type="text" style="border-style:none;height:38px;" id="tWfjParamName" class="customTex">  </td>');
		_paramForm
				.push('<td style="vertical-align: middle;text-align: center;">王府井参数编码</td>');
		_paramForm
				.push('<td style="vertical-align: middle;text-align: center;"><input type="text" style="border-style:none;height:38px;" id="tWfjParamCode" class="customTex"></td>');
		_paramForm.push('</tr>');
		_paramForm.push('</table>');
		_paramForm.push('</form>');
		return $(_paramForm.join(''));
	}

	var _$paramForm = _paramFormInit();

	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	
	
	var _setting = {
		view : {
			selectedMulti : false,
			showLine : true,
			fontCss : getFontCss
		},
		callback : {
			onDblClick : zTreeOnClick
		},
		data : {
			simpleData : {
				idKey : "id",
				pIdKey : "parentId"
			},
			key : {
				name : "name",
				title : "title"
			}
		},
		async : {
			enable : true,
			url : __ctxPath +"/express/queryExpress",
			autoParam : [ "id=parentId" ],
			dataFilter : filter,
			dataType : "json"
		}
	};
	
	
	var topTree = {
		id : "0c078d3f45044b0c86446e0c5cf6ccc8",
		isParent : true,
		name : "阿里快递对应",
		title : "快递"
	}
	
	/* 初始化tree树 */
	$(function() {
		refreshAllZTree();
	});

	function refreshAllZTree() {
		$.fn.zTree.init($("#paramTree"), _setting, topTree);
	}
	
	//修改配置
    
	var _updateParam = function(callback) {
		if (!_$paramForm.valid()) {
			return;
		}
		LA.env = 'dev';
		  LA.sysCode = '44';
		  var sessionId = '<%=request.getSession().getId()%>';
		  LA.log('tmall-express-modify', '阿里快递修改', userName, sessionId);
		var treeObj = $.fn.zTree.getZTreeObj("paramTree");
		var nodes = treeObj.getSelectedNodes();
		var _id = _$paramForm.find("#p_id").val();
		var _paramName = _$paramForm.find("#paramName").val();
		var _paramCode = _$paramForm.find("#paramCode").val();
		var _wfjParamName = _$paramForm.find("#tWfjParamName").val();
		var _wfjParamCode = _$paramForm.find("#tWfjParamCode").val();
		var radio = _$paramForm.find(":radio");
		var _stat = _$paramForm.find("input[name='stat']")[0].checked ? _$paramForm
				.find("input[name='stat']")[0].value
				: _$paramForm.find("input[name='stat']")[1].value;
		var _requestData = {
			"id" : _id,
			"expressName" : _paramName,
			"expressCode" : _paramCode,
			"status" : _stat,
			"wfjExpressCode" : _wfjParamCode,
			"wfjExpressName" : _wfjParamName,
		};

		$.ajax({
			type : "post",
			url : __ctxPath + "/express/updateExpress",
			data : _requestData,
			dataType : "json",
			success : function(json) {
				$("#settingTable").hide();
				//_loadParamTree();

				util.msg(json.msg);
				(callback && typeof (callback) == "function") && callback();
			}
		});
	}
	
	
	var _paramFromValidate = function() {
		_$paramForm = _paramFormInit();
		_$paramForm.validate({
			rules : {
				paramName : {
					required : true,
					maxlength : 25
				},
				paramCode : {
					required : true,
					maxlength : 25
				},
				remark : {
					maxlength : 100
				}
			},
			messages : {
				paramName : {
					required : "请填写参数名称",
					maxlength : "参数名称不得超过25字符"
				},
				paramCode : {
					required : "请填写参数编码",
					maxlength : "参数编码不得超过25字符"
				},
				remark : {
					maxlength : "备注不得超过100字符"
				}
			}
		});
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
</script>
<body>
	
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">天猫快递管理</h5>
								<div class="widget-buttons">
									<a data-toggle="maximize"></a> 
									<a data-toggle="collapse" onclick="tab('pro');"> 
										<i class="fa fa-minus" id="pro-i"></i>
									</a> 
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">

									<div class="table-toolbar"></div>
									<ul id="paramTree" class="ztree"></ul>
								</div>
							</div>
							<div class="table-toolbar">
								<form style="display: none" id="settingTable"></form>
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
</body>
</html>
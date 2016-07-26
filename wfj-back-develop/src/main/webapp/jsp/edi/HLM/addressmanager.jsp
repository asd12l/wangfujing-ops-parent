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
<script src="${pageContext.request.contextPath}/jsp/edi/js/bootstrap/bootstrap.min.js"></script>
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

	__ctxPath = "${pageContext.request.contextPath}";
	
	function getFontCss(treeId, treeNode) {
		return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
	}
	
	var _lookbackBrand = function(brandJSON) {
		var _roleTable = [];
		_roleTable
				.push('<table class="table table-condensed" id="roleTable" attr='+brandJSON+'>');
		_roleTable
				.push('<tr style="margin:5px;font-size:12px;"><td colspan="6"> 省: <input class="keyword" style="width:50px;"  type="text" id="statName"/> 市: <input class="keyword"   style="width:50px;" type="text" id="cityName"/> 县: <input class="keyword"  style="width:50px;"  type="text" id="areaName"/>&nbsp;&nbsp;&nbsp;<input type="button"  id="btnSerach" class="serach" value="搜索"><div id="loading" style="display:none;float:right"><img src="../images/progressBar_s.gif">正在努力搜索中..</div></td></tr>');
		_roleTable
				.push('<tr style="backgroud:silver"><td colspan="2" align="center" >省级</td><td colspan="2"  align="center">市级</td><td colspan="2"  align="center">县级</td></tr>');
		$.each(brandJSON.results, function(index, val) {
			var remark = val.remark == null ? "" : val.remark;
			_roleTable.push('<tr class="listTR">');
			_roleTable.push('<td class="statName" >' + val.statName + '</td>');
			_roleTable.push('<td class="statId" >' + val.statId + '</td>');
			_roleTable.push('<td class="cityName" >' + val.cityName + '</td>');
			_roleTable.push('<td class="cityId" >' + val.cityId + '</td>');
			_roleTable.push('<td class="areaName" >' + val.areaName + '</td>');
			_roleTable.push('<td class="areaId" >' + val.areaId + '</td>');
			_roleTable.push('</tr>');
		});
		_roleTable.push('</table>');
		_roleTable
				.push('<div class="page" ><span><a id="top">[  首页   ]</a><a id="prev">[ 上一页  ]</a></span>  <a>[ '
						+ brandJSON.pageNo
						+ ' ]</a>  <span ><a id="next">[ 下一页  ]</a><a id="last" alt="2">[ 尾页  ]</a></span></div>');
		return $(_roleTable.join(''));
	}
	
	
	function lookbackResult(result) {
		var name, code;
		var level = _$paramForm.find("#tWfjParamName").attr("level");
		if (level == 1) {
			_$paramForm.find("#tWfjParamName").val(
					$(result).find(".statName").html());
			_$paramForm.find("#tWfjParamCode").val(
					$(result).find(".statId").html());
		} else if (level == 2) {
			_$paramForm.find("#tWfjParamName").val(
					$(result).find(".cityName").html());
			_$paramForm.find("#tWfjParamCode").val(
					$(result).find(".cityId").html());
		} else {
			_$paramForm.find("#tWfjParamName").val(
					$(result).find(".areaName").html());
			_$paramForm.find("#tWfjParamCode").val(
					$(result).find(".areaId").html());
		}
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
			url : __ctxPath + "/receiptAddress/queryAddressInfo?channel=CC",
			data : _requestData,
			dataType : "json",
			success : function(resJSON) {
				if (resJSON == null) {
					util.msg("无法识别地区对应！！");
					return;
				}
				_$paramForm.find("#paramName").val(resJSON.addressName);
				_$paramForm.find("#paramCode").val(resJSON.addressCode);
				_$paramForm.find("#tWfjParamName").val(resJSON.wfjAddressName);
				_$paramForm.find("#tWfjParamName").attr({
					"level" : treeNode.level
				});
				_$paramForm.find("#tWfjParamCode").val(resJSON.wfjAddressCode);
				if (resJSON.status == "0") {
					_$paramForm.find("input[name='stat'][value='0']").attr(
							"checked", true);
				} else {
					_$paramForm.find("input[name='stat'][value='1']").attr(
							"checked", true);
				}
				_$paramForm.find("#p_id").val(resJSON.id);
				var url = __ctxPath
						+ "/receiptAddress/queryWFJProperties?type=TMALL_AREA&channel=CC";
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
						util.msg("未找到合适的匹配对象");
					}
				});
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
				cssClass: 'btn-primary',
				action : function(dialogRef) {
					if (_$paramForm.valid()) {
						_updateParam(dialogRef.close());
					}
				}
			}, {
				label : '关闭',
				cssClass: 'btn-warning',
				action : function(dialogRef) {
					dialogRef.close();
				}
			} ]
		})

	}

	//添加配置表单
	var _paramFormInit = function() {
		var _paramForm = [];
		_paramForm.push('<form id="paramForm">');
		_paramForm.push('<table class="table table-bordered">');
		_paramForm.push('<tr>');
		_paramForm
				.push('<td style="vertical-align: middle;text-align: center;">名称</td>');
		_paramForm
				.push('<td><input type="text" style="border-style:none;height:38px;" class="customTex" id="paramName" name="paramName"><input type="hidden" id="p_id"></td><td style="vertical-align: middle;text-align: center;">编码</td><td><input type="text" style="border-style:none;height:38px;" class="customTex" id="paramCode" name="paramCode"></td>');
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
				.push('<td style="vertical-align: middle;text-align: center;"><input type="text" style="border-style:none;height:38px;" id="tWfjParamName" class="customTex">  </td>');
		_paramForm
				.push('<td style="vertical-align: middle;text-align: center;">王府井参数编码</td>');
		_paramForm
				.push('<td style="vertical-align: middle;text-align: center;"><input type="text" style="border-style:none;height:38px;" id="tWfjParamCode" class="customTex"></td>');
		_paramForm.push('</tr>');
		_paramForm.push('<tr>');
		_paramForm
				.push('<td  style="vertical-align: middle;text-align: center;">王府井地区</td>');
		_paramForm.push('<td colspan="5"><div id="brandList"></div></td>');
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
			url : __ctxPath + "/receiptAddress/queryAddress?channel=CC",
			autoParam : [ "id=parentId" ],
			dataFilter : filter,
			dataType : "json"
		}
	};

	var topTree = {
			id:"hlm0",
	   		isParent:true,
	   		name:"好乐买地区对应",
	   		title:"地区"
	};

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
			"addressName" : _paramName,
			"addressCode" : _paramCode,
			"status" : _stat,
			"wfjAddressCode" : _wfjParamCode,
			"wfjAddressName" : _wfjParamName,
		};

		$.ajax({
			type : "post",
			url : __ctxPath + "/receiptAddress/updateAddress?channel=CC",
			data : _requestData,
			dataType : "json",
			success : function(json) {
				$("#settingTable").hide();
				//_loadParamTree();

				util.msg(json.msg);
				(callback && typeof (callback) == "function") && callback();
			}
		});
	};

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

	var topTree1 = {
		id : "00020004",
		isParent : true,
		name : "爱逛街地区对应",
		title : "地区"
	};

	function changeChannel(s) {
		alert(s);
		$.fn.zTree.init($("#paramTree"), _setting, topTree1);
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
								<h5 class="widget-caption">好乐买地址管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
																		
								<div class="table-toolbar">
							    	<!-- <select style="padding: 0 0;" id="channelcode" onchange="changeChannel(this.options[this.options.selectedIndex].value)">
								        <option value="00020004">天猫</option>
								        <option value="CA">爱逛街</option>
								        <option value="CB">全球购</option>
								        <option value="C8">聚美</option>
								        <option value="CC">有赞</option>
							    	</select> -->
							    	<ul id="paramTree" class="ztree"></ul>
								</div>
								</div>
								<!-- <div class="table-toolbar"> -->
							        <form  style="display: none" id="settingTable">
							          
							        </form>
							    <!-- </div> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
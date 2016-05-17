<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 属性属性值修改
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	count = 1;
	$(function() {
		//获取所有渠道
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/channel/findChannel",
			async : false,
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class","loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				/* 获取所有渠道 */
				var option = "";
				for (var i = 0; i < response.length; i++) {
					if (channelSid == response[i].sid) {
						option += "<option value='"+response[i].sid+"' selected='selected'>"
								+ response[i].channelName + "</option>";
					} else {
						option += "<option value='"+response[i].sid+"'>"
								+ response[i].channelName + "</option>";
					}
				}
				$("#channelSid").append(option);
			}
		});
		/* 获取属性类型 */
		var checknote = $("#propnotes").attr('checked')
		var checkmeiju = $("#propmeiju").attr('checked')
		$("#propnotes").click(function() {
			if (checknote == undefined) {
				$("#propadd").fadeOut(1000);
			} else {
				$("#propadd").fadeIn();
			}
		});
		$("#propmeiju").click(function() {
			if (checkmeiju) {
				$("#propadd").fadeIn(1000);
			} else {
				$("#propadd").fadeOut();
			}
		});

		$("#propsName").val(propsName);
		$("#propsDesc").val(propsDesc);
		if (status == "有效") {
			$("#propsStatus_1").attr("checked", "checked");
		} else {
			$("#propsStatus_0").attr("checked", "checked");
		}
		if (isKeyProp == "是") {
			$("#isKeyProp_1").attr("checked", "checked");
		} else {
			$("#isKeyProp_0").attr("checked", "checked");
		}
		if (isErpProp == "是") {
			$("#isErpProp_1").attr("checked", "checked");
		} else {
			$("#erpTypeDiv").hide();
			$("#isErpProp_0").attr("checked", "checked");
		}
		if (erpType == "SAP") {
			$("#erpType_1").attr("checked", "checked");
		} else if (erpType == "门店") {
			$("#erpType_0").attr("checked", "checked");
		} else {

		}
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/valuesbox/list",
					dataType : "json",
					data : {
						"sid" : value
					},
					success : function(response) {
						var result = response;
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							var option = "<tr id='checkID_"
									+ count
									+ "' onchange='changeTr("
									+ count
									+ ")' name='oldTr'><td><div class='checkbox' style='padding: 0;'><label>"
									+ "<input type='checkbox' name='checkTd' value='"+count+"' /><span class='text' style='margin: 3px 0 3px -2px;'></span></label></div></td>"
									+ "<td style='display:none'><input type='text' name='valuesSid' value='"+ele.valuesSid+"' /></td>"
									+ "<td style='display:none'><input type='text' name='sid' value='"+ele.sid+"' /></td>"
									+ "<td align='center'><input tpye='text' name='valuesName' value='"+ele.valuesName+"' /></td>"
									+ "<td align='center'><input tpye='text' name='valuesDesc' value='"+ele.valuesDesc+"' /></td>";

							$("#editTable").append(option);
							count += 1;
						}
						return;
					}
				});
		$("#save").click(function() {
			saveFrom();
		});
		$("#close").click(
				function() {
					$("#pageBody").load(
							__ctxPath + "/jsp/Propsdict/PropsdictView.jsp");
				});
		$('#theForm').bootstrapValidator();
	});
	function changeTr(data) {
		$("#checkID_" + data).attr("name", "updateTr");
	}
	function appendTR() {
		var option = "<tr id='checkID_"+count+"' name='insertTr'><td><div class='checkbox' style='padding: 0;'><label>"
				+ "<input type='checkbox' name='checkTd' value='"+count+"' /><span class='text' style='margin: 3px 0 3px -2px;'></span></label></div></td>"
				+ "<td align='center'><input type='text' name='valuesName' /></td>"
				+ "<td align='center'><input type='text' name='valuesDesc' /></td>"
				+ "</tr>";
		$("#editTable").append(option);
		count += 1;
	}
	function delTR() {
		$("input[name='checkTd']:checked").each(function() {
			var i = $(this).val();
			if (i != '') {
				var name = $("#checkID_" + i).attr("name");
				if (name == "insertTr") {
					$("#checkID_" + i).remove();
				} else {
					$("#checkID_" + i).attr("style", "display:none");
					$("#checkID_" + i).attr("name", "deleteTr");
					$("#check_" + i).val(0);
				}
			} else {
				alert("未选中要删除的属性值列");
				return false;
			}
		});
	}
	function checkMis(data) {
		if ($(".check_" + data).val() == 0) {
			$(".check_" + data).val(1);
		} else {
			$(".check_" + data).val(0);
		}
	}
	function isErpPropClick() {
		var click = $("input[name='isErpProp']:checked").val();
		if (click == 1) {
			// 选中
			$("#erpTypeDiv").show();
		} else {
			// 未选择
			$("#erpTypeDiv").hide();
		}
	}
	//保存数据
	function saveFrom() {

		var propsName = $("#propsName").val();
		if (propsName == null || propsName == "") {
			$("#warning2Body").text("请填写属性名称!");
			$("#warning2").show();
			return;
		}
		if($("#propsName").val().trim().length>20){
			$("#warning2Body").text("属性名称不能大于20个字符!");
			$("#warning2").show();
			return;
		}
		if($("#propsDesc").val().trim().length>500){
			$("#warning2Body").text("属性描述不能大于500个字符!");
			$("#warning2").show();
			return;
		}
		var flag = false;
		var flag3 = false;
		var couFlag=false;
		$("input[name='valuesName']").each(function(i, team) {
			var name=$(this).val();
			var cou=0;
			$("input[name='valuesName']").each(function(l, team2) {
				if(name==$(this).val()){
					cou++;
				}
			});
			if(cou>1){
				couFlag=true;
			}
			
			var tr = $(team.parentNode.parentNode);
			if (tr.css("display") != "none" && team.value.trim() == "") {
				flag = true;
			}
			
			if($(this).val().trim().length>100){
				flag3 = true;
			}
		});
		if (flag) {
			$("#warning2Body").text("属性值名称不能为空!");
			$("#warning2").show();
			return;
		}
		if (flag3) {
			$("#warning2Body").text("属性值名称不能大于100个字符!");
			$("#warning2").show();
			return;
		}
		if(couFlag){
			$("#warning2Body").text("属性值名称不能重复!");
			$("#warning2").show();
			return;
		}
		var json1 = '';
		var json2 = '';
		var json3 = '';
		insertLength = $("tr[name='insertTr']").length;//点击加号新增数据TR长度
		updateLength = $("tr[name='updateTr']").length;//修改数据TR长度
		deleteLength = $("tr[name='deleteTr']").length;//删除数据TR长度
		var propsStatus = $("input[name='status']:checked").val();

		if (insertLength != 0) { //新增TR数据
			json1 = insertData();
		}

		if (updateLength >= 0) {//修改TR数据
			json2 = updateDate();
		}
		if (deleteLength != 0) {//删除TR数据
			json3 = deleteDate();
		}
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/propsdict/add",
			dataType : "json",
			data : {
				"sid" : value,
				"propsName" : $("#propsName").val().trim(),
				"propsDesc" : $("#propsDesc").val().trim(),
				"isKeyProp" : $("input[name='isKeyProp']:checked").val(),
				"isErpProp" : $("input[name='isErpProp']:checked").val(),
				"erpType" : $("input[name='erpType']:checked").val(),
				"status" : propsStatus,
				"channelSid" : $("#channelSid").val(),
				"insert1" : json1,
				"update1" : json2,
				"delete1" : json3
			},
			success : function(response) {
				if (response.success == "true") {
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>修改成功，返回列表页!</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
				} else {
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					$("#warning2").show();
				}
				return;
			}
		});
	}
	//新增数据=insert1
	function insertData() {
		var insert1 = "";
		var data = new Array();
		var valuesName = new Array();
		var valuesDesc = new Array();
		var statuss = new Array;
		$("tr[name='insertTr']").each(function() {
			$("input[name='valuesName']", this).each(function(i, team) {
				valuesName.push($(this).val());
			});
			$("input[name='valuesDesc']", this).each(function(i, team) {
				valuesDesc.push($(this).val());
			});
			$("input[name='valuesStatus']", this).each(function(i, team) {
				statuss.push($(this).val());
			});
		});
		for (var i = 0; i < insertLength; i++) {
			statuss[i] = 1;
			data.push({
				'valuesName' : valuesName[i],
				'valuesDesc' : valuesDesc[i],
				'status' : statuss[i]
			});
		}
		insert1 = JSON.stringify(data);
		insert1 = insert1.replace(/\%/g, "%25");
		insert1 = insert1.replace(/\#/g, "%23");
		insert1 = insert1.replace(/\&/g, "%26");
		insert1 = insert1.replace(/\+/g, "%2B");
		return insert1;
	}
	//修改数据=update1
	function updateDate() {

		var update1 = "";
		var data = new Array();
		var valuesSid = new Array();
		var sid = new Array();
		var valuesName = new Array();
		var valuesDesc = new Array();
		var statuss = new Array;
		$("tr[name='updateTr']").each(function() {
			$("input[name='valuesSid']", this).each(function(i, team) {
				valuesSid.push($(this).val());
			});
			$("input[name='sid']", this).each(function(i, team) {
				sid.push($(this).val());
			});
			$("input[name='valuesName']", this).each(function(i, team) {
				valuesName.push($(this).val());
			});
			$("input[name='valuesDesc']", this).each(function(i, team) {
				valuesDesc.push($(this).val());
			});
			$("input[name='valuesStatus']", this).each(function(i, team) {
				statuss.push($(this).val());
			});
		});

		for (var i = 0; i < updateLength; i++) {
			data.push({
				'valuesSid' : valuesSid[i],
				'sid' : sid[i],
				'valuesName' : valuesName[i],
				'valuesDesc' : valuesDesc[i],
				'status' : statuss[i]
			});
		}
		update1 = JSON.stringify(data);
		update1 = update1.replace(/\%/g, "%25");
		update1 = update1.replace(/\#/g, "%23");
		update1 = update1.replace(/\&/g, "%26");
		update1 = update1.replace(/\+/g, "%2B");
		return update1;
	}
	//删除数据=delete1
	function deleteDate() {
		var delete1 = "";
		var data = new Array();
		var valuesSid = new Array();
		var sid = new Array();
		var valuesName = new Array();
		var valuesDesc = new Array();
		var statuss = new Array;
		$("tr[name='deleteTr']").each(function() {
			$("input[name='valuesSid']", this).each(function(i, team) {
				valuesSid.push($(this).val());
			});
			$("input[name='sid']", this).each(function(i, team) {
				sid.push($(this).val());
			});
			$("input[name='valuesName']", this).each(function(i, team) {
				valuesName.push($(this).val());
			});
			$("input[name='valuesDesc']", this).each(function(i, team) {
				valuesDesc.push($(this).val());
			});
			$("input[name='valuesStatus']", this).each(function(i, team) {
				statuss.push($(this).val());
			});
		});
		for (var i = 0; i < deleteLength; i++) {
			data.push({
				'valuesSid' : valuesSid[i],
				'sid' : sid[i],
				'valuesName' : valuesName[i],
				'valuesDesc' : valuesDesc[i],
				'status' : statuss[i]
			});
		}
		delete1 = JSON.stringify(data);
		delete1 = delete1.replace(/\%/g, "%25");
		delete1 = delete1.replace(/\#/g, "%23");
		delete1 = delete1.replace(/\&/g, "%26");
		delete1 = delete1.replace(/\+/g, "%2B");
		return delete1;
	}
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/Propsdict/PropsdictView.jsp");
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
								<span class="widget-caption">修改属性字典</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<div class="form-group">
										<label class="col-lg-4 control-label">属性名称：</label>
										<div class="col-lg-5">
											<input type="text" class="form-control" id="propsName"
												name="propsName" placeholder="必填" data-bv-notempty="true"
												data-bv-notempty-message="属性名称不能为空!" maxlength="20" />
										</div>
									</div>

									<div class="form-group">
										<label class="col-lg-4 control-label">渠道：</label>
										<div class="col-lg-5">
											<select id="channelSid" name="channelSid"
												class="form-control">
												<option value="">全渠道&nbsp;&nbsp;</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">是否关键属性：</label>
										<div class="col-lg-5">
											<div class="radio">
												<label> <input class="basic" type="radio"
													id="isKeyProp_1" name="isKeyProp" value="1"> <span
													class="text">是</span>
												</label> <label> <input class="basic" type="radio"
													id="isKeyProp_0" name="isKeyProp" value="0"> <span
													class="text">否</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label> <input class="inverted" type="radio"
													name="isKeyProp"> <span class="text"></span>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">是否erp属性：</label>
										<div class="col-lg-5">
											<div class="radio" onclick="isErpPropClick();">
												<label> <input class="basic" type="radio"
													id="isErpProp_1" name="isErpProp" value="1"> <span
													class="text">是</span>
												</label> <label> <input class="basic" type="radio"
													id="isErpProp_0" name="isErpProp" value="0"> <span
													class="text">否</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label> <input class="inverted" type="radio"
													name="isErpProp"> <span class="text"></span>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group" id="erpTypeDiv">
										<label class="col-lg-4 control-label">ERP类型：</label>
										<div class="col-lg-5">
											<div class="radio">
												<label> <input class="basic" type="radio"
													id="erpType_1" name="erpType" value="1"> <span
													class="text">SAP ERP</span>
												</label> <label> <input class="basic" type="radio"
													id="erpType_0" name="erpType" value="0"> <span
													class="text">门店 ERP</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label> <input class="inverted" type="radio"
													name="erpType"> <span class="text"></span>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">属性状态：</label>
										<div class="col-lg-5">
											<div class="radio">
												<label> <input class="basic" type="radio"
													id="propsStatus_1" name="status" value="1"> <span
													class="text">有效</span>
												</label> <label> <input class="basic" type="radio"
													id="propsStatus_0" name="status" value="0"> <span
													class="text">无效</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label> <input class="inverted" type="radio"
													name="status"> <span class="text"></span>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">属性描述：</label>
										<div class="col-lg-5">
											<textarea cols="3" rows="5" class="form-control"
												id="propsDesc" name="propsDesc" style="resize:none;"></textarea>
										</div>
									</div>
									<div id="propadd"
										style="width: 60%; margin-left: auto; margin-right: auto;">
										<div class="widget-header ">
											<span class="widget-caption">属性值添加</span>
											<div class="widget-buttons">
												<a href="#" data-toggle="maximize"></a> <a
													data-toggle="dispose"
													style="color: green; cursor: pointer;"> <span
													class="fa fa-plus" onclick="appendTR();">新增</span>
												</a> <a data-toggle="collapse"
													style="color: red; cursor: pointer;"> <span
													class="fa fa-trash-o" onclick="delTR()">删除</span>
												</a>
											</div>
										</div>
										<table id="editTable"
											class="table table-bordered table-striped table-condensed table-hover flip-content">
											<thead class="flip-content bordered-darkorange">
												<tr>
													<th width="10%" style="text-align: center;">选择</th>
													<th style="text-align: center;">属性值名称</th>
													<th style="text-align: center;">属性值描述</th>
												</tr>
											</thead>
										</table>
									</div>
									<p></p>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												type="button" value="保存" />&emsp;&emsp; <input
												class="btn btn-danger" style="width: 25%;" id="close"
												type="button" value="取消" />
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
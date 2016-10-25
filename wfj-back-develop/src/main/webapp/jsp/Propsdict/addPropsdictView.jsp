<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 属性属性值添加
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	count = 1;
	$(function() {
		//获取所有渠道
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/stock/queryChannelListAddPermission",
			async:false,
			dataType: "json",
			ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
			success:function(response) {
				/* 获取所有渠道 */
				var result = response.list;
				var option = "";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.sid+"'>" + ele.channelName + "</option>";
				}
				$("#channelSid").append(option);
			}
		});
		$("#save").click(function() {
			saveFrom();
		});
		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/Propsdict/PropsdictView.jsp");
		});

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
		$("#erpTypeDiv").hide();

	});
	function appendTR() {
		var option = "<tr id='checkID_"+count+"' class='gradeX'>"
				+ "<td align='left'><div class='checkbox' style='margin-bottom: 0;margin-top: 0;padding-left: 3px;'>"
				+ "<label style='padding-left:9px;'>"
				+ "<input type='checkbox' value='"+count+"' />"
				+ "<span class='text' style='margin:-9px 0 5px 6px ;'></span>"
				+ "</label></div></td>"
				+ "<td align='center'><input type='text' id='valuename' name='valuesName'/></td>"
				+ "<td align='center'><input type='text' name='valuesDesc' /></td>"
				+ "</tr>";
		$("#table").append(option);
		count += 1;
		$("#delTR").css("display","block");
	}
	function delTR() {
		var checkboxArray = [];
		if ($("input[type='checkbox']:checked").length == 0) {
			$("#warning2Body").text("请选择要删除的属性值");
			$("#warning2").show();
		}
		$("input[type='checkbox']:checked").each(function(i, team) {
			var i = $(this).val();
			$("#checkID_" + i).remove();
		});
		if ($("input[type='checkbox']").length == 0) {
			$("#delTR").css("display","none");
		}
	}
	function checkMis(data) {
		if ($(".check_" + data).val() == 0) {
			$(".check_" + data).val(1);
		} else {
			$(".check_" + data).val(0);
		}
	}
	function isErpPropClick(){
		var click = $("input[name='isErpProp']:checked").val();
		if(click==1){
			// 选中
			$("#erpTypeDiv").show();
		}else{
			// 未选择
			$("#erpTypeDiv").hide();
		}
	}
	//保存数据
	function saveFrom() {
		
		var propsName=$("#propsName").val();
		if(propsName==null||propsName==""){
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
		var insert1 = "";
		var data = new Array();
		var valuesName = new Array();
		var valuesDesc = new Array();
		var statuss = new Array;
		
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
			valuesName.push($(this).val());
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
		$("input[name='valuesDesc']").each(function(i, team) {
			if($(this).val().trim().length>500){
				$("#warning2Body").text("属性值描述大于500个字符!");
				$("#warning2").show();
				return;
			}
			valuesDesc.push($(this).val());
		});
		$("input[type='checkbox']:checked").each(function(i, team) {
			var i = $(this).val();
			statuss.push(i);
		});
		var length = $("#table tr:gt(0)").length;
		$("#table tr:gt(0)").each(function(i) {
			data.push({
				'valuesName' : valuesName[i],
				'valuesDesc' : valuesDesc[i],
				'status' : statuss[i]
			});
		});
		insert1 = JSON.stringify(data);
		insert1 = insert1.replace(/\%/g, "%25");
		insert1 = insert1.replace(/\#/g, "%23");
		insert1 = insert1.replace(/\&/g, "%26");
		insert1 = insert1.replace(/\+/g, "%2B");

        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('propsdict.add', '添加属性字典：', getCookieValue("username"),  sessionId);

		$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/propsdict/add",
					dataType : "json",
					data : {
						"channelSid":$("#channelSid").val(),
						"propsName" : $("#propsName").val().trim(),
						"propsDesc" : $("#propsDesc").val().trim(),
						"isKeyProp" : $("input[name='isKeyProp']:checked")
								.val(),
						"isErpProp" : $("input[name='isErpProp']:checked")
								.val(),
						"erpType" : $("input[name='erpType']:checked").val(),
						"status" : $("input[name='status']:checked").val(),
						/* "isEnumProp":$("input[name='isEnumProp']:checked").val(), */
						"insert1" : insert1
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>添加成功，返回列表页!</strong></div>");
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
								<span class="widget-caption">添加属性字典</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<div class="form-group">
										<label class="col-lg-4 control-label">属性名称：</label>
										<div class="col-lg-5">
											<input type="text" class="form-control" id="propsName"
												name="propsName" placeholder="必填" maxlength="20" />
										</div>
									</div>
								
									<div class="form-group">
										<label class="col-lg-4 control-label">渠道：</label>
										<div class="col-lg-5">
											<select id="channelSid" name="channelSid" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">是否关键属性：</label>
										<div class="col-lg-5">
											<div class="radio">
												<label> <input class="basic" type="radio"
													id="propIsKeyProp" name="isKeyProp" checked="checked" value="1"> <span
													class="text">是</span>
												</label> <label> <input class="basic" type="radio"
													id="propIsKeyProp" name="isKeyProp" value="0"> <span
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
													name="isErpProp" value="1"> <span
													class="text">是</span>
												</label> <label> <input class="basic" type="radio"
													name="isErpProp" checked="checked" value="0"> <span
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
													name="erpType" checked="checked" value="1"> <span
													class="text">SAP ERP</span>
												</label> <label> <input class="basic" type="radio"
													name="erpType" value="0"> <span
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
												<label> 
													<input class="basic" type="radio" id="propsStatus" checked="checked" name="status" value="1">
													<span class="text">有效</span>
												</label> 
												<label> 
													<input class="basic" type="radio" id="propsStatus" name="status" value="0"> 
													<span class="text">无效</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label> 
													<input class="inverted" type="radio" name="status"> 
													<span class="text"></span>
												</label>
											</div>
										</div>
									</div>
							    	<div class="form-group">
										<label class="col-lg-4 control-label">属性描述：</label>
										<div class="col-lg-5">
											<textarea cols="3" rows="5" class="form-control" id="propsDesc"
												name="propsDesc" style="resize:none;"></textarea>
										</div>
									</div>

									<div id="propadd"
										style="width: 60%; margin-left: auto; margin-right: auto;">
										<div class="widget-header ">
											<span class="widget-caption">属性值添加</span>
											<div class="widget-buttons">
												<a href="#" data-toggle="maximize"></a> 
												<a data-toggle="dispose" style="color: green;cursor: pointer;"> 
													<span class="fa fa-plus"
													onclick="appendTR();">新增</span>
												</a> 
												<a href="#" data-toggle="collapse" style="color: red;cursor: pointer"> 
													<span id="delTR" class="fa fa-trash-o" onclick="delTR()" style="display: none">删除</span>
												</a>
											</div>
										</div>
										<table id="table" class="table table-bordered table-striped table-condensed table-hover flip-content">
											<thead class="flip-content bordered-darkorange">
												<tr>
													<th width="10%" style="text-align: center;">选择</th>
													<th width="49%" style="text-align: center;">属性值名称</th>
													<th width="49%" style="text-align: center;">属性值描述</th>
												</tr>
											</thead>
										</table>
									</div>
									<p></p>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp; 
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消" />
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
</body>
</html>
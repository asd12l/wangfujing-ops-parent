<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/selectAjax.css" />
<script src="${ctx}/assets/js/select2/select2.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script	src="${pageContext.request.contextPath}/assets/js/select2/selectSupplier.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	$(function() {

		var r = document.getElementsByName("isShippingPoint");
		var s = document.getElementById("shoppeShippingPoint");
		r[0].onclick = function() {
			s.disabled = !this.checked;
		};
		r[1].onclick = function() {
			$("#shoppeShippingPoint").val("");
			s.disabled = this.checked;
		};

		$("#shopSid").select2();
//        $("#supplySid").select2();
        //查询门店
        $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/shoppe/queryShopListAddPermission",
			dataType : "json",
			async : false,
			data : "organizationType=3",
			success : function(response) {
				if(response.success == "true"){
					var result = response.list;
					var shopSid = $("#shopSid");
					shopSid.html("<option value=''>请选择</option>");
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "' groupSid='" + ele.groupSid
								+ "' organizationCode='" + ele.organizationCode
								+ "' onclick=classifyTwo(" + ele.sid + ",'" + ele.organizationCode
								+ "')>" + ele.organizationName + "</option>");
						option.appendTo(shopSid);
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
		$("#shopSid").change(function(){
			classifyTwo($("#shopSid").val(), $("#shopSid option:selected").attr("organizationCode"));
		});

		$('#theForm').bootstrapValidator({
			message : '无效的值！',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
				var shopSid = $("#shopSid").val();
				if (shopSid == "") {
					$("#warning2Body").text("请选择门店!");
					$("#warning2").show();
					return;
				}

                var floorSid = $("#floorSid").val();
                if (floorSid == "") {
                    $("#warning2Body").text("请选择楼层!");
                    $("#warning2").show();
                    return;
                }

				var supplySid = $("#supplySid").val();
				if(supplySid == ""){
					$("#warning2Body").text("请选择供应商!");
					$("#warning2").show();
					return;
				}

                var shoppeType = $("#shoppeType").val();
                if(shoppeType == '02'){
                    $("#isShippingPoint2").prop("checked","checked");
                    $("#negativeStock").val("1");
                }

				$("#channelCode").val(addChannelCode());

				//给所属集团sid赋值
				$("#groupSid").val($("#shopSid option:selected").attr("groupSid"));

                LA.sysCode = '10';
                var sessionId = '<%=request.getSession().getId() %>';
                LA.log('shoppe.saveShoppe', '添加专柜：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class","loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container").addClass("loading-inactive");
						}, 300);
					},
					url : __ctxPath + "/shoppe/saveShoppe",
					data : $("#theForm").serialize(),
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
							$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
						} else if (response.data.errorMsg != "") {
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					        $("#warning2").show();
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
			},
			fields : {
				shoppeName : {
					validators : {
						notEmpty : {
							message : '专柜名称不能为空'
						}
//						regexp : {
//							regexp : /^[A-Za-z0-9\u4E00-\u9FA5\u3000-\u303F\uFF00-\uFFEF\(\)\.\?\-\_\'\:\;\,\/\[\]\\\{\}]{1,20}$/,
//							message : '专柜名称必须是由1到20位的数字、字母、中文或者特殊字符组成'
//						}
					}
				}
			}

		}).find('button[data-toggle]').on('click',function() {
			var $target = $($(this).attr('data-toggle'));
			$target.toggle();
			if (!$target.is(':visible')) {
				$('#theForm').data('bootstrapValidator').disableSubmitButtons(false);
			}
		});

		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/organization/shoppeView.jsp");
		});
	});

	//专柜类型 改变事件
	$("#shoppeType").change(function() {
		if ($(this).val() == '01') {
			$("#shoppeShippingPoint_div").show();
			$("#negativeStock_div").show();
			$("#isShippingPoint_div").show();
            $("#channelDiv").show();
		} else {
			$("#shoppeShippingPoint_div").hide();
			$("#negativeStock_div").hide();
			$("#isShippingPoint_div").hide();
            $("#channelDiv").hide();
		}
	});

	//触发查询
	function classifyTwo(sid, organizationCode) {
		//查询楼层
		var floorSid = $("#floorSid");
		floorSid.html("<option value=''>请选择</option>");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/shoppe/queryFloorList",
			dataType : "json",
			async : false,
			data : "shopSid=" + sid,
			success : function(response) {
				var result = response.list;
				if(typeof(result) != "undefined"){
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>"
								+ ele.floorName + "</option>");
						option.appendTo(floorSid);
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
		//拆单标识（如果门店是电商，则需要传这个参数，过滤供应商）
		var apartOrder = "";
		if(organizationCode == "D001"){
			apartOrder = "1";
            //对业态做限制
//            $("#industryConditionSid_zero").attr("disabled","disabeld");
//            $("#industryConditionSid_one").attr("disabled","disabeld");
//            $("#industryConditionSid_two").removeAttr("disabled");
		}
//        else{
//            //对业态做限制
//            $("#industryConditionSid_zero").removeAttr("disabled");
//            $("#industryConditionSid_one").removeAttr("disabled");
//            $("#industryConditionSid_two").attr("disabled","disabeld");
//        }
		//查询供应商
//		var supplySid = $("#supplySid");
//		supplySid.html("<option value=''>请选择</option>");
//		$.ajax({
//			type : "post",
//			contentType : "application/x-www-form-urlencoded;charset=utf-8",
//			url : __ctxPath + "/supplierDisplay/findListSupplier",
//			dataType : "json",
//			async : false,
//			data : "shopCode=" + organizationCode + "&apartOrder=" + apartOrder,
//			success : function(response) {
//				var result = response.list;
//				if(typeof(result) != "undefined"){
//					for (var i = 0; i < result.length; i++) {
//						var ele = result[i];
//						var option = $("<option organizationCode='" + organizationCode + "' businessPattern='"
//                                + ele.businessPattern + "' value='" + ele.sid + "'>"
//								+ ele.supplyName + "</option>");
//						option.appendTo(supplySid);
//					}
//				}
//				return;
//			},
//			error : function(XMLHttpRequest, textStatus) {
//				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
//				if(sstatus != "sessionOut"){
//					$("#warning2Body").text(buildErrorMessage("","系统出错！"));
//			        $("#warning2").show();
//			        }
//				if(sstatus=="sessionOut"){
//	            	 $("#warning3").css('display','block');
//	             }
//			}
//		});

        $("#supplySid_input").keyup(function(event){
            var code = event.keyCode;
            if(code == 9 || code == 13 || code == 16 || code == 17 || code == 18 || code == 35 || code == 37
               || code == 38 || code == 39 || code == 40 || code == 91){
                return;
            }
            searchSupplier($("#shopSid option:selected").attr("organizationCode").trim(), $("#supplySid_input").val());
        });

		//查询集货地点
		var shoppeShippingPoint = $("#shoppeShippingPoint");
		shoppeShippingPoint.html("<option value=''>请选择</option>");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/shoppe/queryShoppeShippingPoint",
			dataType : "json",
			async : false,
			data : "storeCode=" + organizationCode,
			success : function(response) {
				var result = response.list;
				if(typeof(result) != "undefined"){
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option  value='" + ele.warehouse_id + "'>"
								+ ele.warehouse_name + "</option>");
						option.appendTo(shoppeShippingPoint);
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

	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true",	"class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/organization/shoppeView.jsp");
	}

	$(function() {
		var channels = $("#channel");
		$("#channelTable tbody").html("<tr>"
								+ "<td><div><label style='padding-left: 5px;'>"
								+ "<input type='checkbox' name='channelCheckboxCode' value='0' disabled='disabled'>"
								+ "<span class='text'></span>"
								+ "</label></div></td>"
								+ "<td align='center'>全渠道</td>" + "</tr>");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/channelDisplay/queryAllChannelDisplays",
			data : {
				"channelStatus" : "0"
			},
			dataType : "json",
			success : function(response) {
                if(response.success == "true") {
                    var result = response.list;
                    for (var i = 0; i < result.length; i++) {
                        var ele = result[i];
                        var option = $("<option id='channelOption_" + ele.channelCode + "' value='" + ele.channelCode + "'>"
                                + ele.channelName + "</option>");
                        option.appendTo(channels);
                    }
                }
				return;
			}
	  });
	});

	function addChannel() {
		var channelCode = $("#channel").val();
		var mark = true;
		$("input[name='channelCheckboxCode']").each(function(i) {
			if (channelCode == $(this).val()) {
				mark = false;
			}
		});
		if (!mark) {
			$("#warning2Body").text(buildErrorMessage("","添加渠道不能相同！"));
	        $("#warning2").show();
			return;
		}
		var channelName = $("#channel").find("option:selected").html().trim();
		var option = "<tr id='channelTableTr_"+ channelCode +"'>"
				+ "<td><div><label style='padding-left: 5px;'>"
				+ "<input type='checkbox' name='channelCheckboxCode' value='" + channelCode + "'>"
				+ "<span class='text'></span>" + "</label></div></td>"
				+ "<td align='center' name='channelName'>" + channelName
				+ "</td>" + "</tr>";
		$("#channelTable tbody").append(option);
		$("#channelOption_" + channelCode).hide();
		return;
	}
	function deleteChannel() {
		$("input[type='checkbox']:checked").each(function() {
			$("#channelTableTr_" + $(this).val()).remove();
			$("#channelOption_" + $(this).val()).show();
		});
		return;
	}

	function addChannelCode() {
		var inT = "";
		$("input[name='channelCheckboxCode']").each(function(i) {
			inT += $(this).val() + ",";
		});
		return inT;
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
								<span class="widget-caption">添加专柜</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" id="channelCode" name="channelCode" /> <input
										type="hidden" name="groupSid" id="groupSid" value="" /> <input
										type="hidden" name="userName" value="" /> <input
										type="hidden" name="createName" value="" />
										<script type="text/javascript">
											$("input[name='userName']").val(getCookieValue("username"));
											$("input[name='createName']").val(getCookieValue("username"));
										</script>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">
												门店：<font style="color: red;">*(必填)</font>
											</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<select style="width: 100%;" id="shopSid" name="shopSid">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">
                                                楼层：<font style="color: red;">*(必填)</font>
                                            </label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<select class="form-control" id="floorSid" name="floorSid">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">专柜名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<input maxlength="20" type="text" class="form-control"
													id="shoppeName" name="shoppeName" placeholder="必填"
													 />
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">
												业态：<font style="color: red;">*(必填)</font>
											</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<select class="form-control" id="industryConditionSid"
													name="industryConditionSid" data-bv-field="country">
													<option id="industryConditionSid_zero" value="0" selected="selected">百货</option>
													<option id="industryConditionSid_one" value="1">超市</option>
													<option id="industryConditionSid_two" value="2">电商</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">
												供应商：<font style="color: red;">*(必填)</font>
											</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<%--<select style="width: 100%;" id="supplySid" name="supplySid">
													<option value="">请选择</option>
												</select>--%>
                                                <select id="supplySid" name="supplySid" style="width: 100%;display: none;">
                                                    <option value="" sid="">请选择</option>
                                                </select>
                                                <input id="supplySid_input" class="_input" type="text"
                                                       value="" placeholder="请输入供应商名称或编码">
                                                <div id="dataList_hidden" class="_hiddenDiv" style="width:91%;">
                                                    <ul></ul>
                                                </div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">
												专柜状态：<font style="color: red;">*(必填)</font>
											</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<select class="form-control" id="shoppeStatus"
													name="shoppeStatus">
													<option value="1" selected="selected">正常</option>
													<option value="2">停用</option>
													<option value="3">撤销</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">
												专柜类型：<font style="color: red;">*(必填)</font>
											</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<select class="form-control" id="shoppeType"
													name="shoppeType" data-bv-field="country">
													<option value="01" selected="selected">全渠道单品专柜</option>
													<option value="02">非全渠道单品专柜</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group" id="isShippingPoint_div">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">是否有集货地点：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<div class="radio">
													<label>
                                                        <input class="basic" type="radio" checked="checked" id="isShippingPoint1" name="isShippingPoint" value="0">
														<span class="text">是</span>
													</label>
                                                    <label>
                                                        <input class="basic" type="radio" id="isShippingPoint2" name="isShippingPoint" value="1">
                                                        <span class="text">否</span>
													</label>
												</div>
												<div class="radio" style="display: none;">
													<label>
                                                        <input class="inverted" type="radio" name="isShippingPoint">
                                                        <span class="text"></span>
													</label>
												</div>
											</div>
										</div>
									</div>
									<div class="form-group" id="shoppeShippingPoint_div">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">集货地点：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<select class="form-control" id="shoppeShippingPoint" name="shoppeShippingPoint">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group" id="negativeStock_div">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">是否负库存销售：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<select class="form-control" id="negativeStock"
													name="negativeStock">
													<option value="0" selected="selected">允许</option>
													<option value="1">不允许</option>
												</select>
											</div>
										</div>
									</div>

                                    <div id="channelDiv">
                                        <div class="col-md-10" style="width: 500px; margin: 0 220px;">
                                            <h5>
                                                <strong>添加渠道</strong>
                                            </h5>
                                            <hr class="wide" style="margin-top: 0;">
                                            <div class="col-md-3" style="width: 260px;">
                                                <label class="col-md-4 control-label">渠道：</label>
                                                <div class="col-md-8">
                                                    <select class="form-control" id="channel">
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="col-md-4 buttons-preview"
                                                    style="width: 170px; margin: 0;">
                                                    <a class="btn btn-default" id="addSku"
                                                        onclick="addChannel();">添加</a>&nbsp; <a
                                                        class="btn btn-danger" id="deleteSku"
                                                        onclick="deleteChannel();">删除</a>
                                                </div>
                                                &nbsp;
                                            </div>
                                        </div>
                                        <div class="col-md-12"
                                            style="width: 500px; margin: 0 220px; padding-left: 0">
                                            <div class="col-md-12" id="baseDivTable">
                                                <table id="channelTable"
                                                    class="table table-bordered table-striped table-condensed table-hover flip-content">
                                                    <thead class="flip-content bordered-darkorange">
                                                        <tr>
                                                            <th width="50px;"></th>
                                                            <th style="text-align: center;" id="">渠道</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>

                                                    </tbody>
                                                </table>
                                            </div>
                                            &nbsp;
                                        </div>
                                    </div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save"
												type="submit">保存</button>
											&emsp;&emsp; <input class="btn btn-danger"
												style="width: 25%;" id="close" type="button" value="取消" />
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
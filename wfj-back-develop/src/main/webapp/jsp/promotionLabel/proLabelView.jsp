<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<style type="text/css">
   .tags-child{
    background-color: #CC324C;
    border-radius: 2px;
    color: #fff;
    display: inline-block;
    font-size: 13px;
    margin: 5px;
    padding: 2px 20px 2px 4px;
    position: relative;
    vertical-align: top;
    box-sizing: border-box;
    text-decoration: none;
    font-family:sans-serif;
   }
   #tags-childs{
     display: inline;
     box-sizing: border-box;
     text-decoration: none;
   }
   .tags-childs-remove{
    border-radius: 0 2px 2px 0;
    bottom: 0;
    color: #fff;
    cursor: pointer;
    display: inline-block;
    font-family: simsun;
    font-size: 12px;
    font-weight: bold;
    line-height: 10px;
    margin: 0 0 0 5px;
    padding: 6px 2px 4px;
    position: absolute;
    right: 0;
    top: 0;
    vertical-align: top;
    box-sizing: border-box;
    text-decoration: none;
   }
</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<link
	href="${pageContext.request.contextPath}/js/bootstrap/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.min.js"
	charset="UTF-8"></script>
<script
	src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript">
	function buildErrorMessage(errorCode,errorMsg){
		if(errorCode!=null && errorCode!=""){
			return errorMsg+"("+errorCode+")";	
		}
		if(errorMsg!=null && errorMsg!=""){
			return errorMsg
		}			
	}
	</script>
<script type="text/javascript">
	//__ctxPath = "${pageContext.request.contextPath}";

	var labelPagination;

	$(function() {

		initProLabel();

		$('.form_time').datetimepicker({
			format : 'yyyy-mm-dd hh:ii:00',
			language : 'zh-CN',
			minuteStep : 1,
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			minView : 0,
			maxView : 4,
			forceParse : 0
		});

		$("#pageSelect").change(labelQuery);
		$("#tagType_select").change(labelQuery);
		
		//查询，开始时间与结束时间之间的限制
		$("#beginDate_queryDiv").on(
				"changeDate",
				function(event) {
					$("#endDate_queryDiv").datetimepicker("setStartDate",
							$("#beginDate_input").val());
				});

		$("#endDate_queryDiv").on(
				"changeDate",
				function(event) {
					$("#beginDate_queryDiv").datetimepicker("setEndDate",
							$("#endDate_input").val());
				});

		//添加，开始时间与结束时间之间的限制
		$("#add_beginDateDiv").on(
				"changeDate",
				function(event) {
					$("#add_endDateDiv").datetimepicker("setStartDate",
							$("#add_beginDate").val());
				});

		$("#add_endDateDiv").on(
				"changeDate",
				function(event) {
					$("#add_beginDateDiv").datetimepicker("setEndDate",
							$("#add_endDate").val());
				});

		//修改，开始时间与结束时间之间的限制
		$("#edit_beginDateDiv").on(
				"changeDate",
				function(event) {
					$("#edit_endDateDiv").datetimepicker("setStartDate",
							$("#edit_beginDate").val());
				});

		$("#edit_endDateDiv").on(
				"changeDate",
				function(event) {
					$("#edit_beginDateDiv").datetimepicker("setEndDate",
							$("#edit_endDate").val());
				});

		$("#save").click(addCheck);
	});

	function labelQuery() {
		$("#tagName_from").val($("#tagName_input").val());
		$("#tagType_from").val($("#tagType_select").val());
		$("#beginDate_from").val($("#beginDate_input").val());
		$("#endDate_from").val($("#endDate_input").val());

		var params = $("#label_form").serialize();
        LA.sysCode = '16';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('proLabel.queryProLabel', '促销活动标签查询：' + params, getCookieValue("username"),  sessionId);
		params = decodeURI(params);
		labelPagination.onLoad(params);
	}
	function find() {
		$("#tagName_from").val($("#tagName_input").val());
		$("#tagType_from").val($("#tagType_select").val());
		$("#beginDate_from").val($("#beginDate_input").val());
		$("#endDate_from").val($("#endDate_input").val());

		var params = $("#label_form").serialize();
		params = decodeURI(params);
		labelPagination.onLoad(params);
	}

	function reset() {

		$("#tagName_input").val("");
		$("#tagType_select").val("");
		$("#beginDate_input").val("");
		$("#endDate_input").val("");

		labelQuery();
	}
	function initProLabel() {
		var url = $("#ctxPath").val() + "/proLabel/queryProLabel.htm";
		labelPagination = $("#labelPagination").myPagination(
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
							//使用模板
							$("#label_tab tbody").setTemplateElement(
									"label-list").processTemplate(data);
						}
					}
				});
	}

	function addActiveLabel() {
		initTags();
		$("#add_tagType").val("");
		$("#add_tagName").val("");
		$("#add_beginDate").val("");
		$("#add_endDate").val("");
		$("#add_status0").prop("checked", true);
		$("#addLabelDiv").show();
	}
	
	function initTags(){
		  $("#tags").empty();
		  $("#tagsfather").css("display","none");
		  $("#tagNames").attr("value","");
	  }

	function editActiveLabel(sid) {
		$("#sid").val(sid);
		$("#edit_tagType").val($("#tagType_" + sid).attr("tagType").trim());
		$("#edit_labelName").val($("#labelName_" + sid).html().trim());
		$("#edit_beginDate").val($("#beginDate_" + sid).html().trim());
		$("#edit_endDate").val($("#endDate_" + sid).html().trim());
		if ($("#statusHidden_" + sid).html().trim() == 0) {
			$("#status0").prop("checked", true);
			$("#status1").prop("checked", false);
		} else {
			$("#status1").prop("checked", true);
			$("#status0").prop("checked", false);
		}
		$("#editLabelDiv").show();
	}
	
	function addCheck(){
		if($("#add_tagType").val() == ""){
			$("#save").removeAttr("disabled");
			$("#warning2Body").text("请选择标签类型！");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		 if($("#add_tagName").val().trim() == "" && $("#tagNames").attr("value") == ""){
			$("#save").removeAttr("disabled");
			$("#warning2Body").text("请填写标签名称！");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		} 
		if($("#add_beginDate").val().trim() == ""){
			$("#save").removeAttr("disabled");
			$("#warning2Body").text("请选择开始时间！");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#add_endDate").val().trim() == ""){
			$("#save").removeAttr("disabled");
			$("#warning2Body").text("请选择结束时间！");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		return true;
	}
	
	function closeBtDiv() {
		$("#addLabelDiv").hide();
		$("#editLabelDiv").hide();
		$("#addShoppeProDiv").hide();
		$("#addProDetailDiv").hide();
		$("#save").removeAttr("disabled");
		$("#edit").removeAttr("disabled");
	}

	function successBtn() {
		closeBtDiv();
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		labelQuery();
	}
</script>
<!-- 添加 -->
<script type="text/javascript">
	$('#addForm')
			.bootstrapValidator(
					{
						message : 'This value is not valid',
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh'
						},
						submitHandler : function(validator, form, submitButton) {
							var url = $("#ctxPath").val()
									+ "/proLabel/saveProLabel.htm";
							var tagType = $("#add_tagType option:selected").val();
							var tagName = $("#add_tagName").val();
							var tagNames = $("#tagNames").attr("value");
							var beginDate = $("#add_beginDate").val();
							var endDate = $("#add_endDate").val();
							var operaterName =$('input[name="operaterName"]').val();
							var status = $('input[name="status"]:checked').val();

                            LA.sysCode = '16';
                            var sessionId = '<%=request.getSession().getId() %>';
                            LA.log('proLabel.saveProLabel', '添加促销活动标签：', getCookieValue("username"),  sessionId);

							$.ajax({
										type : "post",
										contentType : "application/x-www-form-urlencoded;charset=utf-8",
										url : url,
										dataType : "json",
										ajaxStart : function() {
											$("#loading-container").attr(
													"class",
													"loading-container");
										},
										ajaxStop : function() {
											//隐藏加载提示
											setTimeout(
													function() {
														$("#loading-container")
																.addClass(
																		"loading-inactive");
													}, 300);
										},
										data : //$("#addForm").serialize(),
										{
											"tagType":tagType,
											"tagName" : tagName,
											"tagNames" :tagNames,
											"beginDate" : beginDate,
											"endDate" : endDate,
											"operaterName" : operaterName,
											"status" : status
										},
										success : function(response) {
											if (response.success == "true") {
												var msg = response.msg;
												if(msg == "" || msg == null){
													msg = response.data;
												}
												$("#modal-body-success")
														.html(
																"<div class='alert alert-success fade in'align='center'><strong>"+msg+"</strong></div>");
												$("#modal-success")
														.attr(
																{
																	"style" : "display:block;z-index:9999",
																	"aria-hidden" : "false",
																	"class" : "modal modal-message modal-success"
																});
											} else if (response.data.errorMsg != "") {
												$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
												$("#warning2").attr("style", "z-index:9999");
												$("#warning2").show();
											}
											return;
										},
										error : function(XMLHttpRequest, textStatus) {
											var sstatus = XMLHttpRequest
													.getResponseHeader("sessionStatus");
											if (sstatus != "sessionOut") {
												$("#warning2Body").text(buildErrorMessage("","系统出错！"));
												$("#warning2").attr("style", "z-index:9999");
												$("#warning2").show();
											}
											if (sstatus == "sessionOut") {
												$("#warning3").css('display', 'block');
											}
										}
									});

						}
					}).find('button[data-toggle]').on(
					'click',
					function() {
						var $target = $($(this).attr('data-toggle'));
						$target.toggle();
						if (!$target.is(':visible')) {
							$('#addForm').data('bootstrapValidator')
									.disableSubmitButtons(false);
						}
					});
</script>
<!-- 修改 -->
<script type="text/javascript">
	function editStatus(sid, status) {
		var tagName = $("#labelName_" + sid).html().trim();
		var beginDate = $("#beginDate_" + sid).html().trim();
		var endDate = $("#endDate_" + sid).html().trim();
		var operaterName = $("#operaterName_" + sid).html().trim();

        LA.sysCode = '16';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('proLabel.editProLabel', '启用停用促销活动标签：', getCookieValue("username"),  sessionId);

		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : $("#ctxPath").val() + "/proLabel/editProLabel.htm",
			dataType : "json",
			data : {
				"sid" : sid,
				"tagName" : tagName,
				"beginDate" : beginDate,
				"endDate" : endDate,
				"operaterName" : operaterName,
				"status" : status
			},
			success : function(response) {
				if (response.success == 'true') {
					labelQuery();
				}
			}
		});
	}

	$('#editForm').bootstrapValidator(
                    {
						message : 'This value is not valid',
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh'
						},
						submitHandler : function(validator, form, submitButton) {
							var editTagType = $("#edit_tagType").val();
							if (editTagType == "") {
								$("#warning2Body").text("请选择标签类型！");
								$("#warning2").attr("style", "z-index:9999");
								$("#warning2").show();
								return;
							}

							var url = $("#ctxPath").val() + "/proLabel/editProLabel.htm";

                            LA.sysCode = '16';
                            var sessionId = '<%=request.getSession().getId() %>';
                            LA.log('proLabel.editProLabel', '修改促销活动标签：', getCookieValue("username"),  sessionId);

							$.ajax({
										type : "post",
										contentType : "application/x-www-form-urlencoded;charset=utf-8",
										url : url,
										dataType : "json",
										ajaxStart : function() {
											$("#loading-container").attr(
													"class",
													"loading-container");
										},
										ajaxStop : function() {
											//隐藏加载提示
											setTimeout(
													function() {
														$("#loading-container")
																.addClass(
																		"loading-inactive");
													}, 300);
										},
										data : $("#editForm").serialize(),
										success : function(response) {
											if (response.success == "true") {
												$("#modal-body-success")
														.html(
																"<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
												$("#modal-success")
														.attr(
																{
																	"style" : "display:block;z-index:9999",
																	"aria-hidden" : "false",
																	"class" : "modal modal-message modal-success"
																});
											} else if (response.data.errorMsg != "") {
												$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
												$("#warning2").show();
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

						}
					}).find('button[data-toggle]').on(
					'click',
					function() {
						var $target = $($(this).attr('data-toggle'));
						$target.toggle();
						if (!$target.is(':visible')) {
							$('#editForm').data('bootstrapValidator')
									.disableSubmitButtons(false);
						}
					});
	//多标签添加  
	var tagcount = 5;//暂时只支持一次添加五个标签
	/*标签输入框键盘弹出事件*/
	  $("#add_tagName").bind("keyup", function(event) {
		var keyCode = event.keyCode;//获取键盘按键code
		if (keyCode == 59) {//按键为;；时
			var add_tagName = $("#add_tagName").val();//获取标签输入框内的文本
			add_tagName = cleanTag(add_tagName);//处理文本，将文本中的；;替换为“”
			var val =$.trim(add_tagName);//去除文本两边的空白
			/* var tagType = $("#add_tagType option:selected").val();//获取选择框的值，标签类型
			if(tagType == ""){//如果标签类型为“” 报错
				$("#warning2Body").text(buildErrorMessage("","请选择标签类型！"));
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				cleanText();//弹出提示框后，清楚文本框内的;
				return ;
			} */
			if(val == "" || val == null){//如果输入;替换为“”
				$("#add_tagName").val("");
			}else if(val == ";" || val == "；"){
				val = cleanTag(val);
				$("#add_tagName").val(val);
			}else{//不为空，且部位;；时，创建标签
				val = cleanTag(val);
				if (checkTags(val) != -1) {
					$("#warning2Body").text(buildErrorMessage("","已有该标签："+val));
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
					cleanText();
				} else {
					createTag(val);
					showTags();
					$("#add_tagName").val("");
				}
			}
		}
	});  
	/*创建标签并添加至隐藏input*/
	function createTag(val) {
		var count = $(".tags-child").length;
		if (tagcount > count) {
			var $tagschild = $("<div class='tags-child'  style='float:left'>"
					+ val
					+ "<div class='tags-childs-remove'style='background-color: #CC324C'><a style='text-decoration:none;color:#fff' >×</a></div><div style='clear: both;'></div></div>");
			$("#tags").append($tagschild);
			var tagNames = $("#tagNames").attr("value");
			//var newTagName = tagNames + val + tagType + ";";
			var newTagName = tagNames + val + ";";
			$("#tagNames").attr("value",newTagName);
			if($("#tags").height()>150){  
				$("#tags").css("height","150px");  
				$("#tags").css("overflow","scroll");  
				}
		} else {
			$("#warning2Body").text("一次最多添加5个标签！");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			cleanText();
		}
	}
	/*标签组div显示新增加的标签*/
	function showTags() {
		var count = $(".tags-child").length;
		if (count == 0) {
			$("#tagsfather").css("display", "none");
		} else {
			$("#tagsfather").css("display", "block");
		}
	}
	/*对比标签是否存在*/
	function checkTags(tagsName) {
		var tagNames = $("#tagNames").attr("value");
		if (tagNames != null && tagNames != "") {
			var tagshuzu = tagNames.split(";");
			return jQuery.inArray(tagsName, tagshuzu);
		} else {
			return -1;
		}
	}
	//删除输入框内的；
	function cleanText(){
		var add_tagName = $("#add_tagName").val().replace(/[;；]/g,"");
		$("#add_tagName").val(add_tagName);
	}
	//清除标签中;
	function cleanTag(add_tagName){
		name = add_tagName.replace(/[;；]/g,"");
		tagName = $.trim(name);
		return tagName;
	}
</script>
<script type="text/javascript">
	//添加专柜商品 
	var _tsgSid = "";
	function addShoppeProDiv(labelSid, isMore) {
		_tagSid = labelSid;
		_isMore = isMore;
		var labelName = $("#labelName_"+labelSid+"").text();
		var labelType = $("#tagType_"+labelSid+"").text();
		var te = "添加专柜商品"+"&nbsp至"+ "<a style='color:red;text-decoration:none'>"+labelType+":"+labelName+"</a>";
		$("#divTitle1").html(te);
		$("#pageBodyShoppe").load(
				$("#ctxPath").val()
						+ "/jsp/promotionLabel/labelAddShoppePro.jsp");
		$("#addShoppeProDiv").show();
	}
	//添加商品
	function addProDetailDiv(labelSid, isMore) {
		_tagSid = labelSid;
		_isMore = isMore;
		var labelName = $("#labelName_"+labelSid+"").text();
		var labelType = $("#tagType_"+labelSid+"").text();
		var te = "添加商品"+"&nbsp至"+ "<a style='color:red;text-decoration:none'>"+labelType+":"+labelName+"</a>";
		$("#divTitle2").html(te);
		$("#pageBodyProDetail").load(
				$("#ctxPath").val()
						+ "/jsp/promotionLabel/labelAddProDetail.jsp");
		$("#addProDetailDiv").show();
	}
</script>
<script type="text/javascript">
$(function(){
	/*标签显示区域，点击×时 删除对应标签*/
	$("#tags").on('click','a',function(event){
		var tagname  = $(event.target).parent().parent().text();
		//var tagType = $(event.target).parent().parent().attr("value"); 
		tagname = $.trim(tagname);
		var OldName = tagname; //+ tagType;
		tagOldName = OldName.replace("×","");
		var tagNames = $("#tagNames").attr("value");
		var tags = tagNames.split(";");
		tags.splice(jQuery.inArray(tagOldName,tags),1);
		$("#tagNames").attr("value",tags.join(";"));
		$(event.target).parent().parent().remove();
		if($(".tags-child").length == 0){
			$("#tagsfather").css("display","none");
		}
	});
	//鼠标移入×时，改变CSS
	$("#tags").on('mouseover','a',function(event){
		$(event.target).parent().css("background-color","#FFCE55");
	    $(event.target).css("background-color","#FFCE55");
	    $(event.target).css("color","#CC324C");
	    
	});
	$("#tags").on('mouseout','a',function(event){
		$(event.target).parent().css("background-color","#CC324C");
	    $(event.target).css("background-color","#CC324C");
	    $(event.target).css("color","#fff");
	});
});
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">促销活动标签管理</h5>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
										<a id="editabledatatable_new" onclick="addActiveLabel()"
											class="btn btn-primary"> <i class="fa fa-plus"></i> 添加标签
										</a>
										
									</div>
									<div class="table-toolbar">
										<div class="col-md-4" id="" style="padding: 0;">
											<label class="col-md-4 control-label"
												style="line-height: 33px; margin: 0; width: 100px;">标签名称：</label>
											<div class="col-md-4" style="padding: 0;">
												<input type="text" id="tagName_input"
													style="width: 250px; height: 33px;" />
											</div>
										</div>
										<div class="col-md-4" id="" style="padding: 0;">
											<label class="col-md-4 control-label"
												style="line-height: 33px; margin: 0; width: 100px;">标签类型：</label>
											<div class="col-md-4" style="padding: 0;">
												<select style="width: 250px; height: 33px;"
													id="tagType_select">
													<option selected="selected" value="">请选择</option>
													<option value="1">促销标签</option>
													<option value="2">关键字</option>
													<option value="3">活动关键字</option>
												</select>
											</div>
										</div>
										
										<br>&nbsp;<br>&nbsp;<br>
										<div class="col-md-4" id="" style="padding: 0;">
											<label class="col-md-4 control-label"
												style="line-height: 33px; margin: 0; width: 100px;">开始时间：</label>
											<div class="col-md-4" style="padding: 0;">
												<div id="beginDate_queryDiv"
													class="col-lg-10 mtb10 input-group date form_time"
													data-date="" data-date-format="yyyy-mm-dd hh:mm:ss"
													data-link-field="dtp_input2"
													data-link-format="yyyy-mm-dd hh:mm:ss"
													style="width: 250px; margin: 0;">
													<input class="form-control" onfocus="this.blur();"
														id="beginDate_input" style="position: relative"
														name="beginDate" placeholder="开始时间" size="10" type="text"
														readonly> <span class="input-group-addon">
														<span class="glyphicon glyphicon-remove"></span>
													</span> <span class="input-group-addon"> <span
														class="glyphicon glyphicon-calendar"></span>
													</span>
												</div>
											</div>
										</div>
										<div class="col-md-4" id="" style="padding: 0;">
											<label class="col-md-4 control-label"
												style="line-height: 33px; margin: 0; width: 100px;">结束时间：</label>
											<div class="col-md-4" style="padding: 0;">
												<div id="endDate_queryDiv"
													class="col-lg-10 mtb10 input-group date form_time"
													data-date="" data-date-format="yyyy-mm-dd hh:mm:ss"
													data-link-field="dtp_input2"
													data-link-format="yyyy-mm-dd hh:mm:ss"
													style="width: 250px; margin: 0;">
													<input class="form-control" onfocus="this.blur();"
														id="endDate_input" style="position: relative"
														name="endDate" placeholder="结束时间" size="10" type="text"
														readonly> <span class="input-group-addon">
														<span class="glyphicon glyphicon-remove"></span>
													</span> <span class="input-group-addon"> <span
														class="glyphicon glyphicon-calendar"></span>
													</span>
												</div>
											</div>
										</div>
										<div class="col-md-4" id="" style="">
											<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>
										</div>
										<br>&nbsp;<br>
										<table
											class="table table-bordered table-striped table-condensed table-hover flip-content"
											id="label_tab">
											<thead class="flip-content bordered-darkorange">
												<tr role="row">
													<!-- <th style="text-align: center;" width="7.5%">选择</th> -->
													<th style="text-align: center;">标签类型</th>
													<th style="text-align: center;">标签名称</th>
													<th style="text-align: center;">开始时间</th>
													<th style="text-align: center;">结束时间</th>
													<th style="text-align: center;">最后更改人</th>
													<th style="text-align: center;" width="7%">是否启用</th>
													<th style="text-align: center;" width="30%">操作</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
										<div class="btn-group pull-left">
											<form id="label_form" action="">
												<div class="col-lg-12" style="margin-top: 5px;">
													<select id="pageSelect" name="pageSize">
														<option>5</option>
														<option selected="selected">10</option>
														<option>15</option>
														<option>20</option>
													</select> <input type="hidden" id="tagName_from" name="tagName" />
													<input type="hidden" id="tagType_from" name="tagType" />
													<input type="hidden" id="beginDate_from" name="beginDate" />
													<input type="hidden" id="endDate_from" name="endDate" />
												</div>
												&nbsp;
											</form>
										</div>
									</div>
									<div id="labelPagination"></div>
								</div>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="label-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="center" id="tagType_{$T.Result.sid}" tagType="{$T.Result.tagType}">
														{#if $T.Result.tagType == 1}
															促销标签
														{#elseif $T.Result.tagType == 2}
															关键字
														{#elseif $T.Result.tagType == 3}	
															活动关键字
														{#/if}
													</td>
													<td align="center" id="labelName_{$T.Result.sid}" >
														{$T.Result.tagName}
													</td>
													<td align="center" id="beginDate_{$T.Result.sid}">
														{$T.Result.beginDate}
													</td>
													<td align="center" id="endDate_{$T.Result.sid}">
														{$T.Result.endDate}
													</td>
													<td align="center" id="operaterName_{$T.Result.sid}">
														{#if $T.Result.operaterName == '[object Object]'}
														{#else}{$T.Result.operaterName}
														{#/if}
													</td>
													
													<td align="center" id="status_{$T.Result.sid}">
														{#if $T.Result.status == 1}<a href="javascript:editStatus('{$T.Result.sid}', '0');"><span class="btn btn-primary">启用</span></a>
														{#elseif $T.Result.status == 0}<a href="javascript:editStatus('{$T.Result.sid}', '1');"><span class="btn btn-yellow">停用</span></a>
														{#/if}
													</td>
													<td align="center" style="padding-left:0px;white-space:nowrap;">
														<a href="javascript:editActiveLabel({$T.Result.sid});" style="margin-left:5px;text-decoration:none"  >
														    <span class="btn btn-blue" style="margin-left:0px" >修改</span>
														</a>
														{#if $T.Result.tagType == 1}
															<a href="javascript:addShoppeProDiv({$T.Result.sid}, 0);" style="margin-left:5px;text-decoration:none" >
														    	<span class="btn btn-primary" >添加专柜商品</span>
															</a>
															<a href="javascript:addShoppeProDiv({$T.Result.sid}, 1);" style="width:60%;padding-left:5px"> 
															    <span class="btn btn-yellow" >批量导入</span>
															</a>
														{#elseif $T.Result.tagType == 2}
															<a href="javascript:addProDetailDiv({$T.Result.sid}, 0);" style="margin-left:5px;text-decoration:none" >
														    	<span class="btn btn-primary"  >添加商品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
															</a>
															<a href="javascript:addProDetailDiv({$T.Result.sid}, 1);" style="width:60%;padding-left:5px"> 
															    <span class="btn btn-yellow" >批量导入</span>
															</a>
														{#elseif $T.Result.tagType == 3}	
															<a href="javascript:addProDetailDiv({$T.Result.sid}, 0);" style="margin-left:5px;text-decoration:none">
														    	<span class="btn btn-primary"  >添加商品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
															</a>
															<a href="javascript:addProDetailDiv({$T.Result.sid}, 1);" style="width:60%;padding-left:5px"> 
															    <span class="btn btn-yellow" >批量导入</span>
															</a>
														{#/if}
													</td>
													<td style="display:none;" id="statusHidden_{$T.Result.sid}">{$T.Result.status}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- /Page Container -->
			</div>
		</div>
		<!-- Main Container -->
	</div>

	<!-- 添加 -->
	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="addLabelDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv();">×</button>
					<h4 class="modal-title" id="divTitle">添加促销活动标签</h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<div class="row">
						<form method="post" class="form-horizontal" id="addForm">
							<div class="col-xs-12 col-md-12">
								<input type="hidden" name="operaterName" value="">
								<script type="text/javascript">
									$("input[name='operaterName']").val(getCookieValue("username"));
								</script>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签类型：</label>
									<div class="col-md-6">
										<select class="form-control" style="padding: 10px 100px"
											id="add_tagType" name="tagType">
											<option selected="selected" value="">请选择</option>
											<option value="1">促销标签</option>
											<option value="2">关键字</option>
											<option value="3">活动关键字</option>
										</select>
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12"  style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签名称：</label>
									<div class="col-md-6 ">
									    <!--  <div id="tags-childs" style="float:left"></div>-->
										<input type="text" class="form-control" name="tagName" 
											id="add_tagName" />
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12" id="tagsfather" style="padding: 10px 100px;display:none">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</label>
									<div class="col-md-6 "  >
									<div id="tags"  style="float:left"></div>
									</div>
									<input type="text" id="tagNames" style="display:none" name="tagNames"/>
									<br>&nbsp;
								</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签开始时间：</label>
									<div class="col-md-6">
										<div id="add_beginDateDiv"
											class="col-lg-10 mtb10 input-group date form_time"
											data-date="" data-date-format="yyyy-mm-dd hh:mm:ss"
											data-link-field="dtp_input2"
											data-link-format="yyyy-mm-dd hh:mm:ss"
											style="width: 250px; margin: 0;">
											<input class="form-control" onfocus="this.blur();"
												id="add_beginDate" style="position: relative"
												name="beginDate" placeholder="开始时间" size="10" type="text"
												readonly> <span class="input-group-addon"> <span
												class="glyphicon glyphicon-remove"></span>
											</span> <span class="input-group-addon"> <span
												class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签结束时间：</label>
									<div class="col-md-6">
										<div id="add_endDateDiv"
											class="col-lg-10 mtb10 input-group date form_time"
											data-date="" data-date-format="yyyy-mm-dd hh:mm:ss"
											data-link-field="dtp_input2"
											data-link-format="yyyy-mm-dd hh:mm:ss"
											style="width: 250px; margin: 0;">
											<input class="form-control" onfocus="this.blur();"
												id="add_endDate" style="position: relative" name="endDate"
												placeholder="结束时间" size="10" type="text" readonly> <span
												class="input-group-addon"> <span
												class="glyphicon glyphicon-remove"></span>
											</span> <span class="input-group-addon"> <span
												class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签是否启用：</label>
									<div class="col-md-6">
										<div class="radio" style="height: 20px;">
											<label style="line-height: 20px;"> <input
												class="basic" type="radio" value="0" checked="checked"
												name="status"> <span class="text">是</span>
											</label> <label style="line-height: 20apx;"> <input
												class="basic" type="radio" value="1" name="status">
												<span class="text">否</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label> <input class="inverted" type="radio"
												name="status"> <span class="text"></span>
											</label>
										</div>
									</div>
									<br>&nbsp;
								</div>
							</div>
							<br>&nbsp;
							<div class="form-group">
								<div class="col-lg-offset-4 col-lg-6">
									<button class="btn btn-success" style="width: 25%;" id="save"
										type="submit">保存</button>
									&emsp;&emsp; <input class="btn btn-danger"
										onclick="closeBtDiv();" style="width: 25%;" id="close"
										type="button" value="取消" />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- 修改 -->
	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="editLabelDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv();">×</button>
					<h4 class="modal-title" id="divTitle">修改促销活动标签</h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<div class="row">
						<form method="post" class="form-horizontal" id="editForm">
							<div class="col-xs-12 col-md-12">
								<input type="hidden" name="sid" id="sid"> <input
									type="hidden" name="operaterName" value="">
									<script type="text/javascript">
										$("input[name='operaterName']").val(getCookieValue("username"));
									</script>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签类型：</label>
									<div class="col-md-6">
										<select class="form-control" style="padding: 10px 100px"
											id="edit_tagType" name="tagType">
											<option selected="selected" value="">请选择</option>
											<option value="1">促销标签</option>
											<option value="2">关键字</option>
											<option value="3">活动关键字</option>
										</select>
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签名称：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="tagName"
											id="edit_labelName" />
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签开始时间：</label>
									<div class="col-md-6">
										<div id="edit_beginDateDiv"
											class="col-lg-10 mtb10 input-group date form_time"
											data-date="" data-date-format="yyyy-mm-dd hh:mm:ss"
											data-link-field="dtp_input2"
											data-link-format="yyyy-mm-dd hh:mm:ss"
											style="width: 250px; margin: 0;">
											<input class="form-control" onfocus="this.blur();"
												id="edit_beginDate" style="position: relative"
												name="beginDate" placeholder="开始时间" size="10" type="text"
												readonly> <span class="input-group-addon"> <span
												class="glyphicon glyphicon-remove"></span>
											</span> <span class="input-group-addon"> <span
												class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签结束时间：</label>
									<div class="col-md-6">
										<div id="edit_endDateDiv"
											class="col-lg-10 mtb10 input-group date form_time"
											data-date="" data-date-format="yyyy-mm-dd hh:mm:ss"
											data-link-field="dtp_input2"
											data-link-format="yyyy-mm-dd hh:mm:ss"
											style="width: 250px; margin: 0;">
											<input class="form-control" onfocus="this.blur();"
												id="edit_endDate" style="position: relative" name=endDate
												placeholder="开始时间" size="10" type="text" readonly> <span
												class="input-group-addon"> <span
												class="glyphicon glyphicon-remove"></span>
											</span> <span class="input-group-addon"> <span
												class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">标签是否启用：</label>
									<div class="col-md-6">
										<div class="radio" style="height: 20px;">
											<label style="line-height: 20px;"> <input
												id="status0" class="basic" type="radio" value="0"
												name="status"> <span class="text">是</span>
											</label> <label style="line-height: 20px;"> <input
												id="status1" class="basic" type="radio" value="1"
												name="status" > <span class="text">否</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label> <input class="inverted" type="radio"
												name="status"> <span class="text"></span>
											</label>
										</div>
									</div>
									<br>&nbsp;
								</div>
							</div>
							<br>&nbsp;
							<div class="form-group">
								<div class="col-lg-offset-4 col-lg-6">
									<button class="btn btn-success" style="width: 25%;" id="edit"
										type="submit">保存</button>
									&emsp;&emsp; <input class="btn btn-danger"
										onclick="closeBtDiv();" style="width: 25%;" id="close"
										type="button" value="取消" />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 添加专柜商品 -->
	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="addShoppeProDiv">
		<div class="modal-dialog"
			style="width: 1000px; height: auto; margin: 50px auto;">
			<div class="modal-content" style="width: 1000px;">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv();">×</button>
					<h4 class="modal-title" id="divTitle1"></h4>
				</div>
				<div class="page-body" id="pageBodyShoppe"></div>
			</div>
		</div>
	</div>

	<!-- 添加商品 -->
	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="addProDetailDiv">
		<div class="modal-dialog"
			style="width: 1000px; height: auto; margin: 50px auto;">
			<div class="modal-content" style="width: 1000px;">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv();">×</button>
					<h4 class="modal-title" id="divTitle2"></h4>
				</div>
				<div class="page-body" id="pageBodyProDetail"></div>
			</div>
		</div>
	</div>


</body>
<!-- <script>
	jQuery(document).ready(function() {
		$('#divTitle').mousedown(function(event) {
			var isMove = true;
			var abs_x = event.pageX - $('#btDiv').offset().left;
			var abs_y = event.pageY - $('#btDiv').offset().top;
			$(document).mousemove(function(event) {
				if (isMove) {
					var obj = $('#btDiv');
					obj.css({
						'left' : event.pageX - abs_x,
						'top' : event.pageY - abs_y
					});
				}
			}).mouseup(function() {
				isMove = false;
			});
		});
	});
</script> -->
</html>
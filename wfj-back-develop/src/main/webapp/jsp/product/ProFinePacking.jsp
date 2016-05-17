<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/jsp/ueditor/";
</script>
	<script type="text/javascript" charset="utf-8" 
			src="${pageContext.request.contextPath}/jsp/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" 
    		src="${pageContext.request.contextPath}/jsp/ueditor/ueditor.all.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" 
    		src="${pageContext.request.contextPath}/jsp/ueditor/lang/zh-cn/zh-cn.js"> </script>

<script type="text/javascript">
	var ue = UE.getEditor('editor');
</script>
<script type="text/javascript">
	$("#colorBox1 a").click(function() {
		$("#colorBox1 a").removeClass("color_on");
		$(this).addClass("color_on");
		$("#hid_color").val("");
		var colorSid = $(this).attr("colorSid");
		$("#hid_color").val(colorSid);
		document.cookie="colorSid="+colorSid;
		getProPacking(colorSid);
		getSpuName($(this).attr("title"));
		return false;
	});
	
	function getProPacking(colorSid, isFirst){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/productDesc/getProPackingBySkuAndColorSid",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			data : {
				"proSid" : $('#spuCode_from').val(),
				"colorSid" : colorSid,
				"mark" : "${mark }"
			},
			success : function(response) {
				if(response.success == "true" && response.data != ""){
					var data = response.data[0];
					if(isFirst==0){
						UE.getEditor('editor').addListener("ready", function () {
						       UE.getEditor('editor').setContent(data.contents, false);
						});
						return;
					}
					UE.getEditor('editor').setContent(data.contents, false);
				} else if(response.success == "true" && response.data == ""){
					if(isFirst==0){
						UE.getEditor('editor').addListener("ready", function () {
						       UE.getEditor('editor').setContent("", false);
						});
						return;
					}
					UE.getEditor('editor').setContent("", false);
				}
			}
		});
	}
</script>
<script type="text/javascript">

	$("#proPackSave").click(function(){
		saveProPacking();
	});
	
	
	function saveProPacking(){
		var contents = UE.getEditor('editor').getContent();
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/productDesc/saveProPacking",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			data : {
				"proSid" : $('#spuCode_from').val(),
				"colorSid" : $("#hid_color").val(),
				"contents" : contents,
				"mark" : "${mark }"
			},
			success : function(response) {
				if(response.success == "true"){
					if($("#edit-success").attr("style") != undefined){
						saveProShortAndLongDesc();
					} else {
						$("#modal-body-success")
								.html("<div class='alert alert-success fade in'><strong>添加成功</strong></div>");
						$("#modal-success").attr({
							"style" : "display:block;z-index:9999;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
					}
	    		} else {
	    			$("#warning2Body").text(response.data);
	    			$("#warning2").attr("style", "z-index:9999");
	    			$("#warning2").show();
	    		}
			}
		});
	}
	
</script>
<script type="text/javascript">
	function getSpuName(color){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/getProBySpuCode",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			data : {
				"spuCode" : $('#spuCode_from').val()
			},
			success : function(response) {
				if(response != "undefined"){
					$("#productName_1").html(response[0].productName + "&nbsp;" + color);
					$("#shortDesc").val(response[0].shortDes);
					$("#longDesc").val(response[0].longDesc);
				}
			}
		});
	}
	
	function saveProShortAndLongDesc(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/editProDescBySpuCode",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			data : {
				"spuCode" : $('#spuCode_from').val(),
				"longDesc" : $("#longDesc").val(),
				"shortDesc" : $("#shortDesc").val()
			},
			success : function(response) {
				if(response.success == "true"){
					if($("#edit-success").attr("style") != undefined){
						$("#modal-body-success1").html(response.data);
		    			$("#edit-success").attr({
							"style" : "display:block;z-index:9999;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
					} else {
						$("#modal-body-success")
								.html("<div class='alert alert-success fade in'><strong>添加成功</strong></div>");
						$("#modal-success").attr({
							"style" : "display:block;z-index:9999;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
					}
	    		} else {
	    			$("#warning2Body").text(response.data);
	    			$("#warning2").attr("style", "z-index:9999");
	    			$("#warning2").show();
	    		}
			}
		});
	}
</script>
</head>
<body>
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<div class="page-body">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div style="width: 20%; float: left;">
							<div class="widget">
								<div class="widget-header ">
									<h5 class="widget-caption" id="widget">色系</h5>
									<input id="hid_color" type="hidden"> <input
										id="hid_product" type="hidden" value="${productCode}">
								</div>
								<div class="widget-body clearfix" id="colorBox1">
									<c:forEach items="${colors}" var="color">
										<a class="colorbox" colorSid="${color.sid}"
											href="javascript:void(0);" title="${color.color_name}"
											style="background: url('${pageContext.request.contextPath}/images/colorImg/${color.rgb}');"><i></i></a>
									</c:forEach>
								</div>
							</div>
						</div>
						<div style="width: 77%; float: left; margin-left: 20px;">
							<div class="widget" id="editFinePack">
								<div class="widget-header ">
									<h5 class="widget-caption" id="widget">精包装</h5>
								</div>
								<div class="widget-body clearfix" id="">
									<div>
										<span>标准名：</span>
										<span id="productName_1"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="text" value="" id="shortDesc" maxLength=70 style="float: right;margin-right: 20px;width: 40%"/>
										<span  style="float: right;">短名称：</span>
										<br>
										<br>
										<span>描述名称：</span>
										<input type="text" value="" id="longDesc" style="width: 90%" maxLength=50/>
									</div>
									<br>
									<div>
										<script id="editor" type="text/plain" style="height:400px;"></script>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group" id="button">
					<div class="col-lg-offset-4 col-lg-6">
						<input class="btn btn-success" style="width: 25%;" id="proPackSave"
							type="button" value="保存">&emsp;&emsp; <input
							class="btn btn-danger" style="width: 25%;" id="proPackClose"
							type="button" value="取消" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		document.cookie="spuCode="+$('#spuCode_from').val();
		/* $("#colorBox1 a:eq(0)").addClass("color_on");
		var colorSid = $("#colorBox1 a:eq(0)").attr("colorSid");
		$("#hid_color").val(colorSid);
		document.cookie="colorSid="+colorSid;		
		getProPacking(colorSid, 0); */
		
		window.setTimeout(function(){
			$("#colorBox1 a").each(function(){
				if($(this).attr("colorSid") == $("#SkuColorSid").val().trim()){
					$(this).click();
					getSpuName($(this).attr("title"));
				} else {
					$(this).hide();
				}
			});
		}, 500)
		$("#proPackClose").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		
		/* getSpuName($("#colorBox1 a:eq(0)").attr("title")); */
		
	});
</script>
</html>
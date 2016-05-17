<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
	// 添加全局站点信息
	var BASE_URL = '${pageContext.request.contextPath}';

	$("#colorBox a").click(function() {
		$("#hid_color").val("");
		$("#colorBox a").removeClass('color_on');
		$(this).addClass('color_on');
		var colorSid = $(this).attr("colorSid");
		$("#hid_color").val(colorSid);
		loadImg(colorSid);
		return false;
	});

	function loadImg(colorSid) {
		$("#imgBox").load(
				"${pageContext.request.contextPath}/upImg/loadProImgs", {
					"proSid" : $('#spuCode_from').val(),
					"colorSid" : colorSid,
					"mark" : "${mark }"
				});
	}

	// 关闭DIV
	function closeImgDiv() {
		var isUp=false;
		if($(".gridly").html().trim()==""){
			isUp=true;
		}
		loadImg($("#hid_color").val());
		if(isUp){
			setTimeout(function(){
				if($(".gridly").html().trim()==""){
					return;
				}
				$($("input[name='selImg']")[0]).prop("checked", true);
				var arr = new Array();
				$("input[name='selImg']:checked").each(function (i) {
					arr[i] = this.value;
					if(this.value==$("#main_id").val()){
						delFlag = false;
					}
		        });
				$("#mian_pic").attr("imgUrl",$("#pic_"+arr[0]).attr("imgUrl"));
				$("#mian_pic").attr("imgName",$("#pic_"+arr[0]).attr("imgName"));
				var ids = arr.join(",");
				$("#orders").val(ids);
				var imgIds=$("#orders").val();
				var imgUrl=$("#mian_pic").attr("imgUrl");
				var imgName=$("#mian_pic").attr("imgName");
				$($("input[name='selImg']")[0]).prop("checked", false);
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/upImg/modifyImg",
					dataType : "json",
					async : false,
					data : {
						"type" : 2,
						"imgIds":imgIds,
						"imgUrl":imgUrl,
						"imgName":imgName
					},
					success : function(response) {
						loadImg($("#hid_color").val());
					}
				});
			},1000);
		}
		$("#appImgDiv").hide();
	}

	function uploadImg() {
		$("#imgWindow").attr("src",
				"${pageContext.request.contextPath}/jsp/product/imgWindow.jsp");
		$("#appImgDiv").show();
	}

	/* $("#colorBox a").click(function() {
		$("#colorBox a").removeClass("color_on");
		$(this).addClass("color_on");
	}); */

	$(function() {
		if ("${mark }" == "1") {
			$("#button").show();
			$("#quxiao").hide();
			$("#addSkuImg").show();
			$("#downImg").show();
		}else if("${mark }" == "0"){
			$("#button").hide();
			$("#quxiao").show();
			$("#addSkuImg").hide();
			$("#downImg").hide();
		}else{
			$("#button").hide();
			$("#quxiao").hide();
			$("#addSkuImg").show();
			$("#downImg").show();
		}
		if($("#backUrl").val() != "/jsp/product/ProductView.jsp" && $("#backUrl").val() != ""){
			$("input[id='save']").hide();
		}
		//修改按钮事件
		$("input[id='save']").click(function() {
			var a = $(this).attr("name");
			if($("#skuSale").val() != 1){
				goEditPro(a);
			} else {
				$("#warning2Body").text("上架商品不能修改!");
				$("#warning2").show();
			}
		});
		//关闭按钮事件
		/* $("input[id='close']").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		}); */
	});
</script>
<script type="text/javascript">
  $(function(){
	  $("#colorBox a").each(function(){
		  if("${mark }" == 3){
		  } else {
			  if($(this).attr("colorSid") == $("#SkuColorSid").val().trim()){
				  $(this).click();
			  } else {
				  $(this).hide();
			  }
		  }
	  });
	  $("input[id='close']").click(function() {
	  		var url = $("#backUrl").val() == undefined ? "/jsp/product/ProductView.jsp" : $("#backUrl").val();
	  		$("#pageBody").load(__ctxPath + url);
	  });
  });
</script>

</head>
<body>

	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<div class="page-body">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div style="width: 25%; float: left;">
							<div class="widget">
								<div class="widget-header ">
									<h5 class="widget-caption" id="widget">色系</h5>
									<input id="hid_color" type="hidden"> <input
										id="hid_product" type="hidden" value="${productCode}">
								</div>
								<div class="widget-body clearfix" id="colorBox">
									<c:forEach items="${colors}" var="color">
										<a class="colorbox" colorSid="${color.sid}"
											href="javascript:void(0);" title="${color.color_name}"
											style="background: url('${pageContext.request.contextPath}/images/colorImg/${color.rgb}');"><i></i></a>
									</c:forEach>
								</div>
							</div>
						</div>
						<div style="width: 70%; float: left; margin-left: 20px;">
							<div class="widget">
								<div class="widget-header ">
									<h5 class="widget-caption" id="widget">图片</h5>
									<a class="btn btn-default purple" id="downImg" onclick="down();"
										style="margin: 2px 5px">图片打包下载</a>
									<a class="btn btn-default purple" id="addSkuImg" onclick="openShow();"
										style="margin: 2px 5px">预览</a>
								</div>
								<div class="widget-body" id="imgBox" style="min-height: 68px;"></div>

							</div>
						</div>
					</div>
				</div>
				<div class="form-group" id="button">
					<div class="col-lg-offset-4 col-lg-6">
						<input class="btn btn-success" style="width: 25%;" id="save"
							type="button" value="修改" name="show">&emsp;&emsp; <input
							class="btn btn-danger" style="width: 25%;" id="close"
							type="button" value="关闭" />
					</div>
				</div>
				<div class="form-group" id="quxiao">
					<div style="text-align: center;">
						<input class="btn btn-danger"
							style="width: 10%;" id="close" type="button" value="取消" />
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Add DIV root classification used -->
	<div class="modal modal-darkorange" id="appImgDiv">
		<div class="modal-dialog" style="width: 80%; margin-top: 80px;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeImgDiv();">×</button>
					<h4 class="modal-title">图片上传</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body"
						style="overflow-x: hidden; overflow-y: auto; height: 450px;">
						<div class="row" style="padding: 10px;">
							<div class="col-lg-12 col-sm-12 col-xs-12" style="height: 380px;">
								<iframe id="imgWindow" width="100%" height="100%"
									style="border: 0px;"> </iframe>
								<div class="form-group">
									<div style="text-align: center;">
										<input onclick="closeImgDiv();" class="btn btn-danger"
											style="width: 10%;" id="closeLoadImg" type="button"
											value="取消" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
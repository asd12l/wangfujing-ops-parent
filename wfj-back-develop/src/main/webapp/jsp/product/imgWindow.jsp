<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" 
    href="${pageContext.request.contextPath}/js/drag/jquery.gridly.css" 
    type="text/css">
<!--图片上传 -->
<link
	href="${pageContext.request.contextPath}/js/webupload/webuploader.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/js/webupload/style.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/webupload/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/webupload/webuploader.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/webupload/upload.js"></script>
<script type="text/javascript"> 
	// 添加全局站点信息
	var BASE_URL = '${pageContext.request.contextPath}';
	
	$(function(){
		$("#input_color").val($("#hid_color",parent.document).val());
		$("#input_prodcut").val( $('#hid_product',parent.document).val());
		$("#input_sort1").val($('#input_maxsort',parent.document).val());
		
	}); 
	
	
</script>
</head>
<body>
	<div id="wrapper">
		<div id="container">
			<form style="display:none;" id="imgForm">
				<input id="input_sort1"  />
				<input id="input_sort" name="sort" />
				<input id="input_color" name="colorSid" />
				<input id="input_prodcut" name="productCode" />
			</form>
		
			<!--头部，相册选择和格式选择-->
			<div id="uploader">
				<div class="queueList">
					<div id="dndArea" class="placeholder">
						<div id="filePicker"></div>
						<p>或将照片拖到这里，单次最多可选300张，仅支持.gif、.jpg格式图片，且单张图片大小不超过1M</p>
					</div>
					<ul class="filelist">

					</ul>
				</div>
				<div class="statusBar" style="display: none;">
					<div class="progress">
						<span class="text">0%</span> <span class="percentage"></span>
					</div>
					
					<div class="info"></div>
					
					<div class="btns">
						<div id="filePicker2"></div>
						<div class="uploadBtn">开始上传</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 	
	
<div aria-hidden="false" style="display: none;" class="modal modal-message modal-warning fade in" id="warning21">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            	<h5 id="myModalLabel">温馨提示</h5>                
            </div>
            <div class="modal-title" id="warning2Body1">错误信息</div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-warning" onclick="warning2Btn();" type="button">确定</button>
            </div>
        </div> / .modal-content
    </div> / .modal-dialog
</div> -->
</body>
</html>
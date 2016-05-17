<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0"> 
<title>图片展示</title>
<style type="text/css">
	  .gridly {
    position: relative;
    width: 100%;
  }
  .brick.small {
    width: 140px;
    height: 200px;
  }
  .brick.small .con_img{
  	 width: 140px;
    height: 140px;
  }
  .sel_img{text-align: center;}
  .brick.large {
    width: 300px;
    height: 300px;
  }
  .img_tip{
  	height: 20px; margin:5px 0px;
  }
  .img_tip span{
  	margin-left: 5px;
  }
  
</style> 

<link rel="stylesheet" href="${pageContext.request.contextPath}/js/drag/jquery.gridly.css" type="text/css">
	
<script type="text/javascript" src="${pageContext.request.contextPath}/js/drag/jquery.gridly.js"></script>

<script type="text/javascript">
    
    $(function(){
    	if("${mark }"=="1"){
    		$("#btn").hide();
    	}
    	for(var i=0;i<$(".imgNameSpan").length;i++){
    		var text = $($(".imgNameSpan")[i]).html();
    		text = text.substring(text.lastIndexOf("/")+1);
    		$($(".imgNameSpan")[i]).html(text);
    	}
    	isShowFinePackimg();
    });
	
	$(document).ajaxStart(function () {
		$("#loading-container").prop("class",
		"loading-container");
	});
	
	$(document).ajaxStop(function () {
		$("#loading-container").addClass(
		"loading-inactive");
	});

	$('.gridly').gridly({
	  base: 60, // px 
	  gutter: 20, // px
	  columns: 8,
	  callbacks: {
	        reordered: reordered
	        //reordering: reordering
	    }
	});
	if("${mark }"=="1"){
		$('.gridly').gridly('draggable', 'off');
	}else{
		$('.gridly').gridly('draggable', 'on');
	}
	
	/* callbacks */
	var reordered = function($elements, e) {
		if(e != undefined){
			var arr = new Array();
			$elements.each(function(i){
				arr[i]=$(this).attr("imgId");
			}); 		
			var ids = arr.join(",");
			$("#orders").val(ids);
			modifyImg(3);
			$('.gridly').gridly('draggable', 'on'); // disables dragging
		}
	};

	/*图片修改的方法*/
	function modifyImg(type){
		//设置主图
		if(!checkSelImg(type)){
			return false;
		}
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/upImg/modifyImg",
			dataType : "json",
			async : false,
			/* ajaxStart : function() {
				$("#loading-container").prop("class",
						"loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass(
						"loading-inactive");
			}, */
			data : {
				"type" : type,
				"imgIds":$("#orders").val(),
				"imgUrl":$("#mian_pic").attr("imgUrl"),
				"imgName":$("#mian_pic").attr("imgName"),
			},
			success : function(response) {
				if(response.success=="true"){
					if(type == 2){
						$("#modal-body-success1").html("修改成功!");
				        $("#edit-success").attr({
									"style" : "display:block;z-index:9999;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-success"
								});
						/* $("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修改成功!</strong></div>");
	  	  				$("#wcSuccess").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"}); */
					}
					if(type == 4){
						$("#modal-body-success1").html("删除成功!");
				        $("#edit-success").attr({
									"style" : "display:block;z-index:9999;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-success"
								});
						/* $("#modal-body-success").html("<div class='alert alert-success fade in'><strong>删除成功!</strong></div>");
	  	  				$("#wcSuccess").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"}); */
					}
					loadImg($("#hid_color").val());
				}else{
					$("#warning2Body").text("修改失败!");
					$("#warning2").show();
				}
			}
		});
	}
	
	//获取选中的图片id,并校验
	function checkSelImg(type){
		var delFlag = true;
		if(type==3) return true;
		var arr = new Array();
		$("input[name='selImg']:checked").each(function (i) {
			arr[i] = this.value;
			if(this.value==$("#main_id").val()){
				delFlag = false;
			}
        });
		if(arr.length==0){
			$("#warning2Body").text("请选择图片！");
			$("#warning2").show();
			return false;
		}
		if(type==2){
			if(arr.length>1){
				$("#warning2Body").text("只能设置一张主图！");
				$("#warning2").show();
				return fasle;
			}
			$("#mian_pic").attr("imgUrl",$("#pic_"+arr[0]).attr("imgUrl"));
			$("#mian_pic").attr("imgName",$("#pic_"+arr[0]).attr("imgName"));
		}
		if(type==4){
			if(!delFlag){
				$("#warning2Body").text("不能删除主图！");
				$("#warning2").show();
				return false;
			}
		}
		var ids = arr.join(",");
		$("#orders").val(ids);
		return true;
	}
	
	//图片排序	
	 /* function sortImg(){
		$('.gridly').gridly('draggable', 'on');  // enables dragging
		$("#wcSuccess2").html(
				"<div class='alert alert-success fade in'>"
						+ "<strong>拖拽图片进行排序</strong></div>");
		$("#wcSuccess").attr({
			"style" : "display:block;z-index:9999;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-success"
		});
	}  */
	
	function wcSuccess() {
		$("#wcSuccess").hide();
		loadImg($("#hid_color").val());
	}
	
	
</script>

</head>
<body>
  <div class="well with-header">
  	<div class="header bordered-danger" id="btn">
  		 <a class="btn btn-default danger btn-sm fa fa-edit" onclick="uploadImg();" > 图片上传</a>
		  <a class="btn btn-default danger btn-sm fa fa-edit" onclick="modifyImg(2);"> 设为主图</a>
<!-- 		  <a class="btn btn-default danger btn-sm fa fa-edit" onclick="modifyImg(1);" > 设为模特</a> -->
		  <a class="btn btn-default danger btn-sm fa fa-edit" onclick="modifyImg(4);" > 删除图片</a>
		  <!--  <a class="btn btn-default danger btn-sm fa fa-edit" onclick="sortImg();"> 图片排序</a>		 -->
		  <input id="input_maxsort" type="hidden" value="${maxSort}" />	
  	</div>
  	<input id="orders" type="hidden">
	<input id="mian_pic" type="hidden" imgUrl="" imgName="" value="" /> 
	<div class="gridly">
	<c:forEach items="${imgs}" var="img">
	  <div imgId="${img.sid}" class="brick small">
	  	<div class="con_img">
	  		<img src="${img_server}${img.pictureUrl}?${uid}" width="100%" height="100%" />
	  		<input id="pic_${img.sid}" type="hidden" imgUrl="${img.pictureUrl}" imgName="${img.pictureName}" value="${img.sid}" /> 
	  	</div>
	  	<div class="img_tip">
	  		<c:if test="${img.isPrimary==0}">
	  			<span class="badge badge-danger" style="margin:0">主</span>
	  			<input id="main_id" type="hidden" value="${img.sid}" />
	  		</c:if>
	  		<span class="imgNameSpan" style="float:right;margin:2px 10px 0 0;">${img.pictureName}</span>
	  	</div>
	  	<c:if test="${mark == 0 }">
	  	<div class="sel_img">
	  		<div class="checkbox">
	  		   <label>
                  <input  name="selImg" value="${img.sid}" type="checkbox">
                  <span class="text"></span>
               </label>
             </div>
        </div>
        </c:if>
      </div>
      </c:forEach>
	</div>
  </div>
  
  <div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="wcSuccess">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<i class="glyphicon glyphicon-check"></i>
				</div>
				<div class="modal-body" id="wcSuccess2">修改成功!</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="wcSuccess()">确定</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<style type='text/css'>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--  
<script type="text/javascript" src="${ctx}/sysjs/promotion/flushcache.js"></script>
<script type="text/javascript" src="${ctx}/sysjs/channelTreeSelector.js"></script>
<script type="text/javascript" src="${ctx}/sysjs/SysConstant.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/RowExpander.js"></script>
-->
<title>订单列表</title>
<script type="text/javascript">
__ctxPath = "${pageContext.request.contextPath}";
$(function(){
	var channelId=$("#channelId");
		$.ajax({
		type: "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url: __ctxPath + "/channel/channeltree",
		dataType: "json",
		success: function(response) {
			var result = response;
			//alert(result);
			channelId.html("<option value='-1'></option>");
			for ( var i = 0; i < result.length; i++) {
				var ele = result[i];
				var option = $("<option value='" + ele.id + "'>"
							+ ele.text + "</option>");
				option.appendTo(channelId);
			}
			return;
		}
	});
});
//清楚频道缓存
function clearChannelCache(){
	var channelId=$("#channelId").val();
	if(channelId!=-1&&channelId!=null){
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/cache/deleteChannel",
			dataType: "json",
			data: {
				"channelSid":channelId
			},
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>清理成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>缓存清理失败!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}else{
		alert("请选择频道！");
	}
}
//清除商品缓存
function clearProductCache(){
	var cachekey=$("#cachekey").val();
	if(cachekey!=null&&cachekey!=""){
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/cache/delete",
			dataType: "json",
			data: {
				"cachekey":cachekey
			},
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>清理成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>缓存清理失败!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}else{
		alert("请填写商品id");
	}
}
//清除活动缓存
function clearPromotionCache(){
	var promotionSid=$("#promotionSid").val();
	if(promotionSid!=null&&promotionSid!=""){
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/cache/deletePromotion",
			dataType: "json",
			data: {
				"promotionSid":promotionSid
			},
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>清理成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>缓存清理失败!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}else{
		alert("请填写活动id!");
	}
}
</script>
</head>
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
                                    <span class="widget-caption"><h5>缓存管理</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
									<div class="form-group">
										<label class="col-lg-3 control-label">频道</label>
										<div class="col-lg-6" style="width: 300px;">
											<select id="channelId" name="channelSid"></select>
										</div>
										<a id="editabledatatable_new" onclick="clearChannelCache();" class="btn btn-danger glyphicon glyphicon-trash">
											清除频道缓存
                                        </a>&nbsp;&nbsp;
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">商品id</label>
										<div class="col-lg-6" style="width: 300px;">
											<input type="text" class="form-control" id="cachekey" name="cachekey" placeholder="必填"/>
										</div>
										<a id="editabledatatable_new" onclick="clearProductCache();" class="btn btn-danger glyphicon glyphicon-trash">
											清除商品缓存
                                        </a>&nbsp;&nbsp;
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">活动id</label>
										<div class="col-lg-6" style="width: 300px;">
											<input type="text" class="form-control" id="promotionSid" name="promotionSid" placeholder="必填"/>
										</div>
										<a id="editabledatatable_new" onclick="clearPromotionCache();" class="btn btn-danger glyphicon glyphicon-trash">
											清除活动缓存
                                        </a>&nbsp;&nbsp;
									</div>
								</form>
							</div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Page Body -->
            </div>
            <!-- /Page Content -->
        </div>
</body>
</html>
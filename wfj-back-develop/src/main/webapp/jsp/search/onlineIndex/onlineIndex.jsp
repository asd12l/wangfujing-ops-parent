<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<style type='text/css'>
	.reset{
		width: 150px;
		float: right;
	}
	#store{
		float: right;
		width: 320px;
	}
	#set{
		float: right;
	}
	#item2{
		margin-top: 15px;
	}
	#pro1{
		height: 80px;
	}
	.ti{
		width: 200px;
		float: left;
	}
	#allIndex{
		float: right;	
		margin-right: 18px;
	}
	#bg{
		background-color: gray;
		
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
  <script type="text/javascript">
  
  __ctxPath = "${pageContext.request.contextPath}";
	
	$(function(){
		$("#set1").click(function(){
			var spuId=$("#spuId").val();
			
			if(spuId==""||spuId==null){
				
				return;
			}
			set();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function set(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/spuFresh",
	        dataType: "json",
	        data:{
	        	spuId:$("#spuId").val()
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>刷新成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					//$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.memo+"</strong></div>");
	     	  		//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#remove2").click(function(){
			var spuId=$("#spuId").val();
			
			if(spuId==""||spuId==null){
				
				return;
			}
			remove2();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function remove2(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/removeSpu",
	        dataType: "json",
	        data:{
	        	spuId:$("#spuId").val()
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>移除成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					//$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.memo+"</strong></div>");
	     	  		//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#fresh2").click(function(){
			var brandId=$("#brandId").val();
			
			if((brandId==""||brandId==null)){
				
				return;
			}
			fresh2();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function fresh2(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/brandFresh",
	        dataType: "json",
	        data:{
	        	brandId:$("#brandId").val(),
	        	
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>刷新成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#remove1").click(function(){
			var brandId=$("#brandId").val();
			
			if((brandId==""||brandId==null)){
				
				return;
			}
			remove1();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function remove1(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/removeBrand",
	        dataType: "json",
	        data:{
	        	brandId:$("#brandId").val(),
	        	
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>移除成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					//$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.memo+"</strong></div>");
	     	  		//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#fresh3").click(function(){
			var skuId=$("#skuId").val();
			
			if((skuId==""||skuId==null)){
				
				return;
			}
			fresh3();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function fresh3(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/skuFresh",
	        dataType: "json",
	        data:{
	        	skuId:$("#skuId").val(),
	        	
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>刷新成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					//$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.memo+"</strong></div>");
	     	  		//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#remove3").click(function(){
			var skuId=$("#skuId").val();
			
			if((skuId==""||skuId==null)){
				
				return;
			}
			remove3();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function remove3(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/removeSku",
	        dataType: "json",
	        data:{
	        	skuId:$("#skuId").val(),
	        	
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>移除成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					//$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.memo+"</strong></div>");
	     	  		//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#fresh4").click(function(){
			var itemId=$("#itemId").val();
			
			if((itemId==""||itemId==null)){
				
				return;
			}
			fresh4();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function fresh4(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/itemFresh",
	        dataType: "json",
	        data:{
	        	itemId:$("#itemId").val(),
	        	
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class=''></i><strong>刷新成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					//$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.memo+"</strong></div>");
	     	  		//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#remove4").click(function(){
			var itemId=$("#itemId").val();
			
			if((itemId==""||itemId==null)){
				
				return;
			}
			remove4();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function remove4(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/removeItem",
	        dataType: "json",
	        data:{
	        	itemId:$("#itemId").val(),
	        	
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>移除成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					//$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.memo+"</strong></div>");
	     	  		//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#fresh5").click(function(){
			var categoryId=$("#categoryId").val();
			
			if((categoryId==""||categoryId==null)){
				
				return;
			}
			fresh5();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function fresh5(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/categoryFresh",
	        dataType: "json",
	        data:{
	        	categoryId:$("#categoryId").val(),
	        	
	        },
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>刷新成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					//$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.memo+"</strong></div>");
	     	  		//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	$(function(){
		$("#bg").click(function(){
			bootbox.confirm("全量刷新索引十分耗时！确定要刷新吗?", function(r){
				if(r){
					freshall();
				}
			});
			
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
		});
	});
	
	function freshall(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/onlineIndex/allFresh",
	        dataType: "json",
	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class=''></i><strong>刷新成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/onlineIndex.jsp");
	}
  </script>
</head>
<body>
<div class="container">
  <div class="ti">
  	<h5>线上专柜商品索引管理：</h5>
  </div>
  <div class="col-md-2" id="allIndex">
  	 <a id="bg" onclick="" class="btn" style="width: 80%;">
  	 	<font color="white">全量刷新索引</font>
  	 </a>
  </div>
  
  <div id="item" class="col-md-3" style="width: 100%; height: 130px;background-color:white;">
       <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>根据品牌刷新索引</h5></span>
                                    <div class="widget-buttons">
                                        <!-- <a href="#" data-toggle="maximize"></a>
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        <a href="#" data-toggle="dispose"></a> -->
                                    </div>
                                </div>
                                <div class="widget-body" id="pro1">
                                    <div class="table-toolbar">
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>品牌编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="brandId" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                    
	                                	<div class="col-md-2" id="set">
	                                    	<a id="fresh2" class="btn btn-yellow" style="width: 80%;">
	                                    		<i class="fa fa-eye"></i>
												刷新
	                                        </a>
                                        </div>
                                        <div class="reset">
	                                        <a id="remove1" onclick="reset2();" class="btn btn-primary" style="width: 80%;">
	                                        	<i class="fa fa-random"></i>
												移除
	                                        </a>&nbsp;
	                                    </div>
	      							</div>
	      						</div>
          					</div>
         			 </div>
          	</div>
   </div>
 
   <div id="item2" class="col-md-3" style="width: 100%; height: 130px;background-color:white;">
       <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>根据SPU刷新索引</h5></span>
                                    <div class="widget-buttons">
                                        <!-- <a href="#" data-toggle="maximize"></a>
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        <a href="#" data-toggle="dispose"></a> -->
                                    </div>
                                </div>
                                <div class="widget-body" id="pro1">
                                    <div class="table-toolbar">
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>SPU编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="spuId" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                                	
	                                	<div class="col-md-2" id="set">
	                                    	<a id="set1" class="btn btn-yellow" style="width: 80%;">
	                                    		<i class="fa fa-eye"></i>
												刷新
	                                        </a>
                                        </div>
                                        <div class="reset">
	                                        <a id="remove2" onclick="" class="btn btn-primary" style="width: 80%;">
	                                        	<i class="fa fa-random"></i>
												移除
	                                        </a>&nbsp;
	                                    </div>
	      							</div>
	      						</div>
          					</div>
         			 </div>
          	</div>
   </div>
   
      <div id="item2" class="col-md-3" style="width: 100%; height: 130px;background-color:white;">
       <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>根据SKU刷新索引</h5></span>
                                    <div class="widget-buttons">
                                        <!-- <a href="#" data-toggle="maximize"></a>
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        <a href="#" data-toggle="dispose"></a> -->
                                    </div>
                                </div>
                                <div class="widget-body" id="pro1">
                                    <div class="table-toolbar">
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>SKU编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="skuId" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                                	
	                                	<div class="col-md-2" id="set">
	                                    	<a id="fresh3" class="btn btn-yellow" style="width: 80%;">
	                                    		<i class="fa fa-eye"></i>
												刷新
	                                        </a>
                                        </div>
                                        <div class="reset">
	                                        <a id="remove3" onclick="" class="btn btn-primary" style="width: 80%;">
	                                        	<i class="fa fa-random"></i>
												移除
	                                        </a>&nbsp;
	                                    </div>
	      							</div>
	      						</div>
          					</div>
         			 </div>
          	</div>
   </div>
   
      <div id="item2" class="col-md-3" style="width: 100%; height: 130px;background-color:white;">
       <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>根据item刷新索引</h5></span>
                                    <div class="widget-buttons">
                                        <!-- <a href="#" data-toggle="maximize"></a>
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        <a href="#" data-toggle="dispose"></a> -->
                                    </div>
                                </div>
                                <div class="widget-body" id="pro1">
                                    <div class="table-toolbar">
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>item编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="itemId" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                                	
	                                	<div class="col-md-2" id="set">
	                                    	<a id="fresh4" class="btn btn-yellow" style="width: 80%;">
	                                    		<i class="fa fa-eye"></i>
												刷新
	                                        </a>
                                        </div>
                                        <div class="reset">
	                                        <a id="remove4" onclick="" class="btn btn-primary" style="width: 80%;">
	                                        	<i class="fa fa-random"></i>
												移除
	                                        </a>&nbsp;
	                                    </div>
	      							</div>
	      						</div>
          					</div>
         			 </div>
          	</div>
   </div>
   
   <div id="item2" class="col-md-3" style="width: 100%; height: 130px;background-color:white;">
       <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>根据分类刷新索引</h5></span>
                                    <div class="widget-buttons">
                                       <!--  <a href="#" data-toggle="maximize"></a>
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        <a href="#" data-toggle="dispose"></a> -->
                                    </div>
                                </div>
                                <div class="widget-body" id="pro1">
                                    <div class="table-toolbar">
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>分类编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="storeCode1" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                                	
	                                	<div class="col-md-2" id="set">
	                                    	<a id="fresh5" class="btn btn-yellow" style="width: 80%;">
	                                    		<i class="fa fa-eye"></i>
												刷新
	                                        </a>
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
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
	#allIndex,#allIndexErp{
		float: right;
	}
	#allIndex{
		margin-right: 21px;
	}
	#allIndexErp{
		margin-right: -19px;
	}
	.btn{
		background-color: gray;
	}
	
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
  <script type="text/javascript">
  function reset(){
		$("#storeCode").val("");
		$("#shoppeCode").val("");
		$("#spuCode").val("");
		$("#skuCode").val("");
		$("#storeBrandCode").val("");
	}
  
  function reset1(){
	 	$("#storeCode1").val("");
		$("#storeBrandName").val("");
		$("#storeBrandCode1").val("");
  }
  
  function reset2(){
	 	$("#itemCode").val("");
		
}
  
  __ctxPath = "${pageContext.request.contextPath}";
  LA.sysCode = '28';
  var sessionId = "<%=request.getSession().getId() %>";
	$(function(){
		$("#fresh").click(function(){
			var storeCode=$("#storeCode").val();
			var shoppeCode=$("#shoppeCode").val();
			var spuCode=$("#spuCode").val();
			var skuCode=$("#skuCode").val();
			var storeBrandCode=$("#storeBrandCode").val();
			
			if((storeCode==""||storeCode==null) && (shoppeCode==""||shoppeCode==null) && (spuCode==""||spuCode==null) 
					&& (skuCode==""||skuCode==null) && (storeBrandCode==""||storeBrandCode==null)){
				
				return;
			}
			fresh();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/shoppe/shoppe.jsp");
		});
	});
	
	function fresh(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/shoppe/freshIndex",
	        dataType: "json",
	        data:{
	        	storeCode:$("#storeCode").val(),
	        	shoppeCode:$("#shoppeCode").val(),
	        	spuCode:$("#spuCode").val(),
	        	skuCode:$("#skuCode").val(),
	        	storeBrandCode:$("#storeBrandCode").val()
	        },
	        success:function(response) {
				LA.log('search.shoppeIndex', "刷新索引 storeCode:"+$("#storeCode1").val() + " storeBrandCode:"+$("#storeBrandCode1").val()+
						" shoppeCode:"+$("#shoppeCode").val()+" spuCode:"+$("spuCode").val()+" skuCode:"+$("#skuCode").val(), getCookieValue("username"), sessionId);
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
	
	$(function(){
		$("#set1").click(function(){
			var storeCode=$("#storeCode1").val();
			
			var storeBrandCode=$("#storeBrandCode1").val();
			
			if((storeCode1==""||storeCode1==null)  &&  (storeBrandCode1==""||storeBrandCode1==null)){
				
				return;
			}
			set();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/shoppe/shoppe.jsp");
		});
	});
	
	function set(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/shoppe/brand_Update",
	        dataType: "json",
	        data:{
	        	storeCode:$("#storeCode1").val(),
	        	storeBrandCode:$("#storeBrandCode1").val()
	        },
	        success:function(response) {
				LA.log('search.shoppeIndex', "根据品牌刷新索引 storeCode:"+$("#storeCode1").val() + " storeBrandCode:"+$("#storeBrandCode1").val(), getCookieValue("username"), sessionId);
				if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>修改成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	
	$(function(){
		$("#fresh2").click(function(){
			var storeCode=$("#itemCode").val();
			
			if((itemCode==""||itemCode==null)){
				
				return;
			}
			fresh2();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/shoppe/shoppe.jsp");
		});
	});
	
	function fresh2(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/shoppe/itemIndex",
	        dataType: "json",
	        data:{
	        	itemCode:$("#itemCode").val(),
	        	
	        },
	        success:function(response) {
				LA.log('search.shoppeIndex', "根据商品刷新索引 itemCode:"+$("#itemCode").val(), getCookieValue("username"), sessionId);
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
	
	$(function(){
		$("#bg").click(function(){
			bootbox.confirm("全量刷新索引十分耗时！确定要刷新吗?", function(r){
				if(r){
					freshall();
				}
			});
			
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/shoppe/shoppe.jsp");
		});
	});
	
	$(function(){
		$("#bg1").click(function(){
			bootbox.confirm("全量刷新索引十分耗时！确定要刷新吗?", function(r){
				if(r){
					freshall2();
				}
			});
			
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/shoppe/shoppe.jsp");
		});
	});
	
	function freshall(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/shoppe/allFresh",
	        dataType: "json",
	        data:{},
	        success:function(response) {
				LA.log('search.shoppeIndex', "全量刷新索引", getCookieValue("username"), sessionId);
				if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class=''></i><strong>刷新成功!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					alert(response.message);
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
      	}
		});
	}
	
	function freshall2(){
		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/shoppe/allFreshERP",
	        dataType: "json",
	        data:{},
	        success:function(response) {
				LA.log('search.shoppeIndex', "全量刷新大码索引", getCookieValue("username"), sessionId);
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
		$("#pageBody").load(__ctxPath+"/jsp/search/shoppe/shoppe.jsp");
	}
  </script>
</head>
<body>
<div class="container">
  <div class="ti">
  	<h5>线下索引管理：</h5>
  </div>
  <div class="col-md-2" id="allIndex">
  	 <a id="bg" onclick="" class="btn" style="width: 80%;">
  	 	<font color="white">全量刷新商品</font>
  	 </a>
  	 
  </div>
  <div class="col-md-2" id="allIndexErp">
  	<a id="bg1" onclick="" class="btn" style="width: 80%;">
  	 	<font color="white">全量刷新大码商品</font>
  	 </a>
  </div>
  
  <div id="item" class="col-md-3" style="width: 100%; height: 140px;background-color:white;">
       <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>专柜商品刷新索引</h5></span>
                                    <div class="widget-buttons">
                                       <!--  <a href="#" data-toggle="maximize"></a>
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        <a href="#" data-toggle="dispose"></a> -->
                                    </div>
                                </div>
                                <div class="widget-body" id="pro1">
                                    <div class="table-toolbar">
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>专柜商品编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="itemCode" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                    
	                                	<div class="col-md-2" id="set">
	                                    	<a id="fresh2" class="btn btn-yellow" style="width: 80%;">
	                                    		<i class="fa fa-eye"></i>
												刷新
	                                        </a>
                                        </div>
                                        <div class="reset">
	                                        <a id="reset" onclick="reset2();" class="btn btn-primary" style="width: 80%;">
	                                        	<i class="fa fa-random"></i>
												重置
	                                        </a>&nbsp;
	                                    </div>
	      							</div>
	      						</div>
          					</div>
         			 </div>
          	</div>
   </div>
 
   <div id="item2" class="col-md-3" style="width: 100%; height: 140px;background-color:white;">
       <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>根据品牌刷新索引</h5></span>
                                    <div class="widget-buttons">
                                      <!--   <a href="#" data-toggle="maximize"></a>
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        <a href="#" data-toggle="dispose"></a> -->
                                    </div>
                                </div>
                                <div class="widget-body" id="pro1">
                                    <div class="table-toolbar">
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>门店编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="storeCode1" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>门店品牌编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="storeBrandCode1" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                    
	                                	<div class="col-md-2" id="set">
	                                    	<a id="set1" class="btn btn-yellow" style="width: 80%;">
	                                    		<i class="fa fa-eye"></i>
												修改
	                                        </a>
                                        </div>
                                        <div class="reset">
	                                        <a id="reset" onclick="reset1();" class="btn btn-primary" style="width: 80%;">
	                                        	<i class="fa fa-random"></i>
												重置
	                                        </a>&nbsp;
	                                    </div>
	      							</div>
	      						</div>
          					</div>
         			 </div>
          	</div>
   </div>
   
   
   
    <div id="item2" class="col-md-3" style="width: 100%; height: 160px;background-color:white;">
          <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>刷新索引</h5></span>
                                    <div class="widget-buttons">
                                      <!--   <a href="#" data-toggle="maximize"></a>
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        <a href="#" data-toggle="dispose"></a> -->
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                    	<div class="col-md-4">
	                                		<div class="col-lg-3">门店编码：</div>
	                                		<div class="col-lg-9">
                                   				<input maxlength="20" type="text" id="storeCode"  style="width: 100%;"/>
                                   			</div>
                                		</div>
                                    	<div class="col-md-4">
	                                		<div class="col-lg-3"><span>专柜编码：</span></div>
	                                		<div class="col-lg-9"><input maxlength="20" type="text" id="shoppeCode" style="width: 100%"/></div>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>产品编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="spuCode" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>SKU编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="skuCode" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4"><span>门店品牌编码：</span></div>
	                                		<div class="col-lg-8"><input maxlength="20" type="text" id="storeBrandCode" style="width: 100%"/></div>
	                                		&nbsp;
	                                	</div>&nbsp;
	                                	<div class="col-md-2" id="set">
	                                    	<a id="fresh" class="btn btn-yellow" style="width: 80%;">
	                                    		<i class="fa fa-eye"></i>
												刷新
	                                        </a>
                                        </div>
                                        <div class="reset">
	                                        <a id="reset" onclick="reset();" class="btn btn-primary" style="width: 80%;">
	                                        	<i class="fa fa-random"></i>
												重置
	                                        </a>&nbsp;
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
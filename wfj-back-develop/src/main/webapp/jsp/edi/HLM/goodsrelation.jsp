<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<!--Jquery Select2-->
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script src="${pageContext.request.contextPath}/js/jquery/jquery.form.js"></script>

<style>
.jiechu{
	cursor: pointer;
	color: red;
}
a:hover{color: black;text-decoration: none;}

.shoudong{
	width: 400px;
	height: 130px;
	border: 1px solid red;
	vertical-align: middle;
	MARGIN-LEFT: 350px;
	margin-top: -134px;
	z-index:99999;
	background: #F8F6F5;
	position: fixed;
	text-align: center;
	visibility: hidden;
}
.one{
	width: 400px;
	height: 30px;
	margin: 0 auto;
	margin-top: 20px;
}
.two{
	width: 300px;
	height: 42px;
	margin: 0 auto;
	margin-top: 32px;
}
.piliang{
	width: 400px;
	height: 130px;
	border: 1px solid red;
	vertical-align: middle;
	MARGIN-LEFT: 350px;
	margin-top: -134px;
	z-index:99999;
	background: #F8F6F5;
	position: fixed;
	text-align: center;
	visibility: hidden;
}

</style>

<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	
	function initStock() {
		var url = $("#ctxPath").val() + "/Commoditymessage/selectCommoditySearch?type=ITEMADD";
		stockPagination = $("#stockPagination").myPagination(
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
							$("#loading-container").attr("class","loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass("loading-inactive")
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#stock_tab tbody").setTemplateElement("stock-list").processTemplate(data);
						}
					}
					
				});
	}
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
	}
	
	var olvPagination;
	
	//重置
	function reset() {
		$("#num_iids").val("");
		$("#outer_ids").val("");
		$("#sku_names").val("");
		$("#brand_names").val("");
		goodsQuery();
	}
	
	//按条件查询
	function goodsQuery(){
		$("#num_iid").val($("#num_iids").val());
		$("#outer_id").val($("#outer_ids").val());
		var newStr = $("#sku_names").val().replace(/\s+/g,"");
		$("#sku_name").val(newStr);
		var brand_name = $("#brand_names").val().replace(/\s+/g,"");
		$("#brand_name").val(brand_name);
		$("#pageSelect").val($("#pageSelect2").val());
		$("#new_refundId_from").val($("#new_refundId_from2").val());
        var params = $("#goods_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	
	
	$(function() {
	    initOlv();
	    $("#pageSelect2").change(goodsQuery);
	});
	
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/ediGoods/selectGoodsList?channel_code=OB";
		olvPagination = $("#olvPagination").myPagination({
           panel: {
             tipInfo_on: true,
             tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
             tipInfo_css: {
               width: '25px',
               height: "20px",
               border: "2px solid #f0f0f0",
               padding: "0 0 0 5px",
               margin: "0 5px 0 5px",
               color: "#48b9ef"
             }
           },
           debug: false,
           ajax: {
             on: true,
             url: url,
             dataType: 'json',
             ajaxStart: function() {
            	 $("#loading-container").attr("class","loading-container");
             },
             ajaxStop: function() {
               //隐藏加载提示
               setTimeout(function() {
            	   $("#loading-container").addClass("loading-inactive")
               }, 300);
             },
             callback: function(data) {
            	//alert($("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data));
           		 $("#goods_table tbody").setTemplateElement("goods-list").processTemplate(data);
             }
           }
         });
    }
	
	//手动关联隐藏div
 	function hidd(){
 		$("#numiid").val("");
	 	if(document.getElementById('yincang').style.visibility == 'hidden'){
	 		document.getElementById('yincang').style.visibility = 'visible';
	 	} else {
	 		document.getElementById('yincang').style.visibility = 'hidden';
	 	}
 	 }
	
 	//手动关联显示div
 	function vis(){
	 	if(document.getElementById('yincang').style.visibility == 'visible'){
	 		document.getElementById('yincang').style.visibility = 'hidden';
	 	} else {
	 		document.getElementById('yincang').style.visibility = 'visible';
	 	}
 	 }
 	
 	//批量关联隐藏div
 	function hidds(){
	 	if(document.getElementById('piliang').style.visibility == 'hidden'){
	 		document.getElementById('piliang').style.visibility = 'visible';
	 	} else {
	 		document.getElementById('piliang').style.visibility = 'hidden';
	 	}
 	 }
	
 	//批量关联显示div
 	function viss(){
	 	if(document.getElementById('piliang').style.visibility == 'visible'){
	 		document.getElementById('piliang').style.visibility = 'hidden';
	 	} else {
	 		document.getElementById('piliang').style.visibility = 'visible';
	 	}
 	 }
 	
 	//手动关联
	function manual(){
        var numiid = $("#numiid").val();
        if(numiid){
        	 $.ajax({
        		on: true,
     			url : __ctxPath + "/ediGoods/goodsManual?numiid="+numiid+"&channelCode=OB",
     			dataType : "json",
     			success : function(data) {
     				reset();
				},
        	 	error:function(){ 
        			reset(); 
        	   	} 
     		});
        } else{
        	alert("请输入好乐买ID！");
        }
        hidd();
   	}
 	
	//批量关联
 	function batchAssociated(){
 		var fileName = $('#file').val();
 		var fileA = fileName.split(".");
 	 	//获取截取的最后一个字符串，即为后缀名
 		var suffix = fileA[fileA.length-1];
 	 	var url = __ctxPath + "/ediGoods/goodsBatch?channelCode=C7";
 		if(suffix == 'xlsx' || suffix == 'XLSX' || suffix == 'xls' || suffix == 'XLS'){
 			var form = $('#impDataForm');
 			//form.attr('action', url);
 			//form.submit();
	        var options  = {    
	            url:url,    
	            type:'post',  
	            success : function(data) {
	            	hidds();
		            reset();
				},
        	 	error:function(){ 
        	 		hidds();
		            reset(); 
        	   	}
	        };    
	        form.ajaxSubmit(options); 
 			
 		}else{
 			alert("您上传的文件格式不正确，请上传excel文件。");
 			reset();
 		}
 	 	//reset();
 	}
 	
	//自动关联
	function automatic(){
       	 $.ajax({
       		on: true,
  			url : __ctxPath + "/ediGoods/goodsAutomatic?channelCode=C7",
  			dataType : "json"
    	});
        reset();
   	}
	
	//解除关联关系
	function removeRelation(outerid,numiid){
       	 $.ajax({
       		on: true,
    			url : __ctxPath + "/ediGoods/goodsRemove?outerid="+outerid+"&numiid="+numiid+"&channelCode=C7",
    			dataType : "json",
    			success : function(data) {
		            reset();
				},
        	 	error:function(){ 
		            reset(); 
        	   	}
    	});
        reset();
   	}
</script>
</head>

<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">好乐买商品关联</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
																		
								<div class="table-toolbar" style="z-index:-1;">
									<ul class="listInfo clearfix">
										<li>
											<span>好乐买ID：</span>
											<input type="text" id="num_iids" style="width: 150px"/>
										</li>
										<li>
											<span>商家编码：</span>
											<input type="text" id="outer_ids" style="width: 150px"/>
										</li>
										<li>
											<span>商品名称：</span>
											<input type="text" id="sku_names" style="width: 150px"/>
										</li>
										<li>
											<span>品牌名称：</span>
											<input type="text" id="brand_names" style="width: 150px"/>
										</li>
										
										<form id="goods_form" action="">
											<input type="hidden" id="num_iid" name="num_iid" />
											<input type="hidden" id="outer_id" name="outer_id" />
											<input type="hidden" id="sku_name" name="sku_name" />
											<input type="hidden" id="brand_name" name="brand_name" />
											<input type="hidden" id="pageSelect" name="pageSize" />
											<input type="hidden" id="new_refundId_from" name="new_refundId" />
										</form>
										
										<li style="height:35px;margin-top:0">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<a style="width:150px" class="btn btn-default shiny" onclick="vis();">手 动 关 联</a>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<a style="width:150px" class="btn btn-default shiny" onclick="viss();">批 量 关 联</a>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<!-- <a style="width:150px" class="btn btn-default shiny" onclick="automatic();">自 动 关 联</a> -->
										</li>
										<li style="height:35px;margin-top:0;float:right">
											<a class="btn btn-default shiny" onclick="goodsQuery();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</li>
									</ul>
								</div>
								
								<!-- 手动关联点击弹出 -->
								<div class="shoudong" id="yincang">
									<div class="one">
										<span>请输入好乐买ID：</span>
										<input type="text" id="numiid" name="numiid" style="width: 150px"/>
									</div>
									<div class="two">
										<a class="btn btn-default shiny" onclick="manual();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提 交&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="hidd();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;关 闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
									</div>
								</div>
								
								<!-- 批量关联关联点击弹出 -->
								<div class="piliang" id="piliang">
									<form action="#" style="display: inline;" id="impDataForm" method="post" enctype="multipart/form-data">
										<div class="one">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											请选择文件：<input type="file" name="file" id="file" style="display: inline;">
										</div>
									</form>
									<div class="two">
										<a class="btn btn-default shiny" onclick="batchAssociated();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提 交&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="hidds();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;关 闭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
									</div>
								</div>
								
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="goods_table">
                                       <thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th style="text-align: center;">好乐买ID</th><!-- num_iid -->
											<th style="text-align: center;">商家编码</th><!--outer_id -->
											<th style="text-align: center;">品牌名称</th><!-- brand_name -->
											<th style="text-align: center;">商品名称</th><!--sku_name  -->
											<th style="text-align: center;">操作</th><!-- operation -->
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="stock_form" action="">
										<div class="col-lg-12">
	                                        	<select id="pageSelect2" name="pageSize2" style="padding: 0 12px;">
													<option>5</option>
													<option>10</option>
													<option selected="selected">15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										 <input type="hidden" id="new_refundId_from2" name="new_refundId2" />
									</form>
								</div>
								<div id="olvPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="goods-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr style="height: 10px" class="gradeX">
													<td align="center" id="getNumiid">{$T.Result.num_iid}</td>
													<td align="center" id="getOuterId">{$T.Result.outer_id}</td>
													<td align="center" id="productCode_{$T.Result.sid}">{#if $T.Result.brand_name == null || $T.Result.brand_name == ""} --- {#else} {$T.Result.brand_name} {#/if}</td>
													<td align="center" id="unitName_{$T.Result.sid}">{$T.Result.sku_name}</td>
													<td align="center">
														<input type="button" value="解除关联" onclick="removeRelation('{$T.Result.outer_id}','{$T.Result.num_iid}')"></input>
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	
								</textarea>
							</p>
						</div>
					</div>
				</div>
			</div>
			<!-- /Page Body -->
		</div>
		<!-- /Page Content -->
	</div>
	<!-- /Page Container -->
	<!-- Main Container -->
	</div>
</body>
</html>
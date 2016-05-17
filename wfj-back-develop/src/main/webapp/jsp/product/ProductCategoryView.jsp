<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 商品分类管理
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<script src="${pageContext.request.contextPath}/js/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/zTreeStyle/metro.css">
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var pcPagination;
	$(function() {    	
	    initPc();
	    $("#pageSelect").change(pcQuery);
	});
	function pcQuery(){
        var params = $("#pc_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        pcPagination.onLoad(params);
   	}
	function reset(){
		colorQuery();
	}
 	function initPc() {
		var url = __ctxPath+"/productCategory/selectAllProductCategory";
		pcPagination = $("#pcPagination").myPagination({
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
	        	 },300);
	         },
             ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
             callback: function(data) {
               //使用模板
               $("#pc_tab tbody").setTemplateElement("pc-list").processTemplate(data);
             }
           }
         });
    }
 	//维护关系
 	var zNodes="";
 	var productSid = "";
	function modifyCa(data){
		var id = [];
		$.ajax({url:__ctxPath+"/productCategory/edit?pid="+data,dataType:"json",ajaxStart: function() {
       	 $("#loading-container").attr("class","loading-container");
        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive")
       	 },300);
        },async:false,success:function(response){
			productSid = data;
			id = response.categorySid;
			$("#categorySid").val(response.categorySid);
		}});
		$.ajax({
			 type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/productCategory/liste?productSid="+data,
	        dataType: "json",
	        ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
	        success:function(response) {
	        	zNodes=response;
	        	//$("#znodes").val(zNodes);
	        	var t = $("#tree");
	            t = $.fn.zTree.init(t, setting, zNodes);
	            var names = "";
	            for(var i=0;i<response.length;i++){
	            	for(var j=0;j<id.length;j++){
		            	if(id[j] == response[i].id){
		            		names +=response[i].name+",";
		            	}
	            	}
	            }
	            /* 去除末尾逗号 */
	            var lastIndex = names.lastIndexOf(',');
	            names = names.substring(0, lastIndex) + names.substring(lastIndex + 1, names.length);
	            $("#productName").val(names);
      		}
		});
		$("#pcDiv").show();
	}
	var zTree;
    var setting = {
        check: {
            enable: true
        },
        view: {
            dblClickExpand: false,
            showLine: true,
            selectedMulti: false
        },
        data: {
            simpleData: {
                enable:true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: ""
            }
        },
        callback: {
        	onClick: function(event,treeId, treeNode,clickFlag){
        		var treeObj = $.fn.zTree.getZTreeObj("tree");
        		treeObj.checkNode(treeNode,true,true);
        		var nodes = treeObj.getCheckedNodes(true);
       			var names = "";
       			var ids = "";
       			for(var i=0;i<nodes.length;i++){
       				if(i==nodes.length){
       					names+=nodes[i].name;
       					ids += nodes[i].id;
       				}else{
       					names+=nodes[i].name+",";
       					ids += nodes[i].id+",";
       				}
   				}
       			$("#categorySid").val(ids);
       			$("#productName").val(names);
        	},
        	onCheck: function(event,treeId, treeNode,clickFlag){
        		var treeObj = $.fn.zTree.getZTreeObj("tree");
        		var nodes = treeObj.getCheckedNodes(true);
        		var names = "";
        		var ids = "";
   				for(var i=0;i<nodes.length;i++){
   					if(i==nodes.length){
       					names+=nodes[i].name;
       					ids += nodes[i].id;
       				}else{
       					names+=nodes[i].name+",";
       					ids += nodes[i].id+",";
       				}
   				}
   				$("#categorySid").val(ids);
   				$("#productName").val(names);
        	}
        }
    };

    function loadReady() {
        var bodyH = demoIframe.contents().find("body").get(0).scrollHeight,
                htmlH = demoIframe.contents().find("html").get(0).scrollHeight,
                maxH = Math.max(bodyH, htmlH), minH = Math.min(bodyH, htmlH),
                h = demoIframe.height() >= maxH ? minH:maxH ;
        if (h < 530) h = 530;
        demoIframe.height(h);
    }
    //保存tree选中的节点
    function saveDivFrom(){
    	var cSid = $("#categorySid").val();
   		$.ajax({
			type:"post",
   	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
   	        url:__ctxPath + "/productCategory/save",
   	        dataType: "json",
	   	     ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
   	        data:{
   	        	"productSid":productSid,
   	        	"categorySid":cSid
   	        },
   	        success:function(response) {
   	        	if(response.status == 'success'){
   	        		$("#pcDiv").hide();
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>操作成功，返回列表页!</strong></div>");
		  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>操作失败!</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
       		}
		});
    }
    //ul加号处理
    function divUlApp(){
    	if($("#divLabel").attr("class")=="fa fa-angle-double-up"){
    		$("#divLabel").attr("class","fa fa-angle-double-down");
    		$("#tree").hide();
    	}else{
    		$("#divLabel").attr("class","fa fa-angle-double-up");
    		$("#tree").show();
    	}
    }
    function closeCategoryDiv(){
    	$("#pcDiv").hide();
    }
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/product/ProductCategoryView.jsp");
	}
	</script> 
</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
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
                                    <span class="widget-caption"><h5>商品分类管理</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="pc_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr>
                                                <th style="text-align: center;">商品名称</th>
                                                <th style="text-align: center;">商品SKU</th>
                                                <th style="text-align: center;">商品品牌</th>
                                                <!-- <th style="text-align: center;">正式品牌标记</th> -->
                                                <th style="text-align: center;">生效标记</th>
                                                <th style="text-align: center;">上架标记</th>
                                                <!-- <th style="text-align: center;">款式</th> -->
                                                <th style="text-align: center;">操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div style="margin-top: 5px;">
                                       <div class="pull-left">
                                       		 <form id="pc_form" action="">
	                                        	<select id="pageSelect" name="pageSize">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
	                                       	</form>
                                        </div>
                                    </div>
                                    <div id="pcPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="pc-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="center" style="vertical-align:middle;">{$T.Result.product_name}</td>
													<td align="center" style="vertical-align:middle;">{$T.Result.product_sku}</td>
													<td align="center" style="vertical-align:middle;">{$T.Result.brand_name}</td>
													<td align="center" style="vertical-align:middle;">
														{#if $T.Result.pro_active_bit == 0}
						           							<span class="btn btn-danger btn-xs">无效</span>
						                      			{#elseif $T.Result.pro_active_bit == 1}
						           							<span class="btn btn-success btn-xs">有效</span>
						                   				{#/if}
													</td>
													<td align="center" style="vertical-align:middle;">
														{#if $T.Result.pro_selling == 0}
						           							<span class="btn btn-danger btn-xs">无效</span>
						                      			{#elseif $T.Result.pro_selling == 1}
						           							<span class="btn btn-success btn-xs">有效</span>
						                   				{#/if}
													</td>
													<td align="center" style="vertical-align:middle;">
														<a onclick="modifyCa({$T.Result.sid})" class="btn btn-info glyphicon glyphicon-wrench">
															维护分类对应关系
                                        				</a>
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
                            </div>
                            <!-- 备用字段 款式和正式品牌标记 -->
                            <!-- 
                            	<td align="center" style="vertical-align:middle;">{$T.Result.colorAlias}</td>
                            	<td align="center" style="vertical-align:middle;">
									{#if $T.Result.proType == 0}
	           							<span class="btn btn-danger btn-xs">无效</span>
	                      			{#elseif $T.Result.proType == 1}
	           							<span class="btn btn-success btn-xs">有效</span>
	                   				{#/if}
								</td>
                             -->
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
    <div class="modal modal-darkorange" id="pcDiv">
        <div class="modal-dialog" style="width: 400px;margin: 80px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCategoryDiv();">×</button>
                    <h4 class="modal-title">展示分类信息</h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divForm" method="post" class="form-horizontal" enctype="multipart/form-data">
					                <input type="hidden" id="categorySid" />
					                <div class="form-group">
					                	<input type="text" id="productName" readonly="readonly" style="width: 95%;height: 30px;padding: 6px 12px;">&nbsp;
										<label class="fa fa-angle-double-down" id="divLabel" onclick="divUlApp()"></label>
										<!-- 自定义滚动条 -->
										<div  style="height:220px; overflow:auto;">
				 							<ul id="tree" style="display: none;" class="ztree" overflow:auto;"></ul>
				 						</div>
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeCategoryDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
</body>
</html>
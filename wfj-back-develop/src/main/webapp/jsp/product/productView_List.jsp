<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 产品列表页
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
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var productPagination;
	$(function() {    	
	    initProduct();
	    $("#proType_select").change(productQuery);
	    $("#pageSelect").change(productQuery);
	});
	function productQuery(){
		$("#skuCode_from").val($("#skuCode_input").val());
		$("#skuName_from").val($("#skuName_input").val());
        var params = $("#product_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        productPagination.onLoad(params);
   	}
	// 查询
	function query(){
		productQuery();
	}
	// 重置
	function reset(){
		$("#skuCode_input").val("");
		$("#skuName_input").val("");
		productQuery();
	}
	//初始化商品列表
 	function initProduct() {
		var url = $("#ctxPath").val()+"/product/selectAllSpu";
		productPagination = $("#productPagination").myPagination({
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
             callback: function(data) {
               //使用模板
               $("#product_tab tbody").setTemplateElement("product-list").processTemplate(data);
             }
           }
         });
    }
	
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
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
                                    <h5 class="widget-caption">产品管理</h5>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                    <div class="mtb10">
                                    		<span>编码:</span>
                                			<input type="text" id="skuCode_input"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                			<span>标准品名：</span>
		                                	<input type="text" id="skuName_input" />&nbsp;&nbsp;&nbsp;&nbsp;
	                                		<a class="btn btn-default shiny" onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
                           					<a class="btn btn-default shiny" onclick="reset();">重置</a>
                           					<!-- <div class="col-md-3">
		                                		<span>产品名称：</span>
			                                	<input type="text" id="spuName_input" style="width: 70%;"/>
		                                	</div> -->
                                    	</div>
                                	</div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="product_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr>
                                            	<th style="text-align: center;" width="5%">选择</th>
                                                <th style="text-align: center;">编码</th>
                                                <th style="text-align: center;">标准品名</th>
                                                <th style="text-align: center;">款号</th>
                                                <th style="text-align: center;">主属性</th>
                                                <th style="text-align: center;">集团品牌名称</th>
                                                <th style="text-align: center;">工业分类</th>
                                                <th style="text-align: center;">统计分类</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                     <div class="pull-left" style="padding: 10px 0;">
                                   		 <form id="product_form" action="">
                                     		<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp;
											<input type="hidden" id="skuCode_from" name="spuCode"/>
											<input type="hidden" id="skuName_from" name="productName"/>
											<input type="hidden" id="proType_from" name="industryCondition"/>
                                      	</form>
                                      </div>
                                    <div id="productPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="product-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">{$T.Result.spuCode}</td>
													<td align="center">{$T.Result.productName}</td>
													<td align="center">{$T.Result.modelCode}</td>
													<td align="center">{$T.Result.primaryAttr}</td>
													<td align="center">{$T.Result.brandGroupName}</td>
													<td align="center">{$T.Result.categoryName}</td>
													<td align="center">{$T.Result.statCategoryName}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
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
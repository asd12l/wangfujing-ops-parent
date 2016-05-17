<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
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
	
	
	var promotionPagination;
	$(function() {    	
	    initAdv();
	    $("#promotionSku_input").change(promotionQuery);
	    $("#promotionId_input").change(promotionQuery);
	    $("#brandName_input").change(promotionQuery);
	    $("#beginTime_input").change(promotionQuery);
	    $("#endTime_input").change(promotionQuery);
	    $("#pageSelect").change(promotionQuery);
	   
	});
	function promotionQuery(){
		$("#promotionSku_input").val($("#promotionSku_input").val());
		$("#promotionId_input").val($("#promotionId_input").val());
		$("#brandName_input").val($("#brandName_input").val());
		$("#beginTime_input").val($("#beginTime_input").val());
		$("#endTime_input").val($("#endTime_input").val());
        var params = $("#promotion_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        promotionPagination.onLoad(params);
   	}
	function reset(){
		$("#promotionSku_input").val("");
		$("#promotionId_input").val("");
		$("#brandName_input").val("");
		$("#beginTime_input").val("");
		$("#endTime_input").val("");
		promotionQuery();
	}
	//初始化广告列表
 	function initAdv() {
		var url = $("#ctxPath").val()+"/promotions/selectPromotionListByKey";
		productPagination = $("#promotionPagination").myPagination({
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
               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
             },
             ajaxStop: function() {
               //隐藏加载提示
               setTimeout(function() {
                 ZENG.msgbox.hide();
               }, 300);
             },
             callback: function(data) {
               //使用模板
               $("#promotion_tab tbody").setTemplateElement("promotion-list").processTemplate(data);
             }
           }
         });
    }
	//按钮事件-添加商品
	function addPromotion(){
		bootbox.confirm("确定添加活动？", function(r){
			if(r){
				var url = __ctxPath+"/jsp/ws/addAdv.jsp";
				$("#pageBody").load(url);
			}
		});
	}
	//按钮事件-查询商品详情
	function getPromotionAdv(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var promotionSid = $(this).val();
			checkboxArray.push(promotionSid);
		});
		if(checkboxArray.length>1){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else if(checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要查看的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/product/getProductDetail/"+value;
		$("#pageBody").load(url);
	}
	//按钮事件-补充商品
	function appendProduct (){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else if(checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要补充的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/product/toproduct/"+value;
		$("#pageBody").load(url);
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
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/web/addAdv.jsp");
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
                                    <span class="widget-caption"><h5>活动管理</h5></span>
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
                                    <div class="col-md-4">
	                                		<div class="col-lg-5"><span>选项：</span></div>
	                                		<div class="col-lg-7"><input type="text" id="promotionSku_input" style="width: 100%"/></div>
	                                	</div>
                                    	<div class="col-md-4">
	                                		<div class="col-lg-5"><span>活动Id：</span></div>
	                                		<div class="col-lg-7"><input type="text" id="promotionId_input" style="width: 100%"/></div>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-5"><span>活动标题：</span></div>
	                                		<div class="col-lg-7"><input type="text" id="brandName_input" style="width: 100%"/></div>
	                                	</div>
	                                	<hr>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-5"><span>开始时间：</span></div>
	                                		<div class="col-lg-7"><input type="text" id="beginTime_input" style="width: 100%"/></div>
	                                	</div>
	                               	
	                                	<div class="col-md-4">
	                                		<div class="col-lg-5"><span>结束时间：</span></div>
	                                		<div class="col-lg-7"><input type="text" id="endTime_input" style="width: 100%"/></div>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-12">
                                				<a class="btn btn-default" onclick="" style="margin-top:-6px;">查询</a>
                                			</div>&nbsp;
                                		</div>
	                                	
	                                	<div class="col-md-4">
	                                		<div class="col-lg-12">
                                				<a class="btn btn-default" onclick="reset();" style="margin-top:-6px;">重置</a>
                                			</div>&nbsp;
                                		</div>
                                		 <div class="col-md-6">
	                                       <div class="btn-group pull-right">
	                                       		 <form id="promotion_form" action="">
	                                       		 	<div class="col-lg-12">
			                                        	<select id="pageSelect" name="pageSize">
															<option>5</option>
															<option selected="selected">10</option>
															<option>15</option>
															<option>20</option>
														</select>
													</div>&nbsp;
													<input type="hidden" id="promotionSku_from" name="promotionSku"/>
													<input type="hidden" id="promotionId_from" name="promotionId"/>
													<input type="hidden" id="brandName_from" name="brandName"/>
													<input type="hidden" id="beginTime_from" name="beginTime"/>
													<input type="hidden" id="endTime_from" name="endTime"/>
		                                       	</form>
	                                        </div>
	                                     </div>
                                	</div>
                                    <table class="table table-striped table-hover table-bordered" id="promotion_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th width="7.5%"></th>
                                                <th style="text-align: center;">Sid</th>
                                                <th style="text-align: center;">活动标题</th>
                                                <th style="text-align: center;">开始时间</th>
                                                <th style="text-align: center;">结束时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div id="promotionPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="promotion-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.result.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">{$T.Result.sid}</td>
													<td align="center">{$T.Result.promotionTitle}</td>
													<td align="center">{$T.Result.promotionBeginTime}</td>
													<td align="center">{$T.Result.promotionEndTime}</td>
													
													
													
													
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
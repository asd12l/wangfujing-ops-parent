<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<style type='text/css'>
#product_tab{width:70%;margin-left:130px;}
#sid0{width:30px;}
td,th{text-align:center;}
</style>
<script type="text/javascript">
			__ctxPath = "${pageContext.request.contextPath}";
			var productPagination;
			$(function() {
				initUserRole();
			    initUserRole1();
			    $("#brandCombobox").change(userRoleQuery);
			   $("#pageSelect").change(userRoleQuery); 
			});
			
			function bt1(){
				 var params = $("#product_form").serialize();
			        //alert("表单序列化后请求参数:"+params);
			        params = decodeURI(params);
			        productPagination.onLoad(params);
			}
			
			function userRoleQuery(){
		        var params = $("#product_form").serialize();
		        //alert("表单序列化后请求参数:"+params);
		        params = decodeURI(params);
		        productPagination.onLoad(params);
		   	}
			function clearQuery(){
				$("#name").val("");
				$("#type").val("");
			}
			//新增坑位
			function addBackUser(){
				var brandId =  $("#brandCombobox").val();
				if(brandId==""||brandId==null){
					ZENG.msgbox.show("请选择品牌！", 5, 1000);
	  				return;
	  			}
				var url = __ctxPath+"/jsp/search/BrandStick/brandStickAdd.jsp"+"?brandId="+brandId;
				$("#pageBody").load(url);
			}
			
			function initUserRole1() {
				$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url: __ctxPath+"/back/brandStickSelect",
					dataType: "json",
					success: function(response) {
						var result = response.list;
						var option = null;
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							option += "<option value='"+ele.brandId+"'>"
									+ ele.brandName + "</option>";
						}
						$("#brandCombobox").append(option);
					}
				});
				$("#brandCombobox").select2();
				
		    }	
			
			//初始化
		 	function initUserRole() {
				var url = __ctxPath+"/back/brandStickList";
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
		               $("#product_tab tbody").setTemplateElement("product-list").processTemplate(data);
		             }
		           }
		         });
		    }	
		 	//删除坑位
			function delBackUser(){
				var checkboxArray=[];
				$("input[type='checkbox']:checked").each(function(i, team){
					var productSid = $(this).val();
					checkboxArray.push(productSid);
				});
				if(checkboxArray.length>1){
					ZENG.msgbox.show(" 只能选择一列", 5, 2000);
					 return false;
				}else if(checkboxArray.length==0){
					ZENG.msgbox.show("请选取要删除的记录", 5, 2000);
					 return false;
				}
				bootbox.confirm("确定要删除吗?", function(r){
					if(r){
						var value=	checkboxArray[0];
						var brandId = $("#brandId_"+value).attr("value");
						var spuId = $("#spuId_"+value).attr("value");
						var orders = $("#orders_"+value).attr("value");
						var deleteOperator = $("#createOperator_"+value).attr("value");
						
						$.ajax({
							type: "post",
							contentType: "application/x-www-form-urlencoded;charset=utf-8",
							url: __ctxPath+"/back/brandStickDelete",
							dataType: "json",
							data: {
									"sid":value,
									"brandId":brandId,
									"spuId":spuId,
									"orders":orders,
									"deleteOperator":deleteOperator
									},

							success: function(response) {
								console.log(response);
								if(response.success == true){
									$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
										"<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
					  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
								}else{
									$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
									$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
								}
								return;
							}
						});
					}
				});
			}
		 	
			function successBtn(){
				$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
				$("#pageBody").load(__ctxPath+"/jsp/search/BrandStick/brandStick.jsp");
			}
</script> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

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
                                    <span class="widget-caption"><h5>品牌坑位管理</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                 <form id="product_form" action="">
                                 <input type="hidden" id="username" name="username" value="${username}"/>
                                    <div class="table-toolbar">
                                        <a id="editabledatatable_new" onclick="addBackUser();" class="btn btn-primary glyphicon glyphicon-plus">
										新增坑位
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="delBackUser();" class="btn btn-danger glyphicon glyphicon-trash">
										删除坑位
                                        </a>
                                         <!-- <a id="editabledatatable_new" onclick="setApp();" class="btn btn-info glyphicon glyphicon-wrench">
										修改区间
                                        </a> -->
                                       <div class="btn-group pull-right">
                                      		 <label class="col-md-4 control-label" 
										style="text-align:right;margin-top:6px;width:80px;padding:0;font-weight:bold;font-size:16px">品牌：</label>
											 <select id="brandCombobox" name="brandId" style="width:130px;">
													<option value="" selected="selected">请选择</option>
											 </select>
                                               <select id="pageSelect" name="pageSize">
													<option selected="selected">5</option>
													<option>10</option>
													<option>15</option>
													<option>20</option>
												</select>
                                        </div>
                                    </div>
                                    </form>
                                    <table class="table table-striped table-hover table-bordered" id="product_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                            	<th id="sid0"></th>
                                            	<th>品牌编号</th>
                                                <th>spu编号</th>
                                                <th>顺序</th>
                                                <th>创建时间</th>
                                                <th>创建操作人</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
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
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td id="brandId_{$T.Result.sid}" value="{$T.Result.brandId}">
														{$T.Result.brandId}
													</td>
													<td id="spuId_{$T.Result.sid}" value="{$T.Result.spuId}">
														{$T.Result.spuId}
													</td>
													<td id="orders_{$T.Result.sid}" value="{$T.Result.orders}">
														{$T.Result.orders}
													</td>
													<td id="createTime_{$T.Result.sid}" value="{$T.Result.createTime}">{$T.Result.createTime}</td>
													<td id="createOperator_{$T.Result.sid}" value="{$T.Result.createOperator}">{$T.Result.createOperator}</td>
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

</body>
</html>
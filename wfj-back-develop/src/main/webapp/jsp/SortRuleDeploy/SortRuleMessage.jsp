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
#product_tab{width:70%;margin-left:130px;}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
			__ctxPath = "${pageContext.request.contextPath}";
			var productPagination;
			$(function() {
			    initUserRole();
			    $("#pageSelect").change(userRoleQuery);
			});
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
			//新增
			function addBackUser(){
				/*var checkboxArray=[];
				$("input[type='checkbox']:checked").each(function(i, team){
					var productSid = $(this).val();
					checkboxArray.push(productSid);
				});
				if(checkboxArray.length>0){
					ZENG.msgbox.show("该规则已经被选中不能添加！", 5, 2000);
					 return false;
				}*/
				var url = __ctxPath+"/jsp/SortRuleDeploy/AddSortRule.jsp";
				$("#pageBody").load(url);
			}
			//初始化
		 	function initUserRole() {
				var url = __ctxPath+"/back/sortRuleList";
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
			
		 	//查看详情
			function appExample(){
				var checkboxArray=[];
				$("input[type='checkbox']:checked").each(function(i, team){
					var productSid = $(this).val();
					checkboxArray.push(productSid);
				});
				if(checkboxArray.length>1){
					ZENG.msgbox.show(" 只能选择一列", 5, 2000);
					 return false;
				}else if(checkboxArray.length==0){
					ZENG.msgbox.show("请选取要查看实例的程序", 5, 2000);
					 return false;
				}
				var value=	checkboxArray[0];
				var url = __ctxPath+"/jsp/SortRuleDeploy/showSortDetail.jsp"+"?contentSid="+value;
				$("#pageBody").load(url);
			}
			
		 	//删除程序
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
						var showText = $("showText_")+value;
						var showOrder = $("#showOrder_").attr("value");
						var defaultOrderBy = $("defaultOrderBy_").attr("value");
						
						$.ajax({
							type: "post",
							contentType: "application/x-www-form-urlencoded;charset=utf-8",
							url: __ctxPath+"/back/sortRuleDelete",
							dataType: "json",
							data: {
								"sid":value,
								"showText":showText,
								"showOrder":showOrder,
								"defaultOrderBy":defaultOrderBy
									},

							success: function(response) {
								console.log(response);
								if(response.success == true){
									$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
										"<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
					  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
								}else{
									alert(response.errorCode+response.message);
									/* $("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
									$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"}); */
								}
								return;
							}
						});
					}
				});
			}
		 	//修改app
		 	function setApp(){
		 		var checkboxArray=[];
				$("input[type='checkbox']:checked").each(function(i, team){
					var Sid = $(this).val();
					checkboxArray.push(Sid);
				});
				if(checkboxArray.length>1){
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					 return false;
				}else if(checkboxArray.length==0){
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					 return false;
				}
				var value=	checkboxArray[0];
				sid=value;
				showText_ = $("#showText_"+value).text().trim();
				showOrder_ = $("#showOrder_"+value).text().trim();
				defaultOrderBy_ = $("#defaultOrderBy_"+value).text().trim();
				//encodeURI(encodeURI(field_))中文乱码处理
		 		var url = __ctxPath+"/jsp/SortRuleDeploy/UpdataSortRule.jsp"+"?sid="+sid+"&showText="+encodeURI(encodeURI(showText_))+"&showOrder="+showOrder_+"&defaultOrderBy="+defaultOrderBy_;
				$("#pageBody").load(url);
		 	}
			function successBtn(){
				$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
				$("#pageBody").load(__ctxPath+"/jsp/SortRuleDeploy/SortRuleMessage.jsp");
			}
</script> 
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
                                    <span class="widget-caption"><h5>排序配置信息</h5></span>
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
                                 	<input type="hidden" value="" id="username"/>
                                 	<script type="text/javascript">
										$("input[id='username']").val(getCookieValue("username"));
									</script>
                                    <div class="table-toolbar">
                                        <a id="editabledatatable_new" onclick="addBackUser();" class="btn btn-primary glyphicon glyphicon-plus">
										新增规则
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="delBackUser();" class="btn btn-danger glyphicon glyphicon-trash">
										删除规则
                                        </a>
                                         <a id="editabledatatable_new" onclick="setApp();" class="btn btn-info glyphicon glyphicon-wrench">
										修改规则
                                        </a>  
                                        <a id="editabledatatable_new" onclick="appExample();" class="btn btn-yellow">
										<i class="fa fa-eye"></i>
										查看详情
                                        </a>
                                       <div class="btn-group pull-right">
                                       		
	                                        	<select id="pageSelect" name="pageSize">
													<option selected="selected">5</option>
													<option >10</option>
													<option>15</option>
													<option>20</option>
												</select>
                                        </div>
                                    </div>
                                    </form>
                                    <table class="table table-striped table-hover table-bordered" id="product_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th></th>
                                            	<th>编号</th>
                                                <th>描述</th>
                                                <th>显示顺序</th>
                                                <th>排序规则</th>
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
													<td id="sid_{$T.Result.sid}">
														{$T.Result.sid}
													</td>
													<td id="showText_{$T.Result.sid}">{$T.Result.showText}</td>
													<td id="showOrder_{$T.Result.sid}">{$T.Result.showOrder}</td>
													{#if $T.Result.defaultOrderBy == "asc"}
													<td id="defaultOrderBy_{$T.Result.sid}" value="{$T.Result.defaultOrderBy}">
														升序
													</td>
													{#else}
													<td id="defaultOrderBy_{$T.Result.sid}" value="{$T.Result.defaultOrderBy}">
														降序
													</td>
													{#/if}
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
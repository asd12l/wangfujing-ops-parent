<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<!-- 
 <script type="text/javascript" src="${ctx}/sysjs/TreeSelector.js"></script>
  <script type="text/javascript" src="${ctx}/outh/userRoleview.js"></script>
  <script type="text/javascript" src="${ctx}/outh/addUserRole.js"></script>
  <script type="text/javascript" src="${ctx}/outh/updateUserRole.js"></script>
  <script type="text/javascript" src="${ctx}/outh/roleGrantWindow.js"></script>
 -->
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<style type='text/css'>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业务类型</title>

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
	//初始化角色列表
 	function initUserRole() {
		var url = __ctxPath+"/LimitRole/getRolesByUser";
		productPagination = $("#productPagination").myPagination({
           /* panel: {
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
           }, */
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
	//跳转到赋权限页面
	function setAuth(){
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
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		sid=value;
		roleName_ = $("#roleName_"+value).text().trim();
		roleCode_ = $("#roleCode_"+value).text().trim();
		var url = __ctxPath+"/jsp/UserRole/roleAuth.jsp";
		$("#pageBody").load(url);
	}
	//跳转到添加角色页面
	/* function addRole(){
		var url = __ctxPath+"/jsp/UserRole/addRole.jsp";
		$("#pageBody").load(url);
	} */
	//跳到编辑角色页面
	/* function updateRole(){
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
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		sid=value;
		roleName_ = $("#roleName_"+value).text().trim();
		roleCode_ = $("#roleCode_"+value).text().trim();
		delFlag_ = $("#delFlag_"+value).attr("value");
		var url = __ctxPath+"/jsp/UserRole/updateRole.jsp";
		$("#pageBody").load(url);
	} */
	//禁用角色
	/* function delRole(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			ZENG.msgbox.show(" 只能选择一列", 5, 2000);
			 return false;
		}else if(checkboxArray.length==0){
			ZENG.msgbox.show("请选取要补充的列", 5, 2000);
			 return false;
		}
		var value=	checkboxArray[0];
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/LimitRole/deleteRole",
			dataType: "json",
			data: {
				"sid":value
			},
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	} */
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/userRole.jsp");
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
                                    <span class="widget-caption"><h5>角色管理</h5></span>
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
                                    	<a id="editabledatatable_new" onclick="setAuth();" class="btn btn-default">
                                    		<i class="fa fa-share-square-o"></i>
											角色授权
                                        </a>&nbsp;&nbsp;
                                        <!-- <a id="editabledatatable_new" onclick="addRole();" class="btn btn-primary glyphicon glyphicon-plus">
											添加角色
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="delRole();" class="btn btn-danger glyphicon glyphicon-trash">
											删除角色
                                        </a>
                                        <a id="editabledatatable_new" onclick="updateRole();" class="btn btn-info glyphicon glyphicon-wrench">
											编辑角色
                                        </a> -->
                                       <!-- <div class="btn-group pull-right">
                                       		 <form id="product_form" action="">
	                                        	<select id="pageSelect" name="pageSize">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
	                                       	</form>
                                        </div> -->
                                    </div>
                                    <table class="table table-striped table-hover table-bordered" id="product_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th width="7%"></th>
                                                <th>角色名</th>
                                                <th>角色编码</th>
                                                <th>是否有效</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div id="productPagination" style="visibility: hidden;"></div>
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
													<td id="roleName_{$T.Result.sid}">{$T.Result.roleName}</td>
													<td id="roleCode_{$T.Result.sid}">{$T.Result.roleCode}</td>
													<td id="delFlag_{$T.Result.sid}" value="{$T.Result.delFlag}">
														{#if $T.Result.delFlag == 0}
						           							有效
						                      			{#elseif $T.Result.delFlag == 1}
						           							无效
						                   				{#/if}
													</td>
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
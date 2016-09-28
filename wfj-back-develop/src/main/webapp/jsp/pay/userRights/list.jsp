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
<script src="${pageContext.request.contextPath}/js/jquery/1.10.4/jquery-ui.js"></script>
<script type="text/javascript" src="http://10.6.2.152:8081/log-analytics/wfj-log.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery/1.10.4/css/jquery-ui.css"/>
<style type="text/css">
.ui-autocomplete{z-index:1100}
.checkbox label:hover{background-color:#38B0DE;}
</style>
<script type="text/javascript">
//上下文路径
__ctxPath = "${pageContext.request.contextPath}";
//接入log监控start
var userName;
var logJs;	
var sessionId = '<%=request.getSession().getId()%>';
function reloadjs(){
      var head= document.getElementsByTagName('head')[0]; 
      var script= document.createElement('script'); 
           script.type= 'text/javascript'; 
           script.onload = script.onreadystatechange = function() { 
      if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete" ) { 
               script.onload = script.onreadystatechange = null; 
               }}; 
        script.src= logJs; 
            head.appendChild(script);  
}
function sendParameter(){
         LA.sysCode = '57';
       }
       
//接入log监控end
//初始化参数
var userIds =[];//用户名数组
var users;//用户对象集合
var addBpIds=[];//添加的用户权限
var delBpIds=[];//删除的用户权限
var userBpIds=[];//用户拥有的权限
var businessList;//所有权限列表

//页面加载完成后自动执行
$(function() {
	bindEvent();
	queryUsers();
	queryBusiness();
});

//绑定事件
function bindEvent(){
	
	$("#rightsQuery").click(function (){
		$("#save").attr({"disabled":"disabled"});
		$('input:checkbox').each(function () {
	        $(this).prop("checked",false);
		});
		//获取用户权限byUserId
		var url=__ctxPath+"/wfjpay/userRights/findRightsByUserId";
		sendParameter();
		LA.log('UserRights-query', '用户权限查询', userName, sessionId);
		var errorMsg=validate();
		if(errorMsg!=""){
			showWarning(errorMsg);
			return;
		}

		var params={"userId":$("#userId").val()}
		$.post(url,params,function(data){
			if(data.success){
				userBpIds=data.bpIds;
				//选中已经拥有的权限
				for(var i in userBpIds){
					$("input:checkbox[value='"+userBpIds[i]+"']").prop('checked',true);
				}
				$("#save").removeAttr("disabled");
			}else{
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"获取用户权限超时！"+"</strong></div>");
				$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
		},"json");
	}).focus(function(){
		$("#save").removeAttr("disabled");
	});

}

//查询用户表
function queryUsers(){
	var url=__ctxPath+"/wfjpay/userRights/getAllUsers";
	$.post(url,function(data){
		if(data.success){
			users=data.list;
			for (var i in users){
				userIds.push(users[i].uid);
			}
			 $("#userId").autocomplete({
				    source: userIds
			  });
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询用户超时！"+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}

//查询业务平台列表(所有的权限列表)
function queryBusiness(){
	//加载框..
	$("#loading-container").attr("class","loading-container");
	//请求地址
	var url=__ctxPath+"/wfjpay/businessStation";
	$.post(url,function(data){
		if(data.success){
			userName = data.userName ;
    		 logJs = data.logJs;
    		 reloadjs();
			businessList=data.list;
			var usersHtml="<div style='overflow-Y: scroll;width:100%;height:100%;'><form class='form-inline'>";
			for (var i in businessList){
				if(businessList[i].id==0)continue;
				usersHtml+="<div class='checkbox col-md-3' style='text-align:center;'>";
				usersHtml+="<label class='control-label' style='width:100%;border-radius:5px;'> ";
				usersHtml+=businessList[i].name;
				usersHtml+="<input value='";
				usersHtml+=businessList[i].id+"' type='checkbox' name='bpId'>";
				usersHtml+="<span class='text' style='display:block;'></span>";
				usersHtml+="</label>";
				usersHtml+="</div>";
			}
			usersHtml+="</form></div>";
			$("#usersDiv").html(usersHtml);
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询权限列表超时！"+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json").complete(function() { 
		//请求完成后隐藏加载框
		$("#loading-container").removeClass("loading-container");
		$("#loading-container").addClass("loading-inactive");
	});
}

/**
 * 保存的时候效验参数
 */
function validate(){
	var userId=$("#userId").val();
	//效验用户是否选择一条权限?
	if($("input:checkbox[name='bpId']:checked")<=0){
		//TODO 用户没有选择一条权限，视为全部取消
	}
	//效验用户名是否为空
	if(userId.trim()==""){
		return "请输入用户名！";
	}
	//效验用户名是否存在
	var flag=true;
	for(var i in userIds){
		if(userIds[i]==userId){
			flag=false;
			break;
		}
	}
	if(flag){
		return "当前用户不存在!";
	}
	//效验成功
	return "";
}

//警告窗口
function showWarning(msg){
	$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+msg+"</strong></div>");
	$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
}


//保存用户权限
function saveUserRights(){
	sendParameter();
	LA.log('UserRights-save', '用户权限保存', userName, sessionId);
	addBpIds=[];
	delBpIds=[];
	var errorMsg=validate();
	if(errorMsg!=""){
		showWarning(errorMsg);
		return;
	}
	
	var userId=$("#userId").val();
	var bpIds=[];
	$("input:checkbox[name='bpId']:checked").each(function(){
		bpIds.push($(this).val());
	});
	//新增权限列表
	for(var i in bpIds){
		var flag=true;
		for(var j in userBpIds){
			if(bpIds[i]==userBpIds[j]){
				flag=false;
				break;
			}
		}
		if(flag){
			addBpIds.push(bpIds[i]);
		}
	}
	//删除权限列表
	for(var i in userBpIds){
		var flag=true;
		for(var j in bpIds){
			if(userBpIds[i]==bpIds[j]){
				flag=false;
				break;
			}
		}
		if(flag){
			delBpIds.push(userBpIds[i]);
		}
	}
	//保存权限地址
	var url=__ctxPath+"/wfjpay/userRights/savaUserRights";
	//保存权限请求参数
	var params={"addBpIds":addBpIds+"","delBpIds":delBpIds+"","userId":userId}
	$.post(url,params,function(data){
		if(data.success){
			//更新当前用户已有的权限为当前用户选择的权限
//			userBpIds=bpIds;
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"保存用户权限超时！"+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:1200;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}

//折叠页面
function tab(data){
	if($("#"+data+"-i").attr("class")=="fa fa-minus"){
		$("#"+data+"-i").attr("class","fa fa-plus");
		$("#"+data).css({"display":"none"});
	}else if(data=='pro'){
		$("#"+data+"-i").attr("class","fa fa-minus");
		$("#"+data).css({"display":"block"});
	}else{
		$("#"+data+"-i").attr("class","fa fa-minus");
		$("#"+data).css({"display":"block"});
		$("#"+data).parent().siblings().find(".widget-body").css({"display":"none"});
		$("#"+data).parent().siblings().find(".fa-minus").attr("class","fa fa-plus");
	}
}

//操作成功提示框点击确定后执行
function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
}
</script> 
</head>
<body>
<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
<!-- Main Container -->
<div class="main-container container-fluid">
    <!-- 内容显示区域 -->
    <div class="page-container">
            <!-- Page Body -->
            <div class="page-body" id="pageBodyRight">
                <div class="row">
                    <div class="col-xs-12 col-md-12">
                        <div class="widget">
                            <div class="widget-header ">
                                <h5 class="widget-caption">权限设置</h5>
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
                                		<ul class="topList clearfix">                           			
                                			<li class="col-md-4">
                                				<label class="titname">用户名：</label>
                                				<input type="text" id="userId"/>
                               				</li>
                               				<li class="col-md-4">
                               					<button class="btn btn-success" style="width:100px;"  id="rightsQuery">查询</button>                        			
                               					<button class="btn btn-success" style="width:100px;" onclick="saveUserRights();" id="save">保存</button>
                               				</li>
                                		</ul>
                                	<!--查询表单-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="account_form" name="account"/>
                                  	</form>
                                  	<!--参数表单，添加或修改用-->
                                  	<form id="data_form" action="">
                                  		<input type="hidden" id="userNameParam_form" name="userName"/>
                                  		<input type="hidden" id="userIdParam_form" name="userId"/>
                                  		<input type="hidden" id="bpIdParam_form" name="bpId"/>
									</form>
								</div>
								<div style="padding:5px;border-radius:10px;border:1px solid #ddd; height:330px;" id="usersDiv">
								<!--业务平台列表在这里显示-->
								
								
								<!--业务平台列表在这里显示-->
								</div>
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
<script>
//页面加载完成后执行函数
jQuery(document).ready(
		function () {
			$('#divTitle').mousedown(
				function (event) {
					var isMove = true;
					var abs_x = event.pageX - $('#btDiv').offset().left;
					var abs_y = event.pageY - $('#btDiv').offset().top;
					$(document).mousemove(function (event) {
						if (isMove) {
							var obj = $('#btDiv');
							obj.css({'left':event.pageX - abs_x, 'top':event.pageY - abs_y});
							}
						}
					).mouseup(
						function () {
							isMove = false;
						}
					);
				}
			);
		}
	);	
</script> 
</body>
</html>
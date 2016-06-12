<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="common/header.jsp"%>
<head>
<title>王府井运营支撑系统</title>
<meta name="description" content="Dashboard" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<style type="text/css">
.sidebar-collapse-index {
	text-align: left;
	padding: 0;
	position: absolute;
	left: 224px;
	top: 0;
	z-index: 2;
	width: 1120px;
	height: 45px;
}

.returnSystem {
	font-size: 15px;
	color: white;
	float: right;
	margin-top: 15px;
	margin-right: 15px;
}
.ind_img1{left:30px;top:30px;}
.ind_img2{left:50%;top:50%;margin-left:-200px;margin-top:-200px;}
.ind_img3{right:30px;bottom:30px;}
</style>
<link rel="shortcut icon" href="${ctx }/images/titleLogo.png"
	type="image/x-icon">

<!--Basic Styles-->
<link href="${ctx }/assets/css/bootstrap.min.css" rel="stylesheet" />
<link id="bootstrap-rtl-link" href="" rel="stylesheet" />
<link href="${ctx }/assets/css/font-awesome.min.css" rel="stylesheet" />
<link href="${ctx }/assets/css/weather-icons.min.css" rel="stylesheet" />
<!--Beyond styles-->
<link id="beyond-link" href="${ctx }/assets/css/beyond.min.css"
	rel="stylesheet" type="text/css" />
<link href="${ctx }/assets/css/demo.min.css" rel="stylesheet" />
<link href="${ctx }/assets/css/typicons.min.css" rel="stylesheet" />
<link href="${ctx }/assets/css/animate.min.css" rel="stylesheet" />
<link href="${ctx }/assets/css/skins/pink.min.css" rel="stylesheet" />
<link id="skin-link" href="" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="${ctx }/assets/css/layout.css" />
<!--[if IE 8]>
    <link rel="stylesheet" type="text/css" href="${ctx }/assets/css/ie8.css"/>
    <![endif]-->

<!--Skin Script: Place this script in head to load scripts for skins and rtl support-->
<script src="${ctx }/js/jquery-1.9.1.js"></script>
<script src="${ctx }/assets/js/skins.min.js"></script>
<script type="text/javascript">
	function getCookieValue(key){
		var value = "";
		var cookies = document.cookie.split(";");
    	for(var i=0;i<cookies.length;i++){
    		if(cookies[i].indexOf(key) >= 0){
    			value = cookies[i].split("=")[1];
    			break;
    		}
    	}
    	return value;
	}
</script>
<script type="text/javascript">
	var LoneList = $.parseJSON(decodeURIComponent(getCookieValue("LOne")));
	$(function(){
		var Aoption = "";
		for(var i=0; i<LoneList.length; i++){
			Aoption += "<a class='btn' style='height: 45px; width: 100px; color: white; font-size: 20px; background-color: #cc324b; border-color: #cc324b; border-radius: 0px;' " + 
			"onclick='navigatColor(" + LoneList[i].sid + ");' " + 
			"id='navigatColor_" + LoneList[i].sid + "'>" + LoneList[i].rsName + "</a>";
		}
		$("#LOne").append(Aoption);
	});
</script>
<script type="text/javascript">   
        __ctxPath = "${pageContext.request.contextPath}";
    	$.ajaxSetup ({
    		cache: false, //关闭AJAX相应的缓存
    		 contentType:"application/x-www-form-urlencoded;charset=utf-8",
             complete:function(XHR,TS){ 
             var sessionstatus=XHR.getResponseHeader("sessionStatus");  
             if(sessionstatus=="sessionOut"){     
            	 $("#warning3").css('display','block');     
             } 
         } 
    	});
    	/* 针对站点切换使用 */
    	var _site_id_param = "";
	   /*  _searchPath="http://192.168.10.85:9080/searchAdmin";
	    flashImage="http://images.shopin.net/images";
	    image = "http://images.shopin.net/images";
	    ctx="http://www.shopin.net"; */
	    <%-- var username = '<%=session.getAttribute("username")%>'; --%>
	    var username = getCookieValue("username");
	    var resources = '<%=session.getAttribute("resources")%>';
	     var rsCodes = resources.split(",");
	    //load2级菜单和三级菜单
	    var sidNew;
	    function navigatColor(sid){
	    	__ctxPath = $("#__ctxPath").val();
	    	if(sidNew==''){
	    		$("#navigatColor_"+sid).css({
		    		"color":"#cc324b",
		    		"background-color":"#fff",
		    		"border-color":"#eee"
		    	});
	    	}else if(sidNew!=sid){
	    		$("#navigatColor_"+sidNew).css({
		    		"color":"white",
		    		"background-color":"#cc324b",
		    		"border-color":"#cc324b"
		    	});
	    		$("#navigatColor_"+sid).css({
		    		"color":"#cc324b",
		    		"background-color":"#fff",
		    		"border-color":"#eee"
		    	});
	    		sidNew = sid;
	    	}
	    	var url = __ctxPath + "/security/indexLeft?sid="+sid;
    		$("#container").load(url,null,function(response,status,xhr){
    			if(status == "error"){
    				$("#warning3").css('display','block');
    			}
    		});
	    }
	    function openUrl(data){
	    	var __ctxPath = $("#__ctxPath").val();
	    	var url = __ctxPath + data;
			alert(url);
			$("#pageBody").load(url);
			_site_id_param = "";
	    }
	    
	    $(function(){
	    	var wh=($(window).height())-85;
	    	$("#index_img_div").css({height:wh+"px"});
	    });
    </script>
    <style>
    body:before{background-color:#fff;}
    </style>
</head>
<!-- /Head -->
<!-- Body -->
<body class="ie8">
	<input type="hidden" id="__ctxPath"
		value="${pageContext.request.contextPath}">
	<!-- Loading Container -->
	<div class="loading-container" id="loading-container">
		<div class="loading-progress">
			<div class="rotator">
				<div class="rotator">
					<div class="rotator colored">
						<div class="rotator">
							<div class="rotator colored">
								<div class="rotator colored"></div>
								<div class="rotator"></div>
							</div>
							<div class="rotator colored"></div>
						</div>
						<div class="rotator"></div>
					</div>
					<div class="rotator"></div>
				</div>
				<div class="rotator"></div>
			</div>
			<div class="rotator"></div>
		</div>
	</div>
	<!--  /Loading Container -->
	<!-- Navbar -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="navbar-container">
				<!-- Navbar Barnd -->
				<div class="navbar-header pull-left">
					<a href="index.jsp" class="navbar-brand"> <img
						style="margin: -2px 0 0 -5px; width: 219px; height: 45px;"
						src="${ctx }/images/logo01new.jpg" />
					</a>
				</div>
				<!-- /Navbar Barnd -->

				<!-- 导航条 -->
				<div class="sidebar-collapse-index" id="LOne">
					<%-- <c:forEach items="${LOne }" var="one">
						<a class="btn"
						style="height: 45px; width: 100px; color: white; font-size: 20px; background-color: #cc324b; border-color: #cc324b; border-radius: 0px;"
						onclick="navigatColor(${one.sid });"
							id="navigatColor_${one.sid }">${one.rsName }</a>
					</c:forEach> --%>
					<a class="returnSystem"
						href="${pageContext.request.contextPath}/security/logoutAction"
						target="_parent"> <i class="icon fa fa-warning">退出</i>
					</a>
				</div>
				<!-- /导航条 -->
				<!-- /Sidebar Collapse -->
			</div>
		</div>
	</div>
	<!-- /Navbar -->
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container" id="container">
			<!-- Page Sidebar -->
			<div class="page-sidebar hide" id="sidebar">
				<!-- Sidebar Menu -->
				<ul class="nav sidebar-menu">
					<!--Dashboard-->
					<li class="active"><a href="index.jsp"> <i
							class="menu-icon glyphicon glyphicon-home"></i> <span
							class="menu-text"> 首页 </span>
					</a></li>
				</ul>
				<!-- /Sidebar Menu -->
			</div>
			<!-- /Page Sidebar -->
			<!-- Page Content -->
			<div class="page-content clearfix" id="js_home">
				<!-- Page Header -->
				<div class="page-header position-relative">
					<!--Header Buttons-->
					<div class="header-buttons">
						<a class="sidebar-toggler" href="#"> <i class="fa fa-arrows-h"></i>
						</a> <a class="refresh" id="refresh-toggler" href=""> <i
							class="glyphicon glyphicon-refresh"></i>
						</a> <a class="fullscreen" id="fullscreen-toggler" href="#"> <i
							class="glyphicon glyphicon-fullscreen"></i>
						</a>
					</div>
					<!--Header Buttons End-->
				</div>
				<!-- /Page Header -->
				<!-- Page Body -->
				<div id="pageBody">
					<div id="index_img_div"  class="posr">
						<div class="posa ind_img1">
							<img src="${ctx}/images/indexImg_01.png"/>
						</div>
						<div class="posa ind_img2">
							<img src="${ctx}/images/indexImg_02.png"/>
						</div>
						<div class="posa ind_img3">
							<img src="${ctx}/images/indexImg_03new.png"/>
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

	<!--Basic Scripts-->

	<!--[if lte IE 8]>
    	<script src="${ctx }/js/jquery-1.9.1.js"></script>
	<![endif]-->
	<!-- [if !IE]>
	<script src="${ctx }/assets/js/jquery-2.0.3.min.js"></script>
	<![endif]-->
	<script src="${ctx }/assets/js/bootstrap.min.js"></script>
	<!--Beyond Scripts-->
	<script src="${ctx }/assets/js/beyond.min.js"></script>
	<script src="${ctx}/assets/js/bootbox/bootbox.js">  </script>
	<!--Page Related Scripts-->
	<!--Sparkline Charts Needed Scripts-->
	<%-- <script src="${ctx }/assets/js/charts/sparkline/jquery.sparkline.js"></script>
    <script src="${ctx }/assets/js/charts/sparkline/sparkline-init.js"></script> --%>

	<!--Easy Pie Charts Needed Scripts-->
	<%--  <script src="${ctx }/assets/js/charts/easypiechart/jquery.easypiechart.js"></script>
    <script src="${ctx }/assets/js/charts/easypiechart/easypiechart-init.js"></script> --%>

	<!--Flot Charts Needed Scripts-->
	<%-- <script src="${ctx }/assets/js/charts/flot/jquery.flot.js"></script>
    <script src="${ctx }/assets/js/charts/flot/jquery.flot.resize.js"></script>
    <script src="${ctx }/assets/js/charts/flot/jquery.flot.pie.js"></script>
    <script src="${ctx }/assets/js/charts/flot/jquery.flot.tooltip.js"></script>
    <script src="${ctx }/assets/js/charts/flot/jquery.flot.orderBars.js"></script> --%>


</body>
<!--  /Body -->
</html>
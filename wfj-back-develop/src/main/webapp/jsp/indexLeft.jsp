<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--Beyond Scripts-->
<script src="${pageContext.request.contextPath}/assets/js/beyond.min.js"></script>
<script>
$(function(){
	var wh=($(window).height())-85;
	$("#index_img_div").css({height:wh+"px"});
});
</script>
<!-- Page Sidebar -->
<div class="page-sidebar" id="sidebar">
    <!-- Sidebar Menu -->
    <ul class="nav sidebar-menu" id="LTwos">
        <!--Dashboard-->
        <li class="active">
            <a href="index.jsp">
                <i class="menu-icon glyphicon glyphicon-home"></i>
                <span class="menu-text"> 首页  </span>
            </a>
        </li>
        	<!--Databoxes-->
        <%-- <c:forEach items="${LTwos }" var="two"> --%>
       		<c:forEach items="${LTwos }" var="limitResources">
             	<li>
             		<a class="menu-dropdown" style="cursor: pointer">
             			<i class="menu-icon fa "></i>
                      	<span class="menu-text">${limitResources.rsName }</span>
                      	<i class="menu-expand"></i>
                  	</a>
                  	<ul class="submenu">
            			<%-- <c:forEach items="${LThrees }" var="three"> --%>
            				<c:forEach items="${LThrees }" var="limitResources2">
             					<c:if test="${limitResources.sid==limitResources2.parentSid }">
                  					<li>
                  						<a onclick="openUrl('${limitResources2.rsUrl}')" style="cursor: pointer">
                           					<span class="menu-text">${limitResources2.rsName }</span>
                       					</a>
                   					</li>
                  				</c:if>
              				</c:forEach>
             			<%-- </c:forEach> --%>
            		</ul>
              	</li>
      		</c:forEach>
        <%-- </c:forEach> --%>
    </ul>
    <!-- /Sidebar Menu -->
</div>
<!-- /Page Sidebar -->
<!-- Page Content -->
<div class="page-content">
    <!-- Page Header -->
<div class="page-header position-relative">
    <!--Header Buttons-->
<div class="header-buttons">
    <a class="sidebar-toggler" href="#">
        <i class="fa fa-arrows-h"></i>
    </a>
    <a class="refresh" id="refresh-toggler" href="">
        <i class="glyphicon glyphicon-refresh"></i>
    </a>
    <a class="fullscreen" id="fullscreen-toggler" href="#">
        <i class="glyphicon glyphicon-fullscreen"></i>
    </a>
</div>
<!--Header Buttons End-->
</div>
<!-- /Page Header -->
<!-- Page Body -->
<div id="pageBody">
	<div id="index_img_div"  class="posr">
		<div class="posa ind_img1">
			<img src="${pageContext.request.contextPath}/images/indexImg_01.png"/>
		</div>
		<div class="posa ind_img2">
			<img src="${pageContext.request.contextPath}/images/indexImg_02.png"/>
		</div>
		<div class="posa ind_img3">
			<img src="${pageContext.request.contextPath}/images/indexImg_03new.png"/>
		</div>
	</div>	
</div>
<!-- /Page Body -->
</div>
<!-- /Page Content -->
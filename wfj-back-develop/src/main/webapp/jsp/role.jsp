<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type='text/css'>
.x-tree-node-leaf .x-tree-node-icon{   
	      background-image:url(../js/ext3.4/resources/images/default/tree/drop-yes.gif);   
	  } 
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
  <script type="text/javascript" src="${ctx}/sysjs/quanxian/addrole.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/quanxian/roleview.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/quanxian/updaterole.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/quanxian/editResource.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/quanxian/editChannel.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/quanxian/addChannelWindow.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/quanxian/addResourceWindow.js"></script>
  <script type="text/javascript">
			__ctxPath = "${pageContext.request.contextPath}";
			
		</script> 
		
  <script type="text/javascript">
 
  <%-- var username = '<%=session.getAttribute("username")%>'; --%>
  var username = getCookieValue("username");
    Ext.onReady(function(){
    	new RoleView();
    });
  
  </script>



</head>
<body>
   <div id="mainDiv"></div>
</body>
</html>
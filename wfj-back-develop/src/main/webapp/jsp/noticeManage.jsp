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
<title>公告类型管理</title>
		  <script type="text/javascript">
			__ctxPath = "${pageContext.request.contextPath}";
			image="http://images.shopin.net/images";
		</script> 
<script type="text/javascript" src="${ctx}/notice/addNotice.js"></script>
<script type="text/javascript" src="${ctx}/notice/noticeView.js"></script>
<script type="text/javascript" src="${ctx}/notice/updateNotice.js"></script>
  <script type="text/javascript">
    Ext.onReady(function(){
    	new NoticeManageView();
    });
  
  </script>

</head>
<body>
   <div id="mainDiv"></div>
</body>
</html>
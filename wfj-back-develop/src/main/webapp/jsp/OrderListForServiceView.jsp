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
<script type="text/javascript" src="${ctx}/order/OrderListView.js"></script>
<script type="text/javascript" src="${ctx}/order/service/OrderListForServiceView.js"></script>
<script type="text/javascript" src="${ctx}/sysjs/SysConstant.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/RowExpander.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客服订单表</title>
  
  <script type="text/javascript">
 	__ctxPath = "${pageContext.request.contextPath}";  
    Ext.onReady(function(){
    	new OrderListForServiceView();
    });
  
  </script>

</head>
<body>
   <div id="mainDiv"></div>
</body>
</html>
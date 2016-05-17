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
<script type="text/javascript" src="${ctx}/sysjs/xuanpin/pagelayout.js"></script>
<script type="text/javascript" src="${ctx}/sysjs/xuanpin/addproduct.js"></script>
<script type="text/javascript" src="${ctx}/sysjs/xuanpin/TreeSelector.js"></script>
 <script type="text/javascript" src="${ctx}/sysjs/xuanpin/channelview.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/xuanpin/channelview-addpromotion.js"></script>
    <script type="text/javascript" src="${ctx}/sysjs/xuanpin/pagelayout-addbrand.js"></script>
        <script type="text/javascript" src="${ctx}/sysjs/xuanpin/pagelayout-addContent.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/xuanpin/channelview-addAds.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/xuanpin/channelview-updateAds.js"></script>
<script type="text/javascript" src="${ctx}/sysjs/channelTreeSelector.js"></script>
<script type="text/javascript" src="${ctx}/sysjs/SysConstant.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/RowExpander.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/fileuploadfield/FileUploadField.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/js/ext3.4/ux/fileuploadfield/css/fileuploadfield.css"/>
  <script type="text/javascript">
			__ctxPath = "${pageContext.request.contextPath}";
			image="http://images.shopin.net/images";
		/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
		saleMsgImage="http://images.shopin.net/images";
		</script> 

<title>订单列表</title>
  
  <script type="text/javascript">
 	__ctxPath = "${pageContext.request.contextPath}";  
    Ext.onReady(function(){
    	new ChannelView()
    });
  
  </script>
<%-- 解决上传图片后返回值的编码格式，否则返回failure--%>
<script type="text/javascript">

        Ext.USE_NATIVE_JSON = true;
        window.JSON = {
            "stringify":Ext.util.JSON.doEncode,
            "parse":function(json){
                var str = json;
                var spos = str.indexOf(">");
                var epos = 0;
                if(spos != -1){
                     epos = str.indexOf("<",spos);
                    str = str.substr(spos+1,epos-spos-1);
                }
                return eval("("+str+")");
            },

            "toString":function(){
                return '[object JSON]';
            }

        };
    </script>
</head>
<body>
   <div id="mainDiv"></div>
</body>
</html>
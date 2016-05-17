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
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业务类型</title>
<!--  
  <script type="text/javascript" src="${ctx}/sysjs/search/suggestKeyView.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/search/addSuggestKey.js"></script>
-->
  <script type="text/javascript">
			__ctxPath = "${pageContext.request.contextPath}";
  </script> 
  <script type="text/javascript">
  var btPagination;
  $(function() {    	
      	initBt();
  });

  //初始化商品列表
	function initBt() {
	var url = __ctxPath + "/hotKey/suggestKeyList.json";
	btPagination = $("#btPagination").myPagination({
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
           ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 100);
         },
         ajaxStop: function() {
           //隐藏加载提示
           setTimeout(function() {
             ZENG.msgbox.hide();
           }, 300);
         },
         callback: function(data) {
           //使用模板
           $("#bt_tab tbody").setTemplateElement("bt-list").processTemplate(data);
         }
       }
     });
};
	  function queryBt(){
	      var params = $("#bt_form").serialize();
	      //alert("表单序列化后请求参数:"+params);
	      params = decodeURI(params);
	      btPagination.onLoad(params);
	 	};
	 	  //添加
	 function addBt(){
	 	  		$("#divTitle").html("新建建议词");
	 	  		$("#btDiv").show();
	 	  }
	 function closeBtDiv(){
		  	$("#btDiv").hide();
		  }
	 function successBtn(){
		  $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		  $("#pageBody").load(__ctxPath+"/jsp/suggestKey.jsp");
		  initBt();
	  }
	 function deleteBt(){
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
		  		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要删除的记录!</strong></div>");
		  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		  		 return false;
		  	}
		  	var value=	checkboxArray[0];
		  	bootbox.confirm("确定删除吗？", function(r){
		  		if(r){
		  			$.ajax({
		  				type: "post",
		  				contentType: "application/x-www-form-urlencoded;charset=utf-8",
		  				url: __ctxPath+"/hotKey/delSuggestKey.json",
		  				dataType: "json",
		  				data: {
		  					"sid":value
		  				},
		  				success: function(response) {
		  					if(response.success==true){
		  						alert("操作成功！");
		  						queryBt();
		  						//$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
		  						//	"<i class='fa-fw fa fa-times'></i><strong>删除成功</strong></div>");
		  	  	  				//$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
		  					}else{
		  						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>禁用失败</strong></div>");
		  						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		  					}
		  					return;
		  				}
		  			});
		  		}
		  	});
		  }
	//保存div中数据
	  function saveDivFrom(){
	  	var url = "";
	  	var suggestKey=$("#suggestKey").val();
	  	if(suggestKey==""||suggestKey==null){
	  		alert("建议词不能为空！");
	  	}else{
	  		url=__ctxPath + "/hotKey/addSuggestKey.json";
		  	$.ajax({
		  		type: "post",
		  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		  		url: url,
		  		dataType: "json",
		  		data: $("#divForm").serialize(),
		  		success: function(response) {
		  			//alert(response.success);
		  			if(response.success==true){
		  				$("#btDiv").hide();
		  				$("#suggestKey").val("");
		  		  		alert("操作成功！");
		  		  		queryBt();
		  				//$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
		  				//	"<i class='fa-fw fa fa-times'></i><strong>操作成功</strong></div>");
		  	  				//$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
		  			}else{
		  				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
		  				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		  			}
		  			return;
		  		}
		  	});
	  	}
	  }
  </script>
</head>
<body>
    <div class="main-container container-fluid">
        <!-- Page Container -->
        <div class="page-container">
                <!-- Page Body -->
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>建议词配置</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                <form id="bt_form">
                                    <div class="table-toolbar">
                                    		建议词查询:<input type="text" name="query" id="query" class="btn btn-default"/>
                                    	<a id="editabledatatable_new" onclick="queryBt();" class="btn btn-default">
											查询
                                        </a>&nbsp;&nbsp;
                                    	<a id="editabledatatable_new" onclick="addBt();" class="btn btn-primary glyphicon glyphicon-plus">
											新增建议词
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="deleteBt();" class="btn btn-danger glyphicon glyphicon-trash">
											删除建议词
                                        </a>
                                    </div>
                                    </form>
                                    <table class="table table-striped table-hover table-bordered" id="bt_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th width="7.5%"></th>
                                            	<th style="text-align: center;">Sid</th>
                                                <th style="text-align: center;">建议词</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                               
								<!-- Templates -->
								<p style="display:none">
									<textarea id="bt-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">{$T.Result.sid}</td>
													<td align="center" id="keyword_{$T.Result.sid}">{$T.Result.keyword}</td>
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
        <!-- /Page Container -->
        <!-- Main Container -->
    </div>   
    <div class="modal modal-darkorange" id="btDiv">
        <div class="modal-dialog" style="width: 400px;margin: 160px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divForm" method="post" class="form-horizontal" enctype="multipart/form-data">
					                <div class="form-group">
					 					建议词名称：
					 					<input type="text" placeholder="必填" class="form-control" id="suggestKey" name="suggestKey">
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
</body>
</html>
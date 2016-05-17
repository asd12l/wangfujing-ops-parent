<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<style type='text/css'>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
  <script type="text/javascript">
  var tree =[];
  var resourcePagination;
  $(function(){
	  $.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/limitResource/getAllLimitResources",
	        dataType: "json",
	        data: $("#theForm").serialize(),
	        success:function(response) {
	        	$('#tree').treeview({
					data:response.list,
					onNodeSelected: function(event, node) {
						resourceQuery(node.id);
			        }
				});
	        	//tree=response.list;
	        	// $('#tree').treeview({data: tree});
	        	 //return tree;
    		}
		});
	  initResources();
  });
  function resourceQuery(data){
	 // alert(data);
		if(data!=''){
			$("#cid").val(data);
		}else{
			$("#cid").val(0);
		}
	    var params = $("#category_form").serialize();
	    //alert("表单序列化后请求参数:"+params);
	    params = decodeURI(params);
	    resourcePagination.onLoad(params);
	}
  function initResources(){
	  //limitResource/getLimitResourceByParam
	  resourcePagination = $("#resourcePagination").myPagination({
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
	         url: __ctxPath+"/limitResource/getLimitResourceByParam",
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
	           $("#resource_tab tbody").setTemplateElement("resource-list").processTemplate(data);
	         }
	       }
	     });
	  
  };
  
	//跳转到添加角色页面
	function addResource(){
		var pid=$("#cid").val();
		if(pid!=""){
			sid = pid;
			var url = __ctxPath+"/jsp/UserRole/addResource.jsp";
			$("#pageBody").load(url);
		}else{
			alert("请选择父类节点");
		}
		
	}
	//跳到编辑角色页面
	function updateResource(){
		var checkboxArray=[];
		var resourceSid = $("#cid").val();
		checkboxArray.push(resourceSid);
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
		rsName_ = $("#rsName_"+value).text().trim();
		rsCode_ = $("#rsCode_"+value).text().trim();
		parentSid_=$("#parentSid_"+value).text().trim();
		rsUrl_=$("#rsUrl_"+value).val();
		delFlag_ = $("#delFlag_"+value).attr("value");
		isLeaf_=$("#isLeaf_"+value).attr("value");
		var url = __ctxPath+"/jsp/UserRole/updateResource.jsp";
		$("#pageBody").load(url);
	}
	//禁用角色
	function delResource(){
		var checkboxArray=[];
		var productSid = $("#cid").val();
		checkboxArray.push(productSid);
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
			url: __ctxPath+"/limitResource/proLmitResources",
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
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/roleResource.jsp");
	}
  </script>
</head>
<body>
<div class="container">
  <div class="">
  	<h5>所有资源：</h5>
  </div>
  <div class="" style="">
      <div class="col-md-3" style="padding-left: 0px; width: 30%">
          <div class="well">
              <div id="tree" style="height: 500px;overflow:auto;  border:1px;"></div>
          </div>
      </div>
  </div>
   <div class="" style="float: left;width: 70%">
      <div class="col-xs-12 col-md-12" style="padding-left: 0px;">
           <div class="widget">
                 <div class="widget-header ">
                      <span class="widget-caption"><h5>资源详情</h5></span>
                       <div class="widget-buttons">
                            <a href="#" data-toggle="maximize"></a>
                            <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                   <i class="fa fa-minus" id="pro-i"></i>
                            </a>
                            <a href="#" data-toggle="dispose"></a>
                        </div>
                 </div>
                  <form id="category_form" action="">
									<input type="hidden" id="cid" name="sid" />
                  </form>
                  <div class="widget-body" id="pro">
                       <div class="table-toolbar">
                                        <a id="editabledatatable_new" onclick="addResource();" class="btn btn-primary glyphicon glyphicon-plus">
											添加资源
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="delResource();" class="btn btn-danger glyphicon glyphicon-trash">
											删除资源
                                        </a>
                                        <a id="editabledatatable_new" onclick="updateResource();" class="btn btn-info glyphicon glyphicon-wrench">
											编辑资源
                                        </a>
                                    </div>
                                    <table class="table table-striped table-hover table-bordered" id="resource_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th></th>
                                            	<th>sid</th>
                                                <th>资源名称</th>
                                                <th>资源编码</th>
                                               
                                                <th>父资源id</th>
                                                <th>是否有效</th>
                                                <th>是否为叶子节点</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div id="resourcePagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="resource-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<input type="hidden" id="rsUrl_{$T.Result.sid}" value="{$T.Result.rsUrl}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td id="sid_{$T.Result.sid}">
														{$T.Result.sid}
													</td>
													<td id="rsName_{$T.Result.sid}">{$T.Result.rsName}</td>
													<td id="rsCode_{$T.Result.sid}">{$T.Result.rsCode}</td>
													
													<td id="parentSid_{$T.Result.sid}">{$T.Result.parentSid}</td>
													<td id="delFlag_{$T.Result.sid}" value="{$T.Result.delFlag}">
														{#if $T.Result.delFlag == 0}
						           							有效
						                      			{#elseif $T.Result.delFlag == 1}
						           							无效
						                   				{#/if}
													</td>
													<td id="isLeaf_{$T.Result.sid}" value="{$T.Result.isLeaf}">
														{#if $T.Result.isLeaf == 1}
						           							叶子节点
						                      			{#elseif $T.Result.isLeaf ==0}
						           							根节点
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
</body>
</html>
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
	        url:__ctxPath + "/sortList/allSortList",
	        dataType: "json",
	        data: $("#theForm").serialize(),
	        success:function(response) {
	        	$('#tree').treeview({
					data:response.list,
					onNodeSelected: function(event, node) {
						/* if(node.leafLevel){ */
							resourceQuery(node.categoryId);
						/* }else{
							
						} */
							if(!node.leafLevel){
								$("#cid").val("");
							}
			        }
				});
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
	         url: __ctxPath+"/sortList/sortListSelect",
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
				 if(data.success == true){
					 $("#resource_tab tbody").setTemplateElement("resource-list").processTemplate(data);

				 }else{
					 $("#model-body-warning").html("<div class='alert alert-warning fade in'><i></i><strong>"+data.message+"</strong></div>");
					 $("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
				 }
	         }
	       }
	     });
	  
  };
  
	//跳转到添加角色页面
	function addResource(){
		var pid=$("#cid").val();
		if(pid!=""){
			sid = pid;
			var url = __ctxPath+"/jsp/search/BrandStick/addSortList.jsp"+"?sid="+sid;
			$("#pageBody").load(url);
		}else{
			ZENG.msgbox.show("请选择子分类节点", 5, 1000);
			 return false;
		}
		
	}
	//删除资源
	function delResource(){
		var checkboxArray=[];
		//var productSid = $("#cid").val();
		//checkboxArray.push(productSid);
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			ZENG.msgbox.show(" 只能选择一列", 5, 2000);
			 return false;
		}else if(checkboxArray.length==0){
			ZENG.msgbox.show("请选取要删除的列", 5, 2000);
			 return false;
		}
		var value=	checkboxArray[0];
		var categoryId = $("#categoryId_"+value).text().trim();
		var spuId =	$("#spuId_"+value).text().trim();
  		var orders = $("#orders_"+value).text().trim();
  		var deleteOperator = $("#createOperator_"+value).text().trim();
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/sortList/sortListDelete",
			dataType: "json",
			data: {
				"sid":value,
				"categoryId":categoryId,
				"spuId":spuId,
				"orders":orders,
				"deleteOperator":deleteOperator
			},
			success: function(response) {
				if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/search/BrandStick/SortListbox.jsp");
	}
  </script>
</head>
<body>
<div class="container">
  <div class="">
  	<h5>所有分类：</h5>
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
                      <span class="widget-caption"><h5>分类详情</h5></span>
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
											添加坑位
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="delResource();" class="btn btn-danger glyphicon glyphicon-trash">
											删除坑位
                                        </a>
                                    </div>
                                    <table class="table table-striped table-hover table-bordered" id="resource_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                            	<th></th>
                                            	<th>编号</th>
                                                <th>分类编号</th>
                                                <th>spu编号</th>
                                               
                                                <th>顺序</th>
                                                <th>创建时间</th>
                                                <th>创建操作人</th>
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
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}">
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td id="sid_{$T.Result.sid}">
														{$T.Result.sid}
													</td>
													<td id="categoryId_{$T.Result.sid}">{$T.Result.categoryId}</td>
													<td id="spuId_{$T.Result.sid}">{$T.Result.spuId}</td>
													
													<td id="orders_{$T.Result.sid}">{$T.Result.orders}</td>
													<td id="createTime_{$T.Result.sid}">{$T.Result.createTime}</td>
													<td id="createOperator_{$T.Result.sid}">{$T.Result.createOperator}</td>
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
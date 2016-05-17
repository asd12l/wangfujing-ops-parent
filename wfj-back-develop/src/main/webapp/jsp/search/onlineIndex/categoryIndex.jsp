<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	        success:function(response) {
	        	$('#tree').treeview({
					data:response.list,
					onNodeSelected: function(event, node) {
						
						if(node.leafLevel == true){
							initData(node);
							$("#freshIndex").html("<a id='' onclick='freshByCategory()' class='btn btn-primary glyphicon glyphicon-wrench'>"+
									"刷新索引"+"</a>");
						}else{
							$("#freshIndex").html("");
						}
							
			        }
				});
    		}
		});
  });
  function freshByCategory(){
	  $.ajax({
		  type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/onlineIndex/categoryFresh",
			dataType: "json",
			data: {
				"categoryId":$("#categoryId").val(),
				"channel":$("#channel").val()
			},
			success: function(response) {
				if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class=''></i><strong>刷新成功</strong></div>");
	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
	  });
  }
  function initData(data){
			$("#categoryId").val(data.categoryId);
			$("#channel").val(data.channel);
			$("#leafLevel").val(data.leafLevel);
	}
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/search/onlineIndex/categoryIndex.jsp");
	}
  </script>
</head>
<body>
<div class="container">
  <div class="">
  	<h5>所有分类：</h5>
  </div>
  <div class="" style="">
      <div class="col-md-3" style="padding-left: 0px; width: 40%">
          <div class="well">
              <div id="tree" style="height: 500px; overflow:auto;  border:1px;"></div>
          </div>
      </div>
  </div>
   <div class="" style="float: left;width: 40%">
      <div class="col-xs-12 col-md-12" style="padding-left: 0px;">
           <div class="widget">
                 <div class="widget-header ">
                      <span class="widget-caption"><h5>刷新索引</h5></span>
                       <div class="widget-buttons">
                            <a href="#" data-toggle="maximize"></a>
                            <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                   <i class="fa fa-minus" id="pro-i"></i>
                            </a>
                            <a href="#" data-toggle="dispose"></a>
                        </div>
                 </div>
                  <form id="category_form" action="">
									<input type="hidden" id="categoryId" name="categoryId" />
									<input type="hidden" id="channel" name="channel" />
									<input type="hidden" id="leafLevel" name="leafLevel" />
                  </form>
                  <div class="widget-body" id="pro">
                       <div class="table-toolbar" id="freshIndex">
                                       
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<script src="${ctx}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${ctx}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${ctx}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${ctx}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/js/pagination/myPagination/page.css"/>
<!--Bootstrap Date Range Picker-->
<script src="${ctx}/assets/js/datetime/moment.js"></script>
<script src="${ctx}/assets/js/datetime/daterangepicker.js"></script>
<script type="text/javascript">
__ctxPath = "${ctx}";
image="http://images.shopin.net/images";
saleMsgImage="http://images.shopin.net/images";
ctx="http://www.shopin.net";

$(function() {
	
	$.ajax({
		type: "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url: __ctxPath+"/omsOrder/selectCodThreshold",
		dataType: "json",
		success: function(response) {
			var result = response.list[0];
			$("#codAmount_input").val(result.thresholdAmount);
			return;
		}
	});
	
});
	function save(){
		$("#btDiv2").show();
		$("#divTitle2").html("温馨提示！");
	}
	function No(){
		$("#btDiv2").hide();
	}
	function closeBtDiv2(){
		$("#btDiv2").hide();
	}
	function Ok1(){
		$("#btDiv2").hide();
		var userName = "${username}";
		var amount = $("#codAmount_input").val();
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/omsOrder/updateCodThreshold",
			async : false,
			data : {
				"thresholdAmount" : amount,
				"userName":userName
			},
			dataType : "json",
			
			success : function(response) {
				if(response.success=='true'){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修改成功!</strong></div>");
					$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改成功!</strong></div>");
 	     	  		$("#modal-warning").attr({"style":"display:block;z-index:2000","aria-hidden":"false","class":"modal modal-message modal-warning"});
					//没有保存成功，不跳转
				}
				return;
			}
		});
	}
	
	/* function reset(){
		$("#codAmount_input").val(0);
		save();
	} */
//折叠页面
	function tab(data){
		if($("#"+data+"-i").attr("class")=="fa fa-minus"){
			$("#"+data+"-i").attr("class","fa fa-plus");
			$("#"+data).css({"display":"none"});
		}else if(data=='pro'){
			$("#"+data+"-i").attr("class","fa fa-minus");
			$("#"+data).css({"display":"block"});
		}else{
			$("#"+data+"-i").attr("class","fa fa-minus");
			$("#"+data).css({"display":"block"});
			$("#"+data).parent().siblings().find(".widget-body").css({"display":"none"});
			$("#"+data).parent().siblings().find(".fa-minus").attr("class","fa fa-plus");
		}
	}
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/order/CodCheckView.jsp");
	}
</script>

</head>
<body>
	<input type="hidden" id="ctxPath" value="${ctx}" />
    <!-- Main Container -->
    <div class="main-container container-fluid">
        <!-- Page Container -->
        <div class="page-container">
                <!-- Page Body -->
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <h5 class="widget-caption">COD订单自动审核管理</h5>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                            <div class="widget-body" id="pro">
                                    		<ul class="topList clearfix"> 
                                    		<div>&nbsp;</div>                          			
                                   				<div align="center" style="position: 30 30 20;">
                                    				<label class="titname">COD金额阀值：</label>
                                    				<input type="text" id="codAmount_input"/>
                                   				</div>
                                   			<div>&nbsp;</div>
                                    			<div align="center">
                                   					<a class="btn btn-default shiny" onclick="save();">修改</a>&nbsp;&nbsp;
													<!-- <a class="btn btn-default shiny" onclick="reset();">取消</a> -->
                                    			</div>
                                    		</ul>
                                    	
                               			<form id="olv_form" action="">
											<input type="hidden" id="codAmount_form" name="codAmount"/>
											<input type="hidden" name="userName" value="${username}"/>
                                      	</form>
                                	<div style="width:100%; height:0%; min-height:300px; overflow-Y: hidden;">
                                    </div>
                                </div>
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
    <div class="modal modal-darkorange" id="btDiv2">
        <div class="modal-dialog" style="width: 300px;height:300%;margin: 16% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv2();">×</button>
                    <h4 class="modal-title" id="divTitle2"></h4>
                </div>
                <div align="center">
                  	&nbsp;&nbsp; &nbsp; &nbsp;
            	</div>
                <div align="center">
                  	<a class="btn btn-default shiny" onclick="Ok1();">确定</a>&nbsp;&nbsp; &nbsp; &nbsp;
					<a class="btn btn-default shiny" onclick="No();">取消</a>
            	</div>
            	 <div align="center">
                  	&nbsp;&nbsp; &nbsp; &nbsp;
            	</div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>   
</body>
</html>
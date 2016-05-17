<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var salesChannelPagination;
	$(function() {    	
	    initSalesChannel();
	    $("#channelName_input").change(salesChannelQuery);
	    $("#pageSelect").change(salesChannelQuery);
	});
	function salesChannelQuery(){
		$("#channelName_from").val($("#channelName_input").val());
        var params = $("#salesChannel_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        salesChannelPagination.onLoad(params);
   	}
	function reset(){
		$("#channelName_input").val("");
		salesChannelQuery();
	}
	//初始化销售渠道列表
 	function initSalesChannel() {
		var url = $("#ctxPath").val()+"/ChannelDisplay/selectAllChannel";
		salesChannelPagination = $("#salesChannelPagination").myPagination({
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
               $("#salesChannel_tab tbody").setTemplateElement("salesChannel-list").processTemplate(data);
             }
           }
         });
    }
	function addSalesChannel(){
		var url = __ctxPath+"/jsp/salesChannel/addSalesChannelNode.jsp";
		$("#pageBody").load(url);
	}
	function editSalesChannel (){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			$("#warning2Body").text(buildErrorMessage("","只能选择一列！"));
			$("#warning2").show();
			 return false;
		}else if(checkboxArray.length==0){
			$("#warning2Body").text(buildErrorMessage("","请选取要修改的列！"));
			$("#warning2").show();
			 return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/ChannelDisplay/getChannelByChannelById/"+value;
		$("#pageBody").load(url);
	}
	function delSalesChannel(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			$("#warning2Body").text(buildErrorMessage("","只能选择一列！"));
			$("#warning2").show();
			 return false;
		}else if(checkboxArray.length==0){
			$("#warning2Body").text(buildErrorMessage("","请选取要删除的列！"));
			$("#warning2").show();
			 return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/ChannelDisplay/deleteChannel";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
			data: {
				"sid":value
			},
			success: function(response) {
				if(response.status=="success"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(buildErrorMessage("","删除失败！"));
					$("#warning2").show();
				}
				return;
			}
		});
	}
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/salesChannel/salesChannelNode.jsp");
	}
	</script> 
</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
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
                                    <span class="widget-caption"><h5>销售渠道管理</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                    	<a id="editabledatatable_new" onclick="addSalesChannel();" class="btn btn-primary">
                                        	<i class="fa fa-plus"></i>
											添加销售渠道
                                        </a>&nbsp;&nbsp;
                                    	<a id="editabledatatable_new" onclick="editSalesChannel();" class="btn btn-info">
                                    		<i class="fa fa-wrench"></i>
											修改销售渠道
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="delSalesChannel();" class="btn btn-danger">
                                        	<i class="fa fa-times"></i>
											删除销售渠道
                                        </a>
                                       <div class="btn-group pull-right">
                                       		 <form id="salesChannel_form" action="">
	                                        	<select id="pageSelect" name="pageSize">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
												<input type="hidden" id="channelName_from" name="channelName"/>
	                                       	</form>
                                        </div>
                                    </div>
                                    <div class="table-toolbar">
                                    	<span>渠道名称：</span>
                                    	<input type="text" id="channelName_input"/>&nbsp;&nbsp;
                                    	<a class="btn btn-default shiny" onclick="reset();" style="height: 32px;margin-top: -4px;">重置</a>
                                    </div>
                                    <table class="table table-hover table-bordered" id="salesChannel_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th width="7.5%"></th>
                                            	<th style="text-align: center;">序号</th>
                                                <th style="text-align: center;">渠道名称</th>
                                                <th style="text-align: center;">状态</th>
                                                <th style="text-align: center;">操作人</th>
                                                <th style="text-align: center;">操作时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div id="salesChannelPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="salesChannel-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">
														{$T.Result.sid}
													</td>
													<td align="center">{$T.Result.channelName}</td>
													<td align="center">
														{#if $T.Result.status == 0}
						           							<span class="btn btn-danger btn-xs">未启用</span>
						                      			{#elseif $T.Result.status == 1}
						           							<span class="btn btn-palegreen btn-xs">已启用</span>
						                   				{#/if}
													</td>
													<td align="center">{$T.Result.optUser}</td>
													<td align="center">{$T.Result.optDate}</td>
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
</body>
</html>
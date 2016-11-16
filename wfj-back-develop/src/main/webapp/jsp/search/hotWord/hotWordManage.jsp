<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" ></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	LA.sysCode = '43';
	var sessionId = "<%=request.getSession().getId() %>";
	var hotWordPagination;
	$(function() {
	    inithotWord();
	    $("#site").change(hotWordQuery);
	    $("#channel").change(hotWordQuery);
	    $("#pageSelect").change(hotWordQuery);
	});
	function hotWordQuery(){
		var siteSid = $("#site").val();
		var channelSid = $("#channel").val();
		$("#hotWordSite").val(siteSid);
		$("#hotWordChannel").val(channelSid);
        var params = $("#hotWord_form").serialize();
		LA.log('search.hotWord', '热词配置列表查询 siteSid:'+$("#site").val()+"channelSid:"+$("#channel").val(), getCookieValue("username"), sessionId);
		params = decodeURI(params);
        hotWordPagination.onLoad(params);
   	}
	function reset(){
		$("#site").val("");
		$("#channel").val("");
		hotWordQuery();
	}
 	function inithotWord() {
		LA.log('search.hotWord', '热词配置列表查询 siteSid:'+$("#site").val()+"channelSid:"+$("#channel").val(), getCookieValue("username"), sessionId);
		var url = $("#ctxPath").val()+"/hotWord/getList";
		hotWordPagination = $("#hotWordPagination").myPagination({
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
					if(data.success == true){
						$("#hotWord_tab tbody").setTemplateElement("hotWord-list").processTemplate(data);
					}else{
						$("#hotWord_tab tbody").setTemplateElement("hotWord-list").processTemplate(data);
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i></i><strong>"+data.message+"</strong></div>");
						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
					}
					
				}
			}
		});
	}
 	
 	//点击事件，获取站点的信息
 	$("#site").one("click",function(){
		LA.log('search.hotWord', '热词配置管理获取站点信息', getCookieValue("username"), sessionId);
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/hotWord/queryListSite",
			dataType: "json",
			success: function(response) {
			    if(response.success != false){
					var result = response.list;
			  		var site = $("#site");
			  		site.html("<option value=''>请选择</option>");
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.id + "'>" + ele.name + "</option>");
						option.appendTo(site);
					}
			    }else{
					$("#warning2Body").text("没有站点的信息!");
					$("#warning2").show();
			    }
				return;
			}
		}); 
	});
/*  	$(function(){
 		$("#channel").click(function(){
 			var channel = $("#channel");
 			channel.html("<option value=''>请选择</option>");
 			var sid = $("#site").val();
 			$.ajax({
 				type: "post",
 				contentType: "application/x-www-form-urlencoded;charset=utf-8",
 				url: __ctxPath+"/hotWord/queryListChannel",
 				dataType: "json",
 				data: {
 					"siteId":sid
 				},
 				success: function(response) {
 				    if(response.success != false){
 						var result = response.list;
 						for ( var i = 0; i < result.length; i++) {
 							var ele = result[i];
 							var option = $("<option value='" + ele.id + "'>" + ele.name + "</option>");
 							option.appendTo(channel);
 						}
 				    }else{
 						$("#warning2Body").text(response.message);
 						$("#warning2").show();
 				    }
 					return;
 				},
 				error: function() {
 					$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
 			  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
 				}
 			}); 
 		});
 	}); */
  //选择站点查询频道
 	function classifyOne(){
 		var channel = $("#channel");
		var sid = $("#site").val();
		channel.html("<option value=''>请选择</option>");
		LA.log('search.hotWord', '热词配置管理查询频道信息 siteId:'+sid, getCookieValue("username"), sessionId);
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/hotWord/queryListChannel",
			dataType: "json",
			data: {
				"siteId":sid
			},
			success: function(response) {
			    if(response.success != false){
					var result = response.list;
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.id + "'>" + ele.name + "</option>");
						option.appendTo(channel);
					}
			    }else{
					/* $("#warning2Body").text("当前站点下没有频道信息!");
					$("#warning2").show(); */
			    }
				return;
			},
			error: function() {
				$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
		  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
			}
		}); 
	}
 	
</script>
<!-- 添加 -->
<script type="text/javascript">
	function addhotWord(){
		if(($("#hotWordSite").val() == "" || $("#hotWordSite").val() == null)||
		($("#hotWordChannel").val() == "" || $("#hotWordChannel").val() == null)){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"请选择站点和频道！"+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			return false;
		}else{
		var url = __ctxPath+"/jsp/search/hotWord/addHotWord.jsp?site="+$("#hotWordSite").val()+"&channel="+$("#hotWordChannel").val();
		$("#pageBody").load(url);
		}
	}
</script>
<!-- 修改 -->
<script type="text/javascript">
	function edithotWord() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
		    $("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
		    $("#warning2Body").text("请选择要修改的行!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		var url = __ctxPath + "/jsp/search/hotWord/updateHotWord.jsp?sid="+value+"&site="+$("#site_"+value).attr("value")+"&channel="+$("#channel_"+value).attr("value")
				+"&value="+$("#value_"+value).attr("value")+"&link="+$("#link_"+value).attr("value")+"&orders="+$("#orders_"+value).attr("value")+"&enable="+$("#enabled"+value).attr("value");
		console.log(encodeURI(url));
		$("#pageBody").load(encodeURI(url));
	}
</script>
<!-- 删除 -->
<script type="text/javascript">
	function delInfo(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
		    $("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
		    $("#warning2Body").text("请选取要删除的行!");
			$("#warning2").show();
			return false;
		}
		if($("#enabled"+value).val()){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"只能删除无效的热词!"+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/hotWord/deleteHotWord";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
			data:{
				"sid":value,
				"site":$("#site_"+value).attr("value"),
				"channel":$("#channel_"+value).attr("value"),
				"value":$("#value_"+value).attr("value"),
				"link":$("#link_"+value).attr("value"),
				"orders":$("#orders_"+value).attr("value"),
				"enabled":$("#enabled_"+value).attr("value")
			},
			ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
			ajaxStop: function() {
				setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
			},
			success: function(response) {
				if(response.success==true){
					LA.log('search.hotWordDelete', '删除热词配置 sid:'+value+"site:"+$("#channel_"+value).attr("value")+
							"channel:"+$("#channel_"+value).attr("value")+"value:"+$("#value_"+value).attr("value")+
							"link:"+$("#link_"+value).attr("value")+"orders:"+$("#orders_"+value).attr("value")+
							"enabled:"+$("#enabled_"+value).attr("value"),
							getCookieValue("username"), sessionId);
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>删除成功，返回列表页!</strong></div>");
					$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}
	
	//使有效、无效
	function toselected(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			 $("#warning2Body").text("只能选择一行!");
				$("#warning2").show();
				return false;
		}else if(checkboxArray.length==0){
			 $("#warning2Body").text("请选择一行!");
				$("#warning2").show();
		}
				var value=	checkboxArray[0];
				$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url: __ctxPath+"/hotWord/enabledHotWord",
					dataType: "json",
					data: {
						"sid":value,
						"site":$("#site_"+value).attr("value"),
						"channel":$("#channel_"+value).attr("value"),
						"value":$("#value_"+value).attr("value"),
						"link":$("#link_"+value).attr("value"),
						"orders":$("#orders_"+value).attr("value"),
						"enabled":$("#enabled_"+value).attr("value")
							},
						ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
						ajaxStop: function() {
							setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
						},
					success: function(response) {
						console.log(response);
						if(response.success == true){
							LA.log('search.hotWord', '热词配置使有效或无效 sid:'+sid+"enabled:"+$("#enabled_"+value).attr("value"), getCookieValue("username"), sessionId);
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<i class=''></i><strong>操作成功，返回列表页!</strong></div>");
			  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						}else{
							
							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
							$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"}); 
						}
						return;
					}
				});
			
	}
</script>
<!-- 基本控制 -->
<script type="text/javascript">
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
		$("#pageBody").load(__ctxPath+"/jsp/search/hotWord/hotWordManage.jsp");
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
                                    <h5 class="widget-caption">热词管理</h5>
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
                                    	<div class="clearfix">
	                                    	<a onclick="delInfo();" class="btn btn-danger">
	                                        	<i class="fa fa-times"></i>
												删除热词
	                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
	                                    	<a onclick="edithotWord();" class="btn btn-info">
	                                    		<i class="fa fa-wrench"></i>
												修改热词
	                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
	                                        <a onclick="toselected()" class="btn btn-danger">
												<i class="fa fa-eye"></i>
												使有效/无效
                                       		 </a>
                                        </div>
                                        
                                        <div class="table-toolbar">
											<span>站点：</span>
											<select onchange="classifyOne();" id="site" style="padding: 0 0;width: 200px">
												<option value="">请选择</option>
											</select>&nbsp;&nbsp;&nbsp;&nbsp;
											<span>频道：</span>
											<select id="channel" style="padding: 0 0;width: 200px">
												<option value="">请选择</option>
											</select>&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="addhotWord();">添加热词</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>
										</div>
                                    </div>
                                   
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="hotWord_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                                <th width="5%" style="text-align: center;">选择</th>
                                                <th style="text-align: center;">站点</th>
                                                <th style="text-align: center;">频道</th>
                                                <th style="text-align: center;">显示内容</th>
                                                <th style="text-align: center;">链接</th>
                                                <th style="text-align: center;">显示顺序</th>
                                                <th style="text-align: center;">是否有效</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                   <div class="pull-left" style="margin-top: 5px;">
										<form id="hotWord_form" action="">
											<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp;
											<input type="hidden" id="hotWordSite" name="hotWordSite" />
											<input type="hidden" id="hotWordChannel" name="hotWordChannel" />
										</form>
									</div>
                                    <div id="hotWordPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="hotWord-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="site_{$T.Result.sid}" value="{$T.Result.site}">
															{$T.Result.siteName}
													</td>
													<td align="center" id="channel_{$T.Result.sid}" value="{$T.Result.channel}">
															{$T.Result.channelName}
													</td>
													<td align="center" id="value_{$T.Result.sid}" value="{$T.Result.value}">
															{$T.Result.value}
													</td>
													<td align="center" id="link_{$T.Result.sid}" value="{$T.Result.link}">
															<a href="{$T.Result.link}">{$T.Result.link}</a>
													</td>
													<td align="center" id="orders_{$T.Result.sid}" value="{$T.Result.orders}">
															{$T.Result.orders}
													</td>
													<td align="center" id="enabled_{$T.Result.sid}" value="{$T.Result.enabled}">
														{#if $T.Result.enabled == false}
						           							<span class="label label-darkorange graded">无效</span>
						                      			{#elseif $T.Result.enabled == true}
						           							<span class="label label-success graded">有效</span>
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
                <!-- /Page Body -->
            </div>
            <!-- /Page Content -->
        </div>
        <!-- /Page Container -->
        <!-- Main Container -->
</body>
</html>
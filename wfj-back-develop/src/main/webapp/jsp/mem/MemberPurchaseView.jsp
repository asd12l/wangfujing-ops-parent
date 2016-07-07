<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
    <!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<!--Bootstrap Date Range Picker-->
<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
<style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
</style>
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	var cid;
	var olvPagination;
	$(function() {
		$("#reservation").daterangepicker();
	    initOlv();
	});
	
	function productQuery(){
		$("#username_from").val($("#username_input").val().trim());
		$("#mobile_from").val($("#mobile_input").val().trim());
		$("#email_from").val($("#email_input").val().trim());
        var params = $("#product_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	// 查询
	function query() {
		$("#cache").val(0);
		productQuery();
	}
	//重置
	function reset(){
		$("#cache").val(1);
		$("#username_input").val("");
		$("#mobile_input").val("");
		$("#email_input").val("");
		productQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/memBasic/getMemBasicInfo";
		olvPagination = $("#olvPagination").myPagination({
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
               ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive")
					}, 300);
				},
             callback: function(data) {
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
		function toChar(data) {
			if(data == null) {
			data = "";
			}
			return data;
			}
    } 
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberPurchaseView.jsp");
	}

	function showMemPurchaseView(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个用户!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要查看的用户!");
			$("#warning2").show();
			return;
		}
		cid=checkboxArray[0].trim();
		$("#pageBody").load(__ctxPath+"/jsp/mem/PurchaseDetail.jsp");
	}
</script>
<!-- 加载样式 -->
<script type="text/javascript">
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
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
                                <div class="widget-header ">会员信息</h5>
                                   <div class="widget-buttons">
										<a href="#" data-toggle="maximize"></a> <a href="#"
											data-toggle="collapse" onclick="tab('pro');"> <i
											class="fa fa-minus" id="pro-i"></i>
										</a> <a href="#" data-toggle="dispose"></a>
									</div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
										<ul class="topList clearfix">
											<li class="col-md-4"><label class="titname">账号：</label>
												<input type="text" id="username_input" /></li>
											<li class="col-md-4"><label class="titname">手机号：</label>
												<input type="text" id="mobile_input" /></li>
											<li class="col-md-4"><label class="titname">邮箱：</label>
												<input type="text" id="email_input" /></li>
											<li class="col-md-6">
												<a onclick="query();" class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询</a>
												<a onclick="reset();"class="btn btn-primary"> <i class="fa fa-random"></i> 重置</a>
												<a onclick="showMemPurchaseView();"class="btn btn-primary"> <i class="fa fa-random"></i> 查询用户购买记录</a>
											</li>
										</ul>

                                   <table class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
										<thead>
                                            <tr role="row" style='height:35px;'>
												<th style="text-align: center;" width="2%">选择</th>
												<th style="text-align: center;" width="12%">账户</th>
												<th style="text-align: center;" width="12%">昵称</th>
												<th style="text-align: center;" width="12%">真实姓名</th>
												<th style="text-align: center;" width="12%">手机</th>
												<th style="text-align: center;" width="12%">邮箱</th>
												<th style="text-align: center;" width="12">所属门店</th>
												<th style="text-align: center;" width="12%">会员等级</th>
												<th style="text-align: center;" width="12%">地址</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>                          
                                  <div class="pull-left" style="padding: 10px 0;">
									<form id="product_form" action="">
											<input type="hidden" id="username_from" name="cid" />
											<input type="hidden" id="mobile_from" name="mobile" /> 
											<input type="hidden" id="email_from" name="email" />
											<input type="hidden" id="cache" name="cache" value="1" />
									</form>
								</div>
                                    <div id="olvPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.cid}" value="{$T.Result.cid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="cid_{$T.Result.cid}">
														{#if $T.Result.cid == "" || $T.Result.cid == null}--
														{#else}{$T.Result.cid}
														{#/if}
													</td>
													<td align="center" id="nickname_{$T.Result.cid}">
														{#if $T.Result.cmnickname == "" || $T.Result.cmnickname == null}--
														{#else}{$T.Result.cmnickname}
														{#/if}
													</td>
													<td align="center" id="realname_{$T.Result.cid}">
														{#if $T.Result.cmname == "" || $T.Result.cmname == null}--
														{#else}{$T.Result.cmname}
														{#/if}
													</td>
													<td align="center" id="mobile_{$T.Result.cid}">
														{#if $T.Result.cmmobile1 == "" || $T.Result.cmmobile1 == null}--
														{#else}{$T.Result.cmmobile1}
														{#/if}
													</td>
													<td align="center" id="email_{$T.Result.cid}">
														{#if $T.Result.cmemail == "" || $T.Result.cmemail == null}--
														{#else}{$T.Result.cmemail}
														{#/if}
													</td>

													<td align="center" id="belongStore_{$T.Result.cid}">
														{#if $T.Result.cmmkt == "" || $T.Result.cmmkt == null}--
														{#else}{$T.Result.cmmkt}
														{#/if}
													</td>
													<td align="center" id="levelName_{$T.Result.cid}">
														{#if $T.Result.levelName == "" || $T.Result.levelName == null}V钻会员
														{#else}{$T.Result.levelName}
														{#/if}
													</td>
													<td align="center" id="address_{$T.Result.cid}">
														{#if $T.Result.address == "" || $T.Result.address == null}--
														{#else}{$T.Result.address}
														{#/if}
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}
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
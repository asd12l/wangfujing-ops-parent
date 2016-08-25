<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 评论信息表页
Version: 1.0.0
Author: wangzi
-->
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<style>

label{width: 70px;}
</style>
 <!--Bootstrap Date Range Picker-->
<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>		
<script
	src="${pageContext.request.contextPath}/js/member/comment/commentlist.js">

	</script>
	<script type="text/javascript">
		__ctxPath = "${ctx}";
	</script>
	<style>
	li{list-style:none;}
	</style>
</head>
<body>
<div class="modal modal-darkorange"
	 id="resetReplyDiv">
	<div class="modal-dialog"
		 style="width: 800px; height: auto; margin: 4% auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeLogin();">×</button>
				<h4 class="modal-title">回复评论</h4>
			</div>
			<div class="page-body">
				<div class="row" id="login_content">
					<form method="post" class="form-horizontal">
						<div class="col-xs-12 col-md-12">
							<input type="hidden" name="replycode" id="replycode">
							<input type="hidden" name="membercode" id="membercode">
							<input type="hidden" name="replyBy" id="replyBy">
							<div class="col-md-12"  style="padding: 10px 100px;" id="typepdiv">
								<label class="col-md-5 control-label"
									   style="line-height: 20px; text-align: right;">回复内容：</label>
								<div class="col-md-6">
									<input type="text" style="line-height:150px;width:200px" 
										   id="replyinfosite" />
									<br/><span id="replyinfo_msg" style="color:red;"></span>
								</div>
								<br>&nbsp;
							</div>
						</div>
						<br>&nbsp;
						<div id="typetable" class="mtb10">
							<a onclick="replystrue();" id="repyes" class="btn btn-info">回复</a>&nbsp;&nbsp;
							<a onclick="modifystrue();" id="mdeyes" type="hidden" class="btn btn-info">修改</a>&nbsp;&nbsp;
							<a onclick="deletstrue();" id="delets" type="hidden" class="btn btn-info">删除</a>&nbsp;&nbsp;
							<a onclick="closeLogin();" class="btn btn-primary">取消</a>&nbsp;&nbsp;
						</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
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
								<h5 class="widget-caption">评论信息</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body clearfix" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
									</div>
									<div class="mtb10">
									
										<li class="col-md-4">
                                    				<label class="titname" width="70px">订单编号：</label>
                                    				<input type="text" id="ordernumber_input">
                                   				</li>
                                   		<li class="col-md-4">
                                    				<label class="titname" width="70px">客户账号：</label>
                                    				<input type="text" id="customeraccount_input">
                                   				</li>
                                   		<li class="col-md-4">
                                    				<label class="titname" width="70px">评论时间：</label>
                                    				<input type="text" id="commenttime_input">
                                   				</li>
                                   		<li class="col-md-4">
                                    				<label class="titname" width="90px" >好评度：</label>
                                    				<select id="praisedegree_input" >
                                    				<option value="">请选择</option>
                                    				<option value="1">一星</option>
                                    				<option value="2">二星</option>
                                    				<option value="3">三星</option>
                                    				<option value="4">四星</option>
                                    				<option value="5">五星</option>
                                    				</select>
                                   				</li>
                                   		<li class="col-md-4">
                                    				<label class="titname" width="70px">是否回复：</label>
                                    				<select id="reply_true">
                                    				<option value="">请选择</option>
                                    				<option value="1">是</option>
                                    				<option value="0">否</option>
                                    				</select>
                                   				</li>
                                   		
                                   		<li class="col-md-4">
                                    				<label class="titname" width="70px">是否屏蔽：</label>
                                    				<select id="whether_shielding">
                                    				<option value="">请选择</option>
                                    				<option value="0">是</option>
                                    				<option value="1">否</option>
                                    				</select>
                                   				</li>
                                   		<li class="col-md-4">
                                    				<label class="titname" width="70px">客 服 ID：&nbsp;</label>
                                    				<input type="text" id="customerservicenumber_input">
                                   				</li>
                                   		<li class="col-md-4">
                                    				<label class="titname" width="70px">回复时间：</label>
                                    				<input type="text" id="recovery_time">
                                   				</li>
                                    				
										<br>
										<li class="col-md-9">
										 <a class="btn btn-default shiny"onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										 <a class="btn btn-default shiny" onclick="add();">回复</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										 <a class="btn btn-default shiny" onclick="modify();">修改</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										 <a class="btn btn-default shiny" onclick="reply();">屏蔽</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										 <a class="btn btn-default shiny" onclick="rereply();">恢复</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										 <a class="btn btn-default shiny" onclick="delet();">删除</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										 <a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										 </li>
									</div>
								</div>
								<div style="width:100%; min-height:300px; min-height:300px; overflow-Y: hidden;">
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="product_tab" style="table-layout:fixed;">
									<thead class="flip-content bordered-darkorange">
										<tr>
											<th style="text-align: center;" width="50px">选择</th>
											<th style="text-align: center;" width="120px">账号</th>
											<th style="text-align: center;" width="120px">订单编号</th>
											<th style="text-align: center;" width="120px">订单明细号</th>
											<th style="text-align: center;" width="75px">商品名</th>
											<th style="text-align: center;" width="75px">评论时间</th>
											<th style="text-align: center;" width="60px">好评度</th>
											<th style="text-align: center;" width="100px">评论内容</th>
											<th style="text-align: center;" width="120px">客服ID</th>
											<th style="text-align: center;" width="75px">回复时间</th>
											<th style="text-align: center;" width="120px">回复内容</th>
											<th style="text-align: center;" width="60px">是否有敏感词</th>
											<th style="text-align: center;" width="50px]">是否屏蔽</th>
											<th style="text-align: center;" width="50px">是否回复</th>
											<th style="text-align: center;" width="50px">是否审核</th>
											<th style="text-align: center;" width="50px">是否升级</th>
											<th style="text-align: center;" width="50px">是否解决</th>
											<th style="text-align: center;" width="50px">物流评级</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								</div>
								
								<div class="pull-left" style="padding: 10px 0;">
									<form id="product_form" action="">
										<input type="hidden" id="customeraccount" name="customeraccount" />
										<input type="hidden" id="ordernumber" name="ordernumber"/>
										<input type="hidden" id="functype" name="functype"/>
										<input type="hidden" id="praisedegree_from" name="praisedegree" value=""/>
										<input type="hidden" id="startcommenttime" name="startcommenttime" value=""/>
										<input type="hidden" id="endcommenttime" name="endcommenttime" value=""/>
										<input type="hidden" id="whether_reply_from" name="whether_reply" value=""/>
										<input type="hidden" id="whether_shielding_from" name="whether_shielding" value="" />
										<input type="hidden" id="customerservicenumber_from" name="customerservicenumber" value=""/>
										<input type="hidden" id="startrecoverytime" name="startrecoverytime" value="" />
										<input type="hidden" id="endrecoverytime" name="endrecoverytime" value=""/>
										<input type="hidden" id="whether_upgrade_from" name="whether_upgrade"value="" />
										<input type="hidden" id="deletnot" name="deletnot"value="" />
										<input type="hidden" id="commentid" name="commentsid" value=""/>
										<input type="hidden" id="datetimenow" name="datetimenow" value=""/>
										<input type="hidden" id="modow" name="modowtype" value=""/>
										<input type="hidden" id="replyinfo" name="replyinfo" value=""/>
										
									</form>
								</div>
								<div id="productPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
							
								<textarea id="product-list" rows="0" cols="0">
										<!--
										{#template MAIN}
										<input type="hidden" id="cachecode" value="{$T.Result.membercommentsid}"/>
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="membercommentsid_{$T.Result.membercommentsid}" value="{$T.Result.membercommentsid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="memberSid_{$T.Result.membercommentsid}"style="word-break:break-all">
														{#if $T.Result.memberSid == "" || $T.Result.memberSid == null}{$T.Result.features}
													    {#else}{$T.Result.memberSid}
													    {#/if}
													    {#if $T.Result.memberSid == "" || $T.Result.memberSid == null}--
													    {#/if}
													</td>
													<td align="center" id="orderno_{$T.Result.membercommentsid}">
														{#if $T.Result.orderno == "" || $T.Result.orderno == null}{$T.Result.features}
													    {#else}{$T.Result.orderno}
													    {#/if}
													</td>
													<td align="center" id="saleno_{$T.Result.membercommentsid}">
														{#if $T.Result.saleno == "" || $T.Result.saleno == null}{$T.Result.features}
													    {#else}{$T.Result.saleno}
													    {#/if}
														{#if $T.Result.saleno == "" || $T.Result.saleno == null}--
						                   				{#/if}	
													</td>
													<td align="center" style="word-wrap:break-word;word-break:break-all;" id="productName_{$T.Result.membercommentsid}">
														{#if $T.Result.productName == "" || $T.Result.productName == null}{$T.Result.features}
													    {#else}{$T.Result.productName}
													    {#/if}
													    {#if $T.Result.productName == "" || $T.Result.productName == null}--
						                   				{#/if}
													</td>
													<td align="center" id="ShieldTime_{$T.Result.membercommentsid}">
														{#if $T.Result.shieldtime == "" || $T.Result.shieldtime == null}{$T.Result.features}
													    {#else}{$T.Result.shieldtime}
													    {#/if}
													    {#if $T.Result.shieldtime == "" || $T.Result.shieldtime == null}
						                   				{#/if}
						                   				
													</td>
													<td align="center" id="score_{$T.Result.membercommentsid}">
														{#if $T.Result.score == "" || $T.Result.score == null}{$T.Result.features}
													    {#else}{$T.Result.score}星
													    {#/if}
													    {#if $T.Result.score == "" || $T.Result.score == null}--
						                   				{#/if}
													</td>
													<td align="center" style="word-wrap:break-word;word-break:break-all;" id="content_{$T.Result.membercommentsid}">
														{#if $T.Result.content == "" || $T.Result.content == null}{$T.Result.features}
													    {#else}{$T.Result.content}
													    {#/if}
													    {#if $T.Result.content == "" || $T.Result.content == null}--
						                   				{#/if}
													</td>
													<td align="center" id="cukomerserviceid_{$T.Result.membercommentsid}">
														{#if $T.Result.cukomerserviceid == "" || $T.Result.cukomerserviceid == null}{$T.Result.features}
													    {#else}{$T.Result.cukomerserviceid}
													    {#/if}
													    {#if $T.Result.cukomerserviceid == "" || $T.Result.cukomerserviceid == null}未回复
						                   				{#/if}
													</td>
													<td align="center" id="replyTime_{$T.Result.membercommentsid}">
														{#if $T.Result.replyTime == "" || $T.Result.replyTime == null}{$T.Result.features}
													    {#else}{$T.Result.replyTime}
													    {#/if}
													    {#if $T.Result.replyTime == "" || $T.Result.replyTime == null}未回复
						                   				{#/if}
													</td>
													<td align="center"  id="replyCon_{$T.Result.membercommentsid}" style="word-break:break-all">
														{#if $T.Result.replyCon == "" || $T.Result.replyCon == null}{$T.Result.features}
													    {#else}{$T.Result.replyCon}
													    <input type="hidden" id="replyCon{$T.Result.membercommentsid}" value="{$T.Result.replyCon}"/>
													    {#/if}
													    {#if $T.Result.replyCon == "" || $T.Result.replyCon == null}--
						                   				{#/if}
													</td>
													<td align="center" id="sensitiveword_{$T.Result.membercommentsid}">
														{#if $T.Result.sensitiveword == "" || $T.Result.sensitiveword == null}{$T.Result.features}
													    {#else}有敏感词
													    {#/if}
													    {#if $T.Result.sensitiveword == "" || $T.Result.sensitiveword == null}--
						                   				{#/if}
													</td>
													<td align="center" id="shieldout_{$T.Result.membercommentsid}">
														{#if $T.Result.shieldoutou == "" || $T.Result.shieldoutou == null}{$T.Result.features}
													    {#/if}
													    {#if $T.Result.shieldoutou =='0'}已屏蔽<input type="hidden" id="shieldoutre{$T.Result.membercommentsid}" value="0">
													    {#elseif $T.Result.shieldoutou =='1'}未屏蔽<input type="hidden" id="shieldoutre{$T.Result.membercommentsid}" value="1">
													    {#else}未屏蔽
						                   				{#/if}
													</td>
													<td align="center" id="wirteback_{$T.Result.membercommentsid}">
														{#if $T.Result.wirteback == "" || $T.Result.wirteback == null}{$T.Result.features}
													    {{#elseif $T.Result.wirteback != "" && $T.Result.wirteback != null}已回复 <input type="hidden" id="wirteback{$T.Result.membercommentsid}" value="{$T.Result.wirteback}"/>
													    {#/if}
													    {#if $T.Result.wirteback == "" || $T.Result.wirteback == null}未回复
						                   				{#/if}
													</td>
													<td align="center" id="examineout_{$T.Result.membercommentsid}">
														{#if $T.Result.examineout == "" || $T.Result.examineout == null}{$T.Result.features}
													    {#else}{$T.Result.examineout}
													    {#/if}
													    {#if $T.Result.examineout == "" || $T.Result.examineout == null}未进行审核
						                   				{#/if}
													</td>
													<td align="center" id="uplevel_{$T.Result.membercommentsid}">
														{#if $T.Result.uplevel == "" || $T.Result.uplevel == null}{$T.Result.features}
													    {#elseif  $T.Result.uplevel == '1'||$T.Result.uplevel == 1}已升级
													    {#/if}
													    {#if $T.Result.uplevel == "" || $T.Result.uplevel == null}未升级
						                   				{#/if}
													</td>
													<td align="center" id="solve_{$T.Result.membercommentsid}">
														{#if $T.Result.solve == "" || $T.Result.solve == null}{$T.Result.features}
													    {#else}{$T.Result.solve}分
													    {#/if}
													    {#if $T.Result.solve == "" || $T.Result.solve == null}未打分
						                   				{#/if}
													</td>

													<td style="display:none;" id="password_{$T.Result.membercommentsid}">{$T.Result.password}</td>
													<td style="display:none;" id="cardNo_{$T.Result.membercommentsid}">{$T.Result.card_no}</td>
													
													<td style="display:none;" id="statCategoryName_{$T.Result.membercommentsid}">{$T.Result.statCategoryName}</td>
													<td style="display:none;" id="spuCode_{$T.Result.membercommentsid}">{$T.Result.spuCode}</td>
													
													<td style="display:none;" id="proActiveBit_{$T.Result.membercommentsid}">{$T.Result.proActiveBit}</td>
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
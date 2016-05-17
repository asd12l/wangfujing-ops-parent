<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="col-lg-9 col-sm-9 col-xs-9 p0 rightdiv">
	<div class="widget-header">
		<h5 class="widget-caption">楼层配置</h5>
	</div>
	<form id="category_form" action="">
		<input type="hidden" id="cid" name="cid" />
	</form>
	<div class="tabbable" id="pro">
		<ul class="nav nav-tabs" id="myTab">
			<li class="active" id="divTitle">
				<a data-toggle="tab" href="#channel"> 块组管理</a>
			</li>
			<li class="tab-red" id="product_list" style="display: none">
				<a data-toggle="tab" href="#active"> 商品列表</a>
			</li>
			<li class="tab-green" id="brand_list" style="display: none">
				<a data-toggle="tab" href="#brand"> 品牌列表</a>
			</li>
			<li class="tab-bule" id="link_list" style="display: none">
				<a data-toggle="tab" href="#link"> 引导链接列表</a>
			</li>
		</ul>
		<div class="tab-content" style="height: 370px;">
			<div id="channel" class="tab-pane in active">
				<div class="btn-group clearfix">
					<a id="editabledatatable_add" onclick="addDiv();" class="btn btn-labeled btn-palegreen">
							<i class="btn-label glyphicon glyphicon-ok"></i>添加块组
					</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<a id="editabledatatable_del" onclick="delDivByGroup();"
						class="btn btn-labeled btn-darkorange"> <i
							class="btn-label glyphicon glyphicon-remove"></i>删除块组
					</a>
				</div>
				<div class="table-scrollable centerDiv">
					<table class="table table-striped table-bordered table-hover" id="channel_tab" 
						style="margin-top:10px;">
						<thead>
							<tr role="row">
								<th style="text-align: center;" width="75px;">选择</th>
								<th style="text-align: center;">类型</th>
								<th style="text-align: center;">顺序</th>
								<th style="text-align: center;">名称</th>
								<th style="text-align: center;">状态</th>
								<th style="text-align: center;">操作</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<input type='hidden' id='pageLayoutSid_' value=''></input>
					<p style="display: none">
						<textarea id="floor-list" rows="0" cols="0">
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
										<input type='hidden' id='pageLayoutSid_{$T.Result.sid}' value='{$T.Result.pageLayoutSid}'></input>
										{#if $T.Result.type==0}
											<td align="center" id="divType_{$T.Result.sid}">块组</td>
										{#elseif $T.Result.type==1}
											<td align="center" id="divType_{$T.Result.sid}">商品块</td>
										{#elseif $T.Result.type==2}
											<td align="center" id="divType_{$T.Result.sid}">品牌块</td>
										{#elseif $T.Result.type==3}
											<td align="center" id="divType_{$T.Result.sid}">链接块</td>
										{#elseif $T.Result.type==-1}
											<td align="center" id="divType_{$T.Result.sid}">楼层</td>
										{#/if}
										<td align="center" id="divSid_{$T.Result.sid}">{$T.Result.seq}</td>
										<td align="center" id="divTitle_{$T.Result.sid}">{$T.Result.title}</td>
										{#if $T.Result.pageType==1}
											<td align="center" id="pageType_{$T.Result.sid}"><span class="label label-success graded">启用</span></td>
										{#elseif $T.Result.pageType==0}
											<td align="center" id="pageType_{$T.Result.sid}"><span>未启用</span></td>
										{#else}
											<td align="center" id="pageType_{$T.Result.sid}">没有指定</td>
										{#/if}
										<td align="center" id="divLink_{$T.Result.sid}">
										<!-- <a class="btn btn-primary" onclick="delFloorDiv({$T.Result.sid});">删除
										</a> -->
										<a class="btn btn-info" onclick="editFloorDiv({$T.Result.sid},{$T.Result.type});">修改</a>
										</td>
						       		</tr>
								{#/for}
						    {#/template MAIN}	 -->
							</textarea>
						</p>
					</div>
				</div>
				<!-- 楼层下商品管理 -->
				<div id="active" class="tab-pane">
					<div class="tab-pane active" id="pro">
						<div class="btn-group clearfix">
							<a id="editabledatatable_add" onclick="addPro();" class="btn btn-labeled btn-palegreen">
								<i class="btn-label glyphicon glyphicon-ok"></i>添加商品
							</a>
							<a id="editabledatatable_del" onclick="delPro();" class="btn btn-labeled btn-darkorange"> 
								<i class="btn-label glyphicon glyphicon-remove"></i>删除商品
							</a>
						</div>
						<div class="centerDiv">
							<table class="table table-hover table-bordered"
								id="floor_product_tab">
								<thead>
									<tr role="row">
										<th style="text-align: center;" width="50px;">选择</th>
										<th style="text-align: center;">编号</th>
										<th style="text-align: center;">商品名称</th>
				<!-- 			<th>款号</th> -->
				<!-- 			<th>类别</th> -->
				<!-- 			<th>品牌</th> -->
									</tr>
								</thead>
								<tbody>
				
								</tbody>
							</table>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="floor_product-list" rows="0" cols="0">
									<!--
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox" style="margin-bottom: 0;margin-top: 0;">
														<label style="padding-left:8px;">
															<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												<td align="center" name="proSid">{$T.Result.productListSid}</td>
												<td align="center">{$T.Result.proName}</td>
								       		</tr>
										{#/for}
								    {#/template MAIN}	-->
								</textarea>
							</p>
						</div>
					</div>
				</div>
				<!-- 品牌管理 -->
				<div id="brand" class="tab-pane">
					<div class="tab-pane active" id="pro">
						<div class="btn-group clearfix">
							<a id="editabledatatable_add" onclick="addFloorBrand();" class="btn btn-labeled btn-palegreen">
								<i class="btn-label glyphicon glyphicon-ok"></i>添加品牌
							</a>
							<a id="editabledatatable_del" onclick="delBrand();" class="btn btn-labeled btn-darkorange"> 
								<i class="btn-label glyphicon glyphicon-remove"></i>删除品牌
							</a>
						</div>
						<div class="centerDiv">
							<table class="table table-hover table-bordered"
								id="brand_tab">
								<thead>
									<tr role="row">
										<th style="text-align: center;" width="50px;">选择</th>
										<th style="text-align: center;">编号</th>
										<th style="text-align: center;">品牌名称</th>
									</tr>
								</thead>
								<tbody>
				
								</tbody>
							</table>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="brand-list" rows="0" cols="0">
									<!-- 
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox" style="margin-bottom: 0;margin-top: 0;">
														<label style="padding-left:8px;">
															<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												
												<td align="center" name="brandSid" id="divSid_{$T.Result.sid}">{$T.Result.brandSid}</td>
												<td align="center" id="divTitle_{$T.Result.sid}">{$T.Result.name}</td>
								       		</tr>
										{#/for}
								    {#/template MAIN}	 -->
								</textarea>
							</p>
						</div>
					</div>
				</div>
				<!-- 引导链接管理 -->
				<div id="link" class="tab-pane">
					<div class="tab-pane active" id="pro">
						<div class="btn-group clearfix">
							<a id="editabledatatable_add" onclick="addLink();" class="btn btn-labeled btn-palegreen">
								<i class="btn-label glyphicon glyphicon-ok"></i>添加引导链接
							</a>
							<a id="editabledatatable_edit" onclick="editLink();" class="btn btn-info glyphicon glyphicon-wrench"> 编辑引导链接 </a>
							<a id="editabledatatable_del" onclick="delLink();" class="btn btn-labeled btn-darkorange"> <i
								class="btn-label glyphicon glyphicon-remove"></i>删除引导链接
							</a>
						</div>
						<div class="table-scrollable centerDiv">
							<table class="table table-striped table-bordered table-hover"
								id="link_tab">
								<thead>
									<tr role="row">
										<th style="text-align: center;">选择</th>
										<th style="text-align: center;">编号</th>
										<th style="text-align: center;">主标题</th>
										<th style="text-align: center;display:none;">图片地址</th>
										<th style="text-align: center;display:none;">背景图片</th>
										<th style="text-align: center;">顺序</th>
										<th style="text-align: center;">是否显示</th>
										<th style="text-align: center;">链接地址</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="link-list" rows="0" cols="0">
									<!-- 
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox" style="margin-bottom: 0;margin-top: 0;">
														<label style="padding-left: 7px;">
															<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												<input type='hidden' id='pageLayoutSid_{$T.Result.sid}' value='{$T.Result.pageLayoutSid}'></input>
												<input type='hidden' id='flag_{$T.Result.sid}' value='{$T.Result.flag}'></input>
												<td align="center" id="linkSid_{$T.Result.sid}">{$T.Result.sid}</td>
												<td style="white-space: normal;" align="center" id="linkMainTitle_{$T.Result.sid}">{$T.Result.mainTitle}</td>
												<td style="white-space: normal;display:none;" align="center" id="linkPic_{$T.Result.sid}">
													<a href="{$T.Result.pict}" target="_Blank">{$T.Result.pict}</a>
												</td>
												<td style="white-space: normal;display:none;" align="center" id="linkSubTitle_{$T.Result.sid}">
													<a href="{$T.Result.subTitle}" target="_Blank">{$T.Result.subTitle}</a>
												</td>
												<td align="center" id="seq_{$T.Result.sid}">{$T.Result.seq}</td>
												{#if $T.Result.flag==1}
													<td align="center" id="">启用</td>
												{#else}
													<td align="center" id="">未启用</td>
												{#/if}
												<td style="white-space: normal;" align="center" id="link_{$T.Result.sid}">{$T.Result.link}</td>
								       		</tr>
										{#/for}
								    {#/template MAIN}	 -->
								</textarea>
							</p>
						</div>
					</div>
				</div>
		</div>
	</div>
</div>	


							
<!-- 添加楼层下的块的引导链接 -->
<%@ include file="addFloorLink.jsp"%>
<!-- 修改楼层下的块的引导链接 -->
<%@ include file="editFloorLink.jsp"%>
<!-- 添加楼层下的块 -->
<%@ include file="addFloorDiv.jsp"%>
<!-- 添加楼层下的商品 -->
<%@ include file="addFloorProduct.jsp"%>

<!-- 修改楼层下的块 -->
<%@ include file="editFloorDIV.jsp"%>
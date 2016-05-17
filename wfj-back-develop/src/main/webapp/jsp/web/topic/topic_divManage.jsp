<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="widget-body" style="float: left; overflow: auto;width: 75%;">
	<div class="widget">
		<div class="widget-header ">
		<a onclick="back();" class="btn btn-default btn-blue btn-lg">返回</a>
			<span class="widget-caption"><h5>楼层配置</h5></span>
		</div>
		<form id="category_form" action="">
			<input type="hidden" id="cid" name="cid" />
		</form>
		<div class="widget-body" id="pro">
			<div class="tabbable">
				<ul class="nav nav-tabs" id="myTab">
					<li class="active" id="divTitle"><a data-toggle="tab"
						href="#channel"> 块组管理 
					</a></li>
					<li class="tab-red" id="product_list" style="display: none"><a data-toggle="tab"
						href="#active"> 商品列表 
					</a></li>
					<li class="tab-green" id="brand_list" style="display: none"><a data-toggle="tab"
						href="#brand"> 品牌列表
					</a></li>
					<li class="tab-bule" id="link_list" style="display: none"><a data-toggle="tab" 
						href="#link"> 引导链接列表
					</a></li>
					<li class="tab-bule" id="linkProduct_list" style="display: none"><a data-toggle="tab" 
						href="#linkProduct"> 链接商品列表
					</a></li>
				</ul>
				<div class="tab-content" style="padding: 0px 0px;">
					<!-- 楼层下块列表 -->
					<div id="channel" class="tab-pane in active">
						<div class="widget-body centerDiv" id="pro">
							<table class="table table-hover table-bordered table-clear table-clear"
								id="channel_tab" style="margin-top:10px">
								<thead>
									<tr role="row">
										<th width="35px;"></th>
										<th style="text-align: center;">类型</th>
										<th style="text-align: center;">名称</th>
										<th style="text-align: center;">顺序</th>
										<!-- <th style="text-align: center;">英文名称</th> -->
										<th style="text-align: center;">状态</th>
										<th style="width:120px;text-align: center;">操作</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table><input type='hidden' id='pageLayoutSid_' value=''></input>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="floor-list" rows="0" cols="0">
									<!-- 
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox">
														<label style="padding-left: 5px;">
															<input type="checkbox" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												<input type='hidden' id='pageLayoutSid_{$T.Result.id}' value='{$T.Result.floorId}'></input>
												{#if $T.Result.floorType==0}
													<td align="center" id="divType_{$T.Result.id}">块组</td>
												{#elseif $T.Result.floorType==1}
													<td align="center" id="divType_{$T.Result.id}">商品块</td>
												{#elseif $T.Result.floorType==2}
													<td align="center" id="divType_{$T.Result.id}">品牌块</td>
												{#elseif $T.Result.floorType==3}
													<td align="center" id="divType_{$T.Result.id}">链接块</td>
												{#elseif $T.Result.floorType==4}
													<td align="center" id="divType_{$T.Result.id}">链接商品</td>
												{#elseif $T.Result.floorType==-1}
													<td align="center" id="divType_{$T.Result.id}">楼层</td>
												{#/if}
												<td align="center" id="divTitle_{$T.Result.id}">{$T.Result.title}</td>
												<td align="center" id="divSid_{$T.Result.id}">{$T.Result.seq}</td>
												{#if $T.Result.flag==0}
													<td align="center" id="flag_{$T.Result.id}"><span class="label label-danger graded">未启用</span></td>
												{#elseif $T.Result.flag==1}
													<td align="center" id="flag_{$T.Result.id}"><span class="label label-success graded">启用</span></td>
												{#/if}
												<td align="center" id="divLink_{$T.Result.id}">
													<a class="btn btn-info btn-sm" onclick="editFloorDiv({$T.Result.id},{$T.Result.seq},{$T.Result.flag});">修改</a>&nbsp;&nbsp;
													<a class="btn btn-primary btn-sm" onclick="delFloorDiv({$T.Result.id});">删除</a>
												</td>
								       		</tr>
										{#/for}
								    {#/template MAIN}	 -->
								</textarea>
							</p>
							<!-- <td align="center" id="divEnTitle_{$T.Result.id}">{$T.Result.enTitle}</td> -->
						</div>
					</div>
					<!-- 楼层下商品管理 -->
					<div id="active" class="tab-pane">
						<div class="widget-body centerDiv" id="pro">
							<div class="btn-group pull-right">
								<div class="col-xs-6 col-md-6">
									<a id="editabledatatable_add" onclick="addPro();" class="btn btn-palegreen glyphicon glyphicon-plus">
										添加商品
	        						</a>
        						</div>
        						<div class="col-xs-6 col-md-6">
	       							<a id="editabledatatable_del" onclick="delPro();" class="btn btn-danger glyphicon glyphicon-trash">
										删除商品
	           						</a>&nbsp;
	           					</div>
							</div>
							<div class="table-scrollable centerDiv">
								<table class="table table-striped table-bordered table-hover" id="floor_product_tab">
									<thead>
										<tr role="row">
											<th style="width: 45px;"></th>
											<th style="text-align: center;">编号</th>
											<th style="text-align: center;">商品名称</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="floor_product-list" rows="0" cols="0">
									<!--
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox">
														<label style="padding-left: 5px;">
															<input type="checkbox"  ref="productlist" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												<td align="center" name="proSid">{$T.Result.productSid}</td>
												<td align="center">{$T.Result.proName}</td>
								       		</tr>
										{#/for}
								    {#/template MAIN}	-->
								</textarea>
							</p>
						</div>
					</div>
					<!-- 品牌管理 -->
					<div id="brand" class="tab-pane">
						<div class="widget-body centerDiv" id="pro">
							<div class="btn-group pull-right">
								<div class="col-md-6">
									<a id="editabledatatable_add" onclick="addFloorBrand();" class="btn btn-palegreen glyphicon glyphicon-plus">
										添加品牌
	        						</a>
								</div>
								<div class="col-md-6">
	       							<a id="editabledatatable_del" onclick="delBrand();" class="btn btn-danger glyphicon glyphicon-trash">
										删除品牌
	                                </a>&nbsp;
                                </div>
							</div>
							<div class="table-scrollable centerDiv">
								<table class="table table-striped table-bordered table-hover" id="brand_tab">
									<thead>
										<tr role="row">
											<th width='35px;'></th>
											<th style="text-align: center;">编号</th>
											<th style="text-align: center;">品牌名称</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="brand-list" rows="0" cols="0">
									<!-- 
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox">
														<label style="padding-left: 5px;">
															<input type="checkbox" ref="brandlist" id="tdCheckbox_{$T.Result.brandSid}" value="{$T.Result.brandSid}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												<td align="center" name="brandSid" id="divSid_{$T.Result.brandSid}">{$T.Result.brandSid}</td>
												<td align="center" id="divTitle_{$T.Result.brandSid}">{$T.Result.name}</td>
								       		</tr>
										{#/for}
								    {#/template MAIN}	 -->
								</textarea>
							</p>
						</div>
					</div>
					<!-- 引导链接管理 -->
					<div id="link" class="tab-pane">
						<div class="widget-body centerDiv" id="pro">
							<div class="btn-group pull-right">
								<div class="col-xs-4 col-md-4">
									<a id="editabledatatable_add" onclick="addLink();" class="btn btn-palegreen glyphicon glyphicon-plus">
										添加引导链接
	        						</a>
								</div>
	           					<div class="col-xs-4 col-md-4">
	           						<a id="editabledatatable_edit" onclick="editLink();" class="btn btn-info glyphicon glyphicon-wrench">
										编辑引导链接
	           						</a>
	           					</div>
								<div class="col-xs-4 col-md-4">
	       							<a id="editabledatatable_del" onclick="delLink();" class="btn btn-danger glyphicon glyphicon-trash">
										删除引导链接
	           						</a>&nbsp;
	           					</div>
							</div>
							<div class="table-scrollable centerDiv">
								<table class="table table-striped table-bordered table-hover" id="link_tab">
									<thead>
										<tr role="row">
											<th></th>
											<th style="text-align: center;">编号</th>
											<th style="text-align: center;">主标题</th>
											<th style="text-align: center;">副标题</th>
											<th style="text-align: center;display:none;">图片地址</th>
											<th style="text-align: center;">图片地址</th>
											<th style="text-align: center;">顺序</th>
											<th style="text-align: center;">是否显示</th>
											<th style="text-align: center;">链接地址</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="link-list" rows="0" cols="0">
									<!-- 
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox">
														<label style="padding-left: 5px;">
															<input type="checkbox" ref="linklist" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												<input type='hidden' id='pageLayoutSid_{$T.Result.id}' value='{$T.Result.pageLayoutSid}'></input>
												<input type='hidden' id='flag_{$T.Result.id}' value='{$T.Result.flag}'></input>
												
												<td align="center" id="linkSid_{$T.Result.id}">{$T.Result.id}</td>
												<td align="center" id="linkMainTitle_{$T.Result.id}">{$T.Result.mainTitle}</td>
												<td align="center" id="linkSubTitle_{$T.Result.id}">{$T.Result.subTitle}</td>
												<td style="white-space: normal;display:none;" align="center" id="linkPic_{$T.Result.id}">{$T.Result.pict}</td>
												<td style="white-space: normal;" align="center" id="linkPicUrl_{$T.Result.id}">{$T.Result.pictPath}</td>
												<td align="center" id="seq_{$T.Result.id}">{$T.Result.seq}</td>
												{#if $T.Result.flag==1}
													<td align="center"><span class="label label-success graded">是</span></td>
												{#else}
													<td align="center"><span class="label label-danger graded">否</span></td>
												{#/if}
												<td style="white-space: normal;" align="center" id="link_{$T.Result.id}">{$T.Result.link}</td>
								       		</tr>
										{#/for}
								    {#/template MAIN}	 -->
								</textarea>
							</p>
						</div>
					</div>
					<!-- 链接商品列表 -->
					<div id="linkProduct" class="tab-pane">
						<div class="widget-body centerDiv" id="pro">
							<div class="btn-group pull-right">
								<div class="col-xs-4 col-md-4">
									<a id="editabledatatable_add" onclick="addLinkProduct();" class="btn btn-palegreen glyphicon glyphicon-plus">
										添加链接商品
	        						</a>
								</div>
	           					<div class="col-xs-4 col-md-4">
	           						<a id="editabledatatable_edit" onclick="editLinkProduct();" class="btn btn-info glyphicon glyphicon-wrench">
										编辑链接商品
	           						</a>
	           					</div>
								<div class="col-xs-4 col-md-4">
	       							<a id="editabledatatable_del" onclick="delLinkProduct();" class="btn btn-danger glyphicon glyphicon-trash">
										删除链接商品
	           						</a>&nbsp;
	           					</div>
							</div>
							<div class="table-scrollable centerDiv">
								<table class="table table-striped table-bordered table-hover" id="linkProduct_tab">
									<thead>
										<tr role="row">
											<th></th>
											<th style="text-align: center;">编号</th>
											<th style="text-align: center;">商品图片</th>
											<th style="text-align: center;">顺序</th>
											<th style="text-align: center;">是否显示</th>
											<th style="text-align: center;">链接地址</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="linkProduct-list" rows="0" cols="0">
									<!-- 
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox">
														<label style="padding-left: 5px;">
															<input type="checkbox" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												<input type='hidden' id='pageLayoutSid_{$T.Result.id}' value='{$T.Result.pageLayoutSid}'></input>
												<input type='hidden' id='flag_{$T.Result.id}' value='{$T.Result.flag}'></input>
												
												<td align="center" id="linkSid_{$T.Result.id}">{$T.Result.id}</td>
												<td style="white-space: normal;" align="center" id="linkPic_{$T.Result.id}">{$T.Result.pict}</td>
												<td align="center" id="seq_{$T.Result.id}">{$T.Result.seq}</td>
												{#if $T.Result.flag==1}
													<td align="center"><span class="label label-success graded">是</span></td>
												{#else}
													<td align="center"><span class="label label-danger graded">否</span></td>
												{#/if}
												<td style="white-space: normal;" align="center" id="link_{$T.Result.id}">{$T.Result.link}</td>
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
</div>
<!-- 添加链接商品页 -->
<%@ include file="./FloorLinkProduct/addFloorLinkProduct.jsp"%>
<!-- 修改链接商品页 -->
<%@ include file="./FloorLinkProduct/editFloorLinkProduct.jsp"%>
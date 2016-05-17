<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="col-lg-9 col-sm-9 col-xs-9 p0 rightdiv" style="width:100%;">
	<div class="widget-header">
		<h5 class="widget-caption">广告商品配置</h5>
		<a class="btn btn-default btn-blue" onclick="back();" style="margin-right:60px;">返回</a>
	</div>
	<div class="tabbable" id="pro">
		<ul class="nav nav-tabs" id="myTab">
			<li class="tab-red active" id="advertise_product_list"><a data-toggle="tab"
				href="#active"> 商品列表 
			</a></li>
		</ul>
		<div style="height: 370px; overflow: auto;"><!--  class="tab-content" -->
				<!-- 广告下商品管理 -->
				<div id="active" class="tab-pane active">
					<div class="widget-body" id="pro">
						<div class="btn-group pull-right">
							<div class="col-md-6">
								<a id="editabledatatable_add" onclick="addPro();"  class="btn btn-labeled btn-palegreen">
									<i class="btn-label glyphicon glyphicon-ok"></i>添加资源
								</a>
							</div>
							<div class="col-md-6">
								<a id="editabledatatable_del" onclick="delPro();" class="btn btn-labeled btn-darkorange"> 
									<i class="btn-label glyphicon glyphicon-remove"></i>删除资源
								</a>&nbsp;
							</div>
							<input id="advertise_id_hide" type="hidden">
						</div>
						<table class="table table-hover table-bordered"
							id="adver_product_tab">
							<thead>
								<tr role="row">
									<th width='35px;'></th>
									<th style="text-align: center;">编号</th>
									<th style="text-align: center;">商品名称</th>
									<th style="text-align: center;">商品价格</th>
									<!-- 			<th>款号</th> -->
									<!-- 			<th>类别</th> -->
									<th style="text-align: center;">品牌</th>
								</tr>
							</thead>
							<tbody>
			
							</tbody>
						</table>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="adver_product-list" rows="0" cols="0">
								<!--
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX">
											<td align="left">
												<div class="checkbox">
													<label style="padding-left: 7px;">
														<input type="checkbox" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
														<span class="text"></span>
													</label>
												</div>
											</td>
											<td align="center" name="proSid">{$T.Result.productSkuCode}</td>
											<td align="center">{$T.Result.productName}</td>
											<td align="center">{$T.Result.productPrice}</td>
											<td align="center">{$T.Result.brandName}</td>
							       		</tr>
									{#/for}
							    {#/template MAIN}	-->
							</textarea>
						</p>
					</div>
				</div>
				
				<%@ include file="addFloorProduct.jsp" %>
		</div>
	</div>									
</div>	

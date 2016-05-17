<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 商品列表弹窗 -->
<div class="modal modal-darkorange" id="addHotwordDIV">
	<div class="modal-dialog" style="width: 70%;">
		<div class="row widget">
			<div class="widget-header ">
				<h5 class="widget-caption">热门关键词列表</h5>
				<div class="widget-buttons">
					<a href="#" data-toggle="collapse" onclick="tab('pro');"> <i class="fa fa-minus" id="pro-i"></i></a>
					<a href="#" aria-hidden="true" data-toggle="collapse" data-dismiss="modal" onclick="closeDiv();"><i class="fa fa-times"></i></a>
				</div>
			</div>
			<div class="widget-body" id="pro">
				<div class="table-toolbar clearfix">
					<div class="col-lg-3 col-sm-3 col-xs-3">
						<span>关键词：</span>
						<input type="text" id="hotword_input" style="width: 60%;"/>
					</div>
					<div class="col-lg-6 col-sm-6 col-xs-6">
						<a onclick="query();" class="btn btn-yellow"> 
							<i class="fa fa-eye"></i> 查询
						</a>&nbsp;&nbsp;
						<a id="editabledatatable_new" onclick="addHotword();" class="btn btn-primary">
							<i class="fa fa-random"></i>添加
						</a>
					</div>
				</div>
				<table
					class="table table-bordered table-striped table-condensed table-hover flip-content"
					id="hotword_tab">
					<thead class="flip-content bordered-darkorange">
						<tr>
							<th style="text-align: center;" width="5%">选择</th>
							<th style="text-align: center;">关键词</th>
							<th style="text-align: center;">链接</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div class="pull-left" style="padding: 10px 0;">
					<form id="product_form" action="">
						<div class="col-lg-12">
							<select id="pageSelect" name="pageSize"
								style="padding: 0 12px;">
								<option>5</option>
								<option selected="selected">10</option>
								<option>15</option>
								<option>20</option>
							</select>
						</div>
					</form>
				</div>
				<div id="hotwordPagination"></div>
			</div>
			<!-- Templates -->
			<p style="display: none">
				<textarea id="hotword-list-s" rows="0" cols="0">
						<!--
						{#template MAIN}
							{#foreach $T.list as Result}
								<tr class="gradeX">
									<td align="left">
										<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
											<label style="padding-left:9px;">
												<input type="checkbox" value="{$T.Result.hotword}|{$T.Result.link}" >
												<span class="text"></span>
											</label>
										</div>
									</td>
									<td align="center">
										<a onclick="getView({$T.Result.sid});" style="cursor:pointer;">{$T.Result.hotword}</a></td>
									<td align="center">
										<a onclick="getView({$T.Result.sid});" style="cursor:pointer;">{$T.Result.link}</a></td>
					       		</tr>
							{#/for}
					    {#/template MAIN}	-->
					</textarea>
			</p>
		</div>
	</div>
</div>
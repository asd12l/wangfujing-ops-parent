<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="widget-body" >
		<div class="widget" >
			<div class="widget-header ">
				<span class="widget-caption"><h5>关键词管理</h5></span>
				<div class="widget-buttons">
					<a href="#" data-toggle="maximize"></a> <a href="#"
						data-toggle="collapse" onclick="tab('pro');"> <i
						class="fa fa-minus" id="pro-i"></i>
					</a> <a href="#" data-toggle="dispose"></a>
				</div>
			</div>
			<form id="category_form" action="">
				<input type="hidden" id="cid" name="cid" />
			</form>
			<div class="widget-body" id="pro">
				<div class="tabbable">
					<div class="tab-content" style="height: 350px;overflow:auto;">
						<!-- 导航管理 -->
						<!-- 热门品牌 -->
						<div id="hootBrand" class="tab-pane active">
							<div class="widget-body" id="pro">
								<div class="btn-group pull-right">
										<span> <a
										onclick="addHotwordDiv();" class="btn btn-labeled btn-palegreen">
											<i class="btn-label glyphicon glyphicon-ok"></i>添加关键词
									</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span> <a
										onclick="deleteHotWord();"
										class="btn btn-labeled btn-darkorange"> <i
											class="btn-label glyphicon glyphicon-remove"></i>删除关键词
									</a></span>
								</div>
								<table class="table table-hover table-bordered"
									id="hotword_tab_db">
									<thead>
										<tr role="row">
											<th width="35px;"></th>
											<th style="text-align: center;">关键词</th>
											<th style="text-align: center;">链接</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
								<div class="pull-left" style="padding: 10px 0;">
									<form id="product_form1" action="">
										<div class="col-lg-12">
											<select id="pageSelect1" name="pageSize"
												style="padding: 0 12px;">
												<option>5</option>
												<option selected="selected">10</option>
												<option>15</option>
												<option>20</option>
											</select>
										</div>
									</form>
								</div>
								<div id="hotwordPagination1"></div>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="hotword-list-db" rows="0" cols="0">
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
																				<td align="center" id="brandname_{$T.Result.sid}">{$T.Result.hotword}</td>
																				<td align="center" id="brandlink_{$T.Result.sid}">{$T.Result.link}</td>
																       		</tr>
																		{#/for}
																    {#/template MAIN}	-->
																</textarea>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<%@ include file="addHotWord.jsp"%>

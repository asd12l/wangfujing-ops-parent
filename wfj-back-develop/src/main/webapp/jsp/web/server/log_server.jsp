<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 列表弹窗 -->
<div class="modal modal-darkorange" id="serverLogDIV">
	<div class="modal-dialog" style="width: 70%;">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="col-xs-12 col-md-12">
				<div class="widget">
					<div class="modal-header " style="background-color: #fff;">
						<button aria-hidden="true" data-dismiss="modal" class="close"
							type="button" onclick="closeDiv();">×</button>
						<span class="widget-caption"><h5>操作记录管理</h5></span>
					</div>
					<div class="widget-body" id="pro">
						<div class="table-toolbar">
							<table
								class="table table-bordered table-striped table-condensed table-hover flip-content"
								id="server_log_tab">
								<thead class="flip-content bordered-darkorange">
									<tr role="row">
<!-- 										<th style="text-align: center;" width="75px;">选择</th> -->
										<th style="text-align: center;">操作记录编号</th>
										<th style="text-align: center;">操作人</th>
										<th style="text-align: center;">操作结果</th>
										<th style="text-align: center;">messageId</th>
										<th style="text-align: center;">操作时间</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							
						</div>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="log-list" rows="0" cols="0">
									<!-- 
									{#template MAIN}
										{#foreach $T.list as Result}
										<tr class="gradeX">
											
											<td align="center" id="logid_{$T.Result.id}">{$T.Result.id}</td>
											<td align="center" id="user_{$T.Result.id}">{$T.Result.user}</td>
											<td align="center" id="status_{$T.Result.id}">
												{#if $T.Result.status == 0}
													<span>失败</span>
												{#else}
													<span>成功</span>
												{#/if}
											</td>
											<td align="center" id="messageid_{$T.Result.id}">{$T.Result.messageId}</td>
											<td align="center" id="dateTime_{$T.Result.id}">{$T.Result.dateTime}</td>
											<td align="center" style="display:none;" id="info_{$T.Result.brandSid}">{$T.Result.text}</td>
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
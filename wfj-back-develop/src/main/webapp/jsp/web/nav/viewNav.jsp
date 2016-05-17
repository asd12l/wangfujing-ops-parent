<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange" id="loadNavDIV">
	<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">查看导航链接</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="viewNavForm" method="post" class="form-horizontal"
								enctype="multipart/form-data">
								<div class="form-group">
		                            <label class="col-sm-3 control-label no-padding-right">导航名称：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder="必填"
										class="form-control" id="name_nav_load" name="name" readonly="readonly">
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label no-padding-right">导航链接：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" id="link_nav_load" name="link" readonly="readonly">
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label no-padding-right">顺序： </label>
		                            <div class="col-sm-9">
										 <input type="text" placeholder=""
										class="form-control" id="seq_nav_load" name="seq" readonly="readonly">
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label no-padding-right">是否有效</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label id="a">
												<input class="basic" type="radio"
													id="isShowNav_load_1" name="isShow" value="1" checked="checked" > 
													<span class="text">是</span>
											</label> 
											<label id="b"> 
												<input class="basic" type="radio"
													id="isShowNav_load_0" name="isShow" value="0"> 
													<span class="text">否</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label> <input class="inverted" type="radio"
												name="isShow"> <span class="text"></span>
											</label>
										</div>
		                            </div>
		                        </div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
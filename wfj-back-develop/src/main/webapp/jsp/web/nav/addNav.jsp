<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange" id="addNavDIV">
	<div class="modal-dialog" style="width: 500px; margin: 10px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">添加导航</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="addNavForm" method="post" class="form-horizontal">
								<input type="hidden" id="channel_sid" name="channelSid" value="">
								<input type="hidden" id="nav_sid" name="navSid" value="">
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>导航名称：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" class="form-control clear_input" id="name_nav_add"
											name="name" placeholder="" />
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">英文名称：</label>
		                            <div class="col-sm-9">
										<input type="text" class="form-control clear_input" id="en_name_nav_add"
											name="enName" placeholder="" />
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>导航链接：
									</label>
		                            <div class="col-sm-9">
										<input type="text" class="form-control clear_input" id="link_nav_add"
											name="link" placeholder="" />
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>顺&#12288;&#12288;序： 
									</label>
		                            <div class="col-sm-9">
		                            	<div class="spinner spinner-horizontal spinner-two-sided">
                                            <div class="spinner-buttons	btn-group spinner-buttons-left">
                                                <button type="button" class="btn spinner-down danger">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input type="text" class="spinner-input form-control clear_input" id="seq_nav_add"
											name="seq" placeholder="" />
                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
                                                <button type="button" class="btn spinner-up blue">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">是否有效</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label>
												<input class="basic" type="radio" id="isShowNav_add_1" checked="checked" name="isShow" value="1">
												<span class="text">是</span>
											</label>
											<label>
												<input class="basic" type="radio" id="isShowNav_add_0" name="isShow" value="0">
												<span class="text">否</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label>
												<input class="inverted" type="radio" name="isShow">
												<span class="text"></span>
											</label>
										</div>
		                            </div>
		                        </div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button"
					onclick="addNavForm();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
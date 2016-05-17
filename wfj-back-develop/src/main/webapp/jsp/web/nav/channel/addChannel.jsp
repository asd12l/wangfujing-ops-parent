<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="addChannelDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv(this);">×</button>
				<h4 class="modal-title">添加频道</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="addChannelForm" method="post" class="form-horizontal" >
								<input type="hidden" id="root" name="root" value="">
					            <input type="hidden" id="site_sid" name="siteId" value="">
					            <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>频道名称：
		                            </label>
		                            <div class="col-sm-9">
		                                <input type="text" class="form-control clear_input" id="channel_add_name" name="name" />
		                            </div>
		                        </div>
					            <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>访问路径：
		                            </label>
		                            <div class="col-sm-9">
		                                <select class="form-control channel_path clear_input" id="channel_add_path" name="path"></select>
		                            </div>
		                        </div>
					            <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>频道模板：
		                            </label>
		                            <div class="col-sm-9">
		                                <select class="form-control tplChannel" id="channel_add_template" name="tplChannel">
										</select><input type="button" value="预览" onclick="showTplView(this,1);" >
		                            </div>
		                        </div>
					            <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>排列顺序：
		                            </label>
		                            <div class="col-sm-9">
		                            	<div class="spinner spinner-horizontal spinner-two-sided">
                                            <div class="spinner-buttons	btn-group spinner-buttons-left">
                                                <button type="button" class="btn spinner-down danger">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input type="text" maxlength="3" class="spinner-input form-control clear_input" 
                                            	id="add_priority" name="priority" value="1">
                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
                                                <button type="button" class="btn spinner-up blue">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
		                            </div>
		                        </div>
					            <div class="form-group" id="add_index_flag">
		                            <label class="col-sm-3 control-label">设置首页：</label>
		                            <div class="col-sm-9" style="padding-top: 7px;">
		                                <label> <input class="basic" type="radio"
											id="channel_add_flag_1" name="indexFlag" value="1"> <span
											class="text">是</span>
										</label> <label> <input class="basic" type="radio"
											id="channel_add_flag_0" name="indexFlag" value="0" checked="checked"> <span
											class="text">否</span>
										</label>
		                            </div>
		                        </div>
					            <div class="form-group">
		                            <label class="col-sm-3 control-label">显&#12288;&#12288;示：</label>
		                            <div class="col-sm-9" style="padding-top: 7px;">
		                                <label> <input class="basic" type="radio"
											id="channel_add_display_1" name="display" value="1" checked="checked"> <span
											class="text">是</span>
										</label> <label> <input class="basic" type="radio"
											id="channel_add_display_0" name="display" value="0" > <span
											class="text">否</span>
										</label>
		                            </div>
		                        </div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button"
					onclick="addChannelForm();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>	
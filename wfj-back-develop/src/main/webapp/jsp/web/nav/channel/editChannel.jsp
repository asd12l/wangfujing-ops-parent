<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="editChannelDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">修改频道</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="editChannelForm" method="post" class="form-horizontal" >
								<input type="hidden" id="channel_id" name="id" >
					            <input type="hidden" id="parent_id" name="parentId" >
					            <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>频道名称：
		                            </label>
		                            <div class="col-sm-9">
		                                <input type="text" placeholder=""
										class="form-control" id="channel_edit_name" name="name" >
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>访问路径：
		                            </label>
		                            <div class="col-sm-9">
		                                <select class="form-control channel_path" id="channel_edit_path" name="path"></select>
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>频道模板：
		                            </label>
		                            <div class="col-sm-9">
		                                <select class="form-control tplChannel" id="channel_tplChannel" name="tplChannel"></select>
										<input type="button" value="预览" onclick="showTplView(this,2);" >
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">排列顺序：</label>
		                            <div class="col-sm-9">
		                            	<div class="spinner spinner-horizontal spinner-two-sided">
                                            <div class="spinner-buttons	btn-group spinner-buttons-left">
                                                <button type="button" class="btn spinner-down danger">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input type="text" maxlength="3" class="spinner-input form-control" 
                                            	id="channel_priority" name="priority"/>
                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
                                                <button type="button" class="btn spinner-up blue">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
		                            </div>
		                        </div>
		                        <div class="form-group" id="edit_index_flag">
		                            <label class="col-sm-3 control-label">设置首页：</label>
		                            <div class="radio col-sm-9">
		                                <label> <input class="basic" type="radio"
											id="channel_edit_flag_1" name="indexFlag" value="1"> <span
											class="text">是</span>
										</label> <label> <input class="basic" type="radio"
											id="channel_edit_flag_0" name="indexFlag" value="0" checked="checked"> <span
											class="text">否</span>
										</label>
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">显示：</label>
		                            <div class="radio col-sm-9">
		                                <label> <input class="basic" type="radio"
											id="display_1" name="display" value="1"> <span
											class="text">是</span>
										</label> <label> <input class="basic" type="radio"
											id="display_0" name="display" value="0" > <span
											class="text">否</span>
										</label></td> 
										<div class="radio" style="display: none;">
											<label> <input class="inverted" type="radio"
												name="display"> <span class="text"></span>
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
					onclick="editChannelForm();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
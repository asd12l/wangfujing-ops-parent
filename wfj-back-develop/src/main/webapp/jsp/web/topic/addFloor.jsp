<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="addTopicFloorDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">添加楼层</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="addTopicFloorForm" method="post" class="form-horizontal" >
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>名&#12288;&#12288;称：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
											class="form-control clear_input" id="title_add" name="title" >
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">英文名称：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
											class="form-control clear_input" id="en_title_add" name="enTitle"/>
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
                                            <input type="text" class="spinner-input form-control clear_input" id="floor_seq_add"
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
		                            <label class="col-sm-3 control-label">楼层样式：</label>
		                            <div class="col-sm-9">
										<select class="form-control style_list" id="style_list" name="styleList" data-bv-field="country">
											<option value="">--无--</option>
										</select>
										<a onclick="view(0);" class="btn btn-default">预览</a>
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">是否生效：</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label> <input class="basic" type="radio"
												id="add_floorFlag_0" name="flag" value="1" checked="checked"> <span
												class="text">是</span>
											</label> 
											<label> <input class="basic divtype" type="radio"
												id="add_floorFlag_1" name="flag" value="0" > <span
												class="text">否</span></label>
										</div>
										<div class="radio" style="display: none;">
											<label> <input class="inverted" type="radio"
												name="flag"> <span class="text"></span>
											</label>
										</div>
		                            </div>
		                        </div>
								<input type="hidden" class="add_topicId" name="topicId" value=""/>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button"
					onclick="saveTopicFloor();">保存</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
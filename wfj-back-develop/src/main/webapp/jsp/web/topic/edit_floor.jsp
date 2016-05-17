<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange" id="editFloor">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title floor-title">修改楼层</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="editTopicFloorForm" method="post" class="form-horizontal editFloor" >
								<input type="hidden" id="floor_id_edit" name="id" value="" />
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>名&#12288;&#12288;称：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" id="floor_title_edit" name="title" >
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">英文名称：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
											class="form-control" id="floor_en_title_edit" name="enTitle" >
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
                                            <input type="text" class="spinner-input form-control clear_input" id="topic_floor_seq"
												name="seq" placeholder="" />
                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
                                                <button type="button" class="btn spinner-up blue">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
		                            </div>
		                        </div>
								<div class="form-group topic_floor_style">
		                            <label class="col-sm-3 control-label">楼层样式：</label>
		                            <div class="col-sm-9">
										<select class="form-control style_list" id="floor_style_edit" name="styleList">
											<option value="">--无--</option>
										</select>
										<a onclick="view(1);" class="btn btn-default">预览</a>
		                            </div>
		                        </div>
								<div class="form-group topic_floor_style">
		                            <label class="col-sm-3 control-label">是否生效：</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label> <input class="basic" type="radio"
												id="edit_tfloorFlag_0" name="flag" value="1"> <span
												class="text">是</span>
											</label> <label> <input class="basic divtype" type="radio"
												id="edit_tfloorFlag_1" name="flag" value="0" > <span
												class="text">否</span></label>
										</div>
										<div class="radio" style="display: none;">
											<label> <input class="inverted" type="radio"
												name="flag"> <span class="text"></span>
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
					onclick="editFloor();">保存</button>
			</div>
		</div>
	</div>
</div>
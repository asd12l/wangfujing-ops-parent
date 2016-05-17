<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange editDiv" id="editFloorDIV">
	<div class="modal-dialog" style="width: 500px; margin: 10px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">修改块</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="editDivForm" method="post" class="form-horizontal editFloor" >
								<input type="hidden" name="divSid" id="divSid" value="" />
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>名&nbsp;&nbsp;&nbsp;称：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control clear_input" id="div_title" name="title" />
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">英文名称：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control clear_input" id="div_en_title" name="enTitle" />
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label"><span style="color:red;">*</span>顺序：</label>
		                            <div class="col-sm-9" id="editFloorDIVspinner">
										<div class="spinner spinner-horizontal spinner-two-sided">
                                            <div class="spinner-buttons	btn-group spinner-buttons-left">
                                                <button type="button" class="btn spinner-down danger">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input type="text" class="spinner-input form-control clear_input" id="div_seq_edit" name="seq" />
                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
                                                <button type="button" class="btn spinner-up blue">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
		                            </div>
		                        </div>
								<div class="form-group" id="floorType">
									<label class="col-sm-3 control-label">块类型：</label>
									<div class="radio col-sm-9">
										<label> <input class="basic" type="radio"
											id="divType_edit_1" name="type" value="2" /> <span
											class="text">品牌</span>
										</label> <label> <input class="basic add_divType_2" type="radio"
											id="divType_edit_0" name="type" value="1"/> <span
											class="text">商品</span>
										</label> <label> <input class="basic" type="radio"
											id="divType_edit_2" name="type" value="3" /> <span
											class="text">链接</span>
										</label>
									</div>
								</div>
								<div class="form-group div adddiv_selectlist" id="" style="display: none;">
									<label class="col-sm-3 control-label">楼层样式：</label>
									<div class="col-sm-9">
										<select class="form-control pro_style_list" id="edit_div_style_list" name="styleList" data-bv-field="country">
											<option value="">--无--</option>
										</select><input type="button" value="预览" onclick="view(this);" />
									</div>
								</div>
								<div class="form-group" id="add_floorFlag">
									<label class="col-sm-3 control-label">是否生效：</label>
									<div class="radio col-sm-9">
										<label> <input class="basic edit_flag_0" type="radio"
											id="edit_divflag_0" name="flag" value="1"/> <span
											class="text">是</span>
										</label> <label> <input class="basic divtype edit_flag_1" type="radio"
											id="edit_divflag_1" name="flag" value="0" /> <span
											class="text">否</span></label>
									</div>
									<div class="radio" style="display: none;">
										<label> <input class="inverted" type="radio"
											name="flag"/> <span class="text"></span>
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
					onclick="editDivForm();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
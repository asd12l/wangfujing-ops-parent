<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange" id="renameFloorDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">修改块组</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="renameDivForm" method="post" class="form-horizontal editFloor" >
								<input type="hidden" name="id" id="renameSid" value="" />
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>名&#12288;&#12288;称：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control clear_input" id="rename_title" name="title" >
		                            </div>
		                        </div>
								<!-- <div class="form-group">
		                            <label class="col-sm-3 control-label">英文名称：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control clear_input" id="rename_en_title" name="enTitle" >
		                            </div>
		                        </div> -->
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
                                            <input type="text" class="spinner-input form-control clear_input" id="div_seq_rename"
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
		                            <label class="col-sm-3 control-label">是否生效： </label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label> <input class="basic" type="radio"
												id="edit_rename_0" name="flag" value="1"> <span
												class="text">是</span>
											</label> <label> <input class="basic divtype" type="radio"
												id="edit_rename_1" name="flag" value="0" > <span
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
					onclick="renameTopicDiv();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
	</div>
</div>
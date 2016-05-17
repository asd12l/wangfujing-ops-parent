<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange" id="editFloorLinkProductDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">修改链接商品</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="editFloorLinkProductForm" method="post" class="form-horizontal"
								enctype="multipart/form-data">
								<input type="hidden" name="sid" id="linkSid_edit" value="" />
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">图片地址：</label>
		                            <div class="col-sm-9">
		                            	<input class="clear_input" id="image_name6" type="file" name="image_name6" onchange="upLoadImgLink('6')" accept=".gif,.jpeg,.jpg,.png"/>
										<input class="clear_input" type="hidden" id="input_img6"  name="pict"/>
										<div id="msg6" class="hide"></div>
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">链接地址：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" id="editFLP_link" name="link" >
		                            </div>
		                        </div>
		                        <div class="form-group" id="editFLP_seq_DIV">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>顺&#12288;&#12288;序：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" id="editFLP_seq" name="seq" >
		                            </div>
		                        </div>
		                        <div class="form-group" id="floorFlag">
		                            <label class="col-sm-3 control-label">是否生效：</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label> <input class="basic" type="radio"
												id="editFLP_isShow_0" name="flag" value="1" checked="checked"> <span
												class="text">是</span>
											</label> 
											<label> <input class="basic" type="radio"
												id="editFLP_isShow_1" name="flag" value="0" > <span
												class="text">否</span>
											</label>
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
					onclick="editFloorLinkProductForm();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
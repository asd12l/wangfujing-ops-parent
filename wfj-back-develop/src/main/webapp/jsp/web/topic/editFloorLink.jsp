<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange" id="editLinkDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">修改引导链接</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="editLinkForm" method="post" class="form-horizontal"
								enctype="multipart/form-data">
								<input type="hidden" name="sid" id="linkSid_edit" ref="linkSid_edit" value="" />
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>主&nbsp;标&nbsp;&nbsp;题：
		                            </label>
		                            <div class="col-sm-9">
										 <input type="text" placeholder=""
										class="form-control" id="mainTitle" name="mainTitle" >
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">副&nbsp;标&nbsp;&nbsp;题：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" id="subTitle" name="subTitle" >
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">图片地址：</label>
		                            <div class="col-sm-9">
		                            	<input class="clear_input" id="image_name4" type="file" name="image_name4" onchange="upLoadImgLink('4')" accept=".gif,.jpeg,.jpg,.png"/>
										<input class="clear_input" type="hidden" id="input_img4"  name="pict"/>
										<div id="msg4" class="hide"></div>
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">链接地址：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" id="link_" name="link" >
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>顺&#12288;&#12288;序：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" id="seq_" name="seq" >
		                            </div>
		                        </div>
		                        <div class="form-group" id="floorFlag">
		                            <label class="col-sm-3 control-label">是否生效：</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label> <input class="basic" type="radio"
												id="edit_isShow_0" name="flag" value="1" checked="checked"> <span
												class="text">是</span>
											</label> <label> <input class="basic" type="radio"
												id="edit_isShow_1" name="flag" value="0" > <span
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
					onclick="editLinkForm();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
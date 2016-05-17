<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	request.setAttribute("ctx", request.getContextPath());
%>

<div class="modal modal-darkorange" id="editLinkDIV" style="top:-50px;">
	<div class="modal-dialog" style="width: 400px; margin: 50px auto;">
		<div class="modal-content" style="width:500px;">
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
								<input type="hidden" name="sid" id="linkSid" value="" />
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>主标题&#12288;： 
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" id="mainTitle" name="mainTitle" >
		                            </div>
		                        </div>
		                        <div class="form-group">
		                       		<label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>图片地址： 
		                            </label>
		                            <div class="col-sm-9">
										<input onchange="uploadlinkImg(this.id)" type="file" id="id_pictEdit" name="name_pictEdit" accept=".gif,.jpg,.png" /> 
										<input type="hidden" id="hidden_pictEdit" name="pict" value="" />
										<div id="msg_pictEdit" class="hide">
											<img id="img_pictEdit" width="96px" height="96px" src="" />
										</div>
		                            </div>
								</div>  
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>背景图片：
		                            </label>
		                            <div class="col-sm-9">
										<input onchange="uploadlinkImg(this.id)" type="file" id="id_subTitleEdit" name="name_subTitleEdit" accept=".gif,.jpg,.png" />
										<input type="hidden" id="hidden_subTitleEdit" name="subTitle" value="">
										<div id="msg_subTitleEdit" class="hide">
											<img id="img_subTitleEdit" width="96px" height="96px" src="" >
										</div>
		                            </div>
		                        </div>
		                        <div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>链接地址：
		                            </label>
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
		                            	<div class="spinner spinner-horizontal spinner-two-sided">
                                            <div class="spinner-buttons	btn-group spinner-buttons-left">
                                                <button type="button" class="btn spinner-down danger">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input type="text" class="spinner-input form-control clear_input" id="seq_" name="seq"/>
                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
                                                <button type="button" class="btn spinner-up blue">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
		                            </div>
		                        </div>
		                        <div class="form-group" id="floorFlag">
		                            <label class="col-sm-3 control-label">是否显示：</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label> <input class="basic" type="radio"
												id="edit_isShow_0" name="flag" value="1"> <span
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
<script src="${ctx}/js/ajaxfileupload.js"></script>
<script src="${ctx}/js/customize/nav/floor/floor_upload_img.js"></script>
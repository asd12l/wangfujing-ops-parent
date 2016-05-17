<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="modal modal-darkorange" id="addLinkDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">添加引导链接</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="addLinkForm" method="post" class="form-horizontal" >
								<input type="hidden" id="topicFloor_link" name="floorId" value=""/>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>主&nbsp;标&nbsp;&nbsp;题：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control clear_input" id="mainTitle_add" name="mainTitle" />
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">副&nbsp;标&nbsp;&nbsp;题：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control clear_input" id="" name="subTitle" />
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">图片地址：</label>
		                            <div class="col-sm-9">
		                            	<input class="clear_input" id="image_name3" type="file" name="image_name3" onchange="upLoadImgLink('3')" accept=".gif,.jpeg,.jpg,.png"/>
										<input class="clear_input" type="hidden"  id="input_img3"  name="pict"/>
										<div id="msg3" class="hide"></div>
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">链接地址：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control clear_input" id="" name="link" value="http://" />
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
                                            <input type="text" class="spinner-input form-control clear_input" id=""
												name="seq" placeholder="" />
                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
                                                <button type="button" class="btn spinner-up blue">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
		                            </div>
		                        </div>
								<div class="form-group" id="add_floorFlag">
		                            <label class="col-sm-3 control-label">是否生效：</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label> 
												<input class="basic" type="radio" checked="checked" id="" name="flag" value="1"/> 
												<span class="text">是</span>
											</label> 
											<label> 
												<input class="basic divtype" type="radio" id="" name="flag" value="0" /> 
												<span class="text">否</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label> <input class="inverted" type="radio" name="flag"/> <span class="text"></span></label>
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
					onclick="addLinkForm();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="addFloorLinkProductDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">添加链接商品</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="addFloorLinkProductForm" method="post" class="form-horizontal" >
								<input type="hidden" id="topicFloor_linkProduct" name="floorId" value=""/>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">商品图片：</label>
		                            <div class="col-sm-9">
		                            	<input class="clear_input" id="image_name5" type="file" name="image_name5" onchange="upLoadImgLink('5')" accept=".gif,.jpeg,.jpg,.png"/>
										<input class="clear_input" type="hidden"  id="input_img5"  name="pict"/>
										<div id="msg5" class="hide"></div>
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">链接地址：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control clear_input" id="addFLP_link" name="link" value="http://" />
		                            </div>
		                        </div>
								<div class="form-group" id="addFLP_seq_DIV">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>顺&#12288;&#12288;序：
		                            </label>
		                            <div class="col-sm-9">
                                            <input type="text" class="form-control clear_input" id="addFLP_seq"
												name="seq" value="1" />
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
					onclick="addLinkProductForm();">保存</button>
				<button data-dismiss="modal" class="btn btn-default"
					onclick="closeDiv();" type="button">返回</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="addtopicfloorDIV">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">添加块/块组</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="topicDivForm" method="post" class="form-horizontal" >
								<input type="hidden" id="topic_floor_id" name="floorId" value=""/>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">
		                            	<span style="color:red;">*</span>名&#12288;&#12288;称：
		                            </label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control title clear_input" id="" name="title" >
		                            </div>
		                        </div>
<!-- 								<div class="form-group">
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
                                            <input type="text" class="spinner-input form-control clear_input" id="floor_seq"
												name="seq" placeholder="" />
                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
                                                <button type="button" class="btn spinner-up blue">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
		                            </div>
		                        </div> -->
								<div class="form-group" id="add_floorDivType">
		                            <label class="col-sm-3 control-label">块&nbsp;/&nbsp;块组：</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label>
												<input class="basic divtype" type="radio" id="add_divType_0" name="divtype" value="0">
												<span class="text">块组</span>
											</label> 
											<label>
												<input class="basic divtype" type="radio" id="add_divType_1" name="divtype" value="1" >
												<span class="text">块</span>
											</label>
										</div>
										<div class="radio" style="display: none;"><label><input class="inverted" type="radio" name="divtype"> <span class="text"></span> </label></div>
		                            </div>
		                        </div>
								<div class="form-group" id="add_floorType" style="display: none;">
		                            <label class="col-sm-3 control-label">块&nbsp;类&nbsp;&nbsp;型：</label>
		                            <div class="col-sm-9">
										<div class="radio div">
											<label>
												<input class="basic divtype" type="radio" id="add_divType_3" name="type" value="2" >
												<span class="text">品牌</span>
											</label> 
											<label>
												<input class="basic add_divType_2" type="radio" id="add_divType_2" name="type" value="1">
												<span class="text">商品</span>
											</label> 
											<label>
												<input class="basic divtype" type="radio" id="add_divType_4" name="type" value="3" >
												<span class="text">链接</span>
											</label>
											<label>
												<input class="basic divtype" type="radio" id="add_divType_5" name="type" value="4" >
												<span class="text">链接商品</span>
											</label>
										</div>
										<div class="radio" style="display: none;"><label><input class="inverted" type="radio" name="type"> <span class="text"></span></label></div>
		                            </div>
		                        </div>
								<div class="form-group adddiv_selectlist" id="addDiv_div_lcys" style="display: none;">
		                            <label class="col-sm-3 control-label">楼层样式：</label>
		                            <div class="col-sm-9">
										<select class="form-control pro_style_list" id="div_style_list" name="styleList" data-bv-field="country">
											<option value="">--无--</option>
										</select>
										<input type="button" value="预览" onclick="showTopicProductimg(this);" >
		                            </div>
		                        </div>
								<div class="form-group" id="edit_floorFlag">
		                            <label class="col-sm-3 control-label">是否生效：</label>
		                            <div class="col-sm-9">
										<div class="radio">
											<label> <input class="basic" type="radio" checked="checked"
												id="" name="flag" value="1"> <span
												class="text">是</span>
											</label> <label> <input class="basic divtype" type="radio"
												id="" name="flag" value="0" > <span
												class="text">否</span></label>
										</div>
										<div class="radio" style="display: none;"><label> <input class="inverted" type="radio"name="flag"> <span class="text"></span></label></div>
		                            </div>
		                        </div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button"
					onclick="saveDivFrom();">保存</button>
			</div>
		</div>
	</div>
</div>
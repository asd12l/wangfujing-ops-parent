<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange" id="editTopicFloorDIV">
					<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeDiv();">×</button>
								<h4 class="modal-title">修改楼层</h4>
							</div>
							<div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding: 10px;">
										<div class="col-md-12">
											<form id="editFloorForm" method="post" class="form-horizontal editFloor" >
												<input type="hidden" id="divSid_edit" name="divSid" value="" />
												
												<table>
													<tr>
														<td><span style="color:red;">*</span>名&nbsp;&nbsp;&nbsp;称：</td>
														<td><input type="text" placeholder=""
														class="form-control" id="title_edit" name="title" ></td>
													</tr>
													<tr>
														<td>顺序:</td>
														<td><input type="text" placeholder=""
														class="form-control" id="floor_seq_edit" name="seq" ></td>
													</tr>
													<tr>
														<td>楼层样式:</td>
														<td><select class="form-control style_list" id="style_list_edit" name="styleList" data-bv-field="country">
															<option value="">--无--</option>
														</select><input type="button" value="预览" onclick="view(this);" ></td>
													</tr>
													<tr>
														<td>是否生效:</td>
														<td>
															<div class="radio">
																<label> <input class="basic" type="radio"
																	id="edit_floorFlag_0" name="flag" value="1"> <span
																	class="text">是</span>
																</label> <label> <input class="basic divtype" type="radio"
																	id="edit_floorFlag_1" name="flag" value="0" > <span
																	class="text">否</span></label>
															</div>
															<div class="radio" style="display: none;">
																<label> <input class="inverted" type="radio"
																	name="flag"> <span class="text"></span>
																</label>
															</div>
														</td>
													</tr>
												</table>
												
												<!-- <div class="form-group">
													<span style="color:red;">*</span>名&nbsp;&nbsp;&nbsp;称：<input type="text" placeholder=""
														class="form-control" id="title_edit" name="title" >
												</div>
												<div class="form-group">
													楼层编号:<input type="text" placeholder=""
														class="form-control" id="floor_seq_edit" name="seq" >
												</div>
												<div class="form-group">
													楼层样式:
														<select class="form-control style_list" id="style_list_edit" name="styleList" data-bv-field="country">
															<option value="">--无--</option>
														</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
												</div> -->
												
											</form>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-default" type="button"
									onclick="editFloorForm();">保存</button>
								<!-- <button data-dismiss="modal" class="btn btn-default"
									onclick="closeDiv();" type="button">返回</button> -->
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
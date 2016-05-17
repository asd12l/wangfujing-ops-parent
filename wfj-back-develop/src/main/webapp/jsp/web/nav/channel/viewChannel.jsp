<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="loadChannelDIV">
					<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeDiv();">×</button>
								<h4 class="modal-title">查看频道</h4>
							</div>
							<div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding: 10px;">
										<div class="col-md-12">
												<div class="form-group">
													<span style="color:red;">*</span>频道名称： <input type="text" readonly="readonly" placeholder=""
														class="form-control" id="channel_load_name" name="name" >
												</div>
												<div class="form-group">
													<span style="color:red;">*</span>访问路径： <input type="text" readonly="readonly" placeholder=""
														class="form-control" id="channel_load_path" name="path" >
												</div>
												<div class="form-group">
													<span style="color:red;">*</span>频道模板： <input type="text" readonly="readonly" placeholder=""
														class="form-control" id="channel_load_tplChannel" name="tplChannel" >
												</div>
												
												<div class="form-group">
													排列顺序： <input type="text" readonly="readonly" placeholder=""
														class="form-control" id="channel_load_priority" name="priority" >
												</div>
												<div class="form-group" id="floorType">
													显示：
													<div class="radio">
														<label> <input class="basic" type="radio"
															id="display_load_1" name="display" value="1"> <span
															class="text">是</span>
														</label> <label> <input class="basic" type="radio"
															id="display_load_0" name="display" value="0" > <span
															class="text">否</span>
														</label>
													</div>
													<div class="radio" style="display: none;">
														<label> <input class="inverted" type="radio"
															name="display"> <span class="text"></span>
														</label>
													</div>
												</div>
												
										</div>
									</div>
								</div>
							</div>
							
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>	
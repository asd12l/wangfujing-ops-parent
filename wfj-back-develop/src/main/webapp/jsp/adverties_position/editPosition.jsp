<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="editPositionDIV">
					<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeDiv();">×</button>
								<h4 class="modal-title">修改广告位置</h4>
							</div>
							<div class="modal-body">
									<div class="row" style="padding: 10px;">
										<div class="col-md-12">
							   <form id="editPositionForm" method="post" class="form-horizontal">        
									<input type="hidden" id="position_id" name="id" >
									<input type="hidden" id="site_id_edit" name="_site_id_param">
									<div class="form-group">
										<label class="col-lg-3 control-label"><span style="color:red;">*</span>名称</label>
										<div class="col-lg-6">
										    <div class="input-icon " >
										    <i class="fa"></i>										
											<input type="text" style="width:84%" class="form-control" id="edit_name" name="name" />												
											</div>										
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label"><span
											style="color: red;">*</span>英文名称</label>
										<div class="col-lg-6">
											<div class="input-icon ">
												<i class="fa"></i> <input type="text" style="width: 84%"
													class="form-control clear_input" id="edit_position"
													name="position" />
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">标记</label>
										<div class="col-lg-6">
											<div class="input-icon ">
												<i class="fa"></i> <input type="text" style="width: 84%"
													class="form-control clear_input" id="edit_source"
													name="source" />
											</div>
										</div>
									</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 35%;" id="edit_position_btn" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 35%;" onclick="closeDiv();" type="button" value="取消"/>
										</div>
									</div>
								</form>
										</div>
									</div>
								</div>
							</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
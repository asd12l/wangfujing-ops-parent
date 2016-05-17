<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="renameDIV">
					<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeDiv();">×</button>
								<h4 class="modal-title">重命名</h4>
							</div>
							<div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding: 10px;">
										<div class="col-md-12">
											<form id="renameForm" method="post" class="form-horizontal"
												enctype="multipart/form-data">
												<input type="hidden" name="path" id="path" value="" />
												<div class="form-group">
													原名称： <input type="text" 
														class="form-control" id="oldName" name="oldName" >
												</div>
												<div class="form-group">
													新名称： <input type="text" placeholder=""
														class="form-control" id="newName" name="newName" >
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-default" type="button"
									onclick="renameForm();">保存</button>
								<button data-dismiss="modal" class="btn btn-default"
									onclick="closeDiv();" type="button">返回</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
						<!-- /.modal-dialog -->
				    </div>
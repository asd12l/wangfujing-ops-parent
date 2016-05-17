<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="addTemplateDIV">
					<div class="modal-dialog" style="width: 800px; margin: 100px auto;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeDiv();">×</button>
								<h4 class="modal-title">创建模板</h4>
							</div>
							<div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding: 10px;">
										<div class="col-md-12">
											<form id="editLinkForm" method="post" class="form-horizontal"
												enctype="multipart/form-data">
												
												<div class="form-group">
													<span style="color:red;">*</span>文件名： <input type="text" placeholder=""
														class="" id="file_name" name="file_name" width="10px;">.html
												</div>
												<div id="addTpl" style="">
													<textarea id="template_edit" style="width:670px;height:300px;font-size:16px;font-weight:500;"></textarea>
													<br/>
													<hr/>
													<input class="btn btn-success" style="width: 25%;" id="" onclick="saveTemplate();" 
														type="button" value="保存" />&emsp;&emsp; 
													<input class="btn btn-danger" style="width: 25%;" id="" onclick="closeDiv();"
														type="button" value="返回" />
												</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="createDirDIV">
					<div class="modal-dialog" style="width: 800px; margin: 100px auto;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeDiv();">×</button>
								<h4 class="modal-title">新建目录</h4>
							</div>
							<div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding: 10px;">
										<div class="col-md-12">
												<div style="float:left">新建目录
		                                           <input type="text" id="dirName" name="dirName"/>
                          							   <input class="create-new" id="dirButton" type="button" value="新建" onclick="createDir();"/>
                           					    </div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
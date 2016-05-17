<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal modal-darkorange" id="loadFloor">
	<div class="modal-dialog" style="width: 500px; margin: 100px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h4 class="modal-title">查看楼层</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
					<div class="row" style="padding: 10px;">
						<div class="col-md-12">
							<form id="editFloorForm" method="post" class="form-horizontal editFloor" >
								<input type="hidden" id="divSid_load" name="divSid" value="" />
								<div class="form-group">
		                            <label class="col-sm-3 control-label">名&nbsp;&nbsp;&nbsp;称：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" readonly id="title_load" name="title" >
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">频道链接：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" readonly id="channel_link_load" name="channelLink" >
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">楼层编号：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" readonly id="floor_seq_load" name="seq" >
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">楼层样式：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" readonly id="style_list_load" name="styleList" >
		                            </div>
		                        </div>
								<div class="form-group">
		                            <label class="col-sm-3 control-label">是否生效：</label>
		                            <div class="col-sm-9">
										<input type="text" placeholder=""
										class="form-control" readonly id="load_divFlag" name="seq" >
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
	<!-- /.modal-dialog -->
</div>
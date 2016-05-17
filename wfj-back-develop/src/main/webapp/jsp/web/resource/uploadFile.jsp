<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="uploadFile">
	<div class="modal-dialog" style="width:400px;height:400px; margin: 100px auto;">
		<div class="modal-content" style="width:600px;">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv();">×</button>
				<h5 class="modal-title">上传文件</h5>
			</div>
		    <div class="modal-body">
				<div class="bootbox-body">
					<div class="row">
						<div class="col-md-12">
							<form class="uploadForm" method="post" fileupload="true" enctype="multipart/form-data">
								<div class="form-group clearfix">
									<div class="col-lg-4 col-sm-4 col-xs-4 tr">源目录：</div>
									<div class="col-lg-8 col-sm-8 col-xs-8"><input class="sourceFile clear_input" name="file" type="file" value="请选择"/></div>
								</div>
								<div class="form-group clearfix">
									<div class="col-lg-4 col-sm-4 col-xs-4 tr">目标目录：</div>
									<div class="col-lg-8 col-sm-8 col-xs-8"><input id="desFile1" readonly="readonly" class="desFile1" name="dPath" class="form-control"></input></div>
								</div>
								<div class="form-group">
									<div class="col-lg-8 col-sm-8 col-xs-8 col-md-offset-4"><input type="button" value="上&nbsp;&nbsp;&nbsp;传" onclick="uploadFile();" class="btn btn-palegreen"/></div>
								</div>
							</form>		
			          </div>
			      </div>
			   </div>
			</div>			
		</div>
	</div>
</div>
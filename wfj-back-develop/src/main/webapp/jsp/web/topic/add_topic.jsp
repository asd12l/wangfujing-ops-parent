<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="addTopicDIV">
	<div class="modal-dialog" style="width: 70%; margin: 20px auto;">
		<div class="widget radius-bordered">
			<div class="modal-header">
			<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" onclick="closeDiv(this);">×</button>
				<h4 class="modal-title">添加活动</h4>
			</div>
			<div class="widget-body">
				<form id="addTopicForm" method="post" class="form-horizontal">
					<input type="hidden" id="add_site_sid" name="_site_id_param" value="">
					<div class="row">
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label">
	                            	<span style="color:red;">*</span>名&#12288;&#12288;称：
	                            </label>
	                            <div class="col-sm-9">
									<input type="text" class="form-control clear_input" id="topic_name" name="name"/>
	                            </div>
	                        </div>
						</div>
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label">简&#12288;&#12288;称：</label>
	                            <div class="col-sm-9">
									<input type="text" class="form-control clear_input" id="shortName" name="shortName"/>
	                            </div>
	                        </div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label">关键字&#12288;：</label>
	                            <div class="col-sm-9">
									<input type="text" class="form-control clear_input" id="topic_name" name="name"/>
	                            </div>
	                        </div>
						</div>
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label">
	                            	<span style="color:red;">*</span>排列顺序：
	                            </label>
	                            <div class="col-sm-9">
									<input type="text" class="form-control clear_input" id="priority" name="priority"/>
	                            </div>
	                        </div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-md-6" style="display: none;">
							<div class="form-group">
	                            <label class="col-sm-3 control-label">
	                            	<span style="color:red;">*</span>模板路径：
	                            </label>
	                            <div class="col-sm-9">
									<select class="form-control tpl_path" id="add_tpl_path" name="path"></select>
	                            </div>
	                        </div>
						</div>
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label" style="padding-top: 2px;">
	                            	<span style="color:red;">*</span>标题图&#12288;：
	                            </label>
	                            <div class="col-sm-9">
									<input class="clear_input" id="image_name1" type="file" name="image_name1" onchange="upLoadImg('1')" accept=".gif,.jpeg,.jpg,.png"/>
									<input class="clear_input" type="hidden"  id="input_img1"  name="titleImg"/>
									<div id="msg1" class="hide"></div>	
	                            </div>
	                        </div>
						</div>
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label">
	                            	<span style="color:red;">*</span>模&#12288;&#12288;板：
	                            </label>
	                            <div class="col-sm-9">
									<select class="form-control tpl_name" id="tplContent" name="tplContent" style="width:78%;">
										<option value="">--默认--</option>
									</select>
									<a class="btn btn-default" onclick="showTplView(0);" style="width:20%;">预览</a>
	                            </div>
	                        </div>
						</div>
					</div>
					<div class="row">
						
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label" style="padding-top: 2px;">
	                            	<span style="color:red;">*</span>是否生效：
	                            </label>
	                            <div class="col-sm-9">
									<label> <input class="basic" type="radio"
										id="" name="recommend" value="1" checked="true"> <span
										class="text">是</span>
									</label> <label> <input class="basic" type="radio"
										id="" name="recommend" value="0" > <span
										class="text">否</span></label>
									<label  style="display: none;"> <input class="inverted" type="radio"
										name="recommend"> <span class="text"></span>
									</label>
	                            </div>
	                        </div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label">
	                            	<span style="color:red;">*</span>开始时间：
	                            </label>
	                            <div class="col-sm-9">
									<input type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',minDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="form-control clear_input form_date Wdate" id="startTime" name="startTime" style="height: 34px;"/>
	                            </div>
	                        </div>
						</div>
						<div class="col-xs-12 col-md-6">
							<div class="form-group">
	                            <label class="col-sm-3 control-label">
	                            	<span style="color:red;">*</span>结束时间：
	                            </label>
	                            <div class="col-sm-9">
									<input type="text" class="form-control clear_input Wdate" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\'||\'new Date()\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="endTime" name="endTime"  style="height: 34px;"/>
	                            </div>
	                        </div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-md-2">
							<div class="form-group">
	                            <label class="col-sm-9 control-label">描&#12288;&#12288;述：</label>
	                        </div>
						</div>
						<div class="col-xs-12 col-md-10">
							<div class="form-group">
	                            <div class="col-sm-12">
									<textarea class="col-lg-6 form-control clear_input" id="description" 
								name="description" style="width:100%;height:90px;font-size:16px;font-weight:500;"></textarea>
	                            </div>
	                        </div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-4 col-lg-6">
							<input class="btn btn-success" style="width: 25%;" 
								type="button" onclick="addTopic();" value="保存" />&emsp;&emsp; <input
								class="btn btn-danger" style="width: 25%;" 
								type="button" onclick="closeDiv();" value="返回" />
						</div>
					</div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>	
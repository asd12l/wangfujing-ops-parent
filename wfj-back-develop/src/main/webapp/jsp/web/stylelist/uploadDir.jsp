<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal modal-darkorange" id="uploadDir">
					<div class="modal-dialog" style="width:600px;height:400px; margin: 100px auto;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeDiv();">×</button>
								<h4 class="modal-title">添加楼层样式</h4>
							</div>
						    <div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding:30px;">
										<div class="col-md-12">
							<form class="uploadZipForm" method="post" fileupload="true" enctype="multipart/form-data">
								<table>
								<tr style="height:50px;">
								<td>源目录:</td>
								<td>
								<input class="sourceFile clear_input" name="file" type="file" value="请选择" accept=".html"/>
								<div id="msg" class="hide"></div>
								</td>
								</tr>
								<tr style="height:50px;">
								<td>楼层样式例图:</td>
								<td>
								<input class="clear_input" id="image_name1" type="file" name="image_name1" onchange="upLoadImg('1')" accept=".gif,.jpeg,.png"/>
								<input class="clear_input" type="hidden"  id="input_img1"  name="attr_image_name"/>
								<input class="clear_input" type="hidden" id="image_url" name="attr_image_url"/>
								<div id="msg1" class="hide"></div>
								</td>
								</tr>
								<tr style="height:50px;" class="form-group">
									<td>楼层样式类型:</td>
									<td>
										<label> <input class="basic divtype" type="radio"
											id="type_0" name="type" value="0" checked="checked"> <span
											class="text">频道楼层样式</span>
										</label> <label> <input class="basic divtype" type="radio"
											id="type_1" name="type" value="1"> <span
											class="text">专题活动楼层样式</span>
										</label> <label> <input class="basic divtype" type="radio"
											id="type_2" name="type" value="2"> <span
											class="text">更多商品楼层样式</span>
										</label>
									
									
										<label style="display: none;"> <input class="inverted" type="radio"
											name="type"> <span class="text"></span>
										</label>
									</td>
								</tr>
										
								<tr style="height:50px;"><td>目标目录:</td><td><input class="clear_input" style="width:80%;" id="desFile" type="text" name="dPath" readonly="true"></input></td></tr>
								<tr style="height:50px;"><td>楼层样式描述:</td><td><input style="width:80%;" class="sourceFile clear_input" name="desc" type="text"/></td><td><div id="descMessage" class="hide"></div></td></tr>
								<tr align="center"><td colspan="2"> <input type="button" value="上传" onclick="uploadZipFile();"/></td></tr>
								</table>
							</form>		
							</div>
							</div>
							</div>
							</div>			
						</div>
					</div>
</div>
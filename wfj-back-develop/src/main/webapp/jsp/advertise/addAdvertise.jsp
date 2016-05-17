<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
	request.setAttribute("_site_id_param",request.getParameter("_site_id_param"));
	request.setAttribute("site_name",request.getParameter("site_name"));
	request.setAttribute("_spaceId",request.getParameter("_spaceId"));
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/js/bootstrap/bootstrap.min.js"></script>
<link href="${ctx}/js/bootstrap/css/components.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script src="${ctx}/js/jquery/jquery.validate.js"></script>
<script src="${ctx}/js/jquery/jquery.validate.messages_cn.js"></script>
<script src="${ctx}/js/customize/common/validate.js"></script>
<script src="${ctx}/js/ajaxfileupload.js"></script>
<title>广告管理</title>
<script type="text/javascript">
__ctxPath = "${pageContext.request.contextPath}";
_site_id_param = "${_site_id_param}";
site_name = "${site_name}";
_spaceId = "${_spaceId}"
</script>

<script src="${ctx}/js/customize/advertise/fileUpload.js"></script>
<script src="${ctx}/js/customize/ckeditor/ckeditor.js"></script>
<script src="${ctx}/js/customize/advertise/add_advertise.js"></script>
</head>
<body>
	<div class="page-body">
		<div class="widget">
			<div class="widget-header">
				<h5 class="widget-caption">添加广告</h5>
			</div>
			<div class="widget-body">
				<form id="theForm" method="post" class="form-horizontal"
					enctype="multipart/form-data">
					<input type="hidden" id="site_id" name="_site_id_param">
					<div class="form-group">
						<label class="col-lg-3 control-label"><span
							style="color: red;">*</span>名称</label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="adver_name"
								name="name" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-3 control-label"><span
							style="color: red;">*</span>版位</label>
						<div class="col-lg-6">
							<select class="form-control adspace" id="adspaceId"
								name="adspaceId"></select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-3 control-label">类型</label>
						<div class="radio">
							<label> <input class="basic divtype cart_flag"
								type="radio" id="category_0" name="category" value="image"
								checked=true onclick="attrChange(this.value)"> <span
								class="text">图片</span>
							</label> <label> <input class="basic divtype cart_flag"
								type="radio" id="category_1" name="category" value="flash"
								onclick="attrChange(this.value)"> <span class="text">视频</span>
							</label> <label> <input class="basic divtype cart_flag"
								type="radio" id="category_2" name="category" value="text"
								onclick="attrChange(this.value)"> <span class="text">文字</span>
							</label> <label> <input class="basic divtype" type="radio"
								id="category_3" name="category" value="code"
								onclick="attrChange(this.value)"> <span class="text">代码</span>
							</label>
						</div>
						<div class="radio" style="display: none;">
							<label> <input class="inverted" type="radio"
								name="category"> <span class="text"></span>
							</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-3 control-label">广告内容</label>
						<div class="col-lg-6">
							<div id="attr_image">
								<ul class="items">
									<li>
										<div>
											<!-- 图片上传修改给上层图片 -->
											<label>上层图片：</label> <input onchange="upLoadImg(this.id)"
												type="file" id="id_attr_image_url"
												name="name_attr_image_url" accept=".gif,.jpg,.png" /> <input
												type="hidden" name="attr_image_url"> <img
												id="img_attr_image_url" width="96px" height="96px" src="">
											<div id="msg_attr_image_url" class="hide"></div>
										</div>
									</li>
									<!-- <li>
										<div>
											<label>上层图片：</label> <input onchange="upLoadImg(this.id)"
												type="file" id="id_attr_image_uppict"
												name="name_attr_image_uppict" accept=".gif,.jpg,.png" /> <input
												type="hidden" name="attr_image_uppict"> <img
												id="img_attr_image_uppict" width="96px" height="96px" src="">
											<div id="msg_attr_image_uppict" class="hide"></div>
										</div>
									</li> -->
									<li>
										<div>
											<label>背景图片：</label> <input onchange="upLoadImg(this.id)"
												type="file" id="id_attr_image_backpict"
												name="name_attr_image_backpict" accept=".gif,.jpg,.png" /> <input
												type="hidden" name="attr_image_backpict"> <img
												id="img_attr_image_backpict" width="96px" height="96px"
												src="">
											<div id="msg_attr_image_backpict" class="hide"></div>
										</div>
									</li>
									<li><label>链接地址：</label> <input type="text"
										name="attr_image_link" value="http://" maxlength="255" /></li>
									<li><label>描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：</label>
										<textarea type="text" name="attr_image_desc" value=""
											maxlength="255" /></li>
								</ul>
							</div>
							<div id="attr_flash" style="display: none;">
								<ul class="items">
									<li><label>FLASH上传：</label> <input
										onchange="upLoadFlash(this.id)" type="file" id="id_attr_flash_url"
										name="name_attr_flash_url" accept=".flv" /> <input type="hidden"
										name="attr_flash_url">
										<input type="text" class="form-control Wdate" id="flash_attr_flash_url" readonly>
										<div id="mgs_attr_flash_url" class="hide"></div></li>
								</ul>
							</div>
							<div id="attr_text" style="display: none;">
								<ul class="items">
									<li><label>文字内容：</label> <textarea id="text_title"
											style='height: 200px; max-height: 500px; width: 100%;'
											maxlength="1232896" wrap="off"></textarea> <input
										type="text" id="attr_text_title" name="attr_text_title"
										style="display: none;"></li>
									<li><label>文字链接：</label> <input type="text"
										name="attr_text_link" value="http://" maxlength="255" /></li>
									<li><label>文字大小：</label> <input type="text"
										name="attr_text_font" maxlength="50" /> <span class="pn-fhelp">如：12px</span>
									</li>
								</ul>
							</div>
							<div id="attr_code" style="display: none;">
								<ul class="items">
									<li><label>&nbsp;</label> <textarea id="attr_code_text"
											name="attr_code"
											style='height: 200px; max-height: 500px; width: 100%;'
											maxlength="1232896" wrap="off"></textarea></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-3 control-label"><span
							style="color: red;">*</span>开始时间</label>
						<div class="col-lg-6">
							<div class="input-icon ">
								<i class="fa"></i> <input type="text" class="form-control Wdate"
									id="startTime" name="startTime" placeholder=""
									onClick="WdatePicker()" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-3 control-label"><span
							style="color: red;">*</span>结束时间</label>
						<div class="col-lg-6">
							<div class="input-icon ">
								<i class="fa"></i> <input type="text" class="form-control Wdate"
									id="endTime" name="endTime" placeholder=""
									onClick="WdatePicker()" />
							</div>

						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-3 control-label"><span
							style="color: red;">*</span>顺序</label>
						<div class="col-lg-6">
							<div class="input-icon ">
								<i class="fa"></i> <input type="text" class="form-control"
									id="adver_seq" name="seq" placeholder="" value="1" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-3 control-label">启用</label>
						<div class="col-lg-6">
							<div class="radio" id="enabled">
								<label> <input class="inverted" id="is_enabled_0"
									type="radio" checked="checked" name="enabled" value="true">
									<span class="text">是</span>
								</label> <label> <input class="basic" id="is_enabled_1"
									type="radio" name="enabled" value="false"> <span
									class="text">否</span>
								</label>
							</div>
							<div class="radio" style="display: none;">
								<label> <input class="inverted" type="radio"
									name="enabled"> <span class="text"></span>
								</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-4 col-lg-6">
							<input class="btn btn-success" style="width: 25%;" id="save"
								type="button" value="保存" />&emsp;&emsp; <input
								class="btn btn-danger" style="width: 25%;" id="close"
								type="button" value="返回" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /Page Body -->
</body>

</html>
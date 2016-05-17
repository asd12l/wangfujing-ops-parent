<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="col-lg-3 col-sm-3 col-xs-3">
	<div class="web-header">楼层管理</div>
	<ul id="floorTree" class="ztree"></ul>
</div>
<!-- 添加楼层 -->
<%@ include file="addFloor.jsp"%>
<!-- 编辑楼层 -->
<%@ include file="editFloor.jsp"%>
<!-- 查看楼层 -->
<%@ include file="floorDetail.jsp"%>
		
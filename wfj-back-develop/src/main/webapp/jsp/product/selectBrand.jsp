<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function initBrandGroup() {
	var url = __ctxPath + "/brandDisplay/queryBrandGroupListPartInfo";
	brandGroupPagination = $("#brandGroupPagination").myPagination(
			{
				panel : {
					tipInfo_on : true,
					tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
					tipInfo_css : {
						width : '25px',
						height : "20px",
						border : "2px solid #f0f0f0",
						padding : "0 0 0 5px",
						margin : "0 5px 0 5px",
						color : "#48b9ef"
					}
				},
				debug : false,
				ajax : {
					on : true,
					url : url,
					dataType : 'json',
					callback : function(data) {
						$("#brandGroup_tab tbody").setTemplateElement("brandGroup-list").processTemplate(data);
						$("tr[class='gradeX']").dblclick(function(){
							var option = "<option sid='"+$(this).attr("brandSid")+"' value='"+$(this).attr("sid")+"'>"
								   + $(this).attr("name") + "</option>";
							$("#BrandCode_input").val($(this).attr("name"));
							$("#BrandCode").html(option);
							closeBrandGroup();
							$("#BrandCode").change();
						});
					}
				}
			});
		}
		
function brandGroupQuery() {
	$("#brandCode_from").val($("#brandCode_input").val());
	$("#brandName_from").val($("#brandName_input").val());
	var params = $("#brandGroup_form").serialize();
	params = decodeURI(params);
	brandGroupPagination.onLoad(params);
}
//查询
function query() {
	$("#cache").val(0);
	brandGroupQuery();
}
// 重置
function reset() {
	$("#cache").val(1);
	$("#brandCode_input").val("");
	$("#brandName_input").val("");
	brandGroupQuery();
}
		
	$(function(){
		initBrandGroup();
		$("#pageSelect1").change(brandGroupQuery);
	});
</script>
</head>
<body>
	<div class="table-toolbar">
		<div>
			<div class="col-md-6">
				<label class="control-label" style="text-align: right;">品牌名称：</label>
				<input type="text" id="brandName_input" />
			</div>
			<div class="col-md-6">
				<label class="control-label" style="text-align: right;">品牌编码：</label>
				<input type="text" id="brandCode_input" />
			</div>
			<div class="col-md-12" style="text-align: right;padding: 10px 30px;">
				<a class="btn btn-default shiny" onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;
				<a class="btn btn-default shiny" onclick="reset();">重置</a>
			</div>
		</div>
	</div>
<!-- <div class="table-bordered" style="overflow-y: scroll; height: 300px;"> -->
	<table
		class="table table-bordered table-striped table-condensed table-hover flip-content"
		style="table-layout: fixed;width: 943px">
		<thead class="flip-content bordered-darkorange">
			<tr>
				<th style="text-align: center;" width="49%">集团品牌名称</th>
				<th style="text-align: center;" width="51%">集团品牌编码</th>
			</tr>
		</thead>
	</table>
	<div style="overflow-y: scroll; min-height: 143px;max-height: 227px">
	<table class="table table-bordered table-striped table-condensed table-hover flip-content"
		id="brandGroup_tab" style="table-layout:fixed;">
		<tbody>
		</tbody>
	</table>
	</div>
	<div class="pull-left" style="padding: 10px 0;">
		<form id="brandGroup_form" action="">
			<div class="col-lg-12">
				<select id="pageSelect1" name="pageSize" style="padding: 0 12px;">
					<option>5</option>
					<option selected="selected">10</option>
					<option>15</option>
					<option>20</option>
				</select>
			</div>
			<input type="hidden" id="brandName_from" value="" name="brandName">
			<input type="hidden" id="brandCode_from" value="" name="brandSid">
		</form>
	</div>
	<div id="brandGroupPagination"></div>
<!-- </div> -->
<!-- Templates -->
<p style="display: none">
	<textarea id="brandGroup-list" rows="0" cols="0">
		<!--
		{#template MAIN}
			{#foreach $T.list as Result}
				<tr class="gradeX" name="{$T.Result.brandName}" sid="{$T.Result.sid}" brandSid="{$T.Result.brandSid}">
					<td align="center"  width="50%" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
						{$T.Result.brandName}
					</td>
					<td align="center" width="50%">
						{$T.Result.brandSid}
					</td>
	       		</tr>
			{#/for}
	    {#/template MAIN}	-->
	</textarea>
</p>
</body>
</html>
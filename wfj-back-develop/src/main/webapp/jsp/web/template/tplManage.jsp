<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="tabbable">
	<ul class="nav nav-tabs" id="myTab">
		<li class="active"><a data-toggle="tab"
			href="#channel"> 模板管理 </a></li>
	</ul>
	<div class="tab-content" id="channel" style="overflow: scroll;">
		<!-- 模板管理 -->
		<div class="m10">
	        <a id="editabledatatable_add" onclick="toUploadFile();" class="btn btn-primary glyphicon glyphicon-plus">文件上传</a>
		</div>		
		<table class="table table-hover table-bordered" id="file_tab" style="margin-top:10px;">
			<thead>
				<tr role="row">
					<th width="35px;"></th>
					<th style="text-align: center;">类型</th>
					<th style="text-align: center;">名称</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>		
		<!-- Templates -->
		<p style="display: none">
			<textarea id="dir-list" rows="0" cols="0">
				<!-- 
				{#template MAIN}
					{#foreach $T.list as Result}
						<tr class="gradeX">
							<td align="left">
								<div class="checkbox">
									<label>
										<input type="checkbox" id="id" value="{$T.Result.name}" >
										<span class="text"></span>
									</label>
								</div>
							</td>
							<input type='hidden' id='path_{$T.Result.name}' value='{$T.Result.path}'></input>
							<td align="center">
								{#if $T.Result.type == "true"}
           							<span class="label label-default"> 目录</span>
                      			{#else if $T.Result.type == "false"}
           							<span class="label label-success">文件</span>
                   				{#/if}
							</td>
							<td align="center" id="name_{$T.Result.name}">{$T.Result.name}</td>
							
			       		</tr>
					{#/for}
			    {#/template MAIN}	 -->
			</textarea>
		</p>
	</div>
</div>
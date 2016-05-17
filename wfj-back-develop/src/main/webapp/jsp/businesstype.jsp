<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var btPagination;
	$(function() {    	
	    initBt();
	    $("#pageSelect").change(btQuery);
	});
	function btQuery(){
        var params = $("#bt_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        btPagination.onLoad(params);
   	}
	function reset(){
		btQuery();
	}
	//初始化商品列表
 	function initBt() {
		var url = __ctxPath + "/DataDictionary/dictTypeList";
		btPagination = $("#btPagination").myPagination({
           panel: {
             tipInfo_on: true,
             tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
             tipInfo_css: {
               width: '25px',
               height: "20px",
               border: "2px solid #f0f0f0",
               padding: "0 0 0 5px",
               margin: "0 5px 0 5px",
               color: "#48b9ef"
             }
           },
           debug: false,
           ajax: {
             on: true,
             url: url,
             dataType: 'json',
             ajaxStart: function() {
               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 100);
             },
             ajaxStop: function() {
               //隐藏加载提示
               setTimeout(function() {
                 ZENG.msgbox.hide();
               }, 300);
             },
             callback: function(data) {
               //使用模板
               $("#bt_tab tbody").setTemplateElement("bt-list").processTemplate(data);
             }
           }
         });
    }
    //添加
    function addBt(){
    	$("#sid").val("");
    	$("#dictTypeCode").removeAttr("disabled");
		$("#dictTypeCode").val("");
		$("#dictTypeName").val("");
		$("#activeFlag").val(1);
    	$("#divTitle").html("添加业务类型");
		$("#btDiv").show();
	}
	
	function modifyBt(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else if(checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		$("#sid").val(value);
		$("#dictTypeCode").attr("disabled","disabled");
		$("#dictTypeCode").val($("#dictTypeCode_"+value).text().trim());
		$("#dictTypeName").val($("#dictTypeName_"+value).text().trim());
		if($("#activeFlag_"+value).text().trim()=="有效"){
			$("#activeFlag").val(1);
		}else{
			$("#activeFlag").val(0);
		}
		$("#divTitle").html("修改业务类型");
		$("#btDiv").show();
	}
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
	}
	
	function deleteBt(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else if(checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		bootbox.confirm("确定禁用吗？", function(r){
			if(r){
				$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url: __ctxPath+"/DataDictionary/deleteDictType",
					dataType: "json",
					data: {
						"sid":value
					},
					success: function(response) {
						if(response.success=="true"){
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<i class='fa-fw fa fa-times'></i><strong>禁用成功</strong></div>");
		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						}else{
							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>禁用失败</strong></div>");
							$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
						return;
					}
				});
			}
		});
	}
	//保存div中数据
	function saveDivFrom(){
		var url = "";
		if($("#sid").val()!=""){
			url=__ctxPath + "/DataDictionary/updateDictType";
		}else{
			url=__ctxPath+"/DataDictionary/saveDictType";
		}
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
			data: $("#divForm").serialize(),
			success: function(response) {
				if(response.success=="true"){
					$("#btDiv").hide();
					$("#sid").val("");
					$("#dictTypeCode").val("");
					$("#dictTypeName").val("");
					$("#activeFlag").val(1);
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/businesstype.jsp");
	}
	function closeBtDiv(){
		$("#btDiv").hide();
	}
	</script> 
</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
    <!-- Main Container -->
    <div class="main-container container-fluid">
        <!-- Page Container -->
        <div class="page-container">
                <!-- Page Body -->
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <h5 class="widget-caption">业务类型管理</h5>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                    	<a id="editabledatatable_new" onclick="addBt();" class="btn btn-primary glyphicon glyphicon-plus">
											添加业务类型
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="modifyBt();" class="btn btn-info glyphicon glyphicon-wrench">
											修改业务类型
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="deleteBt();" class="btn btn-danger glyphicon glyphicon-trash">
											禁用业务类型
                                        </a>
                                       <div class="btn-group pull-right">
                                        </div>
                                    </div>
                                    <table class="table table-striped table-hover table-bordered" id="bt_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th width="7.5%"></th>
                                                <th style="text-align: center;">业务类型SID</th>
                                                <th style="text-align: center;">业务类型编号</th>
                                                <th style="text-align: center;">业务类型名称</th>
                                                <th style="text-align: center;">有效标志位</th>
                                                <th style="text-align: center;">创建时间</th>
                                                <th style="text-align: center;">修改时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                               
								<!-- Templates -->
								<p style="display:none">
									<textarea id="bt-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">{$T.Result.sid}</td>
													<td align="center" id="dictTypeCode_{$T.Result.sid}">{$T.Result.dictTypeCode}</td>
													<td align="center" id="dictTypeName_{$T.Result.sid}">{$T.Result.dictTypeName}</td>
													<td align="center" id="activeFlag_{$T.Result.sid}">
														{#if $T.Result.activeFlag == 0}
						           							<span class="btn btn-danger btn-xs">无效</span>
						                      			{#elseif $T.Result.activeFlag == 1}
						           							<span class="btn btn-success btn-xs">有效</span>
						                   				{#/if}
													</td>
													<td align="center">{$T.Result.createdTime}</td>
													<td align="center">{$T.Result.updatedTime}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Page Body -->
            </div>
            <!-- /Page Content -->
        </div>
        <!-- /Page Container -->
        <!-- Main Container -->
    <div class="modal modal-darkorange" id="btDiv">
        <div class="modal-dialog" style="width: 400px;margin: 160px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divForm" method="post" class="form-horizontal" enctype="multipart/form-data">
				            		<input type="hidden" id="sid" name="sid"/>
					                <div class="form-group">
					 					业务类型编号：
					 					<input type="text" placeholder="必填" class="form-control" id="dictTypeCode" name="dictTypeCode">
					                </div>
					                <div class="form-group">
										业务类型名称：
										<input type="text" placeholder="必填" class="form-control" id="dictTypeName" name="dictTypeName">
					                </div>
					                <div class="form-group">
					 					有效标志位：
					 					<select id="activeFlag" name="activeFlag">
					 						<option value="1" selected="selected">有效</option>
					 						<option value="0">无效</option>
					 					</select>
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
</body>
</html>
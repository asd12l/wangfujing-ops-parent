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
	
	
	var supplyBSPagination;
	$(function() {    	
	    initSupplyBS();
	    $("#supplyName_input").change(supplyBSQuery);
	    $("#pageSelect").change(supplyBSQuery);
	});
	function supplyBSQuery(){
		$("#supplyName_from").val($("#supplyName_input").val());
        var params = $("#supplyBS_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        supplyBSPagination.onLoad(params);
   	}
	function reset(){
		$("#supplyName_input").val("");
		supplyBSQuery();
	}
 	function initSupplyBS() {
		var url = $("#ctxPath").val()+"/supplyBrandShop/selectAllSupplyBrandShop";
		supplyBSPagination = $("#supplyBSPagination").myPagination({
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
               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
             },
             ajaxStop: function() {
               //隐藏加载提示
               setTimeout(function() {
                 ZENG.msgbox.hide();
               }, 300);
             },
             callback: function(data) {
               //使用模板
               $("#supplyBS_tab tbody").setTemplateElement("supplyBS-list").processTemplate(data);
             }
           }
         });
    }
	function addSupplyBS(){
		var url = __ctxPath+"/jsp/SupplyBrandShop/addSupplyBrandShop.jsp";
		$("#pageBody").load(url);
	}
	function editSupplyBS(){
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
		SupplyBSsid = value;
		supplySid_ = $("#supplySid_"+value).text().trim();
		supplyName_ = $("#supplyName_"+value).text().trim();
		brandName_ = $("#brandName_"+value).text().trim();
		shopName_ = $("#shopName_"+value).text().trim();
		netBit_sid = $("#netBit_"+value).text().trim();;
		var url = __ctxPath+"/jsp/SupplyBrandShop/editSupplyBrandShop.jsp";
		$("#pageBody").load(url);
	}
	function delSupplyBS (){
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
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要删除的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/supplyBrandShop/deleteSupplyBrandShop";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
			data: {
				"sid":value
			},
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
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
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/SupplyBrandShop/supplyBrandShop.jsp");
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
                                    <span class="widget-caption"><h5>供应商门店品牌关联管理</h5></span>
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
                                    	<a id="editabledatatable_new" onclick="addSupplyBS();" class="btn btn-primary">
                                        	<i class="fa fa-plus"></i>
											添加
                                        </a>&nbsp;&nbsp;
                                    	<a id="editabledatatable_new" onclick="editSupplyBS();" class="btn btn-info">
                                    		<i class="fa fa-wrench"></i>
											修改
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="delSupplyBS();" class="btn btn-danger">
                                        	<i class="fa fa-times"></i>
											删除
                                        </a>
                                       <div class="btn-group pull-right">
                                       		 <form id="supplyBS_form" action="">
	                                        	<select id="pageSelect" name="pageSize">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
												<input type="hidden" id="supplyName_from" name="supplyName" />
	                                       	</form>
                                        </div>
                                    </div>
                                    <div class="table-toolbar">
                                    	<span>供应商名称：</span>
                                    	<input type="text" id="supplyName_input" />&nbsp;&nbsp;
                                    	<a class="btn btn-default shiny" onclick="reset();" style="height: 32px;margin-top: -4px;">重置</a>
                                    </div>
                                    <table class="table table-hover table-bordered" id="supplyBS_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th width="7.5%"></th>
                                                <th style="text-align: center;">供应商编码</th>
                                                <th style="text-align: center;">供应商名称</th>
                                                <th style="text-align: center;">品牌名称</th>
                                                <th style="text-align: center;">门店</th>
                                                <th style="text-align: center;">是否允许网销</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div id="supplyBSPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="supplyBS-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="supplySid_{$T.Result.sid}">{$T.Result.supplySid}</td>
													<td align="center" id="supplyName_{$T.Result.sid}">{$T.Result.supplyName}</td>
													<td align="center" id="brandName_{$T.Result.sid}">{$T.Result.brandName}</td>
													<td align="center" id="shopName_{$T.Result.sid}">{$T.Result.shopName}</td>
													<td align="center" id="netBit_{$T.Result.sid}">
														{#if $T.Result.netBit == 0}
						           							不允许网销
						                      			{#elseif $T.Result.netBit == 1}
						           							允许网销
						                   				{#/if}
													</td>
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
    </div>    
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<style type="text/css">
    .listInfo li {
        float: left;
        height: 35px;
        margin: 1px 1px 1px 0;
        overflow: hidden;
    }
</style>

<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" ></script>
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var supplierInfoPagination;
	$(function() {
	    $("#pageSelect").change(supplierInfoQuery);
        $("#shopSid_select").change(supplierInfoQuery);
        $("#businessPattern_select").change(supplierInfoQuery);
        shopQuery();

        initSupplierInfo();
    });

    //查询门店
    function shopQuery(){
        var shopSid = $("#shopSid_select");
        shopSid.html("");
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/shoppe/queryShopListAddPermission",
            dataType : "json",
            async : false,
            data : "organizationType=3",
            success : function(response) {
            	if(response.success == "true"){
            		var result = response.list;
                    for (var i = 0; i < result.length; i++) {
                        var ele = result[i];
                        var option = $("<option value='" + ele.organizationCode + "'>" + ele.organizationName + "</option>");
                        option.appendTo(shopSid);
                    }
            	}
                return;
            },
            error : function(XMLHttpRequest, textStatus) {
                var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
                if(sstatus != "sessionOut"){
                    $("#warning2Body").text("系统出错!");
                    $("#warning2").show();
                }
                if(sstatus=="sessionOut"){
                    $("#warning3").css('display','block');
                }
            }
        });
        $("#shopSid_select").select2();
    }

	function supplierInfoQuery(){
		$("#supplyName_form").val($("#supplyName_input").val());
		$("#supplyCode_form").val($("#supplyCode_input").val());
		$("#shopSid_form").val($("#shopSid_select").val());
		$("#businessPattern_form").val($("#businessPattern_select").val());
        var params = $("#supplierInfo_form").serialize();
        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('supplier.selectSupplier', '供应商查询：' + params, getCookieValue("username"),  sessionId);
        params = decodeURI(params);
        supplierInfoPagination.onLoad(params);
   	}

	function find(){
		supplierInfoQuery();
	}

	function reset(){
		$("#supplyName_input").val("");
		$("#supplyCode_input").val("");
        $("#shopSid_select").val($("#shopSid_select option:eq(0)").val()).select2();
        $("#businessPattern_select").val("");
		supplierInfoQuery();
	}
 	function initSupplierInfo() {
		var url = $("#ctxPath").val()+"/supplierDisplay/selectSupplier";
		supplierInfoPagination = $("#supplierInfoPagination").myPagination({
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
               param: "shopSid=" + $("#shopSid_select option:selected").val(),
               ajaxStart : function() {
                    $("#loading-container").attr("class","loading-container");
               },
               ajaxStop : function() {
                   //隐藏加载提示
                   setTimeout(function() {
                       $("#loading-container").addClass("loading-inactive");
                   }, 300);
			},
             callback: function(data) {
               //使用模板
               $("#supplierInfo_tab tbody").setTemplateElement("supplierInfo-list").processTemplate(data);
             }
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
		$("#pageBody").load(__ctxPath+"/jsp/SupplierInfomationNode/SupplierInfomationNode.jsp");
	}
	</script>
	<!-- 点击编码或者名称查询详情 -->
	<script type="text/javascript">
        function getView(data){
            var value = data;
            var url = __ctxPath+"/supplierDisplay/toSupplierDetail";

            LA.sysCode = '10';
            var sessionId = '<%=request.getSession().getId() %>';
            LA.log('supplier.toSupplierDetail', '供应商详情：' + value, getCookieValue("username"),  sessionId);

            $("#pageBody").load(url,{"sid":value});
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
                                    <h5 class="widget-caption">供应商管理</h5>
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
                                        <ul class="listInfo clearfix">
                                            <li>
                                                <span>供应商名称：</span>
                                                <input type="text" id="supplyName_input" style="width: 200px;height: 22px;"/>
                                            </li>
                                            <li>
                                                <span>经营方式：</span>
                                                <select id="businessPattern_select" style="width: 200px;height: 22px;">
                                                    <option value="" selected="selected">请选择</option>
                                                    <option value="0">经销</option>
                                                    <option value="1">代销</option>
                                                    <option value="2">联营</option>
                                                    <option value="3">平台服务</option>
                                                    <option value="4">租赁</option>
                                                </select>
                                            </li>
                                            <li>
                                                <span>门店：</span>
                                                <select id="shopSid_select" style="width: 200px;height: 22px;">
                                                </select>
                                            </li>
                                            <li>
                                               <span>供应商编码：</span>
                                               <input type="text" id="supplyCode_input" style="width: 200px;height: 22px;"/>
                                            </li>
                                            <li>
                                               <a class="btn btn-default shiny" onclick="find();" style="margin-left: 10px;">查询</a>
                                               <a class="btn btn-default shiny" onclick="reset();" style="margin-left: 10px;">重置</a>
                                            </li>
                                       </ul>
                                   </div>
                                   <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="supplierInfo_tab">
                                      <thead class="flip-content bordered-darkorange">
                                        <tr role="row">
                                            <th style="text-align: center;">供应商名称</th>
                                            <th style="text-align: center;">供应商编码</th>
                                            <th style="text-align: center;">门店编码</th>
                                            <th style="text-align: center;">经营方式</th>
                                            <th style="text-align: center;">企业地址</th>
                                            <th style="text-align: center;">联系电话</th>
                                            <th style="text-align: center;">邮箱</th>
                                            <th style="text-align: center;">供应商类型</th>
                                            <th style="text-align: center;">供应商状态</th>
                                            <th style="text-align: center;">供应商简称</th>
                                            <th style="text-align: center;" >重点供应商</th>
                                        </tr>
                                      </thead>
                                      <tbody>
                                      </tbody>
                                   </table>
                                   <div class="pull-left" style="margin-top: 5px;">
                                        <form id="supplierInfo_form" action="">
                                            <select id="pageSelect" name="pageSize">
                                                <option>5</option>
                                                <option selected="selected">10</option>
                                                <option>15</option>
                                                <option>20</option>
                                            </select>
                                            <input type="hidden" id="supplyName_form" name="supplyName"/>
                                            <input type="hidden" id="supplyCode_form" name="supplyCode"/>
                                            <input type="hidden" id="shopSid_form" name="shopSid"/>
                                            <input type="hidden" id="businessPattern_form" name="businessPattern"/>
                                            <input type="hidden" id="apartOrder_form" name="apartOrder"/>
                                        </form>
								   </div>
                                   <div id="supplierInfoPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="supplierInfo-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">

													<td align="center">
														<a id="supplyName_{$T.Result.sid}" onclick="getView({$T.Result.sid});" style="cursor:pointer;">
														    {$T.Result.supplyName}
														</a>
													</td>
													<td align="center">
														<a id="supplyCode_{$T.Result.sid}" onclick="getView({$T.Result.sid});" style="cursor:pointer;">
														    {$T.Result.supplyCode}
														</a>
													</td>
                                                    <td align="center" id="shopSid_{$T.Result.sid}">{$T.Result.shopSid}</td>
                                                    <td align="center">
                                                        <span id="businessPattern_{$T.Result.sid}" style="display:none;">
                                                            {$T.Result.businessPattern}
                                                        </span>
                                                        {#if $T.Result.businessPattern == "0"}
															<span>经销</span>
														{#elseif $T.Result.businessPattern == "1"}
															<span>代销</span>
														{#elseif $T.Result.businessPattern == "2"}
															<span>联营</span>
														{#elseif $T.Result.businessPattern == "3"}
															<span>平台服务</span>
														{#elseif $T.Result.businessPattern == "4"}
															<span>租赁</span>
														{#/if}
                                                    </td>
                                                    <td align="center" style="display:none;">
                                                        <span id="apartOrder_{$T.Result.sid}" style="display:none;">
                                                            {$T.Result.apartOrder}
                                                        </span>
                                                        {#if $T.Result.apartOrder == 1}
															<span>虚库</span>
														{#elseif $T.Result.apartOrder == 0}
															<span>自库</span>
														{#/if}
                                                    </td>
													<td align="center" id="address_{$T.Result.sid}">
													    {#if $T.Result.address != '[object Object]'}
                                                            {$T.Result.address}
                                                        {#/if}
													</td>
													<td align="center" id="phone_{$T.Result.sid}">
													    {#if $T.Result.phone != '[object Object]'}
                                                            {$T.Result.phone}
                                                        {#/if}
													</td>
													<td align="center" id="email_{$T.Result.sid}">
													    {#if $T.Result.email != '[object Object]'}
                                                            {$T.Result.email}
                                                        {#/if}
													</td>
													<td align="center">
													    <span id="supplyType_{$T.Result.sid}" style="display:none;">
													        {$T.Result.supplyType}
													    </span>
														{#if $T.Result.supplyType == 0}
															<span>门店供应商</span>
														{#elseif $T.Result.supplyType == 1}
															<span>集团供应商</span>
														{#/if}
													</td>
													<td align="center">
													    <span id="status_{$T.Result.sid}" style="display:none;">
													        {$T.Result.status}
													    </span>
													    {#if $T.Result.status == "Y"}
															<span>正常</span>
														{#elseif $T.Result.status == "T"}
															<span>未批准</span>
														{#elseif $T.Result.status == "N"}
															<span>终止</span>
														{#elseif $T.Result.status == "L"}
															<span>待审批</span>
														{#elseif $T.Result.status == "3"}
															<span>淘汰</span>
														{#elseif $T.Result.status == "4"}
															<span>停货</span>
														{#elseif $T.Result.status == "5"}
															<span>停款</span>
														{#elseif $T.Result.status == "6"}
															<span>冻结</span>
														{#/if}
													</td>
													<td align="center" id="shortName_{$T.Result.sid}">
													    {#if $T.Result.shortName != '[object Object]'}
													        {$T.Result.shortName}
													    {#/if}
													</td>
													<td align="center">
													    <span id="keySupplier_{$T.Result.sid}" style="display:none;">
													        {$T.Result.keySupplier}
													    </span>
													    {#if $T.Result.keySupplier == 1}
															<span>是</span>
														{#elseif $T.Result.keySupplier == 0}
															<span>否</span>
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
                <!-- /Page Body -->
            </div>
            <!-- /Page Content -->
        </div>
        <!-- /Page Container -->
        <!-- Main Container -->
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--Page Related Scripts-->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
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
    <script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
    <script type="text/javascript">
        __ctxPath = "${pageContext.request.contextPath}";
        var contractLogPagination;

        $(function () {
            $("#pageSelect").change(contractLogQuery);
            $("#storeCode_select").change(contractLogQuery);
            $("#storeCode_select").change(querySupplier);
            $("#supplyCode_select").change(contractLogQuery);
            $("#manageType_select").change(contractLogQuery);

            //查询门店
            var shopSid = $("#storeCode_select");
//            shopSid.html("<option value=''>请选择</option>");
            $.ajax({
                type: "post",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                url: __ctxPath + "/shoppe/queryShopListAddPermission",
                dataType: "json",
                async: false,
                data: "organizationType=3",
                success: function (response) {
                	if(response.success == "true"){
                		var result = response.list;
                        for (var i = 0; i < result.length; i++) {
                            var ele = result[i];
                            var option = $("<option value='" + ele.organizationCode + "'>" + ele.organizationName + "</option>");
                            option.appendTo(shopSid);
                        }
                	} else {
                		$("<option value=''>请选择</option>").appendTo(shopSid);
                	}
                    return;
                },
                error: function (XMLHttpRequest, textStatus) {
                    var sstatus = XMLHttpRequest.getResponseHeader("sessionStatus");
                    if (sstatus != "sessionOut") {
                        $("#warning2Body").text("系统错误!");
                        $("#warning2").show();
                    }
                    if (sstatus == "sessionOut") {
                        $("#warning3").css('display', 'block');
                    }
                }
            });
            $("#storeCode_select").select2();

            querySupplier();
            $("#supplyCode_select").select2();
            initContractLog();
        });

        function querySupplier(){
            //查询供应商
            var supplyCode_select = $("#supplyCode_select");
            supplyCode_select.html("<option value=''>请选择</option>");
            $.ajax({
                type : "post",
                contentType : "application/x-www-form-urlencoded;charset=utf-8",
                url : __ctxPath + "/supplierDisplay/findListSupplier",
                dataType : "json",
                async : false,
                data: "shopCode=" + $("#storeCode_select option:selected").val().trim(),
                success : function(response) {
                    var result = response.list;
                    if(typeof(result) != "undefined"){
                        for (var i = 0; i < result.length; i++) {
                            var ele = result[i];
                            var option = $("<option value='" + ele.supplyCode + "'>" + ele.supplyName + "</option>");
                            option.appendTo(supplyCode_select);
                        }
                    }
                    return;
                },
                error : function(XMLHttpRequest, textStatus) {
                    var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
                    if(sstatus != "sessionOut"){
                        $("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
                        $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
                    }
                    if(sstatus=="sessionOut"){
                        $("#warning3").css('display','block');
                    }
                }
            });
        }

        function contractLogQuery() {
            $("#contractCode_form").val($("#contractCode_input").val());
            $("#manageType_form").val($("#manageType_select").val());
            // 门店编码
            var storeCode = "";
            var storeCode_input = $("#storeCode_input").val().trim();
            if(storeCode_input != ""){
                storeCode = storeCode_input;
            }
            var storeCode_select = $("#storeCode_select").val();
            if(storeCode_select != ""){
               storeCode = storeCode_select;
            }
            $("#storeCode_form").val(storeCode);
            // 供应商赋值
            var supplyCode = "";
            var supplyCode_input = $("#supplyCode_input").val().trim();
            if(supplyCode_input != ""){
                supplyCode = supplyCode_input;
            }
            var supplyCode_select = $("#supplyCode_select").val();
            if(supplyCode_select != ""){
                supplyCode = supplyCode_select;
            }
            $("#supplyCode_form").val(supplyCode);
            var params = $("#contractLog_form").serialize();
            params = decodeURI(params);
            contractLogPagination.onLoad(params);
        }

        function find() {
            contractLogQuery();
        }

        function reset() {
            $("#contractCode_input").val("");
            $("#manageType_select").val("");
            $("#storeCode_select").val($("#storeCode_select option:eq(0)").val()).select2();
            $("#storeCode_input").val("");
            $("#supplyCode_select").select2().select2("val", "");
            $("#supplyCode_input").val("");
            contractLogQuery();
        }
        //初始化
        function initContractLog() {
            var url = $("#ctxPath").val() + "/contractLog/findPageContract";
            contractLogPagination = $("#contractLogPagination").myPagination({
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
                    async: false,
                    param: "storeCode=" + $("#storeCode_select option:selected").val(),
                    ajaxStart: function () {
                        $("#loading-container").attr("class", "loading-container");
                    },
                    ajaxStop: function () {
                        //隐藏加载提示
                        setTimeout(function () {
                            $("#loading-container").addClass("loading-inactive");
                        }, 300);
                    },
                    callback: function (data) {
                        /* 使用模板 */
                        $("#contractLog_tab tbody").setTemplateElement("contractLog-list").processTemplate(data);
                    }
                }
            });
        }

        function tab(data) {
            if (data == 'pro') {//基本
                if ($("#pro-i").attr("class") == "fa fa-minus") {
                    $("#pro-i").attr("class", "fa fa-plus");
                    $("#pro").css({"display": "none"});
                } else {
                    $("#pro-i").attr("class", "fa fa-minus");
                    $("#pro").css({"display": "block"});
                }
            }
        }
    </script>

</head>

<body>
<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}"/>
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
                            <h5 class="widget-caption">合同管理</h5>

                            <div class="widget-buttons">
                                <a href="#" data-toggle="maximize"></a>
                                <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                    <i class="fa fa-minus" id="pro-i"></i>
                                </a>
                                <a href="#" data-toggle="dispose"></a>
                            </div>
                        </div>
                        <div class="widget-body clearfix" id="pro">
                            <div class="table-toolbar">
                                <ul class="listInfo clearfix">
                                    <li>
                                        <span>要约编号：</span>
                                        <input type="text" id="contractCode_input" style="width: 200px;height: 22px;"/>
                                    </li>
                                    <li>
                                        <span>门店编码：</span>
                                        <input type="text" id="storeCode_input" style="width: 200px;height: 22px;">
                                    </li>
                                    <li>
                                        <span>门店：</span>
                                        <select id="storeCode_select" style="width: 200px;height: 22px;">
                                        	
                                        </select>
                                    </li>
                                    <li>
                                        <span>经营方式：</span>
                                        <select id="manageType_select" style="width: 200px;height: 22px;">
                                            <option value="">请选择</option>
                                            <option value="0">经销</option>
                                            <option value="1">代销</option>
                                            <option value="2">联营</option>
                                            <option value="3">平台服务</option>
                                            <option value="4">租赁</option>
                                        </select>
                                    </li>
                                    <li>
                                        <span>供应商编码：</span>
                                        <input type="text" id="supplyCode_input" style="width: 200px;height: 22px;">
                                    </li>
                                    <li>
                                        <span>供应商：</span>
                                        <select id="supplyCode_select" style="width: 200px;height: 22px;">
                                            <option value="">请选择</option>
                                        </select>
                                    </li>
                                    <li>
                                        <a class="btn btn-default shiny" onclick="find();" style="margin-left: 10px;">查询</a>
                                        <a class="btn btn-default shiny" onclick="reset();" style="margin-left: 10px;">重置</a>
                                    </li>
                                </ul>
                            </div>
                            <table class="table table-bordered table-striped table-condensed table-hover flip-content"
                                   id="contractLog_tab">
                                <thead class="flip-content bordered-darkorange">
                                <tr role="row">
                                    <th style="text-align: center;">要约编号</th>
                                    <th style="text-align: center;">门店编码</th>
                                    <th style="text-align: center;">供应商编码</th>
                                    <th style="text-align: center;">经营方式</th>
                                    <th style="text-align: center;">采购类别</th>
                                    <th style="text-align: center;">管理方式</th>
                                    <th style="text-align: center;">业态</th>
                                    <th style="text-align: center;">进项税率</th>
                                    <th style="text-align: center;">销项税率</th>
                                    <th style="text-align: center;">要约扣率</th>
                                    <th style="text-align: center;">管理分类</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div class="pull-left" style="margin-top: 5px;">
                                <form id="contractLog_form" action="">
                                    <div class="col-lg-12">
                                        <select id="pageSelect" name="pageSize" style="padding: 0 12px;">
                                            <option>5</option>
                                            <option selected="selected">10</option>
                                            <option>15</option>
                                            <option>20</option>
                                        </select>
                                    </div>
                                    &nbsp;
                                    <input type="hidden" id="contractCode_form" name="contractCode"/>
                                    <input type="hidden" id="storeCode_form" name="storeCode"/>
                                    <input type="hidden" id="supplyCode_form" name="supplyCode"/>
                                    <input type="hidden" id="manageType_form" name="manageType"/>
                                </form>
                            </div>
                            <div id="contractLogPagination"></div>
                        </div>

                        <!-- Templates -->
                        <p style="display: none">
                            <textarea id="contractLog-list" rows="0" cols="0">
                                <!--
                                {#template MAIN}
                                    {#foreach $T.list as Result status}
                                        <tr class="gradeX">
                                            <td align="center" id="contractCode_{$T.Result.sid}">{$T.Result.contractCode}</td>
                                            <td align="center" id="storeCode_{$T.Result.sid}">{$T.Result.storeCode}</td>
                                            <td align="center" id="supplyCode_{$T.Result.sid}">{$T.Result.supplyCode}</td>
                                            <td align="center" id="manageType_{$T.Result.sid}">
                                                {#if $T.Result.manageType == 0}
                                                    <span>经销</span>
                                                {#elseif $T.Result.manageType == 1}
                                                    <span>代销</span>
                                                {#elseif $T.Result.manageType == 2}
                                                    <span>联营</span>
                                                {#elseif $T.Result.manageType == 3}
                                                    <span>平台服务</span>
                                                {#elseif $T.Result.manageType == 4}
                                                    <span>租赁</span>
                                                {#/if}
                                            </td>
                                            <td align="center" id="buyType_{$T.Result.sid}">
                                                {#if $T.Result.buyType == 0}
                                                    <span>总部集采</span>
                                                {#elseif $T.Result.buyType == 1}
                                                    <span>城市集采</span>
                                                {#elseif $T.Result.buyType == 2}
                                                    <span>门店经营</span>
                                                {#/if}
                                            </td>
                                            <td align="center" id="operMode_{$T.Result.sid}">
                                                {#if $T.Result.operMode == 1}
                                                    <span>单品</span>
                                                {#elseif $T.Result.operMode == 5}
                                                    <span>金饰</span>
                                                {#elseif $T.Result.operMode == 6}
                                                    <span>服务费</span>
                                                {#elseif $T.Result.operMode == 7}
                                                    <span>租赁</span>
                                                {#/if}
                                            </td>
                                            <td align="center" id="businessType_{$T.Result.sid}">
                                                {#if $T.Result.businessType == 0}
                                                    <span>百货</span>
                                                {#elseif $T.Result.businessType == 1}
                                                    <span>超市</span>
                                                {#elseif $T.Result.businessType == 2}
                                                    <span>电商</span>
                                                {#/if}
                                            </td>
                                            <td align="center" id="inputTax_{$T.Result.sid}">
                                                {#if $T.Result.inputTax != '[object Object]'}
                                                    {$T.Result.inputTax}
                                                {#/if}
                                            </td>
                                            <td align="center" id="outputTax_{$T.Result.sid}">
                                                {#if $T.Result.outputTax != '[object Object]'}
                                                    {$T.Result.outputTax}
                                                {#/if}
                                            </td>
                                            <td align="center" id="commissionRate_{$T.Result.sid}">
                                                {#if $T.Result.commissionRate != '[object Object]'}
                                                    {$T.Result.commissionRate}
                                                {#/if}
                                            </td>
                                            <td align="center" id="col1_{$T.Result.sid}">
                                                {#if $T.Result.col1 != '[object Object]'}
                                                    {$T.Result.col1}
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
</body>
</html>
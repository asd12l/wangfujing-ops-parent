<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!--Page Related Scripts-->
<html>
<head>
    <%request.setAttribute("ctx", request.getContextPath());%>
    <script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
    <script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
    <script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/assets/css/dateTime/datePicker.css"/>
    <!--Bootstrap Date Range Picker-->
    <script src="${ctx}/assets/js/datetime/moment.js"></script>
    <script src="${ctx}/assets/js/datetime/daterangepicker.js"></script>
    <style type="text/css">
        .trClick > td, .trClick > th {
            color: red;
        }
    </style>
    <script type="text/javascript">
        //上下文路径
        __ctxPath = "${pageContext.request.contextPath}";

        //页码
        var olvPagination;
        //var format=new RegExp("^(((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/(0?[13578]|1[02])/(0?[1-9]|[12]\\d|3[01]))|((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/(0?[13456789]|1[012])/(0?[1-9]|[12]\\d|30))|((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/0?2/(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((04|08|12|16|[2468][048]|[3579][26])00))/0?2-29)) (20|21|22|23|[0-1]?\\d):[0-5]?\\d:[0-5]?\\d$");
        //只做了简单的日期格式效验(不能效验瑞年) 格式为  yyyy-MM-dd hh:mm:ss 年月日分隔符可以为(-和/)
        var format = /^[\s]*[\d]{4}(\/|-)(0?[1-9]|1[012])(\/|-)(0?[1-9]|[12][0-9]|30|31)[\s]*(0?[0-9]|1[0-9]|2[0-3])(:([0-5][0-9])){2}[\s]*$/;
        //初始时间选择器
        function timePickInit() {
            /* var endTime=new Date();
             var startTime=new Date();
             startTime.setDate(endTime.getDate()-30);
             $('#applyTime').daterangepicker({
             startDate:endTime,
             //		endDate:endTime,
             timePicker:true,
             timePickerSeconds:true,
             timePicker24Hour:true,
             //		minDate:startTime,
             //		maxDate:endTime,
             //		linkedCalendars:false,
             opens:'center',
             showDropdowns : true,
             locale : {
             format: "YYYY-MM-DD HH:mm:ss",
             applyLabel : '确定',
             cancelLabel : '取消',
             fromLabel : '起始时间',
             toLabel : '结束时间',
             customRangeLabel : '自定义',
             daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
             monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
             '七月', '八月', '九月', '十月', '十一月', '十二月' ],
             firstDay : 1
             },
             singleDatePicker:true}); */
            $('#applyTime').daterangepicker({
                timePicker: true,
                timePicker12Hour: false,
                timePickerIncrement: 30,
                format: 'YYYY/MM/DD HH:mm:ss',
                locale: {
                    applyLabel: '确定',
                    cancelLabel: '取消',
                    fromLabel: '起始时间',
                    toLabel: '结束时间',
                    customRangeLabel: '自定义',
                    daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
                    monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                        '七月', '八月', '九月', '十月', '十一月', '十二月'],
                    firstDay: 1
                }
            });
            $('#checkTime').daterangepicker({
                timePicker: true,
                timePicker12Hour: false,
                timePickerIncrement: 30,
                format: 'YYYY/MM/DD HH:mm:ss',
                locale: {
                    applyLabel: '确定',
                    cancelLabel: '取消',
                    fromLabel: '起始时间',
                    toLabel: '结束时间',
                    customRangeLabel: '自定义',
                    daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
                    monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                        '七月', '八月', '九月', '十月', '十一月', '十二月'],
                    firstDay: 1
                }
            });
        }
        //页面加载完成后自动执行
        $(function () {
            //渲染日期
            timePickInit();
            //初始化
            initOlv();
        });

        function parseTime1(strTime) {
            if (format.test(strTime)) {
                var ymdArr = strTime.split(" ")[0].split("/");//年月日
                var hmsArr = strTime.split(" ")[1].split(":");//时分秒
                return new Date(ymdArr[0], ymdArr[1] - 1, ymdArr[2], hmsArr[0], hmsArr[1], hmsArr[2]).getTime();
            }
            return "";
        }
        //解析时间
        function parseTime(str, separator, type) {
            if (str) {
                var arr = str.split(separator);
                var date = new Date(arr[0], arr[1] - 1, arr[2]);
                if (type == 1) {
                    date.setHours(0);
                    date.setMinutes(0);
                    date.setSeconds(0);
                }
                if (type == 2) {
                    date.setHours(23);
                    date.setMinutes(59);
                    date.setSeconds(59);
                }
                return date.getTime();
            }
        }

        //以特定格式格式日期           格式：  年-月-日 时：分：秒
        function formatDate(time) {
            if (isNaN(time)) {
                return;
            }
            var date = new Date(parseInt(time));
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            month = month > 9 ? month : '0' + month;
            var day = date.getDate();
            day = day > 9 ? day : '0' + day;
            var hour = date.getHours();
            hour = hour > 9 ? hour : '0' + hour;
            var minute = date.getMinutes();
            minute = minute > 9 ? minute : '0' + minute;
            var second = date.getSeconds();
            second = second > 9 ? second : '0' + second;
            return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
        }
        //格式化时间二
        function formateDate2(date) {
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            return year + "/" + month + "/" + day;
        }

        //添加申请
        function addApply() {
            var url = __ctxPath + "/jsp/mem/balanceApplyAdd.jsp";
            $("#pageBody").load(url);
        }

        //审核申请
        function checkApply() {
            var checkboxArray = [];
            $("input[type='checkbox']:checked").each(function (i, team) {
                var productSid = $(this).val();
                checkboxArray.push(productSid);
            });
            if (checkboxArray.length > 1) {
                $("#warning2Body").text("只能选择一列!");
                $("#warning2").show();
                return false;
            } else if (checkboxArray.length == 0) {
                $("#warning2Body").text("请选取要审核的申请!");
                $("#warning2").show();
                return false;
            }
            var value = checkboxArray[0];
            var status = $("#status_" + value).val();
            if (status == "0") {
                $("#c_sid").val(value);
                $("#c_memberNum").html($("#memberNum_" + value).html().trim());
                $("#c_applyName").html($("#applyName_" + value).html().trim());
                $("#c_memberAccount").html($("#memberAccount_" + value).html().trim());
                $("#c_applyType").val($("#applyType_" + value).val());
                var i = $("#applyType_" + value).val();
                var type;
                if (i == "0") {
                    $("#c_applyType1").html("运费补偿");
                    type = "10";
                } else {
                    $("#c_applyType1").html("投诉补偿");
                    type = "11";
                }
                var j = $("#voucherType_" + value).val();
                if (j == "0") {
                    $("#c_voucherType").html("子订单号");
                } else {
                    $("#c_voucherType").html("退换货单号");
                }
                $("#c_voucherNum").html($("#voucherNum_" + value).val());
                $("#c_money").html($("#money_" + value).html().trim());
                $("#c_applyReason").html($("#applyReason_" + value).html().trim());
                $.ajax({
                    type: "post",
                    contentType: "application/x-www-form-urlencoded;charset=utf-8",
                    url: __ctxPath + "/balanceApply/getLimit",
                    dataType: "json",
                    data: {
                        "type": type
                    },

                    success: function (response) {
                        if(response.code == "1"){
                            $("#c_moneylimit").html(response.object.thismonthcanuse);
                        }else{
                            $("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>" + response.desc + "</strong></div>");
                            $("#modal-warning").attr({
                                "style": "display:block;",
                                "aria-hidden": "false",
                                "class": "modal modal-message modal-warning"
                            });
                            return false;
                        }
                    }
                });		//待续
                $("#check_apply").show();
            } else {
                $("#warning2Body").text("已审核过，请选取要审核的申请!");
                $("#warning2").show();
                return false;
            }

        }

        function check(status) {
            var sid = $("#c_sid").val();
            var checkReason = $("#c_checkReason").val();
            var money = $("#c_money").html().trim();
            var memberNum = $("#c_memberNum").html().trim();
            var applyType = $("#c_applyType").val();
            $.ajax({
                type: "post",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                url: __ctxPath + "/balanceApply/update",
                dataType: "json",
                data: {
                    "sid": sid,
                    "checkReason": checkReason,
                    "memberNum": memberNum,
                    "money": money,
                    "applyType": applyType,
                    "status": status
                },

                success: function (response) {
                    if (response.code == "1") {
                        $("#check_apply").hide();
                        $("#modal-body-success").html("<div class='alert alert-success fade in'>" +
                                "<i class=''></i><strong>审核成功，返回列表页!</strong></div>");
                        $("#modal-success").attr({
                            "style": "display:block;",
                            "aria-hidden": "false",
                            "class": "modal modal-message modal-success"
                        });
                    } else {
                        $("#check_apply").hide();
                        $("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>审核失败!" + response.desc + "</strong></div>");
                        $("#modal-warning").attr({
                            "style": "display:block;",
                            "aria-hidden": "false",
                            "class": "modal modal-message modal-warning"
                        });
                    }
                }
            });
        }

        //导出excel
        function excelOrder() {
            var url = __ctxPath + "/memDrawback/getWithdrawlsList";
//	var remoteUrl="http://10.6.2.150/wfjpay/admin/order/orderExport.do?";
            var remoteUrl = __ctxPath + "/memDrawback/getWithdrowToExcel2?";
            var params = $("#olv_form").serialize();
            params = decodeURI(params);
            var downloadUrl = remoteUrl + params;
            $.post(url, params, function (data) {
                if ($("#olv_tab tbody tr").size() == 0) {
                    $("#model-body-warning")
                            .html(
                            "<div class='alert alert-warning fade in'><strong>查询结果为空，无法导出Excel!</strong></div>");
                    $("#modal-warning").attr({
                        "style": "display:block;",
                        "aria-hidden": "false",
                        "class": "modal modal-message modal-warning"
                    });
                    return;
                }

                if (data.code == "1") {
//			$("#downloadLink").attr("href",downloadUrl);
//			$("#excelDiv").show();
                    window.open(downloadUrl);
                } else {
                    $("#model-body-warning")
                            .html(
                            "<div class='alert alert-warning fade in'><strong>参数检查失败，无法正常导出Excel!</strong></div>");
                    $("#modal-warning").attr({
                        "style": "display:block;",
                        "aria-hidden": "false",
                        "class": "modal modal-message modal-warning"
                    });
                }
            }, "json");
        }

        //设置表单数据
        function setFormData() {
            var strTime = $("#applyTime").val();
            if (strTime != "" && strTime != null) {
                strTime = strTime.split("-");
                $("#hidStartApplyTime").val(strTime[0].replace("/", "-").replace("/", "-"));
                $("#hidEndApplyTime").val(strTime[1].replace("/", "-").replace("/", "-"));
            } else {
                $("#hidStartApplyTime").val("");
                $("#hidEndApplyTime").val("");
            }

            var strTime2 = $("#checkTime").val();
            if (strTime2 != "" && strTime2 != null) {
                strTime2 = strTime2.split("-");
                $("#hidStartCheckTime").val(strTime2[0].replace("/", "-").replace("/", "-"));
                $("#hidEndCheckTime").val(strTime2[1].replace("/", "-").replace("/", "-"));
            } else {
                $("#hidStartCheckTime").val("");
                $("#hidEndCheckTime").val("");
            }
            $("#hidMemberNum").val($("#memberNum").val())
            $("#hidMemberAccount").val($("#memberAccount").val());
            $("#hidVoucherNum").val($("#voucherNum").val());
            $("#hidApplyName").val($("#applyName").val());
            $("#hidCheckStatus").val($("#checkStatus").val());
        }

        //查询数据
        function olvQuery() {
            //设置表单数据
            setFormData();
            //生成表单请求参数
            var params = $("#olv_form").serialize();
            params = decodeURI(params);
            //根据参数读取数据
            olvPagination.onLoad(params);
        }
        //重置
        function reset() {
            $("#memberNum").val("");
            $("#applyTime").val("");
            $("#checkTime").val("");
            $("#memberAccount").val("");
            $("#voucherNum").val("");
            $("#applyName").val("");
            $("#checkStatus").val("");
            timePickInit();
            olvQuery();
        }
        //初始化函数
        function initOlv() {
            //请求地址
            var url = __ctxPath + "/balanceApply/getList";
            //var url = __ctxPath+"/memDrawback/getWithdrawlsList";
            /* setFormData(); */


            //分页工具
            olvPagination = $("#olvPagination").myPagination({
                panel: {
                    //启用跳页
                    tipInfo_on: true,
                    //跳页信息
                    tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
                    //跳页样式
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
                //ajax请求
                ajax: {
                    on: true,
                    url: url,
                    type: "post",
                    //数据类型
                    dataType: 'json',
                    // param:$("#olv_form").serialize(),
//         //请求开始函数
//         ajaxStart: function() {
//           ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
//         },
//         //请求结束函数
//         ajaxStop: function() {
//           //隐藏加载提示
//           setTimeout(function() {
//             ZENG.msgbox.hide();
//           }, 300);
//         },
                    ajaxStart: function () {
                        $("#loading-container").attr("class", "loading-container");
                    },
                    ajaxStop: function () {
                        //隐藏加载提示
                        setTimeout(function () {
                            $("#loading-container").addClass("loading-inactive");
                        }, 300);
                    },
                    //回调
                    callback: function (data) {
                        $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
                    }
                }
            });

        }

        function closeDialog() {
            $("#check_apply").hide();
        }

        //折叠页面
        function tab(data) {
            if ($("#" + data + "-i").attr("class") == "fa fa-minus") {
                $("#" + data + "-i").attr("class", "fa fa-plus");
                $("#" + data).css({"display": "none"});
            } else if (data == 'pro') {
                $("#" + data + "-i").attr("class", "fa fa-minus");
                $("#" + data).css({"display": "block"});
            } else {
                $("#" + data + "-i").attr("class", "fa fa-minus");
                $("#" + data).css({"display": "block"});
                $("#" + data).parent().siblings().find(".widget-body").css({"display": "none"});
                $("#" + data).parent().siblings().find(".fa-minus").attr("class", "fa fa-plus");
            }
        }

        function successBtn() {
            $("#modal-success").attr({
                "style": "display:none;",
                "aria-hidden": "true",
                "class": "modal modal-message modal-success fade"
            });
            $("#pageBody").load(__ctxPath + "/jsp/mem/balanceApply.jsp");
        }
    </script>
</head>
<body>
<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}"/>
<!-- Main Container -->
<div class="main-container container-fluid">
    <!-- 内容显示区域 -->
    <div class="page-container">
        <!-- Page Body -->
        <div class="page-body" id="pageBodyRight">
            <div class="row">
                <div class="col-xs-12 col-md-12">
                    <div class="widget">
                        <div class="widget-header ">
                            <h5 class="widget-caption">余额申请管理</h5>

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
                                <div class="clearfix">
                                    <a id="addApply" onclick="addApply();"
                                       class="btn btn-primary"> <i class="fa fa-plus"></i>添加申请
                                    </a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="checkApply"
                                                                    onclick="checkApply();" class="btn btn-primary"> <i
                                        class="fa fa-edit"></i> 审核申请
                                </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                </div>
                                <ul class="topList clearfix">
                                    <li class="col-md-4">
                                        <label class="titname">客户编号：</label>
                                        <input type="text" id="memberNum"/>
                                    </li>
                                    <li class="col-md-4">
                                        <label class="titname">申请时间：</label>
                                        <input type="text" id="applyTime"/>
                                    </li>
                                    <li class="col-md-4">
                                        <label class="titname">审核时间：</label>
                                        <input type="text" id="checkTime"/>
                                    </li>
                                    <li class="col-md-4">
                                        <label class="titname">客户账号：</label>
                                        <input type="text" id="memberAccount"/>
                                    </li>
                                    <%--<li class="col-md-4">--%>
                                        <%--<label class="titname">子订单号/退货单号：</label>--%>
                                        <%--<input type="text" id="voucherNum"/>--%>
                                    <%--</li>--%>

                                    <li class="col-md-4">
                                        <label class="titname">申请人：</label>
                                        <input type="text" id="applyName"/>
                                    </li>

                                    <li class="col-md-4">
                                        <label class="titname">审核状态：</label>
                                        <select id="checkStatus">
                                            <option value="">请选择</option>
                                            <option value="0">待审核</option>
                                            <option value="1">审核通过</option>
                                            <option value="2">驳回</option>
                                            <option value="3">取消</option>
                                        </select>
                                    </li>

                                    <li class="col-md-4">
                                        <a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
                                        <a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;
                                        <%--<a class="btn btn-yellow" onclick="excelOrder();">导出</a>--%>
                                    </li>
                                </ul>
                                <!--隐藏参数-->
                                <form id="olv_form" action="">
                                    <input type="hidden" id="hidMemberNum" name="hidMemberNum"/>
                                    <input type="hidden" id="hidStartApplyTime" name="hidStartApplyTime"/>
                                    <input type="hidden" id="hidEndApplyTime" name="hidEndApplyTime"/>
                                    <input type="hidden" id="hidStartCheckTime" name="hidStartCheckTime"/>
                                    <input type="hidden" id="hidEndCheckTime" name="hidEndCheckTime"/>
                                    <input type="hidden" id="hidMemberAccount" name="hidMemberAccount"/>
                                    <input type="hidden" id="hidVoucherNum" name="hidVoucherNum"/>
                                    <input type="hidden" id="hidApplyName" name="hidApplyName"/>
                                    <input type="hidden" id="hidCheckStatus" name="hidCheckStatus"/>
                                </form>
                                <!--数据列表显示区域-->
                                <div style="width:100%; min-height:400px; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab"
                                           style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="1%" style="text-align: center;">操作</th>
                                            <th width="2%" style="text-align: center;">客户登录账号</th>
                                            <th width="2%" style="text-align: center;">客户编号</th>
                                            <th width="2%" style="text-align: center;">申请时间</th>
                                            <th width="2%" style="text-align: center;">申请人</th>
                                            <th width="2%" style="text-align: center;">金额</th>
                                            <th width="2%" style="text-align: center;">审核状态</th>
                                            <th width="2%" style="text-align: center;">审核人</th>
                                            <th width="2%" style="text-align: center;">审核时间</th>
                                            <th width="2%" style="text-align: center;">补偿类型</th>
                                            <th width="2%" style="text-align: center;">相关信息</th>
                                            <th width="2%" style="text-align: center;">申请理由</th>
                                            <th width="2%" style="text-align: center;">审核备注</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <!--分页工具-->
                                <div id="olvPagination"></div>
                            </div>
                            <!--模板数据-->
                            <!-- Templates -->
                            <!--默认隐藏-->
                            <p style="display:none">
								<textarea id="olv-list" rows="0" cols="0">
								{#template MAIN}
									{#foreach $T.object as Result}
										<tr class="gradeX" id="gradeX{$T.Result.sid}"
                                            ondblclick="trClick('{$T.Result.orderTradeNo}',this)" style="height:35px;">
                                            <td align="center">
                                                <div class="checkbox"
                                                     style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
                                                    <label style="padding-left:9px;">
                                                        <input type="checkbox" id="tdCheckbox_{$T.Result.sid}"
                                                               value="{$T.Result.sid}">
                                                        <span class="text"></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td align="center" id="memberAccountStr_{$T.Result.sid}">
                                                <input type="hidden" id = "memberAccount_{$T.Result.sid}" value="{$T.Result.memberAccount}">
                                                {#if $T.Result.memberAccountStr != '[object
                                                Object]'}{$T.Result.memberAccountStr}
                                                {#/if}
                                            </td>
                                            <td align="center" id="memberNum_{$T.Result.sid}">
                                                {#if $T.Result.memberNum!= '[object Object]'}{$T.Result.memberNum}
                                                {#/if}
                                            </td>
                                            <td align="center" id="applyTime_{$T.Result.sid}">
                                                {#if $T.Result.applyTime!= '[object
                                                Object]'}{formatDate($T.Result.applyTime)}
                                                {#/if}
                                            </td>
                                            <td align="center" id="applyName_{$T.Result.sid}">
                                                {#if $T.Result.applyName!= '[object Object]'}{$T.Result.applyName}
                                                {#/if}
                                            </td>
                                            <td align="center" id="money_{$T.Result.sid}">
                                                {#if $T.Result.money != '[object Object]'}{$T.Result.money}
                                                {#/if}
                                            </td>
                                            <td align="center" id="checkStatus_{$T.Result.sid}">
                                                <input type="hidden" id="status_{$T.Result.sid}"
                                                       value="{$T.Result.status}">
                                                {#if $T.Result.status == '0'}待审核
                                                {#elseif $T.Result.status == '1'}审核通过
                                                {#elseif $T.Result.status == '2'}驳回
                                                {#elseif $T.Result.status == '3'}取消
                                                {#/if}
                                            </td>
                                            <td align="center" id="checkName_{$T.Result.sid}">
                                                {#if $T.Result.checkName != '[object Object]'}{$T.Result.checkName}
                                                {#/if}
                                            </td>
                                            <td align="center" id="checkTime_{$T.Result.sid}">
                                                {#if $T.Result.checkTime != '[object
                                                Object]'}{formatDate($T.Result.checkTime)}
                                                {#/if}
                                            </td>
                                            <td align="center" id="applyType1_{$T.Result.sid}">
                                                <input type="hidden" id="applyType_{$T.Result.sid}"
                                                       value="{$T.Result.applyType}"/>
                                                {#if $T.Result.applyType == '0'}运费补偿
                                                {#elseif $T.Result.applyType == '1'}投诉补偿
                                                {#/if}
                                            </td>
                                            <td align="center" id="voucherType1_{$T.Result.sid}">
                                                <input type="hidden" id="voucherType_{$T.Result.sid}"
                                                       value="{$T.Result.voucherType}">
                                                <input type="hidden" id="voucherNum_{$T.Result.sid}"
                                                       value="{$T.Result.voucherNum}">
                                                {#if $T.Result.voucherType != '[object Object]' && $T.Result.voucherType
                                                != null}
                                                {#if $T.Result.voucherType == '0'}子订单号:{$T.Result.voucherNum}
                                                {#elseif $T.Result.voucherType == '1'}退货运单号:{$T.Result.voucherNum}
                                                {#/if}
                                                {#/if}
                                            </td>
                                            <td align="center" id="applyReason_{$T.Result.sid}">
                                                {#if $T.Result.applyReason != '[object Object]'}{$T.Result.applyReason}
                                                {#/if}
                                            </td>
                                            <td align="center" id="checkReason_{$T.Result.sid}">
                                                {#if $T.Result.checkReason!= '[object Object]'}{$T.Result.checkReason}
                                                {#/if}
                                            </td>
                                        </tr>
									{#/for}
							    {#/template MAIN}	
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
<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
     id="check_apply">
    <div class="modal-dialog"
         style="width: 800px; height: auto; margin: 4% auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button" onclick="closeDialog();">×
                </button>
                <h4 class="modal-title" id="divTitle">审核余额申请</h4>
            </div>
            <div class="page-body">
                <div class="row">
                    <form method="post" class="form-horizontal" id="editForm">
                        <div class="col-xs-12 col-md-12">
                            <input type="hidden" name="c_sid" id="c_sid" value=""/>
                            <input type="hidden" name="c_applyType" id="c_applyType"/>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">客户编号：</label>

                                <div class="col-md-6" id="c_memberNum">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请人：</label>

                                <div class="col-md-6" id="c_applyName">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">客户登录号：</label>

                                <div class="col-md-6" id="c_memberAccount">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请类型：</label>

                                <div class="col-md-6" id="c_applyType1">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">凭证类型：</label>

                                <div class="col-md-6" id="c_voucherType">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">凭证单号：</label>

                                <div class="col-md-6" id="c_voucherNum">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">余额金额：</label>

                                <div class="col-md-6" id="c_money">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">可用余额：</label>

                                <div class="col-md-6" id="c_moneylimit">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请理由：</label>

                                <div class="col-md-6" id="c_applyReason">

                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">审核备注：</label>

                                <div class="col-md-6">
                                    <textarea name="c_checkReason" id="c_checkReason" cols="30" placeholder="请填写审核备注"/>
                                </div>
                                <br>&nbsp;
                            </div>

                        </div>
                        <br>&nbsp;
                        <div class="form-group">
                            <div class="col-lg-offset-4 col-lg-7">
                                <button onclick="check('1');" style="width: 90px;" id="pass" type="button">通过</button>
                                &emsp;&emsp;&emsp;&emsp;
                                <button onclick="check('2');" style="width: 90px;" id="nopass" type="button">驳回</button>
                                &emsp;&emsp;&emsp;&emsp;
                                <button onclick="check('3');" style="width: 90px;" id="cancel" type="button">取消申请
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<script>

</script>
</body>
</html>
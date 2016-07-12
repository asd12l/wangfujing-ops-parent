<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!--Page Related Scripts-->
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
    <script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
    <script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
    <!--Bootstrap Date Range Picker-->
    <script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
    <style type="text/css">
        .trClick>td,.trClick>th{
            color:red;
        }
    </style>
    <script type="text/javascript">
        __ctxPath = "${pageContext.request.contextPath}";
        image="http://images.shopin.net/images";
        saleMsgImage="http://images.shopin.net/images";
        ctx="http://www.shopin.net";

        var olvPagination;
        $(function() {
            $("#reservationAp").daterangepicker();
            $("#reservationCh").daterangepicker();
            $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
            initOlv();
        });

        function productQuery(){
            $("#login_from").val($("#login_input").val());
            $("#sid_from").val($("#sid_input").val());
            $("#order_from").val($("#order_input").val());
            $("#applyName_from").val($("#applyName_input").val());
            var strApTime = $("#reservationAp").val();
            var strChTime=$("#reservationCh").val();
            if(strApTime!=""){
                strApTime = strApTime.split("- ");
                $("#m_timeApStartDate_form").val(strApTime[0].replace("/","-").replace("/","-"));
                $("#m_timeApEndDate_form").val(strApTime[1].replace("/","-").replace("/","-"));
            }else{
                $("#m_timeApStartDate_form").val("");
                $("#m_timeApEndDate_form").val("");
            }
            if(strChTime!=""){
                strChTime = strChTime.split("- ");
                $("#m_timeChStartDate_form").val(strChTime[0].replace("/","-").replace("/","-"));
                $("#m_timeChEndDate_form").val(strChTime[1].replace("/","-").replace("/","-"));
            }else{
                $("#m_timeChStartDate_form").val("");
                $("#m_timeChEndDate_form").val("");
            }
            var params = $("#product_form").serialize();
            params = decodeURI(params);
            olvPagination.onLoad(params);
        }
        // 查询
        function query() {
            $("#cache").val(0);
            productQuery();
        }
        //重置
        function reset(){
            $("#cache").val(1);
            $("#login_input").val("");
            $("#sid_input").val("");
            $("#order_input").val("");
            $("#applyName_input").val("");
            $("#reservationAp").val("");
            $("#reservationCh").val("");
            productQuery();
        }
        //初始化优惠券申请
        function initOlv() {
            var url = __ctxPath+"/memCoupon/getMemCoupon";
            olvPagination = $("#olvPagination").myPagination({
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
                    ajaxStart : function() {
                        $("#loading-container").attr("class",
                                "loading-container");
                    },
                    ajaxStop : function() {
                        setTimeout(function() {
                            $("#loading-container").addClass(
                                    "loading-inactive")
                        }, 300);
                    },
                    callback: function(data) {
                        $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
                    }
                }
            });
            function toChar(data) {
                if(data == null) {
                    data = "";
                }
                return data;
            }
        }
        function successBtn(){
            $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
            $("#pageBody").load(__ctxPath+"/jsp/mem/CouponApplyView.jsp");
        }
        //查看优惠券申请
        function showCouPonDetail(){
            var checkboxArray=[];
            $("input[type='checkbox']:checked").each(function(i,team){
                var sid=$(this).val();
                checkboxArray.push(sid);
            });
            if (checkboxArray.length > 1) {
                $("#warning2Body").text("只能选择一条申请记录!");
                $("#warning2").show();
                return;
            } else if (checkboxArray.length == 0) {
                $("#warning2Body").text("请选择要查看的申请!");
                $("#warning2").show();
                return;
            }
            var value=checkboxArray[0];
            $("#sid").val(value);
            $("#apply_cid").val($("#apply_cid_"+value).text().trim());
            $("#apply_name").val($("#apply_name_"+value).text().trim());
            $("#apply_num").val($("#apply_point_"+value).text().trim());
            $("#apply_reason").val($("#apply_reason_"+value).text().trim());
            $("#apply_status").val($("#apply_status_"+value).text().trim());

            var applyType=$("#apply_type_"+value).text().trim();
            if(applyType=="2"){
                $("#apply_type_1").attr("checked",true);
            }else{
                $("#apply_type_0").attr("checked",true);
            }

            var sourceType=$("#source_type_"+value).text().trim();
            if(sourceType=="2"){
                $("#source_type_1").attr("checked",true);
            }else{
                $("#source_type_0").attr("checked",true);
            }

            $("#editLabelDiv").show();
        }
        //隐藏div
        function closeMerchant(){
            $("#editLabelDiv").hide();
        }
        //新建积分申请
        function closeAddIntegral(){
            $("#addIntegralDiv").hide();
        }
        function showAddIntegral(){
            //清空表单内容
            $("#login_name_add").val("");
            $("#apply_name_add").val("");
            $("#from_order_add").val("");
            $("#apply_reason_add").val("");
            $("#apply_reason_add").val("");
            $("#addIntegralDiv").show();
        }
        function submitAddIntegral(){
            $(".add_msg").hide();
            var loginName=$("#login_name_add").val().trim();
            var applyName=$("#apply_name_add").val().trim();
            var applyType=$("input[name='apply_type_add']:checked").val();
            var sourceType=$("input[name='source_type_add']:checked").val();
            var orderNo=$("#from_order_add").val().trim();
            var applyNo=$("#apply_num_add").val().trim();
            var applyReason=$("#apply_reason_add").val().trim();
            if(loginName==""||loginName==null) {
                $("#login_msg").show();
                return false;
            }
            if(applyName==""||applyName==null){
                $("#applyName_msg").show();
                return false;
            }
            if(orderNo==""||orderNo==null){
                $("#orderNo_msg").show();
                return false;
            }
            if(applyNo==""||applyNo==null){
                $("#applyNo_msg").html("不能为空!")
                $("#applyNo_msg").show();
                return false;
            }
            if(isNaN(applyNo)){
                $("#applyNo_msg").html("请输入数字!")
                $("#applyNo_msg").show();
            }
            var url = __ctxPath+"/memberIntegral/addMemberIntegral";
            $.ajax({
                        type : "post",
                        contentType : "application/x-www-form-urlencoded;charset=utf-8",
                        url : url,
                        dataType : "json",
                        ajaxStart : function() {
                            $("#loading-container").attr(
                                    "class",
                                    "loading-container");
                        },
                        ajaxStop : function() {
                            //隐藏加载提示
                            setTimeout(
                                    function() {
                                        $("#loading-container")
                                                .addClass(
                                                "loading-inactive")
                                    }, 300);
                        },
                        data :{"loginName":loginName,"applyName":applyName,"applyType":applyType,"sourceType":sourceType,"orderNo":orderNo,
                        "applyNo":applyNo,"applyReason":applyReason},
                        success : function(response) {
                            if (response.code == "0") {
                                $("#modal-body-success")
                                        .html(
                                        "<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
                                $("#modal-success")
                                        .attr(
                                        {
                                            "style" : "display:block;z-index:9999",
                                            "aria-hidden" : "false",
                                            "class" : "modal modal-message modal-success"
                                        });
                                $("#addIntegralDiv").hide();

                            } else  if(response.code=="1"){
                                $("#model-body-warning")
                                        .html(
                                        "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                                        + "用户名无效!"
                                        + "</strong></div>");
                                $("#modal-warning")
                                        .attr(
                                        {
                                            "style" : "display:block;z-index:9999",
                                            "aria-hidden" : "false",
                                            "class" : "modal modal-message modal-warning"
                                        });
                                $("#addIntegralDiv").hide();
                            } else if(response.code=="2"){
                                $("#model-body-warning")
                                        .html(
                                        "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                                        + "订单无效"
                                        + "</strong></div>");
                                $("#modal-warning")
                                        .attr(
                                        {
                                            "style" : "display:block;z-index:9999",
                                            "aria-hidden" : "false",
                                            "class" : "modal modal-message modal-warning"
                                        });
                                $("#addIntegralDiv").hide();
                            }else{
                                $("#model-body-warning")
                                        .html(
                                        "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                                        + "添加失败"
                                        + "</strong></div>");
                                $("#modal-warning")
                                        .attr(
                                        {
                                            "style" : "display:block;z-index:9999",
                                            "aria-hidden" : "false",
                                            "class" : "modal modal-message modal-warning"
                                        });
                                $("#addIntegralDiv").hide();
                            }
                            return;
                        },
                        error : function() {
                            $("model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
                            $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
                        }

                    });


        }

        //编辑积分申请
        function editIntegralApply(){
            $(".edit_msg").hide();

            //回显
            var checkboxArray=[];
            $("input[type='checkbox']:checked").each(function(i,team){
                var sid=$(this).val();
                checkboxArray.push(sid);
            });
            if (checkboxArray.length > 1) {
                $("#warning2Body").text("只能选择一条申请记录!");
                $("#warning2").show();
                return;
            } else if (checkboxArray.length == 0) {
                $("#warning2Body").text("请选择要查看的申请!");
                $("#warning2").show();
                return;
            }
            var value=checkboxArray[0];
            var checkStatus=$("#check_status_"+value).text().trim();
            if(checkStatus=="审核通过"){
                $("#warning2Body").text("该申请已通过,请选择其他申请记录!!");
                $("#warning2").show();
                return;
            }
            $("#edit_sid").val(value);
            $("#edit_cid").val($("#apply_cid_"+value).text().trim());
            $("#edit_applynName").val($("#apply_name_"+value).text().trim());
            $("#edit_applyNum").val($("#apply_point_"+value).text().trim());
            $("#edit_applyReason").val($("#apply_reason_"+value).text().trim());
            $("#edit_orderNo").val($("#orderNo_"+value).text().trim());
            $("#edit_checkMemo").val($("#checkMemo_"+value).text().trim());

            var applyType=$("#apply_type_"+value).text().trim();
            if(applyType=="2"){
                $("#edit_applyType_1").attr("checked",true);
            }else{
                $("#edit_applyType_0").attr("checked",true);
            }

            var sourceType=$("#source_type_"+value).text().trim();
            if(sourceType=="2"){
                $("#edit_sourceType_1").attr("checked",true);
            }else{
                $("#edit_sourceType_0").attr("checked",true);
            }
            $("#editIntegralDiv").show();
        }

        function submitIntegralApply(){
            var sid=$("#edit_sid").val();
            var applyType=$("input[name='apply_type_edit']:checked").val();
            var sourceType=$("input[name='source_type_edit']:checked").val();
            var orderNo=$("#edit_orderNo").val().trim();
            var applyNum=$("#edit_applyNum").val().trim();
            var applyReason=$("#edit_applyReason").val().trim();
            if(orderNo==""||orderNo==null){
                $("#editOrderNo_msg").show();
                return false;
            }
            if(applyNum==""||applyNum==null){
                $("#editApplyNum_msg").html("不能为空!")
                $("#editApplyNum_msg").show();
                return false;
            }
            if(isNaN(applyNum)){
                $("#editApplyNum_msg").html("请输入数字!")
                $("#editApplyNum_msg").show();
            }
            if(applyReason==""||applyReason==null){
                $("#editReason_msg").show();
                return false;
            }

            var url = __ctxPath+"/memberIntegral/editMemberIntegral";
            $.ajax({
                type : "post",
                contentType : "application/x-www-form-urlencoded;charset=utf-8",
                url : url,
                dataType : "json",
                ajaxStart : function() {
                    $("#loading-container").attr(
                            "class",
                            "loading-container");
                },
                ajaxStop : function() {
                    //隐藏加载提示
                    setTimeout(
                            function() {
                                $("#loading-container")
                                        .addClass(
                                        "loading-inactive")
                            }, 300);
                },
                data :{"sid":sid,"applyType":applyType,"sourceType":sourceType,"orderNo":orderNo,
                    "applyNum":applyNum,"applyReason":applyReason},
                success : function(response) {
                    if (response.success == "true") {
                        $("#modal-body-success")
                                .html(
                                "<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
                        $("#modal-success")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-success"
                                });
                        $("#editIntegralDiv").hide();

                    } else  {
                        $("#model-body-warning")
                                .html(
                                "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                                + "修改失败!"
                                + "</strong></div>");
                        $("#modal-warning")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-warning"
                                });
                    }
                    return;
                },
                error : function() {
                    $("model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
                    $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
                }

            });
        }
        function closeEditIntegral(){
            $("#editIntegralDiv").hide();
        }

        //审核积分申请
        function showCheckApply(){
            $("#checkName_msg").hide();
            var checkboxArray=[];
            $("input[type='checkbox']:checked").each(function(i,team){
                var sid=$(this).val();
                checkboxArray.push(sid);
            });
            if (checkboxArray.length > 1) {
                $("#warning2Body").text("只能选择一条申请记录!");
                $("#warning2").show();
                return;
            } else if (checkboxArray.length == 0) {
                $("#warning2Body").text("请选择要审核的申请!");
                $("#warning2").show();
                return;
            }
            var sid=checkboxArray[0];
            var checkStatus=$("#check_status_"+sid).text().trim();
            if(checkStatus=="审核通过"){
                $("#warning2Body").text("审核通过不能取消!");
                $("#warning2").show();
                return;
            }
            $("#check_sid").val(sid);
            $("#checkIntegralDiv").show();
        }
        function closeCheckApply(){
            $("#checkIntegralDiv").hide();
        }
        function checkIntegralApply(){
            var sid=$("#check_sid").val().trim();
            var checkName=$("#checkName").val().trim();
            var checkStatus=$("input[name='check_status']:checked").val().trim();
            var checkMemo=$("#check_memo").val().trim();
            if(checkName==""||checkName==null){
                $("#checkName_msg").show();
                return false;
            }
            var url = __ctxPath+"/memberIntegral/checkMemberIntegral";
            $.ajax({
                type : "post",
                contentType : "application/x-www-form-urlencoded;charset=utf-8",
                url : url,
                dataType : "json",
                ajaxStart : function() {
                    $("#loading-container").attr(
                            "class",
                            "loading-container");
                },
                ajaxStop : function() {
                    //隐藏加载提示
                    setTimeout(
                            function() {
                                $("#loading-container")
                                        .addClass(
                                        "loading-inactive")
                            }, 300);
                },
                data :{"sid":sid,"checkName":checkName,"checkStatus":checkStatus,"checkMemo":checkMemo},
                success : function(response) {
                    if (response.success == "true") {
                        $("#modal-body-success")
                                .html(
                                "<div class='alert alert-success fade in'><strong>审核操作成功，返回列表页!</strong></div>");
                        $("#modal-success")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-success"
                                });
                        $("#checkIntegralDiv").hide();

                    } else  {
                        $("#model-body-warning")
                                .html(
                                "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                                + "操作失败!"
                                + "</strong></div>");
                        $("#modal-warning")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-warning"
                                });
                    }
                    return;
                },
                error : function() {
                    $("model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
                    $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
                }

            });
        }

        //取消积分申请
        function cancleApply(){
            var checkboxArray=[];
            $("input[type='checkbox']:checked").each(function(i,team){
                var sid=$(this).val();
                checkboxArray.push(sid);
            });
            if (checkboxArray.length > 1) {
                $("#warning2Body").text("只能选择一条申请记录!");
                $("#warning2").show();
                return;
            } else if (checkboxArray.length == 0) {
                $("#warning2Body").text("请选择要取消的积分申请!");
                $("#warning2").show();
                return;
            }
            var sid=checkboxArray[0];
            var checkStatus=$("#check_status_"+sid).text().trim();
            if(checkStatus=="审核通过"){
                $("#warning2Body").text("审核通过不能取消!");
                $("#warning2").show();
                return;
            }
            var url = __ctxPath+"/memberIntegral/cancleMemberIntegral";
            $.ajax({
                type : "post",
                contentType : "application/x-www-form-urlencoded;charset=utf-8",
                url : url,
                dataType : "json",
                ajaxStart : function() {
                    $("#loading-container").attr(
                            "class",
                            "loading-container");
                },
                ajaxStop : function() {
                    //隐藏加载提示
                    setTimeout(
                            function() {
                                $("#loading-container")
                                        .addClass(
                                        "loading-inactive")
                            }, 300);
                },
                data :{"sid":sid},
                success : function(response) {
                    if (response.success == "true") {
                        $("#modal-body-success")
                                .html(
                                "<div class='alert alert-success fade in'><strong>取消成功，返回列表页!</strong></div>");
                        $("#modal-success")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-success"
                                });
                        $("#checkIntegralDiv").hide();

                    } else  {
                        $("#model-body-warning")
                                .html(
                                "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                                + "操作失败!"
                                + "</strong></div>");
                        $("#modal-warning")
                                .attr(
                                {
                                    "style" : "display:block;z-index:9999",
                                    "aria-hidden" : "false",
                                    "class" : "modal modal-message modal-warning"
                                });
                    }
                    return;
                },
                error : function() {
                    $("model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
                    $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
                }

            });
        }
    </script>
    <!-- 加载样式 -->
    <script type="text/javascript">
        function tab(data) {
            if (data == 'pro') {//基本
                if ($("#pro-i").attr("class") == "fa fa-minus") {
                    $("#pro-i").attr("class", "fa fa-plus");
                    $("#pro").css({
                        "display" : "none"
                    });
                } else {
                    $("#pro-i").attr("class", "fa fa-minus");
                    $("#pro").css({
                        "display" : "block"
                    });
                }
            }
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
                            <h5 class="widget-caption">优惠券申请</h5>
                            <div class="widget-buttons">
                                <a href="#" data-toggle="maximize"></a> <a href="#"
                                                                           data-toggle="collapse" onclick="tab('pro');"> <i
                                    class="fa fa-minus" id="pro-i"></i>
                            </a> <a href="#" data-toggle="dispose"></a>
                            </div>
                        </div>
                        <div class="widget-body" id="pro">
                            <div class="table-toolbar">
                                <ul class="topList clearfix">
                                    <li class="col-md-4"><label class="titname">客户账号：</label>
                                        <input type="text" id="login_input" /></li>
                                    <li class="col-md-4"><label class="titname">单据号：</label>
                                        <input type="text" id="sid_input" /></li>
                                    <li class="col-md-4"><label class="titname">子订单号/退货单号：</label>
                                        <input type="text" id="order_input" /></li>
                                    <li class="col-md-4"><label class="titname">申请时间：</label>
                                        <input type="text" id="reservationAp" /></li>
                                    <li class="col-md-4"><label class="titname">审核时间：</label>
                                        <input type="text" id="reservationCh" /></li>
                                    <li class="col-md-4"><label class="titname">申请人：</label>
                                        <input type="text" id="applyName_input" /></li>
                                    <li class="col-md-6">
                                        <a onclick="query();" class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询</a>
                                        <a onclick="reset();"class="btn btn-primary"> <i class="fa fa-random"></i> 重置</a>
                                    </li>
                                </ul>
                                <div class="mtb10">
                                    <a onclick="showCouPonDetail();" class="btn btn-info"> <i class="fa fa-wrench"></i>查看优惠券申请</a>&nbsp;&nbsp;
                                    <a onclick="showAddCouPon();" class="btn btn-info"> <i class="fa fa-wrench"></i>新建优惠券申请</a>&nbsp;&nbsp;
                                    <a onclick="editCouPonApply();" class="btn btn-info"> <i class="fa fa-wrench"></i>编辑优惠券申请</a>&nbsp;&nbsp;
                                    <a onclick="checkCouPonApply();" class="btn btn-info"> <i class="fa fa-wrench"></i>审核优惠券申请</a>&nbsp;&nbsp;
                                    <a onclick="cancleCouPonApply();" class="btn btn-info"> <i class="fa fa-wrench"></i>取消优惠券申请</a>&nbsp;&nbsp;
                                </div>
                                <table class="table table-bordered table-striped table-condensed table-hover flip-content"
                                       id="olv_tab" style="width: 120%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                    <tr role="row" style='height:35px;'>
                                        <th style="text-align: center;" width="2%">选择</th>
                                        <th style="text-align: center;" width="10%">单据号</th>
                                        <th style="text-align: center;" width="10%">客户登录账号</th>
                                        <th style="text-align: center;" width="10%">申请时间</th>
                                        <th style="text-align: center;" width="10%">申请人</th>
                                        <th style="text-align: center;" width="10%">金额</th>
                                        <th style="text-align: center;" width="10%">审核状态</th>
                                        <th style="text-align: center;" width="10%">审核人</th>
                                        <th style="text-align: center;" width="10%">审核时间</th>
                                        <th style="text-align: center;" width="10%">相关信息</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                <div class="pull-left" style="padding: 10px 0;">
                                    <form id="product_form" action="">
                                        <input type="hidden" id="login_from" name="login" />
                                        <input type="hidden" id="sid_from" name="sid" />
                                        <input type="hidden" id="m_timeApStartDate_form" name="m_timeApStartDate"/>
                                        <input type="hidden" id="m_timeApEndDate_form" name="m_timeApEndDate"/>
                                        <input type="hidden" id="m_timeChStartDate_form" name="m_timeChStartDate"/>
                                        <input type="hidden" id="m_timeChEndDate_form" name="m_timeChEndDate"/>
                                        <input type="hidden" id="order_from" name="order" />
                                        <input type="hidden" id="applyName_from" name="applyName" />

                                        <input type="hidden" id="cache" name="cache" value="1" />
                                    </form>
                                </div>
                                <div id="olvPagination"></div>
                            </div>
                            <!-- Templates -->
                            <p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class=    "text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="sid_{$T.Result.sid}">
														{#if $T.Result.sid == "" || $T.Result.sid == null}--
													    {#else}{$T.Result.sid}
													    {#/if}
													</td>
													<td align="center" id="login_name_{$T.Result.sid}">
														{#if $T.Result.login_name == "" || $T.Result.login_name == null}--
													    {#else}{$T.Result.login_name}
													    {#/if}
													</td>
													<td align="center" id="apply_time_{$T.Result.sid}">
														{#if $T.Result.apply_time == "" || $T.Result.apply_time == null}--
													    {#else}{$T.Result.apply_time}
													    {#/if}
													</td>
													<td align="center" id="apply_name_{$T.Result.sid}">
														{#if $T.Result.apply_name == "" || $T.Result.apply_name == null}--
													    {#else}{$T.Result.apply_name}
													    {#/if}
													</td>
													<td align="center" id="apply_coupon_{$T.Result.sid}">
                                                        {#if $T.Result.apply_coupon_num== "" || $T.Result.apply_coupon_num == null}--
                                                        {#else}
														{#if $T.Result.apply_type == "2"}-{$T.Result.apply_coupon_num}
													    {#else}{$T.Result.apply_coupon_num}
													    {#/if}
                                                        {#/if}
													</td>
													<td align="center" id="check_status_{$T.Result.sid}">
														{#if $T.Result.check_status == "" || $T.Result.check_status == null}--
													    {#/if}
                                                        {#if $T.Result.check_status == "1"}待审核
                                                        {#/if}
                                                        {#if $T.Result.check_status == "2"}审核通过
                                                        {#/if}
                                                        {#if $T.Result.check_status == "3"}审核不通过
                                                        {#/if}
                                                        {#if $T.Result.check_status == "4"}取消审核
                                                        {#/if}
													</td>
													<td align="center" id="check_name_{$T.Result.sid}">
														{#if $T.Result.check_name == "" || $T.Result.check_name == null}--
													    {#else}{$T.Result.check_name}
													    {#/if}
													</td>
													<td align="center" id="check_time_{$T.Result.sid}">
														{#if $T.Result.check_time== "" || $T.Result.check_time == null}--
													    {#else}{$T.Result.check_time}
													    {#/if}
													</td>
													<td align="center" id="from_order_{$T.Result.sid}">
                                                        {#if $T.Result.from_order== "" || $T.Result.from_order== null}--
                                                        {#else}
                                                        {#if $T.Result.source_type == "1"}订单号:{$T.Result.from_order}
                                                        {#else}退货单号:{$T.Result.from_order}
                                                        {#/if}
                                                        {#/if}
													</td>
                                                    <td align="center" style="display:none;" id="source_type_{$T.Result.sid}">{$T.Result.source_type}</td>
                                                    <td align="center" style="display:none;" id="apply_type_{$T.Result.sid}">{$T.Result.apply_type}</td>
                                                    <td align="center" style="display:none;" id="apply_cid_{$T.Result.sid}">
                                                        {#if $T.Result.apply_cid== "" || $T.Result.apply_cid == null}--
                                                        {#else}{$T.Result.apply_cid}
                                                        {#/if}
                                                    </td>
                                                    <td align="center" style="display:none;" id="apply_reason_{$T.Result.sid}">
                                                        {#if $T.Result.apply_reason== "" || $T.Result.apply_reason == null}--
                                                        {#else}{$T.Result.apply_reason}
                                                        {#/if}
                                                    </td>
                                                    <td align="center" style="display:none;" id="orderNo_{$T.Result.sid}">
                                                        {#if $T.Result.from_order== "" || $T.Result.from_order == null}--
                                                        {#else}{$T.Result.from_order}
                                                        {#/if}
                                                    </td>
                                                    <td align="center" style="display:none;" id="checkMemo_{$T.Result.sid}">
                                                        {#if $T.Result.check_memo== "" || $T.Result.check_memo == null}--
                                                        {#else}{$T.Result.check_memo}
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
<!--查看积分申请 -->
<div class="modal modal-darkorange"
     id="editLabelDiv">
    <div class="modal-dialog"
         style="width: 800px; height: auto; margin: 4% auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button" onclick="closeMerchant();">×</button>
                <h4 class="modal-title" id="divTitle">查看积分详情</h4>
            </div>
            <div class="page-body">
                <div class="row">
                    <form method="post" class="form-horizontal" id="editForm">
                        <div class="col-xs-12 col-md-12">
                            <input type="hidden" name="id" id="merchant_id">
                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">单据号：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name"
                                           id="sid" />
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">用户编号：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="feeCostRate"
                                           id="apply_cid" />
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请人：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control"
                                           id="apply_name" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">申请类型：</label>
                                <div class="radio">
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   id="apply_type_0" name="apply_type" value="1" checked="checked" onclick="return false;"> <span
                                            class="text">增积分</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   id="apply_type_1" name="apply_type" value="2" onclick="return false;"> <span
                                            class="text">减积分</span>
                                    </label>
                                </div>
                            </div>


                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">凭证类型：</label>
                                <div class="radio">
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   id="source_type_0" name="source_type" value="1" checked="checked" onclick="return false;"> <span
                                            class="text">订单号</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   id="source_type_1" name="source_type" value="2" onclick="return false;"> <span
                                            class="text">退货单号</span>
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;" id="old_input">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">积分数量：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control"
                                           id="apply_num" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;" id="old_input">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请理由：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control"
                                           id="apply_reason" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;" id="old_input">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">审核备注：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control"
                                           id="check_status" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                        </div>
                        <br>&nbsp;
                        <div class="form-group">
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            <input class="btn btn-danger" onclick="closeMerchant();" style="width: 25%;"
                                   id="submitEdit" type="button" value="关闭" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<!--新建积分申请 -->
<div class="modal modal-darkorange"
     id="addIntegralDiv">
    <div class="modal-dialog"
         style="width: 800px; height: auto; margin: 4% auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button" onclick="closeAddIntegral();">×</button>
                <h4 class="modal-title">积分申请单</h4>
            </div>
            <div class="page-body">
                <div class="row">
                    <form method="post" class="form-horizontal">
                        <div class="col-xs-12 col-md-12">
                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">客户登录账号：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name"
                                           id="login_name_add" />
                                    <span id="login_msg" style="color:red;display:none;" class="add_msg">不能为空!</span>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请人：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name"
                                           id="apply_name_add" />
                                    <span id="applyName_msg" style="color:red;display:none;" class="add_msg">不能为空!</span>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">申请类型：</label>
                                <div class="radio">
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="apply_type_add" value="1" checked="checked"> <span
                                            class="text">增积分</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="apply_type_add" value="2"> <span
                                            class="text">减积分</span>
                                    </label>
                                </div>
                            </div>


                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">凭证类型：</label>
                                <div class="radio">
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="source_type_add" value="1" checked="checked"> <span
                                            class="text">订单号</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="source_type_add" value="2"> <span
                                            class="text">退货单号</span>
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">订单/退货编码：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name"
                                           id="from_order_add" />
                                    <span id="orderNo_msg" style="color:red;display:none;" class="add_msg">不能为空!</span>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">积分数量：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control"
                                           id="apply_num_add"/>
                                    <span id="applyNo_msg" style="color:red;display:none;" class="add_msg">不能为空!</span>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12" id="" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请理由：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control"
                                           id="apply_reason_add"/>
                                </div>
                                <br>&nbsp;
                            </div>

                        </div>
                        <br>&nbsp;
                        <div class="form-group">
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            <input class="btn btn-danger" onclick="submitAddIntegral();" style="width: 25%;"
                                   id="submit" type="button" value="提交" />
                        </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>


<!--编辑积分申请 -->
<div class="modal modal-darkorange"
     id="editIntegralDiv">
    <div class="modal-dialog"
         style="width: 800px; height: auto; margin: 4% auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button" onclick="closeEditIntegral();">×</button>
                <h4 class="modal-title">编辑积分申请单</h4>
            </div>
            <div class="page-body">
                <div class="row">
                    <form method="post" class="form-horizontal">
                        <div class="col-xs-12 col-md-12">
                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">单据号：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="sid" readonly="readonly"
                                           id="edit_sid" />
                                </div>
                                <br>&nbsp;
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">用户编号：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="applyCid" readonly="readonly"
                                           id="edit_cid" />
                                </div>
                                <br>&nbsp;
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请人：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="applyName"
                                           id="edit_applynName" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                                <div class="col-md-12"  style="padding: 10px 100px;">
                                    <label class="col-md-5 control-label"  style="line-height: 10px; text-align: right;">申请类型：</label>
                                    <div class="radio">
                                        <label> <input class="basic divtype cart_flag" type="radio"
                                                       id="edit_applyType_0" name="apply_type_edit" value="1" checked="checked"> <span
                                                class="text">增积分</span>
                                        </label>
                                        <label> <input class="basic divtype cart_flag" type="radio"
                                                       id="edit_applyType_1" name="apply_type_edit" value="2"> <span
                                                class="text">减积分</span>
                                        </label>
                                    </div>
                                </div>
                                <br/>&nbsp;
                                <div class="col-md-12"  style="padding: 10px 100px;">
                                    <label class="col-md-5 control-label"  style="line-height: 10px; text-align: right;">凭证类型：</label>
                                    <div class="radio">
                                        <label> <input class="basic divtype cart_flag" type="radio"
                                                       id="edit_sourceType_0" name="source_type_edit" value="1" checked="checked"> <span
                                                class="text">订单号</span>
                                        </label>
                                        <label> <input class="basic divtype cart_flag" type="radio"
                                                       id="edit_sourceType_1" name="source_type_edit" value="2"> <span
                                                class="text">退货单号</span>
                                        </label>
                                    </div>
                                </div>
                                <br/>&nbsp;
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">积分数量：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control"
                                           id="edit_applyNum"/>
                                    <span id="editApplyNum_msg" style="color:red;display:none;" class="edit_msg"></span>
                                </div>
                                <br>&nbsp;
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">订/退货单号：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control"
                                           id="edit_orderNo"/>
                                    <span id="editOrderNo_msg" style="color:red;display:none;" class="edit_msg">不能为空!</span>
                                </div>
                                <br>&nbsp;
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">申请理由：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control"
                                           id="edit_applyReason"/>
                                    <span id="editReason_msg" style="color:red;display:none;" class="edit_msg">不能为空!</span>
                                </div>
                                <br>&nbsp;
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">审核备注：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control"
                                           id="edit_checkMemo" readonly="readonly"/>
                                </div>
                                <br>&nbsp;
                            </div>

                        </div>
                        <br>&nbsp;
                        <div class="form-group">
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            <input class="btn btn-danger" onclick="submitIntegralApply();" style="width: 25%;"
                                   type="button" value="确认提交" />
                        </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
<!-- 审核积分申请-->
<div class="modal modal-darkorange"
     id="checkIntegralDiv">
    <div class="modal-dialog"
         style="width: 800px; height: auto; margin: 4% auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button" onclick="closeCheckApply();">×</button>
                <h4 class="modal-title">审核积分申请</h4>
            </div>
            <div class="page-body">
                <div class="row">
                    <form method="post" class="form-horizontal">
                        <input type="hidden" id="check_sid"/>
                        <div class="col-xs-12 col-md-12">
                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">审核人：</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name"
                                           id="checkName" />
                                    <span id="checkName_msg" style="color:red;display:none;" class="check_msg">不能为空!</span>
                                </div>
                                <br>&nbsp;
                            </div>

                            <div class="col-md-12"  style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">审核状态：</label>
                                <div class="radio">
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="check_status" value="1" checked="checked"> <span
                                            class="text">待审核</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="check_status" value="2"> <span
                                            class="text">通过</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="check_status" value="3"> <span
                                            class="text">驳回</span>
                                    </label>
                                    <label> <input class="basic divtype cart_flag" type="radio"
                                                   name="check_status" value="4"> <span
                                            class="text">取消</span>
                                    </label>
                                </div>
                            </div>


                            <div class="col-md-12" style="padding: 10px 100px;">
                                <label class="col-md-5 control-label"
                                       style="line-height: 20px; text-align: right;">审核备注：</label>
                                <div class="col-md-6">
                                    <input type="textarea" class="form-control" name="memo"
                                           id="check_memo" />
                                </div>
                                <br>&nbsp;
                            </div>

                        </div>
                        <br>&nbsp;
                        <div class="form-group">
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            <input class="btn btn-danger" onclick="checkIntegralApply();" style="width: 25%;"
                                   id="submitCheck" type="button" value="确定" />
                        </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
</body>
</html>
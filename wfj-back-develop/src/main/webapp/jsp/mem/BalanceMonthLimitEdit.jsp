<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${ctx}/js/jquery-1.9.1.js"></script>
    <script src="${ctx}/js/jquery.form.js"></script>
    <script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
    <title>商品基本信息</title>
    <script type="text/javascript">
        __ctxPath = "${pageContext.request.contextPath}";
        $(function(){
            $("#save").click(function(){
                var setupComplaintBal=$("#setupComplaintBal").val();
                var setupCarriageBal=$("#setupCarriageBal").val();
                setupComplaintBal = valStr(setupComplaintBal);
                setupCarriageBal = valStr(setupCarriageBal);
                $("#setupComplaintBal").val(setupComplaintBal);
                $("#setupCarriageBal").val(setupCarriageBal);
                var filter  = /^[0-9].*$/;
                if(filter.test(setupComplaintBal) && filter.test(setupCarriageBal)){
                    saveFrom();
                }else{
                    $("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!请输入数字</strong></div>");
                    $("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
                    return false;
                }

            });
            $("#close").click(function(){
                $("#pageBody").load(__ctxPath+"/jsp/mem/BalanceMonthLimit.jsp");
            });

        });
        function valStr(str){
            //先把非数字的都替换掉，除了数字和.
            str = str.replace(/[^\d.]/g, "");
            //必须保证第一个为数字而不是.
            str = str.replace(/^\./g, "");
            //保证只有出现一个.而没有多个.
            str = str.replace(/\.{2,}/g, ".");
            //保证.只出现一次，而不能出现两次以上
            str = str.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
            //保证.只后面只能出现两位有效数字
            str = str.replace(/([0-9]+\.[0-9]{2})[0-9]*/, "$1");
            return str;
        }


        //保存数据
        function saveFrom(){
            $.ajax({
                type:"post",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                url:__ctxPath + "/balanceMonthLimit/update",
                dataType: "json",
                data: $("#theForm").serialize(),

                success:function(response) {
                    if(response.code == "1"){
                        $("#modal-body-success").html("<div class='alert alert-success fade in'>"+
                                "<i class='fa-fw fa fa-times'></i><strong>修改成功，返回列表页!</strong></div>");
                        $("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
                    }else{
                        $("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.desc+"</strong></div>");
                        $("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
                    }
                }
            });
        }
        function successBtn(){
            $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
            $("#pageBody").load(__ctxPath+"/jsp/mem/BalanceMonthLimit.jsp");
        }
    </script>
</head>
<body>
<input type="hidden" id="contentSid1" value="${param.contentSid }"/>
<div class="page-body">
    <div class="row">
        <div class="col-lg-12 col-sm-12 col-xs-12">
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <div class="widget radius-bordered">
                        <div class="widget-header">
                            <span class="widget-caption">修改</span>
                        </div>
                        <div class="widget-body">
                            <form id="theForm" method="post" class="form-horizontal">
                                <input type="hidden" id="sid" name="sid" value="${param.sid }"/>
                                <input type="hidden" id="yearSid" name="yearSid" value="${param.yearSid }">
                                <input type="hidden" id="usableMonthcptBal" name="usableMonthcptBal" value="${param.usableMonthcptBal }">
                                <input type="hidden" id="usedMonthcptBal" name="usedMonthcptBal" value="${param.usedMonthcptBal }">
                                <input type="hidden" id="usableMonthcrgBal" name="usableMonthcrgBal" value="${param.usableMonthcrgBal }">
                                <input type="hidden" id="usedMonthcrgBal" name="usedMonthcrgBal" value="${param.usedMonthcrgBal }">
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">投诉补偿额度</label>
                                    <div class="col-lg-6">
                                        <input type="text" class="form-control" id="setupComplaintBal" maxlength="10" value="${param.setupComplaintBal }" name="setupComplaintBal" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">运费补偿额度</label>
                                    <div class="col-lg-6">
                                        <input type="text" class="form-control" id="setupCarriageBal" maxlength="10" value="${param.setupCarriageBal }" name="setupCarriageBal" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">年月份</label>
                                    <div class="col-lg-6">
                                        <input type="text" class="form-control" id="yearMonth" value="${param.yearMonth }" name="yearMonth" readonly="readonly"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-offset-4 col-lg-6">
                                        <input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
                                        <input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消" />
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /Page Body -->
<script>
</script>
</body>
</html>
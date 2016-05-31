<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${ctx}/js/jquery-1.9.1.js"></script>
    <script src="${ctx}/js/jquery.form.js"></script>
    <script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
    <title></title>
    <script type="text/javascript">
        __ctxPath = "${pageContext.request.contextPath}";
        $(function(){
            $("#save").click(function(){
                var setupComplaintBal=$("#setupComplaintBal").val();
                var setupCarriageBal=$("#setupCarriageBal").val();
                var filter  = /^[0-9].*$/;
                if(filter.test(setupComplaintBal) && filter.test(setupCarriageBal)){
                    saveFrom();
                }else{
                    alert("请输入正数！");
                    return false;
                }

            });
            $("#close").click(function(){
                $("#pageBody").load(__ctxPath+"/jsp/mem/balanceApply.jsp");
            });
        });

        //保存数据
        function saveFrom(){
            $.ajax({
                type:"post",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                url:__ctxPath + "/balanceMonthLimit/insert",
                dataType: "json",
                data: $("#theForm").serialize(),

                success:function(response) {
                    console.log(response);
                    if(response.code == "1"){
                        $("#modal-body-success").html("<div class='alert alert-success fade in'>"+
                                "<i class=''></i><strong>添加成功，返回列表页!</strong></div>");
                        $("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
                    }else{
                        $("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.desc+"</strong></div>");
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
<div class="page-body">
    <div class="row">
        <div class="col-lg-12 col-sm-12 col-xs-12">
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <div class="widget radius-bordered">
                        <div class="widget-header">
                            <span class="widget-caption">新增余额申请</span>
                        </div>
                        <div class="widget-body">
                            <form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">客户登录账号</label>
                                    <div class="col-lg-4">
                                        <input type="text" class="form-control" id="memberAccount" name="memberAccount" placeholder="必填"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">申请类型</label>
                                    <div class="col-lg-4">
                                        <select name="applyType" class="form-control">
                                            <option value="0">运费补偿</option>
                                            <option value="1">投诉补偿</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">凭证类型</label>
                                    <div class="col-lg-4">
                                        <select name="applyType" class="form-control">
                                            <option value="0">子订单号</option>
                                            <option value="1">退换货单号</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">凭证单号</label>
                                    <div class="col-lg-4">
                                        <input type="text" class="form-control" id="voucherNum" name="voucherNum" placeholder="必填"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">余额金额</label>
                                    <div class="col-lg-4">
                                        <input type="text" class="form-control" id="money" name="money" placeholder="必填"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">申请理由</label>
                                    <div class="col-lg-4">
                                        <textarea type="text" class="form-control" id="applyReason" name="applyReason" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-offset-4 col-lg-6">
                                        <input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
                                        <input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消"/>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    request.setAttribute("ctx", request.getContextPath());
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
__ctxPath = "${pageContext.request.contextPath}";
$(function () {

    $("#sid").val(sid);
    $("#groupSid").val(groupSid_);
    $("#shoppeCode").html(shoppeCode_);
    var shoppeTypeText = "";
    if(typeof(shoppeType_) != "undefined"){
        if(shoppeType_ == '01'){
            shoppeTypeText = "全渠道单品专柜";
        }
        if(shoppeType_ == '02'){
            shoppeTypeText = "非全渠道单品专柜";
        }
    }
    $("#shoppeType").html(shoppeTypeText);
    $("#shoppeName").html(shoppeName_);
    if(floorCode_ != "[object Object]"){
        $("#floorCode").html(floorCode_);
    }
    if(floorName_ != "[object Object]"){
        $("#floorName").html(floorName_);
    }
    $("#supplyName").html(supplyName_);
    $("#supplyCode").html(supplyCode_);
    var shoppeStatusText = "";
    if(typeof(shoppeStatus_) != "undefined"){
        if(shoppeStatus_ == 1){
            shoppeStatusText = "正常";
        }
        if(shoppeStatus_ == 2){
            shoppeStatusText = "停用";
        }
        if(shoppeStatus_ == 3){
            shoppeStatusText = "撤销";
        }
    }
    $("#shoppeStatus").html(shoppeStatusText);
    $("#shopSid").html(shopName_);
    $("#shopSidHidden").val(shopSid_);
    $("#shopCode").html(shopCode_);
    var industryConditionSidText = "";
    if(typeof industryConditionSid_ != "undefined"){
        if(industryConditionSid_ == 0){
            industryConditionSidText = "百货";
        }
        if(industryConditionSid_ == 1){
            industryConditionSidText = "超市";
        }
        if(industryConditionSid_ == 2){
            industryConditionSidText = "电商";
        }
    }
    $("#industryConditionSid").html(industryConditionSidText);
    var goodsManageTypeTxt = "";
    if(typeof (goodsManageType_) != "undefined"){
        if(goodsManageType_ == 0){
            goodsManageTypeTxt = "是";
        }
        if(goodsManageType_ == 1){
            goodsManageTypeTxt = "否";
        }
    }
    $("#goodsManageType").html(goodsManageTypeTxt);
    var isShippingPointText = "";
    if(typeof isShippingPoint_ != "undefined"){
        if(isShippingPoint_ == 0){
            isShippingPointText = "是";
        }
        if(isShippingPoint_ == 1){
            isShippingPointText = "否";
        }
    }
    $("#isShippingPoint").html(isShippingPointText);
    $("#shoppeShippingPoint").html(shoppeShippingPoint_);
    $("#shoppeShippingPoint").html(shoppeShippingPointName_);
    var negativeStockText = "";
    if(typeof negativeStock_ != "undefined"){
        if(negativeStock_ == 0){
            negativeStockText = "允许";
        }
        if(negativeStock_ == 1){
            negativeStockText = "不允许";
        }
    }
    $("#negativeStock").html(negativeStockText);
    $("#createName").val(createName_);

    //查询集货地点
    $.ajax({
        type : "post",
        contentType : "application/x-www-form-urlencoded;charset=utf-8",
        url : __ctxPath + "/shoppe/queryShoppeShippingPoint",
        dataType : "json",
        async : true,
        data : "storeCode=" + shopCode_,
        success : function(response) {
            var result = response.list;
            if(typeof(result) != "undefined"){
                for (var i = 0; i < result.length; i++) {
                    var ele = result[i];
                    if(shoppeShippingPoint_ == ele.warehouse_id){
                        $("#shoppeShippingPoint").html(ele.warehouse_name);
                    }
                }
            }
            return;
        },
        error : function(XMLHttpRequest, textStatus) {
            var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
            if(sstatus != "sessionOut"){
                $("#warning2Body").text(buildErrorMessage("","系统出错！"));
                $("#warning2").show();
            }
            if(sstatus=="sessionOut"){
                $("#warning3").css('display','block');
            }
        }
    });

    $("#close").click(function () {
        $("#pageBody").load(__ctxPath + "/jsp/organization/shoppeView.jsp");
    });
});

function successBtn() {
    $("#modal-success").attr({"style": "display:none;", "aria-hidden": "true", "class": "modal modal-message modal-success fade"});
    $("#pageBody").load(__ctxPath + "/jsp/organization/shoppeView.jsp");
}

$(function () {
    $.ajax({
        type: "post",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        url: __ctxPath + "/shoppe/queryChannelListByShoppeSid",
        async: false,
        data: {
            "shoppeSid": $("#sid").val()
        },
        dataType: "json",
        success: function (response) {
            var result = response.list;
            if (result == null) return;
            for (var i = 0; i < result.length; i++) {
                var ele = result[i];
                var option = "<tr id='channelTableTr_" + ele.channelCode + "'>"
                           + "<td align='center' name='channelName'>" + ele.channelName + "</td>"
                           + "</tr>";
                $("#channelTable tbody").append(option);
            }
            $("input[name='channelCheckboxCode']").each(function (i) {
                $("#channelOption_" + $(this).val()).hide();
            });
            return;
        }
    });

});
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
    <span class="widget-caption">专柜详情</span>
</div>
<div class="widget-body">
<form id="theForm" method="post" class="form-horizontal">
<input type="hidden" id="channelCode" name="channelCode"/>
<input type="hidden" id="sid" name="sid"/>
<input type="hidden" id="groupSid" name="groupSid"/>
<input type="hidden" id="shopSidHidden" name="shopSid"/>
<input type="hidden" id="supplySidHidden" name="supplySid"/>
<input type="hidden" id="shoppeTypeHidden" name="shoppeType"/>
<input type="hidden" name="userName" value=""/>
<input type="hidden" id="createName" name="createName"/>
<input type="hidden" name="optUser" value=""/>
<script type="text/javascript">
	$("input[name='userName']").val(getCookieValue("username"));
	$("input[name='optUser']").val(getCookieValue("username"));
</script>

<div class="form-group">
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-2">
        <label class="col-lg-6 col-sm-6 col-xs-6 control-label">门店名称：</label>
        <div class="col-lg-5 col-sm-5 col-xs-5">
            <label class="control-label" id="shopSid"></label>
        </div>
    </div>
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-1">
        <label class="col-lg-4 col-sm-4 col-xs-4 control-label">门店编码：</label>
        <div class="col-lg-8 col-sm-8 col-xs-8">
            <label class="control-label" id="shopCode"></label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-2">
        <label class="col-lg-6 col-sm-6 col-xs-6 control-label">楼层名称：</label>
        <div class="col-lg-5 col-sm-5 col-xs-5">
            <label class="control-label" id="floorName"></label>
        </div>
    </div>
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-1">
        <label class="col-lg-4 col-sm-4 col-xs-4 control-label">楼层编码：</label>
        <div class="col-lg-8 col-sm-8 col-xs-8">
            <label class="control-label" id="floorCode"></label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-2">
        <label class="col-lg-6 col-sm-6 col-xs-6 control-label">专柜名称：</label>
        <div class="col-lg-5 col-sm-5 col-xs-5">
            <label class="control-label" id="shoppeName"></label>
        </div>
    </div>
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-1">
        <label class="col-lg-4 col-sm-4 col-xs-4 control-label">专柜编码：</label>
        <div class="col-lg-8 col-sm-8 col-xs-8">
            <label class="control-label" id="shoppeCode"></label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-2">
        <label class="col-lg-6 col-sm-6 col-xs-6 control-label">供应商名称：</label>
        <div class="col-lg-5 col-sm-5 col-xs-5">
            <label class="control-label" id="supplyName"></label>
        </div>
    </div>
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-1">
        <label class="col-lg-4 col-sm-4 col-xs-4 control-label">供应商编码：</label>
        <div class="col-lg-8 col-sm-8 col-xs-8">
            <label class="control-label" id="supplyCode"></label>
        </div>
    </div>
</div>

<div class="form-group">
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-2">
        <label class="col-lg-6 col-sm-6 col-xs-6 control-label">业态：</label>
        <div class="col-lg-5 col-sm-5 col-xs-5">
            <label class="control-label" id="industryConditionSid"></label>
        </div>
    </div>
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-1">
        <label class="col-lg-4 col-sm-4 col-xs-4 control-label">是否负库存销售：</label>
        <div class="col-lg-8 col-sm-8 col-xs-8">
            <label class="control-label" id="negativeStock"></label>
        </div>
    </div>
</div>
<%--<div class="form-group">
    <div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
        <label class="col-lg-5 col-sm-5 col-xs-5 control-label">
            要约号：
        </label>
        <div class="col-lg-6 col-sm-6 col-xs-6">
            <select class="form-control" id="brandSid" name="brandSid">
                <option value="">请选择</option>
            </select>
        </div>
    </div>
</div>--%>
<div class="form-group">
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-2">
        <label class="col-lg-6 col-sm-6 col-xs-6 control-label">专柜状态：</label>
        <div class="col-lg-5 col-sm-5 col-xs-5">
            <label class="control-label" id="shoppeStatus"></label>
        </div>
    </div>
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-1">
        <label class="col-lg-4 col-sm-4 col-xs-4 control-label">专柜类型：</label>
        <div class="col-lg-8 col-sm-8 col-xs-8">
            <label class="control-label" id="shoppeType"></label>
        </div>
    </div>
</div>

<div class="form-group" id="isShippingPoint_div">
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-2">
        <label class="col-lg-6 col-sm-6 col-xs-6 control-label">是否有集货地点：</label>
        <div class="col-lg-5 col-sm-5 col-xs-5">
            <label class="control-label" id="isShippingPoint"></label>
        </div>
    </div>
    <div class="col-lg-4 col-sm-4 col-xs-4 col-lg-offset-1">
        <label class="col-lg-4 col-sm-4 col-xs-4 control-label">集货地点：</label>
        <div class="col-lg-8 col-sm-8 col-xs-8">
            <label class="control-label" id="shoppeShippingPoint"></label>
        </div>
    </div>
</div>

<div class="col-md-10" style="width:500px;margin:0 220px;">
    <h5>
        <strong>渠道</strong>
    </h5>
    <hr class="wide" style="margin-top: 0;">
</div>
<div class="col-md-12" style="width:500px;margin:0 220px;padding-left:0">
    <div class="col-md-12" id="baseDivTable">
        <table id="channelTable"
               class="table table-bordered table-striped table-condensed table-hover flip-content">
            <thead class="flip-content bordered-darkorange">
            <tr>
                <th style="text-align: center;" id="">渠道</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    &nbsp;
</div>

<div class="form-group">
    <div class="col-lg-offset-4 col-lg-6">
        <input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="返回"/>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
__ctxPath = "${pageContext.request.contextPath}";
var stockPagination;
$(function(){

    $("#channelName").val(channelName_);
    $("#channelSid").val(channelSid_);
    $("#productCodeSid").val(productCode_);
    $("#productCode").val(productCode_);
    $("#stockName_").val(stockName_);

    $("#saleStock").val(saleStock_);
    $("#edefectiveStock").val(edefectiveStock_);
    $("#returnStock").val(returnStock_);
    $("#lockedStock").val(lockedStock_);

    $("#stockSid").val(stockSid);
    $("#productSku_").val(productSku_);
    $("#proColorName_").val(proColorName_);
    $("#proStanName_").val(proStanName_);
    $("#proSum_").val(proSum_);
    $("#brandName_").val(brandName_);
    $("#supplyName_").val(supplyName_);
    $("#shopName_").val(shopName_);
    $("#productDetailSid_").val(productDetailSid_);

    initStock();

    $("#stockName").change(stockQuery);
    function stockQuery() {
// 			$("#stockName_from").val($("#shoppeName").val());
        $.ajax({
            type : "post",
            url : __ctxPath + "/stockWei/selectStockWei",
            dataType : "json",
            data : {
                "channelSid":$("#channelSid").val(),
                "supplyProductId":$("#productCode").val()
            },
            async:false,
            success : function(response) {
                var result = response.data;
                for ( var i = 0; i < result.length; i++) {
                    var ele = result[i];
                    if(ele.stockTypeSid == $("#stockName").val()){
                        $("#proSum").val(ele.proSum);
                    }
                }

                return;
            }
        });
        //数量
        $("#proSum").val();
        //穿衣库位变动
        $("#stock_select").empty();
        var option = "<option value='-1'>请选择</option>";
        if($("#stockName").val()=='1001'){
            option += "<option value='1002'>残次品库</option>";
        }else if($("#stockName").val()=='1002'){
            option += "<option value='1001'>可售库</option>";
        }else if($("#stockName").val()=='1003'){
            option += "<option value='1001'>可售库</option>";
            option += "<option value='1002'>残次品库</option>";
        }

        $("#stock_select").append(option);
    }
    $("#save").click(function(){
        if($("#stockName").val()==""){
            $("#warning2Body").text(buildErrorMessage("","请选择原库位！"));
            $("#warning2").show();
            return false;
        }else{
            saveFrom();
        }
    });
    $("#close").click(function(){
        $("#pageBody").load(__ctxPath+"/jsp/stock/StockView.jsp");
    });

});

//add追加
var count=100;
// 追加新的SKU
function addSku(){
    var proStockName= $("#stock_select").val();// 库位id
    var proStockNameText = "";
    if(proStockName != -1){
        proStockNameText = $("#stock_select").find("option:selected").text();// 库位文本
    }
    var option = "";
    if(proStockName==-1){
        $("#warning2Body").text("转移库位必选!");
        $("#warning2").show();
        return;
    }
    if($("#stockNumber").val().trim()==""){
        $("#warning2Body").text("转移数量必填!");
        $("#warning2").show();
        return;
    }
    if($("#stockNumber").val().trim()==0){
        $("#warning2Body").text("转移数量不能为0!");
        $("#warning2").show();
        return;
    }
    option = "<tr id='baseTableTr_"+proStockName+"'><td style='text-align: center;'>"+
            "<div class='checkbox'>"+
            "<label style='padding-left: 5px;'>"+
            "<input type='checkbox' id='baseTableTd_proStockName_"+proStockName+"' value='"+proStockName+"'  name='baseTableTd_proColorSid'>"+
            "<span class='text'></span>"+
            "</label>"+
            "</div></td>"+
            "<td style='text-align: center;'>"+proStockNameText+"</td>"+
            "<td style='text-align: center;' name='baseTableTd_stockNumber'>"+$("#stockNumber").val().trim()+"</td></tr>";
    $("#baseTable tbody").append(option);
    $("#baseDivTable").show();
    $("#stock_select").val("");
    $("#stockNumber").val("");
    return;
}
// 删除选中的SKU
function deleteSku(){
    $("input[type='checkbox']:checked").each(function(){
        $("#baseTableTr_"+$(this).val()).remove();
    });
    return;
}

function initStock() {
    var a = $("#channelSid").val();
    var b = $("#productCode").val();
    var url =  __ctxPath + "/stockWei/selectStockWei";
    stockPagination = $("#stockPagination").myPagination(
            {
                ajax : {
                    on : true,
                    url : url,
                    dataType : 'json',
                    param:'channelSid='+a+'&supplyProductId='+b,
                    ajaxStart : function() {
                        ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
                    },
                    ajaxStop : function() {
                        //隐藏加载提示
                        setTimeout(function() {
                            ZENG.msgbox.hide();
                        }, 300);
                    },
                    callback : function(response) {
                        var result = response.data;
//						$("#stockName").val("");
                        var option = "<option value=''>请选择</option>";
                        for ( var i = 0; i < result.length; i++) {
                            var ele = result[i];
                            option += "<option value='"+ele.stockTypeSid+"'>" + ele.stockName
                                    + "</option>";

                        }
                        $("#stockName").append(option);
                        return;
                    }
                }
            });
}
// 库位json
function skuJson(){
    var stocks = new Array();// 色系
    var numbs = new Array();// 色码
    $("input[name='baseTableTd_proColorSid']").each(function(){
        stocks.push($(this).val());
    });
    $("td[name='baseTableTd_stockNumber']").each(function(){
        numbs.push($(this).html().trim());
    });
    var json = new Array();
    for(var i=0;i<stocks.length;i++){
        json.push({
            'stockTypeSid' : stocks[i],
            'proSum' : numbs[i]
        });
    }
    var inT = JSON.stringify(json);
    inT = inT.replace(/\%/g, "%25");
    inT = inT.replace(/\#/g, "%23");
    return inT;
}

function saveFrom(){
    var inT = skuJson();
    if(inT=='[]'){
        $("#warning2Body").text("未添加库位！");
        $("#warning2").show();
        return;
    }
    $("#stockInfo").html(inT);
    $.ajax({
        type: "post",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        url: __ctxPath + "/stockWei/saveStockWei",
        dataType:"json",
        data: $("#theForm").serialize(),
        success: function(response) {
            if(response.success=="true"){
                $("#modal-body-success").html("<div class='alert alert-success fade in'><strong>保存成功，返回列表页!</strong></div>");
                $("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
            }else{
                $("#warning2Body").text(response.data.errorMsg);
                $("#warning2").show();
            }
            return;
        },
        error: function(XMLHttpRequest, textStatus) {
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
}

function successBtn(){
    $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
    $("#pageBody").load(__ctxPath+"/jsp/stock/StockView.jsp");
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
    <span class="widget-caption">渠道内库存修改</span>
</div>
<div class="widget-body">

<!-- BaseMessage start -->
    <form id="theForm" method="post" class="form-horizontal">
        <input type="hidden" id="productCodeSid" name="sid" />
        <input type="hidden" id="channelSid" name="channelSid" />
        <div class="form-group">
            <div class="col-md-6">
                <label class="col-lg-3 control-label">渠道</label>
                <div class="col-lg-6">
                    <input type="text" class="form-control" disabled="disabled" id="channelName" name="channelName" placeholder="必填"/>
                </div>
            </div>
            <div class="col-md-6">
                <label class="col-lg-3 control-label">专柜商品编码</label>
                <div class="col-lg-6">
                    <input type="text" class="form-control" disabled="disabled" id="productCode" name="productCode" placeholder="必填"/>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-6">
                <label class="col-lg-3 control-label">原库位</label>
                <div class="col-lg-6">
                    <select class="form-control" id="stockName" name="stockName"></select>
                </div>
            </div>
            <div class="col-md-6">
                <label class="col-lg-3 control-label">数量</label>
                <div class="col-lg-6">
                    <input type="text" class="form-control" id="proSum" name="proSum" readonly="readonly" />
                </div>
            </div>
        </div>

        <div class="form-group">
            <!-- <form id="baseForm" method="post" class="form-horizontal"> -->
            <div class="col-md-12">
                <h5><strong>库存转移</strong></h5>
                    <hr class="wide" style="margin-top: 0;">
                    <div class="col-md-4">
                        <label class="col-md-4 control-label">转移库位</label>
                        <div class="col-md-8">
                            <select class="form-control" id="stock_select" name="stock_select">
                                <option value="-1">请选择</option>
                                <option value="1001">可售库</option>
                                <option value="1003">退货库</option>
                                <option value="1002">残次品库</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4" id="colorCodeDiv">
                        <label class="col-md-4 control-label">转移数量</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control"
                                   onkeyup="value=value.replace(/[^0-9- ]/g,'');"
                                   oninput="value=value.replace(/[^0-9- ]/g,'');"
                                   maxLength=20
                                   id="stockNumber" name="stockNumber" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="col-md-12 buttons-preview">
                            <a class="btn btn-default" id="addSku" onclick="addSku();">添加</a>&nbsp;
                            <a class="btn btn-danger" id="deleteSku" onclick="deleteSku();">删除</a>
                        </div>&nbsp;
                    </div>
            </div>
            <div class="col-md-12">
                <div class="col-md-12" id="baseDivTable">
                    <table id="baseTable" class="table table-bordered table-striped table-condensed table-hover flip-content">
                        <thead class="flip-content bordered-darkorange">
                        <tr>
                            <th width="50px;"></th>
                            <th style="text-align: center;" id="baseTableTh_1">转移库位</th>
                            <th style="text-align: center;" id="baseTableTh_2">转移数量</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>&nbsp;
            </div>
            <!-- </form> -->
        </div>
        <div style="display: none;">
            <textarea id="stockInfo" name="stockInfo"></textarea>
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
</body>
</html>
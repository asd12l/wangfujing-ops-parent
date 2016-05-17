/**
 * 公共JS, 站点信息
 */
var siteSid = "";
var siteName = "";
//关闭弹窗
function closeDiv(obj) {
    clearInput();
    $(".modal-darkorange").hide();
}
/**
 * 2016-03-09 10:28:38
 * 非预览页关闭需清理
 * @param obj
 */
function closeShowDiv(obj) {
    clearInput();
    $(obj).parent().parent().parent().hide();
}
/**
 * 2016-03-09 10:28:06
 * 预览页关闭不清理
 * @param obj
 */
function closeShowDiv_NC(obj) {
    $(obj).parent().parent().parent().hide();
}

$(function() {
    $.ajax({
        type: "post",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        url: __ctxPath + "/site/getSiteList",
        dataType: "json",
        success: function(data) {
            $("#site_list").html("");
            for (i = 0; i < data.list.length; i++) {
                if (_site_id_param == '') {
                    var opt = $('<option code=' + data.list[i].channelCode + ' data=' + data.list[i].domain + ' value=' + data.list[i].id + '>' + data.list[i].name + '</option>');
                    $("#site_list").append(opt);
                } else {
                    if (_site_id_param == data.list[i].id) {
                        var opt = $('<option selected="selected" code=' + data.list[i].channelCode + ' data=' + data.list[i].domain + ' value=' + data.list[i].id + '>' + data.list[i].name + '</option>');
                        $("#site_list").append(opt);
                    } else {
                        var opt = $('<option code=' + data.list[i].channelCode + ' data=' + data.list[i].domain + ' value=' + data.list[i].id + '>' + data.list[i].name + '</option>');
                        $("#site_list").append(opt);
                    }
                }
            }
            if (_site_id_param == '') {
                siteSid = $("#site_list").val();
            } else {
                siteSid = _site_id_param;
            }
            _site_id_param = "";
            siteName = $('#site_list  option:selected').attr("data");
            channelCode = $('#site_list  option:selected').attr("code");
            $("#channelCode_from").val(channelCode);
            initTree();
        }
    });
});

// 弹出框弹出前清空
function clearDivForm() {
    $("form input[text]").val("");
}
function clearInput() {
    $(".clear_input").val("");
}

$("#site_list").change(function() {
    siteSid = $("#site_list").val();
    siteName = $('#site_list  option:selected').attr("data");
    initTree();
});
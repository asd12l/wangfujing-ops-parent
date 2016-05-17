function searchSupplier(storeCode, prefix){
    var dataUl = $("#dataList_hidden ul:eq(0)");
    $.ajax({
        type: "post",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        url: __ctxPath+"/supplierDisplay/findListSupplierBySearch",
        dataType: "json",
        data: {
            "storeCode" : storeCode,
            "prefix" : prefix
        },
        success: function(response) {
            dataUl.html("");
            if(response.success == "true"){
                var dataList = response.list;
                for(var i=0; i<dataList.length; i++){
                    var data = dataList[i];
                    var li = "<li sid='" + data.sid + "' supplierCode='" + data.supplierCode
                        + "' organizationCode='" + data.storeCode + "' businessPattern='" + data.businessPattern + "'>"
                        + data.supplierName + "</li>";
                    dataUl.append(li);
                }
                $("#dataList_hidden").show();
                liClick();
            }
        }
    });
}
function liClick(){
    $("#dataList_hidden ul li").click(function(){
        var option = "<option value='" + $(this).attr("sid") + "' organizationCode='" + $(this).attr("organizationCode")
            + "' businessPattern='" + $(this).attr("businessPattern") + "'>" + $(this).text() + "</option>";
        $("#supplySid").html(option);
        $("#supplySid_input").val($(this).text());
        $("#dataList_hidden").hide();
        $("#supplySid").change();
    });
}
$(function(){
    /*$("#supplySid_input").blur(function(){
     if(!$("#dataList_hidden").focus()){
     $("#dataList_hidden").hide();
     }
     });*/
});

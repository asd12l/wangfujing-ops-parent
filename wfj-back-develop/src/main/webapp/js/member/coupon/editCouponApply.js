
$(function(){
	initsEdit();
});

/**
 * 关闭优惠券编辑
 */
$("#closeEditCoupon").click(function(){
	$("#pageBody").load(__ctxPath+"/jsp/mem/CouponApplyView.jsp");
});
 function initsEdit(){
     $("#editSid").val($sid);
     $("#login_name").val($loginName);
     if(null!=$applyType){
    		 $("#apply_type_"+$applyType).attr("checked",true);
     }else{
    	 $("#apply_type_1").attr("checked",true);
     }
	var s = "";
     if(null != $sourceType){
    	 if($sourceType == 1){
        	 s = "<option id='"+$sourceType+"'>订单号</option>";
    	 }else{
           	 s = "<option id='"+$sourceType+"'>退货单号</option>";
    	 }
     }else{
    	 s = "<option id='"+$sourceType+"'>订单号</option>";
     }
     $("#source_type").append(s);
     $("#coupon_template").val($couponTemplate);
     $("#coupon_type").val($couponType);
     $("#coupon_batch").val($couponBatch);
     $("#coupon_name").val($couponName);
     $("#coupon_memo").val($conponMemo);
     $("#apply_reason").val($applyReason);		//缺少优惠券金额
 }
 
 /**
  * 修改优惠券申请
  */
$("#saveEditCoupon").click(function(){
		var sid = $("#editSid").val().trim();
		var loginName = $("#login_name").val().trim();
	    var applyType = $('input[name="apply_type"]').filter(':checked').val();			//var applyType = $("#apply_type").val().trim(); 
		var sourceType = $("#source_type").val().trim();
		var coupenTemplate = $("#coupon_template").val().trim();
		var couponType = $("#coupon_type").val().trim();
		var couponBatch = $("#coupon_batch").val().trim();
		var couponName = $("#coupon_name").val().trim();
		var couponMemo = $("#coupon_memo").val().trim();
		/*var couponMonay = $("#couponMonay").val().trim();*/
		var applyReason = $("#apply_reason").val().trim();
		
		
        var url = __ctxPath+"/memCoupon/updateCouponApply";
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
            data :{
            		"sid":sid,
            		"loginName":loginName,
            		"applyType":applyType,
            		"sourceType":sourceType,
            		"coupenTemplate":coupenTemplate,
            		"couponBatch":couponBatch,
            		"couponType":couponType,
            		"couponName":couponName,
            		"couponMemo":couponMemo,
            		"applyReason":applyReason
            },
            success : function(response) {
                if (response.code == "1") {
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
                    $("#addIntegralDiv").hide();

                } else {
                    $("#model-body-warning")
                            .html(
                            "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.desc+"</strong></div>");
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

});
 
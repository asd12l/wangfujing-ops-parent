
	/**
	 * 关闭新建优惠券页面
	 */
	$("#closeNewCoupon").click(function(){
		$("#pageBody").load(__ctxPath+"/jsp/mem/CouponApplyView.jsp");
	});
	
	/**
	 * 插入新优惠券申请
	 */
	$("#saveNewCoupon").click(function(){
		saveNewCouponParam();
	});
	
	function saveNewCouponParam(){
		var loginName = $("#login_name").val().trim();
		var applyType = $('input[id="apply_type"]').filter(':checked').val();			//		var applyType = $("#apply_type").val().trim(); 
		var sourceType = $("#source_type").val().trim();
		var coupenTemplate = $("#coupon_template").val().trim();
		var couponType = $("#coupon_type").val().trim();
		var couponBatch = $("#coupon_batch").val().trim();
		var couponName = $("#coupon_name").val().trim();
		var couponMemo = $("#coupon_memo").val().trim();
		var couponMonay = $("#couponMonay").val().trim();
		var applyReason = $("#apply_reason").val().trim();
		
		
        var url = __ctxPath+"/memCoupon/saveNewCouponApply";
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
                    		"loginName":loginName,
                    		"applyType":applyType,
                    		"sourceType":sourceType,
                    		"coupenTemplate":coupenTemplate,
                    		"couponBatch":couponBatch,
                    		"couponType":couponType,
                    		"couponName":couponName,
                    		"couponMemo":couponMemo,
                    		"couponMonay":couponMonay,
                    		"applyReason":applyReason,
                    		"checkStatus":"1",
                    },
                    success : function(response) {
                        if (response.code == "1") {
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

	}
	

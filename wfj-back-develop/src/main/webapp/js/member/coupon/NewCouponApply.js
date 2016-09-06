
	/**
	 * validate校验返回validate对象。
	 */
	function validateVal(){
		return $("#saveForm").validate({
			rules:{
				login_name:"required",
				coupon_template:"required",
				coupon_batch:"required",
				couponMonay:{
					required:true,
				 	number:true
				},
				apply_reason:"required"
			},
			messages:{
				login_name:"请输入客户登陆账号",
				coupon_template:"请选择优惠券模板",
				coupon_batch:"请选择优惠券批次",
				couponMonay:{
					required:"请输入优惠券金额",
					number:"请输入正确的数字形式"
				},
				apply_reason:"请输入申请理由"
			}
		});
	}
	
	/**
	 * 关闭新建优惠券页面
	 */
	$("#closeNewCoupon").click(function(){
		$("#pageBody").load(__ctxPath+"/jsp/mem/CouponApplyView.jsp");
	});
	
	$().ready(function() {
		/**
		 * 添加新建优惠券
		 */
	  	$("#saveNewCoupon").click(function(){
			if(validateVal().form()){
				saveNewCouponParam();
			}else{
				return;
			}
		});
	});

	//data commit.
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
                                            "loading-inactive");
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
	

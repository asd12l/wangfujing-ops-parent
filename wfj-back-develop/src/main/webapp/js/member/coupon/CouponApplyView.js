
	var olvPagination;
	$(function() {
	    $("#reservationAp").daterangepicker();
	    $("#reservationCh").daterangepicker();
	    $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	    //initOlv();
	    initCouponApply();
	});
    
	/**
	 * 条件查询
	 */
    function query() {
        $("#cache").val(0);
        QueryCoupon();
    }
   
    /**
     * 重置表单
     */
    function reset(){
        $("#cache").val(1);
        $("#login_name").val("");
        $("#sid").val("");
        $("#order_input").val("");
        $("#applyName_input").val("");
        $("#reservationAp").val("");
        $("#reservationCh").val("");
        //productQuery();
        QueryCoupon();
    }

	/**
	 * 初始化优惠价申请
	 */
	function initCouponApply() {
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
	                $("#loading-container").attr("class","loading-container");
	            },
	            ajaxStop : function() {
	            	setTimeout(function() {
	            		$("#loading-container").addClass("loading-inactive");
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
	
	
	/**
	 * 根据条件查询优惠券申请信息
	 */
    function QueryCoupon(){
        $("#login_from").val($("#login_name").val());
        $("#sid_from").val($("#sid").val());
        $("#order_from").val($("#order_input").val());
        var strApTime = $("#reservationAp").val();
        if(strApTime!=""){
            strApTime = strApTime.split("- ");
            $("#m_timeApStartDate_form").val(strApTime[0].replace("/","-").replace("/","-"));
            $("#m_timeApEndDate_form").val(strApTime[1].replace("/","-").replace("/","-"));
        }else{
            $("#m_timeApStartDate_form").val("");
            $("#m_timeApEndDate_form").val("");
        }
        var strChTime=$("#reservationCh").val();
        if(strChTime!=""){
            strChTime = strChTime.split("- ");
            $("#m_timeChStartDate_form").val(strChTime[0].replace("/","-").replace("/","-"));
            $("#m_timeChEndDate_form").val(strChTime[1].replace("/","-").replace("/","-"));
        }else{
            $("#m_timeChStartDate_form").val("");
            $("#m_timeChEndDate_form").val("");
        }
        $("#applyName_from").val($("#applyName_input").val());
        ;
       $("#check_Status").val($("#checkStatus").val());
        var params = $("#product_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
    }	
    
    
    /**
     * 查看优惠券申请
     */
    function showCouPonDetail(){

        $(".edit_msg").hide();
        //回显
        var checkboxArray=[];
        $("input[type='checkbox']:checked").each(function(i,team){
            var sid=$(this).val();
            checkboxArray.push(sid);
        });
        if (checkboxArray.length > 1) {
            $("#warning2Body").text("只能选择一条优惠券申请记录!");
            $("#warning2").show();
            return;
        } else if (checkboxArray.length == 0) {
            $("#warning2Body").text("请选择要编辑的优惠券申请!");
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
       emptyProperty();
        $sid = value;
        $applyCid = $("#apply_cid_"+value).text().trim();
        $loginName = $("#login_name_"+value).text().trim();
        var apptype = $("#apply_type_"+value).text().trim();
        if(apptype == '服务投诉补偿'){
        	$applyType = 1;
        }else if(apptype == "外呼关怀回访"){
        	$applyType = 2;
        }else{
        	$applyType = 3;
        }
        
        var sourceType= $("#source_type_"+value).text().trim();
        if(sourceType == "订单号"){
        	$sourceType = 1;
        }else{
        	$sourceType = 2;
        }
        $couponTemplate = $("#coupon_template_"+value).text().trim();
        $couponType = $("#coupon_type_"+value).text().trim();
        $couponBatch = $("#coupon_batch_"+value).text().trim();
        $couponName = $("#coupon_name_"+value).text().trim();
        $conponMemo = $("#coupon_memo_"+value).text().trim();
        $applyReason = $("#apply_reason_"+value).text().trim();
        $couponMoney = $("#coupon_Money_"+value).text().trim();
        //$("#deitCouponApplyDiv").show();
        $("#pageBody").load(__ctxPath+"/jsp/mem/DetailCouponApply.jsp");
    
    }
    /**
     * 隐藏优惠券申请详情
     */
    function closeMerchant(){
        $("#CouponDetailDiv").hide();
    }

    
    /**
     * 新建积分申请
     */
    function showAddCouPon(){
        //清空表单内容
        $("#login_name").val("");
        $("#apply_type").val("");
        $("#source_type").val("");
        $("#apply_reason").val("");
		var url = __ctxPath+"/jsp/mem/NewCouponApply.jsp";
		$("#pageBody").load(url);
       // $("#newCouponApp").show();
    }
    
	/**
	 * 隐藏新建积分申请
	 */
    function closeAddCouponApp(){
        $("#newCouponApp").hide();
    }

    
	/**
	 * 新建积分申请时获取优惠券模板信息
	 */
	function foundCouponTemplate(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/y/delSite",
			dataType : "json",
			data : {
				"id" : value
			},
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container")
							.addClass("loading-inactive");
				}, 300);
			},
			success : function(response) {
				if (response.success == "true") {
				} else {
					$("#model-body-warning")
							.html(
									"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
					$("#modal-warning").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-warning"
					});
				}
				return;
			}
		});
	}    

    /**
     * 编辑优惠券申请
     */
    function editCouPonApply(){
        $(".edit_msg").hide();
        //回显
        var checkboxArray=[];
        $("input[type='checkbox']:checked").each(function(i,team){
            var sid=$(this).val();
            checkboxArray.push(sid);
        });
        if (checkboxArray.length > 1) {
            $("#warning2Body").text("只能选择一条优惠券申请记录!");
            $("#warning2").show();
            return;
        } else if (checkboxArray.length == 0) {
            $("#warning2Body").text("请选择要编辑的优惠券申请!");
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
       emptyProperty();
        $sid = value;
        $applyCid = $("#apply_cid_"+value).text().trim();
        $loginName = $("#login_name_"+value).text().trim();
        var apptype = $("#apply_type_"+value).text().trim();
        if(apptype == '服务投诉补偿'){
        	$applyType = 1;
        }else if(apptype == "外呼关怀回访"){
        	$applyType = 2;
        }else{
        	$applyType = 3;
        }
        
        var sourceType= $("#source_type_"+value).text().trim();
        if(sourceType == "订单号"){
        	$sourceType = 1;
        }else{
        	$sourceType = 2;
        }
        $couponTemplate = $("#coupon_template_"+value).text().trim();
        $couponType = $("#coupon_type_"+value).text().trim();
        $couponBatch = $("#coupon_batch_"+value).text().trim();
        $couponName = $("#coupon_name_"+value).text().trim();
        $conponMemo = $("#coupon_memo_"+value).text().trim();
        $applyReason = $("#apply_reason_"+value).text().trim();
        $couponMoney = $("#coupon_Money_"+value).text().trim();
        //$("#deitCouponApplyDiv").show();
        $("#pageBody").load(__ctxPath+"/jsp/mem/editCouPonApply.jsp");
    }
    
    /**
     * 取消优惠券申请
     */
	$("#cancleCouPonApply").click(function(){
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
        var value=checkboxArray[0];
        var url =  __ctxPath+"/memCoupon/cancleCouPonApply";
        $.ajax({
        	type : "post",
        	contentType : "application/x-www-form-urlencoded;charset=utf-8",
        	url : url,
        	dataType : "json",
            ajaxStart : function() {
                $("#loading-container").attr( "class","loading-container");
            },
            ajaxStop : function() {
                //隐藏加载提示
	            setTimeout(
	        		function() {
	                	$("#loading-container").addClass("loading-inactive");
	                }, 300);
            },	
            data :{
        		"sid":value,
            },
            success : function( response ){
            	if(response.code == '1'){
                    $("#modal-body-success").html("<div class='alert alert-success fade in'><strong>取消审核成功，返回列表页!</strong></div>");
		            $("#modal-success").attr({"style" : "display:block;z-index:9999","aria-hidden" : "false","class" : "modal modal-message modal-success"});
		            $("#addIntegralDiv").hide();
            	} else {
            		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.desc+"</strong></div>");
            		$("#modal-warning").attr({"style" : "display:block;z-index:9999","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
            		$("#addIntegralDiv").hide();
            	}
            }
        });
	});
	
	
	/**
	 * 弹出勾选审核条件的页面
	 */
	$("#checkCouPonApply").click(function(){
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
		     $("#checkCouponStatusDiv").show();
	});
	
	/**
	 * 隐藏勾选审核条件的页面
	 */
	function closeMerchant(){
		$("#checkCouponStatusDiv").hide();
	}
    /**
     * 审核优惠券申请
     */
	$("#commitCheckCoupon").click(function(){
		var status = $("#checkStatus_").val();
		var checkMemo = $("#checkMemo_").val();
		if(status == "" || status == null || checkMemo == "" || checkMemo == null){
    		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>审核状态与审核备注均为必填！</strong></div>");
    		$("#modal-warning").attr({"style" : "display:block;z-index:9999","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
    		$("#addIntegralDiv").hide();
    		return;
		}
        var checkboxArray=[];
        $("input[type='checkbox']:checked").each(function(i,team){
            var sid=$(this).val();
            checkboxArray.push(sid);
        });
        var value=checkboxArray[0];
        var url =  __ctxPath+"/memCoupon/checkCouponApply";
        $.ajax({
        	type : "post",
        	contentType : "application/x-www-form-urlencoded;charset=utf-8",
        	url : url,
        	dataType : "json",
            ajaxStart : function() {
                $("#loading-container").attr( "class","loading-container");
            },
            ajaxStop : function() {
                //隐藏加载提示
	            setTimeout(
	        		function() {
	                	$("#loading-container").addClass("loading-inactive");
	                }, 300);
            },	
            data :{
        		"sid":value,
         		"checkStatus":status,
        		"checkMemo":checkMemo
            },
            success : function( response ){
            	if(response.code == '1'){
                    $("#modal-body-success").html("<div class='alert alert-success fade in'><strong>审核成功，返回列表页!</strong></div>");
		            $("#modal-success").attr({"style" : "display:block;z-index:9999","aria-hidden" : "false","class" : "modal modal-message modal-success"});
		            $("#addIntegralDiv").hide();
		            $("#checkCouponStatusDiv").hide();
            	} else {
            		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.desc+"</strong></div>");
            		$("#modal-warning").attr({"style" : "display:block;z-index:9999","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
            		$("#addIntegralDiv").hide();
            	}
            }
        });
	});
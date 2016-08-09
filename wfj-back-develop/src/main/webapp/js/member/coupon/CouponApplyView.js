
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
	            		$("#loading-container").addClass("loading-inactive")
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
        $("#applyName_from").val($("#applyName_input").val());
        var strApTime = $("#reservationAp").val();
        var strChTime=$("#reservationCh").val();
        if(strApTime!=""){
            strApTime = strApTime.split("- ");
            $("#m_timeApStartDate_form").val(strApTime[0].replace("/","-").replace("/","-"));
            $("#m_timeApEndDate_form").val(strApTime[1].replace("/","-").replace("/","-"));
        }else{
            $("#m_timeApStartDate_form").val("");
            $("#m_timeApEndDate_form").val("");
        }
        if(strChTime!=""){
            strChTime = strChTime.split("- ");
            $("#m_timeChStartDate_form").val(strChTime[0].replace("/","-").replace("/","-"));
            $("#m_timeChEndDate_form").val(strChTime[1].replace("/","-").replace("/","-"));
        }else{
            $("#m_timeChStartDate_form").val("");
            $("#m_timeChEndDate_form").val("");
        }
        var params = $("#product_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
    }	
    
    
    /**
     * 查看优惠券申请
     */
    function showCouPonDetail(){
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
        var value=checkboxArray[0];
        $("#sid").val(value);
        $("#apply_cid").val($("#apply_cid_"+value).text().trim());
        $("#apply_name").val($("#apply_name_"+value).text().trim());
        $("#apply_num").val($("#apply_point_"+value).text().trim());
        $("#apply_reason").val($("#apply_reason_"+value).text().trim());
        $("#apply_status").val($("#apply_status_"+value).text().trim());

        var applyType=$("#apply_type_"+value).text().trim();
        if(applyType=="2"){
            $("#apply_type_1").attr("checked",true);
        }else{
            $("#apply_type_0").attr("checked",true);
        }

        var sourceType=$("#source_type_"+value).text().trim();
        if(sourceType=="2"){
            $("#source_type_1").attr("checked",true);
        }else{
            $("#source_type_0").attr("checked",true);
        }
		//显示优惠券申请详情
        $("#CouponDetailDiv").show();
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
							.addClass("loading-inactive")
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
            $("#warning2Body").text("只能选择一条申请记录!");
            $("#warning2").show();
            return;
        } else if (checkboxArray.length == 0) {
            $("#warning2Body").text("请选择要查看的申请!");
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
        $applyType = $("#apply_type_"+value).text().trim();
        $sourceType = $("#source_type_"+value).text().trim();
        $couponTemplate = $("#coupon_template_"+value).text().trim();
        $couponType = $("#coupon_type_"+value).text().trim();
        $couponBatch = $("#coupon_batch_"+value).text().trim();
        $couponName = $("#coupon_name_"+value).text().trim();
        $applyType=$("#apply_type_"+value).text().trim();
        $conponMemo = $("#coupon_memo"+value).text().trim();
        $couponMoney = $("#coupon_Money"+value).text().trim();
        $applyReason = $("#apply_reason"+value).text().trim();
        //$("#deitCouponApplyDiv").show();
        $("#pageBody").load(__ctxPath+"/jsp/mem/editCouPonApply.jsp");
    }
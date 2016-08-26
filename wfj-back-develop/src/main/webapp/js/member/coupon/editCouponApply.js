
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
     /*  $("#source_type").text(s.atttr("select","select"));
    $couponTemplate = $("#coupon_template_"+value).text().trim();
     $couponType = $("#coupon_type_"+value).text().trim();
     $couponBatch = $("#coupon_batch_"+value).text().trim();
     $couponName = $("#coupon_name_"+value).text().trim();
     $applyType=$("#apply_type_"+value).text().trim();
     $conponMemo = $("#coupon_memo"+value).text().trim();
     $couponMoney = $("#coupon_Money"+value).text().trim();
     $applyReason = $("#apply_reason"+value).text().trim();*/
 }
 
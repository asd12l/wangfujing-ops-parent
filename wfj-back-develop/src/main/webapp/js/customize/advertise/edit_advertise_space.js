$(function(){
	validformEdit();
});
//验证
function validformEdit() {
	return $("#editSpaceForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required"
		},
		highlight : function(element) { // hightlight error inputs
			$(element).closest('.form-group')
					.removeClass("has-success").addClass('has-error');
		},
		errorPlacement : function(error, element) { // render error
			// placement for
			// each input type
			var icon = $(element).parent('.input-icon').children('i');
			icon.removeClass('fa-check').addClass("fa-warning");
			icon.attr("data-original-title", error.text()).tooltip({'container' : 'form'});
		},
		success : function(label, element) {
			var icon = $(element).parent('.input-icon').children('i');
			$(element).closest('.form-group').removeClass('has-error')
					.addClass('has-success'); // set success class to
			// the control group
			icon.removeClass("fa-warning").addClass("fa-check");
		}
	});
}
	//保存数据
	function submitEditSpaceForm(){
		var position = $("#position_id").val();
  		var enabled = $("#edit_space_enabled input[name='enabled']:checked").val();
  		checkFlag(position,enabled);
  		// TODO
  		if(validformEdit().form()){
  		flag = true;
  		if(flag){
  			$.ajax({
  				type:"post",
  				dataType: "json",
  				contentType: "application/x-www-form-urlencoded;charset=utf-8",
  				url:__ctxPath + "/advertisingSpace/edit",
  				data: $("#editSpaceForm").serialize(),
  				success:function(response) {
  					if(response.success == 'true'){
  						$("#editSpaceDIV").hide();
  						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
  						"<strong>修改成功，返回列表页!</strong></div>");
  						$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
  						initPropsdict();
  					}else{
  						$("#editSpaceDIV").hide();
  						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败！</strong></div>");
  						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  					}
  				}
  			});
  		}else{
  			$("#editSpaceDIV").hide();
  			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>该位置已有广告启用,请检查后再试！</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			
  			
  		}
  		}
  		}
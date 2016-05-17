function validform() {
	return $("#theForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required",
			domain : {
				required : true,
				DomainNameVal : true
			},
//			sitePath : "required",
			//relativePath : "required",
			//tpl_path : "required",
			//staticSuffix : "required",
			//dynamicSuffix : "required"
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
jQuery.validator.addMethod("DomainNameVal", function(value, element) {
	return this.optional(element) || /^(http(s)?:\/\/)?(www\.)?[\w-]+\.\w{2,4}(\/)?$/.test(value);
}, $.validator.format("请输入正确的域名"));

function validform() {
	return $("#theForm").validate(
			{
				onfocusout : function(element) {
					$(element).valid();
				},
				rules : {
					name : "required",
					ip : {
						required : true,
						IpVal : true
					},
					port : {
						required : true,
						digits : true
					},
					username : "required",
					password : "required",
					path : {
						required : true,
						PathVal : true
					},
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
function validform2() {
	return $("#theForm").validate(
			{
				onfocusout : function(element) {
					$(element).valid();
				},
				rules : {
					ip : {
						required : true,
						IpVal : true
					},
					port : {
						required : true,
						digits : true
					},
					username : "required",
					password : "required",
					path : {
						required : true,
						PathVal : true
					},
				},
				errorPlacement : function(error, element) { // render error
					// placement for
					// each input type
					var icon = $(element).parent('.input-icon').children('i');
					icon.removeClass('fa-check').addClass("fa-warning");
					icon.attr("data-original-title", error.text()).tooltip({'container' : 'form'});
				},
				highlight : function(element) { // hightlight error inputs
					$(element).closest('.form-group')
							.removeClass("has-success").addClass('has-error');
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
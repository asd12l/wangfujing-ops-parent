var productPagination;
	$(function() {
		$('#commenttime_input').daterangepicker({
 			//timePicker: true,
			//timePickerIncrement: 30,
			//format: 'YYYY/MM/DD HH:mm:ss',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        });
		$('#recovery_time').daterangepicker({
 			//timePicker: true,
			//timePickerIncrement: 30,
			//format: 'YYYY/MM/DD HH:mm:ss',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        });
		initProduct();
		$("#pageSelect").change(productQuery);
	});
	
	function productQuery() {
		$("#ordernumber_from").val($("#ordernumber_input").val());//
		$("#ordernumber").val($("#ordernumber_input").val());
		$("#customeraccount").val($("#customeraccount_input").val());//
		$("#commenttime_from").val($("#commenttime_input").val());//
		$("#praisedegree_from").val($("#praisedegree_input").val());//
		$("#whether_reply_from").val($("#reply_true").val());//
		$("#whether_shielding_from").val($("#whether_shielding").val());
		$("#customerservicenumber_from").val($("#customerservicenumber_input").val());
		$("#recovery_time_from").val($("#recovery_time").val());
		$("#whether_upgrade_from").val($("#whether_upgrade").val());
		var params = $("#product_form").serialize();
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	// 查询
	function query() {
		$("#modow").val('');
		$("#replyinfo").val('');
		$("#datetimenow").val('');
		$("#commentid").val('');
		var strTime = $("#commenttime_input").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startcommenttime").val(strTime[0].replace("/","-").replace("/","-")+" 00:00:00");
			$("#endcommenttime").val(strTime[1].replace("/","-").replace("/","-")+" 23:59:59");
		}else{
			$("#startcommenttime").val("");
			$("#endcommenttime").val("");
		}
		var repTime = $("#recovery_time").val();
		if(repTime!=""){
			repTime = repTime.split("-");
			$("#startrecoverytime").val(repTime[0].replace("/","-").replace("/","-")+" 00:00:00");
			$("#endrecoverytime").val(repTime[1].replace("/","-").replace("/","-")+" 23:59:59");
		}else{
			$("#startrecoverytime").val("");
			$("#endrecoverytime").val("");
		}
		productQuery();
	}
	// 重置
	function reset() {
		$("#cache").val(1);
		$("#ordernumber_input").val('');//
		$("#customeraccount_input").val('');//
		$("#commenttime_input").val('');//
		$("#praisedegree_input").val('');//
		$("#reply_true").val('');//
		$("#whether_shielding").val('');
		$("#customerservicenumber_input").val("");
		$("#recovery_time").val("");
		$("#whether_upgrade").val("");
		$("#startcommenttime").val("");
		$("#endcommenttime").val("");
		$("#startrecoverytime").val("");
		$("#endrecoverytime").val("");
		$("#pageSelect").val("10");
		$('#commenttime_input').daterangepicker({
 			//timePicker: true,
			//timePickerIncrement: 30,
			//format: 'YYYY/MM/DD HH:mm:ss',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        });
		$('#recovery_time').daterangepicker({
 			//timePicker: true,
			//timePickerIncrement: 30,
			//format: 'YYYY/MM/DD HH:mm:ss',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        });
		productQuery();
	}
	
	var dataList;
	//初始化商品列表
	function initProduct() {
		var url = __ctxPath + "/membercommentrep/getBycommentwirtlist";
		productPagination = $("#productPagination").myPagination(
				{
					panel : {
						tipInfo_on : true,
						tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
						tipInfo_css : {
							width : '25px',
							height : "20px",
							border : "2px solid #f0f0f0",
							padding : "0 0 0 5px",
							margin : "0 5px 0 5px",
							color : "#48b9ef"
						}
					},
					debug : false,
					ajax : {
						on : true,
						url : url,
						dataType : 'json',
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive");
							}, 300);
						},
						callback : function(data) {
							dataList = data.list;
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
						}
					}
				});
	}
	function delet(){
		$("#typepdiv").html("<label class='col-md-5 control-label'  style='line-height: 20px; text-align: right;'>删除原因：</label><div class='col-md-6'>	<input type='text' style='line-height:150px;width:200px'   id='replyinfosite' /><br/><span id='replyinfo_msg' style='color:red;'></span></div><br>&nbsp;");		
		$("#typetable").html("		<a onclick='deletstrue();' id='delets' class='btn btn-info'>删除</a>&nbsp;&nbsp;<a onclick='closeLogin();' class='btn btn-primary'>取消</a>&nbsp;&nbsp;");
		$("#customerservicenumber_from").val(getCookieValue("username"));
		ever();
		$("#modow").val('3');
		$("#deletnot").val('');
		
		$("#replyinfosite").val('');
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		var cid=checkboxArray[0];
		if($("#wirteback"+cid).val() !=1){
			$("#warning2Body").text("无法删除选中的评论!");
			$("#warning2").show();
			return;
		}
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条评论进行删除!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要修改的删除!");
			$("#warning2").show();
			return;
		}
		var cid=checkboxArray[0];
		$("#commentid").val(cid);
		$("#whether_shielding_from").val('');
		$("#whether_shielding_from").val('1');
		$("#resetReplyDiv").show();
		$("#repyes").hide;
		$("#mdeyes").hide;
	}
	function reply(){
		$("#customerservicenumber_from").val(getCookieValue("username"));
		$("#modow").val('4');
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		var cid=checkboxArray[0];
		if($("#shieldoutre"+cid).val() !=1){
			$("#warning2Body").text("无法屏蔽选中的评论!");
			$("#warning2").show();
			return;
		}
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条评论进行屏蔽!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要屏蔽的评论!");
			$("#warning2").show();
			return;
		}
		$("#commentid").val(cid);
		$("#whether_shielding_from").val('');
		$("#whether_shielding_from").val('0');
		if(confirm("是否屏蔽该条评论"))
	    {
			var params = $("#product_form").serialize();
			params = decodeURI(params);
			productPagination.onLoad(params);
	    }
	    else
	    {
	}
	}
	
	function add() {
		$("#customerservicenumber_from").val(getCookieValue("username"));
		$("#typepdiv").html("<label class='col-md-5 control-label'  style='line-height: 20px; text-align: right;'>回复信息：</label><div class='col-md-6'>	<input type='text' style='line-height:150px;width:200px'   id='replyinfosite' /><br/><span id='replyinfo_msg' style='color:red;'></span></div><br>&nbsp;");
		$("#typetable").html("		<a onclick='replystrue();' id='delets' class='btn btn-info'>回复</a>&nbsp;&nbsp;<a onclick='closeLogin();' class='btn btn-primary'>取消</a>&nbsp;&nbsp;");
		ever();
		$("#modow").val('2');
		$("#replyinfosite").val('');
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		var cid=checkboxArray[0];
		if($("#wirteback"+cid).val() ==1){
			$("#warning2Body").text("无法回复选中的评论!");
			$("#warning2").show();
			return;
		}
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条评论进行回复!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要回复的评论!");
			$("#warning2").show();
			return;
		}
		
		$("#commentid").val(cid);
		$("#resetReplyDiv").show();
		}
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
	}
	function rereply(){
		$("#modow").val('4');
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		var cid=checkboxArray[0];
		if($("#shieldoutre"+cid).val() !=0){
			$("#warning2Body").text("无法恢复选中的回复!");
			$("#warning2").show();
			return;
		}
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条回复进行恢复处理!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要恢复的回复!");
			$("#warning2").show();
			return;
		}
		$("#commentid").val(cid);
		$("#whether_shielding_from").val('1');
		if(confirm("是否确认恢复"))
	    {
			var params = $("#product_form").serialize();
			params = decodeURI(params);
			productPagination.onLoad(params);
	    }
	    else
	    {
	}
	}
    function modify(){
		//清空表单内容
    	$("#whether_shielding_from").val('');
		$("#customerservicenumber_from").val(getCookieValue("username"));
		$("#typepdiv").html("<label class='col-md-5 control-label'  style='line-height: 20px; text-align: right;'>回复信息：</label><div class='col-md-6'>	<input type='text' style='line-height:150px;width:200px'   id='replyinfosite' /><br/><span id='replyinfo_msg' style='color:red;'></span></div><br>&nbsp;");
    	$("#typetable").html("		<a onclick='modifystrue();' id='delets' class='btn btn-info'>修改</a>&nbsp;&nbsp;<a onclick='closeLogin();' class='btn btn-primary'>取消</a>&nbsp;&nbsp;");
		ever();
		$("#modow").val('3');
		$("#replyinfosite").val('');
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		var cid=checkboxArray[0];
		if($("#wirteback"+cid).val() !=1){
			$("#warning2Body").text("无法修改选中的评论!");
			$("#warning2").show();
			return;
		}
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条评论进行修改!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要修改的评论!");
			$("#warning2").show();
			return;
		}

		$("#commentid").val(cid);
		$("#replyinfosite").val($("#replyCon"+cid).val());
		$("#resetReplyDiv").show();
		
		};
		function replystrue(){
			if(confirm("是否确认提交此回复内容？"))
		    {
				$("#resetReplyDiv").hide();
				$("#replyinfo").val($("#replyinfosite").val());
				var params = $("#product_form").serialize();
				params = decodeURI(params);
				productPagination.onLoad(params);
		    }else{
		    	
		    }
		}
		function modifystrue(){
			if(confirm("是否确认修改此评论内容？"))
		    {
				$("#resetReplyDiv").hide();
				$("#replyinfo").val($("#replyinfosite").val());
				var params = $("#product_form").serialize();
				params = decodeURI(params);
				productPagination.onLoad(params);
		    }
		    else
		    {
		    }
		}
		function deletstrue(){
			$("#modow").val('3');
			if(confirm("是否确认删除此评论？"))
		    {
				$("#deletnot").val($("#replyinfosite").val());
				$("#customerservicenumber_from").val(getCookieValue("username"));
				$("#resetReplyDiv").hide();
				$("#whether_shielding_from").val('1');
				var params = $("#product_form").serialize();
				params = decodeURI(params);
				productPagination.onLoad(params);
		    }
		    else
		    {
		    }

		}

   function closeLogin(){
		$("#resetReplyDiv").hide();
	}
   function ever(){
	 //清空表单内容
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var day = date.getDate();
		var hour = date.getHours();
		var minute = date.getMinutes();
		var second = date.getSeconds();
		$("#datetimenow").val(year+'-'+month+'-'+day+' '+hour+':'+minute+':'+second);
   }

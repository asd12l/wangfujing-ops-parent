/**
 * 
 */
var util = (function() {
	
	var _roleTable = [];
	var _isModel=true;
	var _roleTable = [];
	  _roleTable.push('<div style="font-size:12px"><img src="/mw/jsp/edi/image/progressBar_s.gif"/>正在努力加载中..</div>');
	
	// 清除相应区域内的数据输入项
    var _clearData = function($table) {
        $table.find(":input:not(:button,:submit, :reset,:selected,:radio)").val('');
        $table.find("select option:first").attr("selected","selected");
    };
    
    // 模态框
    var _dialog = new BootstrapDialog({
        message: _roleTable,
        closable: false
    });
    
    var _msgDialog=new BootstrapDialog({
        closable: false
    });
    
    var _msgDialogShow=function(msg){
    	_msgDialog.open();
    	_msgDialog.getModalBody().html(msg);
    	window.setTimeout(_msgDialogClose,1500);
    }
    
    var _msgDialogClose=function(){
    	_msgDialog.close();
    	return;
    }
    
    _dialog.realize();
    _dialog.setClosable(false);
    _dialog.getModalHeader().hide();
    _dialog.getModalFooter().hide();
    _dialog.getModalBody().css('background-color', 'white');
    _dialog.getModalBody().css('border','3px solid #CD0000');
    _dialog.getModalBody().css('color', '#68838B');
    _msgDialog.realize();
    _msgDialog.setClosable(false);
    _msgDialog.getModalHeader().hide();
    _msgDialog.getModalFooter().hide();
    _msgDialog.getModalBody().css('background-color', 'white');
    _msgDialog.getModalBody().css('border','3px solid #CD0000');
    _msgDialog.getModalBody().css('color', '#68838B');
    _msgDialog.getModalBody().css('padding', '15px');
    _msgDialog.getModalDialog().css('margin-top','200px');
    _msgDialog.getModalDialog().css('width','220px');
    _msgDialog.getModalDialog().css('text-align','center');
    

	  // 翻页实现
	var _lookbackPage = function(lable, URL, callback, page, result) {
		console.log(lable);
		lable.find(".listTR").click(function() {
			result($(this));
		});
		lable.find("#checkBox").click(function() {
			lable.find(":checkbox").attr({
				"checked" : $(this).context.checked
			});
		})
		lable.find("#prev").click(function() {
			if (page.pageNo > 1) {
				lable.find("#loading").show();
				util.isModel = false;
				$.ajax({
					type : "post",
					url : URL + "&pageNo=" + (page.pageNo - 1),
					dataType : "json",
					success : function(roleJSON) {
						lable.empty();
						lable.append(callback(roleJSON));
						_lookbackPage(lable, URL, callback, roleJSON, result);
						util.isModel = true;
					}
				})
			}

		})
		lable.find("#top").click(function() {
			lable.find("#loading").show();
			util.isModel = false;
			$.ajax({
				type : "post",
				url : URL + "&pageNo=1",
				dataType : "json",
				success : function(roleJSON) {
					lable.empty();
					lable.append(callback(roleJSON));
					_lookbackPage(lable, URL, callback, roleJSON, result);
					util.isModel = true;
				}
			})

		})
		lable.find("#last").click(function() {
			lable.find("#loading").show();
			util.isModel = false;
			$.ajax({
				type : "post",
				url : URL + "&pageNo=" + page.totalPage,
				dataType : "json",
				success : function(roleJSON) {
					lable.empty();
					lable.append(callback(roleJSON));
					_lookbackPage(lable, URL, callback, roleJSON, result);
					util.isModel = true;
				}
			})

		})
		lable.find("#btnSerach").click(
				function() {
					lable.find("#loading").show();
					util.isModel = false;
					console.log(URL);
					if (URL.indexOf('&1=1', 0) > 0) {
						URL = URL.substring(0, URL.indexOf('&1=1', 0));
					}
					var newUrl = "";
					var keyWord = lable.find("#keyword").val();
					var cityName = lable.find("#cityName").val();
					var statName = lable.find("#statName").val();
					var areaName = lable.find("#areaName").val();
					console.log(URL);
					// 对URL进行重定义
					if (keyWord != "") {
						newUrl = URL + "&1=1&keyWord="
								+ encodeURIComponent(keyWord) + "&cityName="
								+ encodeURI(cityName) + "&statName="
								+ encodeURI(statName) + "&areaName="
								+ encodeURI(areaName)
					} else if (URL.indexOf("&1=1", 0) > 0) {
						newUrl = URL.substring(0, URL.indexOf("&1=1", 0));
					} else {
						newUrl = URL;
					}
					console.log(newUrl);
					$.ajax({
						type : "post",
						url : newUrl,
						dataType : "json",
						success : function(roleJSON) {
							lable.empty();
							lable.append(callback(roleJSON));
							_lookbackPage(lable, newUrl, callback, roleJSON,
									result);
							lable.find("#keyword").val(keyWord);
							lable.find("#cityName").val(cityName);
							lable.find("#statName").val(statName);
							lable.find("#areaName").val(areaName);
							util.isModel = true;
						}
					})

				})
		lable.find("#next").click(function() {
			if (page.pageNo < page.totalPage) {
				lable.find("#loading").show();
				util.isModel = false;
					$.ajax({
						type : "post",
						url : URL + "&pageNo="
								+ (page.pageNo + 1),
						dataType : "json",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						success : function(roleJSON) {
							lable.empty();
							lable.append(callback(roleJSON));
							_lookbackPage(lable, URL,
									callback, roleJSON,
									result);
							util.isModel = true;
						}
					})
			  }

		})

	}
	
	return {
		dialog : _dialog,
        clearData : _clearData,
        isModel:_isModel,
        msg:_msgDialogShow,
        page:_lookbackPage
    }
	
}());
$(document).ready(function () {
    //转换checkbox为switch
    var _$yiqifaPush = $('#yiqifa_push').bootstrapSwitch();
    var _$qqPush = $("#qq_push").bootstrapSwitch();
    var _$360Push = $("#360_push").bootstrapSwitch();
    var _$duomaiPush = $("#duomai_push").bootstrapSwitch();
    var _$yiqifaRead = $('#yiqifa_read').bootstrapSwitch();
    var _$qqRead = $("#qq_read").bootstrapSwitch();
    var _$360Read = $("#360_read").bootstrapSwitch();
    var _$duomaiRead = $("#duomai_read").bootstrapSwitch();
    
    //获取当前设置
    $.ajax({
        type: "post",
        url: "/edi-server/queryCpsToggle",
        dataType: "json",
        success: function (cpsSetting) {
        	//表示yiqifa和qq的ID存放
        	var temp="";
            $.each(cpsSetting, function (index, item) {
                if (item.sRC_NAME === "linktech"||item.sRC_NAME==='qq') {
                	temp=temp+item.iD+",";
                    item.cPS_PUSH === '0' ? _$qqPush.bootstrapSwitch('state', true).val(temp) : _$qqPush.bootstrapSwitch('state', false).val(temp);
                    item.cPS_READ === '0' ? _$qqRead.bootstrapSwitch('state', true).val(temp) : _$qqRead.bootstrapSwitch('state', false).val(temp);
                } else if (item.sRC_NAME === "360") {
                    item.cPS_PUSH === '0' ? _$360Push.bootstrapSwitch('state', true).val(item.iD) : _$360Push.bootstrapSwitch('state', false).val(item.iD);
                    item.cPS_READ === '0' ? _$360Read.bootstrapSwitch('state', true).val(item.iD) : _$360Read.bootstrapSwitch('state', false).val(item.iD);
                } else if (item.sRC_NAME === "yiqifa") {
                    item.cPS_PUSH === '0' ? _$yiqifaPush.bootstrapSwitch('state', true).val(item.iD) : _$yiqifaPush.bootstrapSwitch('state', false).val(item.iD);
                    item.cPS_READ === '0' ? _$yiqifaRead.bootstrapSwitch('state', true).val(item.iD) : _$yiqifaRead.bootstrapSwitch('state', false).val(item.iD);
                } else if (item.sRC_NAME === "duomai") {
                    item.cPS_PUSH === '0' ? _$duomaiPush.bootstrapSwitch('state', true).val(item.iD) : _$duomaiPush.bootstrapSwitch('state', false).val(item.iD);
                    item.cPS_READ === '0' ? _$duomaiRead.bootstrapSwitch('state', true).val(item.iD) : _$duomaiRead.bootstrapSwitch('state', false).val(item.iD);
                } else {
                    // todo error
                }
            });
            //绑定swtich切换事件
            $("input[type=checkbox]").on('switchChange.bootstrapSwitch', function (event, state) {
            	var tempID =event.target.value;
            	if(tempID.indexOf(',',0)>0){
            		var temp = tempID.split(',');
            		var flag, msg;
                	for(var i=0;i<2;i++){
                		 var _requestData = {
                                 "ID": temp[i]
                             };
                		
                             if (event.target.id.substr(event.target.id.indexOf("_") + 1) === "push") {
                                 _requestData["CPS_PUSH"] = state === true ? 0 : 1
                             } else {
                                 _requestData["CPS_READ"] = state === true ? 0 : 1
                             }
                             $.ajax({
                                 type: "post",
                                 data: _requestData,
                                 url: "/edi-server/updateCpsToggle",
                                 dataType: "json",
                                 success: function (result) {
                                     
                                     if (result === "SUCCESS") {
                                         util.msg("操作成功!!");
                                     } else {
                                    	 util.msg("操作失败!!");
                                     }
                                    
                                 }
                             });
                	}
                	
            	}else{
            		 var _requestData = {
                             "ID": event.target.value
                         };
                         if (event.target.id.substr(event.target.id.indexOf("_") + 1) === "push") {
                             _requestData["CPS_PUSH"] = state === true ? 0 : 1
                         } else {
                             _requestData["CPS_READ"] = state === true ? 0 : 1
                         }
                         $.ajax({
                             type: "post",
                             data: _requestData,
                             url: "/edi-server/updateCpsToggle",
                             dataType: "json",
                             success: function (result) {
                                 var flag, msg;
                                 if (result === "SUCCESS") {
                                     util.msg("操作成功!!");
                                 } else {
                                	 util.msg("操作失败!!");
                                 }
                             }
                         });
            	}
            });
        }});
});
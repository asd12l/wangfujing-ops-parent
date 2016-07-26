<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
    <link href="${pageContext.request.contextPath}/jsp/edi/css/bootstrap-switch.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/jsp/edi/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/jsp/edi/js/bootstrap/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/jsp/edi/js/bootstrap/highlight.js"></script>
    <script src="${pageContext.request.contextPath}/jsp/edi/js/bootstrap/bootstrap-switch.js"></script>
    <script src="${pageContext.request.contextPath}/jsp/edi/js/bootstrap/main.js"></script>
    <script type="text/javascript">

    $(document).ready(function () {
        //转换checkbox为switch
        var _$yiqifaPush = $('#yiqifa_push').bootstrapSwitch();
        var _$linktechPush = $("#linktech_push").bootstrapSwitch();
        var _$360Push = $("#360_push").bootstrapSwitch();
        var _$duomaiPush = $("#duomai_push").bootstrapSwitch();
        var _$yiqifaRead = $('#yiqifa_read').bootstrapSwitch();
        var _$linktechRead = $("#linktech_read").bootstrapSwitch();
        var _$360Read = $("#360_read").bootstrapSwitch();
        var _$duomaiRead = $("#duomai_read").bootstrapSwitch();
        
        var url = $("#ctxPath").val()+ "/ediCps/queryCpsToggle";
        var updateUrl = $("#ctxPath").val()+ "/ediCps/updateCpsToggle";
        //获取当前设置
        $.ajax({
            type: "post",
            url: url,
            dataType: "json",
            success: function (cpsSetting) {
            	var returnData = $.parseJSON(cpsSetting);
            	
            	//表示yiqifa和qq的ID存放
            	var temp="";
                $.each(returnData, function (index, item) {
                    if (item.srcName==='yiqifa') {
                    	if(item.cpsPush == 0){
                    		$('#yiqifa_push').bootstrapSwitch('state', false);
                    	}else{
                    		$('#yiqifa_push').bootstrapSwitch('state', true);
                    	}
                    	if(item.cpsRead == 0){
                    		$('#yiqifa_read').bootstrapSwitch('state', false);
                    	}else{
                    		$('#yiqifa_read').bootstrapSwitch('state', true);
                    	}
                    }
                    if (item.srcName==='linktech') {
                    	if(item.cpsPush == 0){
                    		$('#linktech_push').bootstrapSwitch('state', false);
                    	}else{
                    		$('#linktech_push').bootstrapSwitch('state', true);
                    	}
                    	if(item.cpsRead == 0){
                    		$('#linktech_read').bootstrapSwitch('state', false);
                    	}else{
                    		$('#linktech_read').bootstrapSwitch('state', true);
                    	}
                    }
                    if (item.srcName==='duomai') {
                    	if(item.cpsPush == 0){
                    		$('#duomai_push').bootstrapSwitch('state', false);
                    	}else{
                    		$('#duomai_push').bootstrapSwitch('state', true);
                    	}
                    	if(item.cpsRead == 0){
                    		$('#duomai_read').bootstrapSwitch('state', false);
                    	}else{
                    		$('#duomai_read').bootstrapSwitch('state', true);
                    	}
                    }
                });
                //绑定swtich切换事件
                $("input[type=checkbox]").on('switchChange.bootstrapSwitch', function (event, state) {
                		var src = event.target.id.substr(0,event.target.id.indexOf("_"));
                		var type = event.target.id.substr(event.target.id.indexOf("_")+1);
                     	// alert(event.target.value);//控件值
                		 var _requestData = {
                                 "src": src
                             };
                		 _requestData["TYPE"] = type
                		 if(state){
                			 _requestData["VALUE"] = 1 
                		 }else{
                			 _requestData["VALUE"] = 0 
                		 }
                         $.ajax({
                             type: "post",
                             data: _requestData,
                             url: updateUrl,
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
                             
                });
            }});
    });
    
    </script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">CPS渠道管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="table-toolbar">
										<ul class="topList clearfix">
											<li class="col-md-4"><label class="titname">亿起发-推送：</label>
											    <input type="checkbox" id="yiqifa_push"/></li>
											<li class="col-md-4"><label class="titname">QQ彩贝,领科特-推送：</label>
												<input type="checkbox" id="linktech_push"/></li>
											<li class="col-md-4"><label class="titname">360-推送：</label>
												<input type="checkbox" id="360_push"/></li>
											<li class="col-md-4"><label class="titname">多麦-推送：</label>
												<input type="checkbox" id="duomai_push"/></li>
											<li class="col-md-4"><label class="titname">亿起发-获取：</label>
												<input type="checkbox" id="yiqifa_read"/></li>
											<li class="col-md-4"><label class="titname">QQ彩贝,领科特-获取：</label>
												<input type="checkbox" id="linktech_read"/></li>
											<li class="col-md-4"><label class="titname">360-获取：</label>
												<input type="checkbox" id="360_read"/></li>
											<li class="col-md-4"><label class="titname">多麦-获取：</label>
												<input type="checkbox" id="duomai_read"/></li>
										</ul>
						   </div>
						</div>
					</div>
				</div>
				<!-- /Page Body -->
			</div>
			<!-- /Page Content -->
		</div>
		<!-- /Page Container -->
		<!-- Main Container -->
	</div>
</body>
</html>
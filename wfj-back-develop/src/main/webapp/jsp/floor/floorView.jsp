<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<style type="text/css">
    .listInfo li {
        float: left;
        height: 35px;
        margin: 1px 1px 1px 0;
        overflow: hidden;
    }
</style>

<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" ></script>
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var floorPagination;
	$(function() {
        initFloor();
        $("#pageSelect").change(floorQuery);
        $("#shopSid_select").change(floorQuery);

        $("#shopSid_select").select2();
		//门店
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/queryShopList",
			dataType : "json",
			async:false,
			success : function(response) {
				if(response.success == "true"){
					var result = response.list;
					var option = "";
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						option += "<option value='"+ele.sid+"'>" + ele.organizationName
								+ "</option>";
					}
					$("#shopSid_select").append(option);
				}
				return;
			}
		});
	});
	function find() {
		floorQuery();
	}

	function floorQuery(){
		$("#floorName_form").val($("#floorName_input").val());
		$("#floorCode_form").val($("#floorCode_input").val());
		$("#shopSid_form").val($("#shopSid_select").val());
        var params = $("#floor_form").serialize();
        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('floor.queryFloor', '楼层查询：' + params, getCookieValue("username"),  sessionId);
        params = decodeURI(params);
        floorPagination.onLoad(params);
   	}

	function reset(){
		$("#floorName_input").val("");
		$("#floorCode_input").val("");
		$("#shopSid_select").select2().select2("val","");
		floorQuery();
	}
	//只选一个
	function selectOne(one){
		$("input[type='checkbox']:checked").each(function(){
			if(this != one){
				$(this).attr("checked",false);
			}
		});
	}
 	function initFloor() {
		var url = $("#ctxPath").val()+"/floor/queryFloor";
		floorPagination = $("#floorPagination").myPagination({
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
             ajaxStart: function() {
		       	 $("#loading-container").attr("class","loading-container");
		        },
	        ajaxStop: function() {
	          //隐藏加载提示
	          setTimeout(function() {
	       	        $("#loading-container").addClass("loading-inactive");
	       	 },300);
	        },

             callback: function(data) {
               //使用模板
               $("#floor_tab tbody").setTemplateElement("floor-list").processTemplate(data);
             }
           }
         });
    }
	function addFloor(){
		var url = __ctxPath+"/jsp/floor/addFloorInfomationNode.jsp";
		$("#pageBody").load(url);
	}
	function editFloor() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要修改的行!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid_ = $("#tdCheckbox_" + value).val().trim();
		shopSid_ = $("#shop_sid_" + value).text().trim();
		shopName_ = $("#shop_name_" + value).text().trim();
		floorCode_= $("#floor_code_" + value).text().trim();
		floorName_= $("#floor_name_" + value).text().trim();
		floorStatus_= $("#floor_status_" + value).text().trim();
		if(floorStatus_ == "禁用"){
			floorStatus_ = 1;
		}else if(floorStatus_ == "可用"){
			floorStatus_ = 0;
		}
		var url = __ctxPath + "/jsp/floor/editFloorInfomationNode.jsp";
		$("#pageBody").load(url);
	}
	
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
	}

</script>
</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
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
                                    <h5 class="widget-caption">楼层管理</h5>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="clearfix">
                                        <a onclick="addFloor();" class="btn btn-primary">
                                            <i class="fa fa-plus"></i>
                                            添加楼层
                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a onclick="editFloor();" class="btn btn-info">
                                            <i class="fa fa-wrench"></i>
                                            修改楼层
                                        </a>
                                   </div>
                                    <div class="table-toolbar">
                                        <ul class="listInfo clearfix">
                                            <li>
                                                <span style="width: 45px;">门店：</span>
                                                <select id="shopSid_select" style="width: 200px;height: 22px;">
                                                    <option value="">请选择</option>
                                                </select>
                                            </li>
                                            <li>
                                                <span style="width: 80px;">楼层名称：</span>
                                                <input maxlength="20" type="text" id="floorName_input" style="width: 200px;height: 22px;"/>
                                            </li>
                                            <li>
                                                <span style="width: 80px;">楼层编码：</span>
                                                <input maxlength="20" type="text" id="floorCode_input" style="width: 200px;height: 22px;"/>
                                            </li>
                                            <li>
                                                <a class="btn btn-default shiny" onclick="find();" style="margin-left: 10px;">查询</a>
                                                <a class="btn btn-default shiny" onclick="reset();" style="margin-left: 10px;">重置</a>
                                            </li>
                                        </ul>
									</div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="floor_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
												<th width="5%" style="text-align: center;">选择</th>
                                                <th style="text-align: center;">楼层名称</th>
                                                <th style="text-align: center;">楼层编码</th>
                                                <th style="text-align: center;">所属门店名称</th>
                                                <th style="text-align: center;">楼层状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                   <div class="pull-left" style="margin-top: 5px;">
                                         <form id="floor_form" action="">
                                            <div class="col-lg-12">
                                            <select id="pageSelect" name="pageSize" style="padding: 0 12px;">
                                                <option>5</option>
                                                <option selected="selected">10</option>
                                                <option>15</option>
                                                <option>20</option>
                                            </select>
                                        </div>&nbsp;
                                            <input type="hidden" id="floorName_form" name="floorName"/>
                                            <input type="hidden" id="floorCode_form" name="floorCode"/>
                                            <input type="hidden" id="shopSid_form" name="shopSid" />
                                        </form>
                                        </div>
                                    <div id="floorPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="floor-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" onclick="selectOne(this);">
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="floor_name_{$T.Result.sid}">
													{#if $T.Result.floorName != '[object Object]'}
														{$T.Result.floorName}
													{#/if}
													</td>
													<td align="center" id="floor_code_{$T.Result.sid}">
													{#if $T.Result.floorCode != '[object Object]'}
														{$T.Result.floorCode}
													{#/if}</td>
													<td align="center" id="shop_name_{$T.Result.sid}">
													{#if $T.Result.shopSid != '[object Object]'}
														{$T.Result.shopName}
													{#/if}
													</td>
													<td align="center" style="display:none;" id="shop_sid_{$T.Result.sid}">
													{#if $T.Result.shopSid != '[object Object]'}
														{$T.Result.shopSid}
													{#/if}
													</td>
													<td align="center" id="floor_status_{$T.Result.sid}">
													{#if $T.Result.floorStatus == 1}
															<span class="label label-darkorange graded">未启用</span>
														{#elseif $T.Result.floorStatus == 0}
															<span class="label label-success graded">已启用</span>
														{#/if}
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
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
</body>
</html>
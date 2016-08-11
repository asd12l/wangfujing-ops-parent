<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
  <script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var priceLimitPagination;

	$(function() {
		//门店名称
		var parentSid = $("#shopName_input");
		$.ajax({
					type : "post",
					url : __ctxPath + "/shoppe/queryShopListAddPermission",
					async : false,
					dataType : "json",
					success : function(response) {
						var list1 = response.list;
						var option = "<option value=''>所有</option>";
						$("#shopSid_select").append(option);
						for (var i = 0; i < list1.length; i++) {
							var ele = list1[i];
							option = "<option value='"+ele.organizationCode+"'>"
									+ ele.organizationName + "</option>";
							$("#shopName_input").append(option);
						}
						return;
					},
					error : function(XMLHttpRequest, textStatus) {		      
						var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
						if(sstatus != "sessionOut"){
							$("#warning2Body").text(buildErrorMessage("","系统出错！"));
		 	     	        $("#warning2").show();
						}
						if(sstatus=="sessionOut"){     
			            	 $("#warning3").css('display','block');     
			             }
					}
				});
		
	    initPriceLimit();
	    $("#pageSelect").change(priceLimitQuery);
	});
	function priceLimitQuery(){
		$("#organizationName_from").val($("#shopName_input").val());
        var params = $("#priceLimit_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        priceLimitPagination.onLoad(params);
   	}
	function find() {
		
		priceLimitQuery();
	}
	function reset(){
		$("#shopName_input").val("");
		priceLimitQuery();
	}
 	function initPriceLimit() {
		var url = $("#ctxPath").val()+"/priceLimit/queryPriceLimit";
		priceLimitPagination = $("#priceLimitPagination").myPagination({
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
             async : false,
             dataType: 'json',
             ajaxStart: function() {
		       	 $("#loading-container").attr("class","loading-container");
		        },
	        ajaxStop: function() {
	          //隐藏加载提示
	          setTimeout(function() {
	       	        $("#loading-container").addClass("loading-inactive")
	       	 },500);
	        },

             callback: function(data) {
               //使用模板
               $("#priceLimit_tab tbody").setTemplateElement("priceLimit-list").processTemplate(data);
             }
           }
         });
    }
	function addPriceLimit(){
		var url = __ctxPath+"/jsp/Price/addPriceLimit.jsp";
		$("#pageBody").load(url);
	}
	function editPriceLimit() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一列！"));
  	        $("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选取要修改的列！"));
  	        $("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		shopSid_ = $("#tdCheckbox_" + value).val().trim();
		shopName_ = $("#shopName_" + value).text().trim();
		shopCode_ = $("#shopCode_" + value).val().trim();
		upper_ = $("#upper_" + value).val().trim();
		lower_ = $("#lower_" + value).val().trim();
		upperStatus_ = $("#upperStatus_" + value).val().trim();
		lowerStatus_ = $("#lowerStatus_" + value).val().trim();
		
		var url = __ctxPath + "/jsp/Price/editPriceLimit.jsp";
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
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/priceLimitmationNode/priceLimitmationNode.jsp");
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
                                    <h5 class="widget-caption">价格阀值管理</h5>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                    	<a onclick="addPriceLimit();" class="btn btn-primary">
                                        	<i class="fa fa-plus"></i>
											添加价格阀值
                                        </a>&nbsp;&nbsp;
                                    	<a onclick="editPriceLimit();" class="btn btn-info">
                                    		<i class="fa fa-wrench"></i>
											修改价格阀值
                                        </a>&nbsp;&nbsp;
                                       <!--  <a id="editabledatatable_new" onclick="delpriceLimit();" class="btn btn-danger">
                                        	<i class="fa fa-times"></i>
											删除门店 
                                        </a>
                                        -->
                                    </div>
                                     <div class="table-toolbar" style="margin-bottom: 5px;">
                                        <span>门店名称：</span>
                                        <select id="shopName_input" name="storeCode">
                                            <option value="">请选择</option>
                                        </select>&nbsp;&nbsp;&nbsp;&nbsp;
                                    	<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
									    <a class="btn btn-default shiny" onclick="reset();">重置</a>
                                    </div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="priceLimit_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                            	<th style="text-align: center;" width="7.5%">选择</th>  
                                                <th style="text-align: center;">门店名称</th>
                                                <th style="text-align: center;">门店编码</th>
                                                <th style="text-align: center;">上限阀值</th>
                                                <th style="text-align: center;">下限阀值</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                   <div class="pull-left" style="margin-top: 5px;">
										<form id="priceLimit_form" action="">
											<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp;  
											<input type="hidden" id="organizationName_from" name="organizationName" />
										</form>
									</div>
                                    <div id="priceLimitPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="priceLimit-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.shopSid}" value="{$T.Result.shopSid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													
													<td align="center" id="shopName_{$T.Result.shopSid}">
													{#if $T.Result.shopName != '[object Object]'}
														{$T.Result.shopName}
													{#/if}</td>
													
													<td align="center" id="shopCode_{$T.Result.shopSid}">
													{#if $T.Result.shopCode != '[object Object]'}
														{$T.Result.shopCode}
													{#/if}
													</td>
													
													<td align="center">
													{#if $T.Result.upper != '[object Object]' && $T.Result.upperStatus==0}
														{$T.Result.upper}
													{#else}
													    禁用
													{#/else}
													{#/if}
													</td>
													<input id="upper_{$T.Result.shopSid}" type="hidden" value="{$T.Result.upper == '[object Object]' ? "" : $T.Result.upper }"/>
													<input id="upperStatus_{$T.Result.shopSid}" type="hidden" value="{$T.Result.upperStatus }"/>

													<td align="center">
													{#if $T.Result.lower != '[object Object]' && $T.Result.lowerStatus==0}
														{$T.Result.lower}
													{#else}
													    禁用
													{#/else}
													{#/if}
													</td>
													<input id="lower_{$T.Result.shopSid}" type="hidden" value="{$T.Result.lower == '[object Object]' ? "" : $T.Result.lower }"/>
													<input id="lowerStatus_{$T.Result.shopSid}" type="hidden" value="{$T.Result.lowerStatus }"/>
													
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script src="${ctx}/js/ajaxfileupload.js"></script>
<!--ztree-->
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/js/jquery.ztree.excheck-3.5.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ztree/css/zTreeStyle.css" type="text/css">
<title>商品基本信息</title>

<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var treeObj;
	var treeObjcre;
	var payCode;
	var parCodecre;
	$(function(){
		
		$('#theForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
				
			},
			fields : {
				partner : {
					validators : {
						regexp: {
	                        regexp: /^[A-Za-z0-9\s]{1,20}$/,
	                        message: '商户id必须由数字或字母或空格20位组成'
	                    },
						notEmpty : {
							message : '商户id不能为空'
						}
						
			            
					}
				},
//				feeCostRate : {
//					validators : {
//						
//						notEmpty : {
//							message : '费率不能为空'
//						}
//						
//			            
//					}
//				},
				
				sellerEmail: {
		                validators: {
		                   
		                    emailAddress: {
		                        message: '邮箱格式不对，如163@wjg.com'
		                    }
		                }
		            },
		            encryptKey: {
		                validators: {
		                	regexp: {
		                        regexp: /^[A-Za-z0-9\s]{1,100}$/,
		                        message: '秘钥必须由数字或字母或空格100位组成'
		                    },
		                	notEmpty : {
								message : '密钥不能为空'
		                    }
		                }
		            },
	          payMediumCode: {
		                validators: {
		                   
		                	regexp: {
		                        regexp: /^[A-Za-z0-9\s]{1,32}$/,
		                        message: '支付介质必须由数字或字母或空格32位组成'
		                    }
		                }
		            }, 
		           
		            payMediumCodeCre:{
						validators : {
							regexp: {
		                        regexp: /^[A-Za-z0-9\s]{1,32}$/,
		                        message: '支付介质编码必须由数字或字母或空格20位组成'
		                    }
						}
					},
					 branchId:{
							validators : {
								regexp: {
			                        regexp: /^[A-Za-z0-9\s]{1,16}$/,
			                        message: '开户分行号必须由数字或字母或空格16位组成'
			                    }
							}
						},
						appid:{
								validators : {
									regexp: {
				                        regexp: /^[A-Za-z0-9\s]{1,32}$/,
				                        message: 'appid必须由数字或字母或空格32位组成'
				                    }
								}
							}
						/*
						,
						publicKey : {
								validators : {
									regexp: {
				                        regexp: /^[A-Za-z0-9]{1,32}$/,
				                        message: '支付宝公钥必须为数字或字母，长度不大于1024'
				                    }
								}
						},
						privateKey : {
								validators : {
									regexp: {
				                        regexp: /^[A-Za-z0-9\s]{1,32}$/,
				                        message: '支付宝私钥必须为数字或字母，长度不大于2048'
				                    }
								}
						}
						*/
				
			}

		}).find('button[data-toggle]').on('click',function() {
			var $target = $($(this).attr('data-toggle'));
			$target.toggle();
			if (!$target.is(':visible')) {
				$('#theForm').data('bootstrapValidator').disableSubmitButtons(false);
			}
		});
		
  		$("#close").click(function(){
  			t = 0;
  			$("#pageBody").load(__ctxPath+"/jsp/pay/channelAccount/list.jsp");
  		});
  		
  		
  	    bind();//建立ztree
	}); 
	     function  bind(){
	    	/*  $("#open1").click(function(){
	    		 //初始化树插件
	    		 var obj=$.fn.zTree.getZTreeObj("treeDemo");
	    		 //获取所有被选中的节点
	    		 var nodes=obj.getCheckedNodes(true);
	    		 
	    		 if($(this).hasClass("fa-plus-square-o")){
	    				$(this).removeClass("fa-plus-square-o");
	    				$(this).addClass("fa-minus-square-o");
	    				for(var i in nodes){
	    					obj.expandNode(nodes[i],true,true,false);
	    				}
	    			}else{
	    				$(this).removeClass("fa-minus-square-o");
	    				$(this).addClass("fa-plus-square-o");
	    				for(var i in nodes){
	    					obj.expandNode(nodes[i],false,true,false);
	    				}
	    			}
	    	 }) */
	    	 $("#open2").click(function(){
	    			var obj=$.fn.zTree.getZTreeObj("treeDemo");
	    			if($(this).hasClass("fa-plus-square")){
	    				$(this).removeClass("fa-plus-square");
	    				$(this).addClass("fa-minus-square");
	    				obj.expandAll(true);
	    			}else{
	    				$(this).removeClass("fa-minus-square");
	    				$(this).addClass("fa-plus-square");
	    				obj.expandAll(false);
	    			}
	    		})
	    		
	    		
	    		 $("#open3").click(function(){
	    			var obj=$.fn.zTree.getZTreeObj("treeDemoCre");
	    			if($(this).hasClass("fa-plus-square")){
	    				$(this).removeClass("fa-plus-square");
	    				$(this).addClass("fa-minus-square");
	    				obj.expandAll(true);
	    			}else{
	    				$(this).removeClass("fa-minus-square");
	    				$(this).addClass("fa-plus-square");
	    				obj.expandAll(false);
	    			}
	    		})
	     }

		
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/pay/channelAccount/list.jsp");
  		});
	
  
  	
  	 
  	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/pay/channelAccount/list.jsp");
	}
  	
  //显示设置支付介质页面
  	function showSetMediumDiv(){
  		var url=__ctxPath+"/wfjpay/findAllMediumListNoParam";
  		$.post(url,function(data){
  			if(data.success==true){
  				var setting = {
  						check: {
  							enable: true,
  							chkStyle: "radio",
  							chkboxType:{ "Y" : "p", "N" : "s" }
  						},
  						data: {
  							simpleData: {
  								enable: true
  							}
  						}
  						/* callback: {
  							beforeCheck: zTreeBeforeCheck
  						} */
  					};
  				var zNodes=data.list;
  				/* oldZtree=[];
  				for(var i in zNodes){
  					if(zNodes[i].checked){
  						oldZtree.push(zNodes[i]);
  					}
  				} */
  				treeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
  				$("#setPayMediumDiv").show();
  			}
  		},"json");
  		
  	}
  	
  	function showSetMediumCreDiv(){
  		var url=__ctxPath+"/wfjpay/findAllMediumListNoParam";
  		$.post(url,function(data){
  			if(data.success==true){
  				var setting = {
  						check: {
  							enable: true,
  							chkStyle: "radio",
  							chkboxType:{ "Y" : "p", "N" : "s" }
  						},
  						data: {
  							simpleData: {
  								enable: true
  							}
  						}
  						/* callback: {
  							beforeCheck: zTreeBeforeCheck
  						} */
  					};
  				var zNodes=data.list;
  				/* oldZtree=[];
  				for(var i in zNodes){
  					if(zNodes[i].checked){
  						oldZtree.push(zNodes[i]);
  					}
  				} */
  				treeObjcre=$.fn.zTree.init($("#treeDemoCre"), setting, zNodes);
  				$("#setPayMediumCreDiv").show();
  			}
  		},"json");
  		
  	}
  	
  	
	//保存数据
  	function saveFrom(){
		var value=$("#partner").val();
  		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/wfjpay/selectPayPartnerAccountPartner",
	        dataType: "json",
	        data: {"partner":value},
	        success:function(response) {
	        	      if(response.success == 'success'){
	        	    	 	$.ajax({
	        	  	        type:"post",
	        	  	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        	  	        url:__ctxPath + "/wfjpay/addchannelPartnerAccount",
	        	  	        dataType: "json",
	        	  	        data: $("#theForm").serialize(),
	        	  	        success:function(response) {
	        	  	        	if(response.success == 'true'){   	
	        	  	        		$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
	    		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	        	  				
	        	          	}
	        	  	        }
	        	  		}); 
	        		
	        		
				       }else if(response.success == 'false'){
				    	   $("#warning2Body").text("该商户id已被注册，请重试！");
				    	   $("#save").attr("disabled", true); 
							$("#warning2").show();
				    	   return;
                    
				}
        	}
		});
  		
		
		
  	}
  	function saveSetMedium(){
  	
  		var nodes=treeObj.getNodes();
  		var arr=treeObj.transformToArray(nodes);
  		for(var i=0;i<arr.length;i++){
  			if(arr[i].checked){
  		
  			payCode=arr[i].id;
  			}
  			
  		} 
  		$("#addPayMediumCode").html("<option value='"+payCode+"'>"+payCode+"</option>");
  		closeSetMediumDiv();
	}
  	function saveSetMediumCre(){
  		var nodesCre=treeObjcre.getNodes();
  		var arr=treeObj.transformToArray(nodesCre);
  		for(var i=0;i<arr.length;i++){
  			if(arr[i].checked){
  				parCodecre=arr[i].id;
  			}
  		}
  		$("#addPayMediumCodeCre").html("<option value='"+parCodecre+"'>"+parCodecre+"</option>");
  		closeSetMediumDivCre();
  	}
  	
  //关闭设置支付介质
  	function closeSetMediumDiv(){
  		$("#setPayMediumDiv").hide();
  	}
  
  	 //关闭设置支付介质
  	function closeSetMediumDivCre(){
  		$("#setPayMediumCreDiv").hide();
  	}
  	   
	</script> 
	</head>
<body>
	<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">新建渠道号信息</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
									<div class="form-group">
										<label class="col-lg-3 control-label">渠道类型：</label>
                                			<select id="channelPayType_input" style="padding: 0 0;" name="payType">
												<option value="ALIPAY">支付宝</option>
												<option value="TENPAY">财付通</option>
												<option value="NETPAY">银联</option>
												<option value="WECHATPAY">微信</option>
												<option value="ICBCPAY">工商银行</option>
												<option value="CMBPAY">招商银行</option>
												<option value="CGBPAY">广发银行</option>
												<option value="WECHATPAY_SHB">微信扫货邦</option>
												<option value="ALIPAY_OFFLINE">支付宝线下</option>
												<option value="WECHATPAY_OFFLINE">微信线下</option>
												<option value="ALIPAY_MOBILE">支付宝WAP</option>
												<option value="WECHATPAY_MOBILE">微信WAP</option>
										    </select>
									</div>
        
									<div class="form-group">
										<label class="col-lg-3 control-label">商户ID：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"  name="partner" id="partner" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">密钥：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="addEncryptKey" name="encryptKey" placeholder="必填"/>
										</div>
									</div>
									<!--
										<div class="form-group">
											<label class="col-lg-3 control-label">费率（%）：</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="addFeeCostRate" name="feeCostRate" placeholder="非必填"/>
											</div>
										</div>
									-->
									<div class="form-group">
										<label class="col-lg-3 control-label">卖家邮箱：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="addSellerEmail"  name="sellerEmail" placeholder="非必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">秘钥文件路径：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="addKeyPath" name="keyPath" placeholder="非必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">支付介质编码：</label>
										<div class="col-lg-6">
										  
										     <!--  <input type="text" class="form-control" id="addPayMediumCode" name="payMediumCode" placeholder="请输入支付介质"/> -->
										       <select id="addPayMediumCode" name="payMediumCode" style="padding: 0 0;">
										            <option value="">请选择支付介质</option>
										       </select>
											 
											
											  <a class="btn btn-default purple btn-sm fa fa-cog" onclick="showSetMediumDiv()"> 设置支付介质</a>
											
											  
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">商户开户分行号：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="addBranchId" name="branchId" placeholder="非必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">信用卡支付介质：</label>
										<div class="col-lg-6">
										  
										     <!--  <input type="text" class="form-control" id="addPayMediumCode" name="payMediumCode" placeholder="请输入支付介质"/> -->
										       <select id="addPayMediumCodeCre" name="payMediumCodeCre" style="padding: 0 0;">
										            <option value="">请选择支付介质</option>
										       </select>
											 
											
											  <a class="btn btn-default purple btn-sm fa fa-cog" onclick="showSetMediumCreDiv()"> 设置支付介质</a>
											
											  
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">微信支付公众号码：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="addAppId" name="appid" placeholder="非必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">支付宝公钥：</label>
										<div class="col-lg-6">
											<textarea class="form-control" id="publicKey" name="publicKey" placeholder="非必填" style="resize: none;height: 100px;"/>
											</textarea>
										</div>
									</div>
									<div class="form-group">
									<label class="col-lg-3 control-label">支付宝私钥：</label>
										<div class="col-lg-6">
											<textarea class="form-control" id="privateKey" name="privateKey" placeholder="非必填" style="resize: none;height: 100px;"/>
											</textarea>
										</div>
									</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
										<button class="btn btn-success" style="width: 25%;" id="save" type="submit" >保存</button>&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消"/>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--设置支付介质-->
<div class="modal modal-darkorange" id="setPayMediumDiv">
	<div class="modal-dialog" style="width: 350px;height:30%;margin: 5% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">设置支付介质</span>
				<div class="widget-buttons">
					<!-- <a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square-o" id="open1" style="font-size:20px;"></i>
	            	</a> -->
	            	<a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square"  style="font-size:20px;" id="open2"></i>
	            	</a>
	            	<a href="#" data-toggle="collapse" onclick="document.getElementById('setPayMediumDiv').style.display='none';" style="margin-right:10px;">
            			<i class="fa fa-times"  style="font-size:20px;" id="pro-i"></i>
            		</a>
				</div>
			</div>
			<div class="widget-body" style="">
				<form id="setPayMediumForm">
					<input type="hidden" name="id" id="numberParam_set">
				</form>
				<div class="zTreeDemoBackground left" style="padding-left:20px;">
					<ul id="treeDemo" class="ztree" style="overflow-y:scroll;height:400px;" ></ul>
				</div>
			
			
			
			</div>
			<!--修改保存/取消-->
	        <div class="modal-footer" style="text-align:center;">
	        	<button class="btn btn-success" style="width: 100px;" id="saveSet" type="submit"  onclick="saveSetMedium();">保存</button>&emsp;&emsp;
	        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('setPayMediumDiv').style.display='none';"/>
	        	<input class="btn btn-danger" style="display:none" id="editReset" type="reset" value="取消"/>
	        </div>
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>


<div class="modal modal-darkorange" id="setPayMediumCreDiv">
	<div class="modal-dialog" style="width: 350px;height:30%;margin: 5% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">设置支付介质</span>
				<div class="widget-buttons">
					<!-- <a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square-o" id="open1" style="font-size:20px;"></i>
	            	</a> -->
	            	<a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square"  style="font-size:20px;" id="open3"></i>
	            	</a>
	            	<a href="#" data-toggle="collapse" onclick="document.getElementById('setPayMediumCreDiv').style.display='none';" style="margin-right:10px;">
            			<i class="fa fa-times"  style="font-size:20px;" id="pro-i"></i>
            		</a>
				</div>
			</div>
			<div class="widget-body" style="">
				<form id=setPayMediumCreDiv>
					<input type="hidden" name="ide" id="numberParame_setCre">
				</form>
				<div class="zTreeDemoBackground left" style="padding-left:20px;">
					<ul id="treeDemoCre" class="ztree" style="overflow-y:scroll;height:400px;" ></ul>
				</div>
			</div>
			<!--修改保存/取消-->
	        <div class="modal-footer" style="text-align:center;">
	        	<button class="btn btn-success" style="width: 100px;" id="saveSet" type="submit"  onclick="saveSetMediumCre();">保存</button>&emsp;&emsp;
	        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('setPayMediumCreDiv').style.display='none';"/>
	        	<input class="btn btn-danger" style="display:none" id="editResetCre" type="reset" value="取消"/>
	        </div>
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>
	</div>
 <!-- /Page Body -->
	<script>
	
	
    </script>
</body>
</html>
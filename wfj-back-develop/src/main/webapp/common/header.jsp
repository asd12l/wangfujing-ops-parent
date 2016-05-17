<%request.setAttribute("ctx", request.getContextPath());%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<head>
<link rel="shortcut icon" href="${ctx }/images/titleLogo.png" type="image/x-icon">
</head>
<%@include file="taglib.jsp" %>
<%@include file="import.jsp" %>

<div aria-hidden="true" style="display: none;" class="modal modal-message modal-success fade" id="modal-success">
    <div class="modal-dialog" style="margin: 200px auto;">
        <div class="modal-content">
            <div class="modal-header">
        		<h5 id="myModalLabel">温馨提示</h5>
            </div>
            <div class="modal-body" id="modal-body-success">操作成功</div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-success" type="button" onclick="successBtn()">确定</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>




<!-- <div aria-hidden="true" style="display: none;" class="modal modal-message modal-success fade" id="modal-success_1">
    <div class="modal-dialog" style="margin: 150px auto;">
        <div class="modal-content">
            <div class="modal-header">            
                <i class="glyphicon glyphicon-check">123</i>
            </div>
            <div class="modal-body" id="modal-body-success">操作成功</div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-success" type="button" onclick="successBtn()">确定</button>
            </div>
        </div> / .modal-content
    </div> / .modal-dialog
</div> -->
<div aria-hidden="true" style="display: none;" class="modal modal-message modal-warning fade" id="modal-warning">
	<div class="modal-dialog" style="margin: 200px auto;">
		<div class="modal-content">
           <div class="modal-header">
           		<h5 class="web-title"><i class="fa fa-warning"></i>温馨提示</h5>
           </div>
           <div class="modal-body" id="model-body-warning">Is something wrong?</div>
           <div class="modal-footer">
               <button data-dismiss="modal" class="btn btn-warning" type="button" onclick="warningBtn()">确定</button>
           </div>
       </div> <!-- / .modal-content -->
   </div> <!-- / .modal-dialog -->
</div>


<div aria-hidden="false" style="display: none;" class="modal modal-message modal-warning fade in" id="warning2">
    <div class="modal-dialog" style="margin: 200px auto;">
        <div class="modal-content">
            <div class="modal-header">
            	<h5 id="myModalLabel">温馨提示</h5>                
            </div>
            <div class="modal-title" id="warning2Body">错误信息</div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-warning" onclick="warning2Btn();" type="button">确定</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>

<div aria-hidden="false" style="display: none;" class="modal modal-message modal-warning fade in" id="warning3">
    <div class="modal-dialog" style="margin: 200px auto;">
        <div class="modal-content">
            <div class="modal-header">
            	<h5 id="myModalLabel">温馨提示</h5>                
            </div>
            <div class="modal-title" id="warning2Body">登录超时，请重新登录</div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-warning" onclick="warning3Btn();" type="button">确定</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>

<div aria-hidden="false" style="display: none;" class="modal modal-message modal-success fade in" id="success1">
    <div class="modal-dialog" style="margin: 200px auto;">
        <div class="modal-content">
            <div class="modal-header">
            	<h5 id="myModalLabel">温馨提示</h5>                
            </div>
            <div class="modal-title" id="success1Body">错误信息</div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-success" onclick="success1Btn();" type="button">确定</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>

<!-- <div aria-hidden="false" style="display: none;" class="modal modal-message modal-warning fade in" id="warning2_1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <i class="fa fa-warning"></i>
            </div>
            <div class="modal-title" id="warning2Body">错误信息</div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-warning" onclick="warning2Btn();" type="button">确定</button>
            </div>
        </div> / .modal-content
    </div> / .modal-dialog
</div> -->

<div aria-hidden="false" style="display: none;" class="modal modal-message modal-warning fade in" id="modal-isOk">
    <div class="modal-dialog" style="margin: 200px auto;">
        <div class="modal-content">
            <div class="modal-header">
            	<h5 id="myModalLabel">温馨提示</h5>                
            </div>
            <div class="modal-title" style="text-align: left!important;font-size: 16px;" id="isOkAndNoWarning">您确定要删除吗?</div>
            <div class="modal-footer" style="text-align: right!important;">
                <button data-dismiss="modal" class="btn btn-success" type="button" onclick="ok()">确定</button>
                <button data-dismiss="modal" class="btn btn-warning" type="button" onclick="radio()">取消</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>
<script type="text/javascript">
	function warningBtn(){
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning fade"});
	}
	function warning2Btn(){
	    $("#warning2").hide();
	}
	function success1Btn(){
	    $("#success1").hide();
	}
	function warning3Btn(){
		$("#warning3").css('display','none');
		window.location.href=__ctxPath+"/login.jsp";
	}
	var okFunction,radioFunction;
	function confirmOkAndNo(okFunction1,radioFunction1){
		$("#modal-isOk").show();
		okFunction = okFunction1;
		radioFunction = radioFunction1;
	}
	function ok(){
		okFunction();
		$("#modal-isOk").hide();
		return false;
	}
	function radio(){
		if(radioFunction != undefined){
			radioFunction();
		}
		$("#modal-isOk").hide();
		return false;
	}
	function buildErrorMessage(errorCode,errorMsg){
		if(errorCode!=null && errorCode!=""){
			return errorMsg+"("+errorCode+")";	
		}
		if(errorMsg!=null && errorMsg!=""){
			return errorMsg
		}			
	}
</script>
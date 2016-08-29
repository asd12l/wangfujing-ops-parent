<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!--Page Related Scripts-->
<html>
<head>
  <script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
  <script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
  <script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
  <!--Bootstrap Date Range Picker-->
  <script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
  <style type="text/css">
    .trClick>td,.trClick>th{
      color:red;
    }
  </style>
  <script type="text/javascript">
    __ctxPath = "${pageContext.request.contextPath}";
    image="http://images.shopin.net/images";
    saleMsgImage="http://images.shopin.net/images";
    ctx="http://www.shopin.net";
    var olvPagination;
    $(function() {
      $("#reservationPull").daterangepicker();
      $("#reservationBack").daterangepicker();
      initOlv();
    });

    function productQuery(){
      $("#username_from").val($("#username_input").val().trim());
      $("#blacklisttype_from").val($("#blacklisttype_input").val().trim());
      $("#pullId_from").val($("#pullId_input").val().trim());
      $("#backId_from").val($("#backId_input").val().trim());
      var strPullTime = $("#reservationPull").val();
      var strBackTime=$("#reservationBack").val();
      if(strPullTime!=""){
        strPullTime = strPullTime.split("- ");
        $("#m_timePullStartDate_form").val(strPullTime[0].replace("/","-").replace("/","-"));
        $("#m_timePullEndDate_form").val(strPullTime[1].replace("/","-").replace("/","-"));
      }else{
        $("#m_timePullStartDate_form").val("");
        $("#m_timePullEndDate_form").val("");
      }
      if(strBackTime!=""){
        strBackTime = strBackTime.split("- ");
        $("#m_timeBackStartDate_form").val(strBackTime[0].replace("/","-").replace("/","-"));
        $("#m_timeBackEndDate_form").val(strBackTime[1].replace("/","-").replace("/","-"));
      }else{
        $("#m_timeBackStartDate_form").val("");
        $("#m_timeBackEndDate_form").val("");
      }
      var params = $("#product_form").serialize();
      params = decodeURI(params);
      olvPagination.onLoad(params);
    }
    // 查询
    function query() {
      $("#cache").val(0);
      productQuery();
    }
    //重置
    function reset(){
      $("#cache").val(1);
      $("#reservationPull").val("");
      $("#reservationBack").val("");
      $("#pullId_input").val("");
      $("#backId_input").val("");
      $("#username_input").val("");
      $("#blacklisttype_input").val("");
      productQuery();
    }
    //初始化包装单位列表
    function initOlv() {
      var url = __ctxPath+"/memBasic/getBlackList";
      olvPagination = $("#olvPagination").myPagination({
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
          ajaxStart : function() {
            $("#loading-container").attr("class",
                    "loading-container");
          },
          ajaxStop : function() {
            setTimeout(function() {
              $("#loading-container").addClass(
                      "loading-inactive")
            }, 300);
          },
          callback: function(data) {
            $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
          }
        }
      });
      function toChar(data) {
        if(data == null) {
          data = "";
        }
        return data;
      }
    }
    function successBtn(){
      $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
      $("#pageBody").load(__ctxPath+"/jsp/mem/editBlackList.jsp");
    }

    function editBlack(){
      var checkboxArray=[];
      $("input[type='checkbox']:checked").each(function(i,team){
        var sid=$(this).val().trim();
        checkboxArray.push(sid);
      });
      if (checkboxArray.length > 1) {
        $("#warning2Body").text("只能选择一个用户!");
        $("#warning2").show();
        return;
      } else if (checkboxArray.length == 0) {
        $("#warning2Body").text("请选择要编辑的用户!");
        $("#warning2").show();
        return;
      }
      var sid=checkboxArray[0].trim();
      var blackStatus=$("#blackStatus_"+sid).text().trim();
      if(blackStatus=="正常"){
        $("#warning2Body").text("该用户不在黑名单中,无法编辑!");
        $("#warning2").show();
        return;
      }
      //回显
      $("#editBlackSid").val(sid);
      $(".edit_msg").hide();
      var pullType=$("#pullType_"+sid).text().trim();
      if(pullType=="恶意下单"){
        $("#pullType").val("0");
      }
      if(pullType=="恶意评论"){
        $("#pullType").val("1");
      }
      var pullReason=$("#pullReason_"+sid).text().trim();
      $("#pullReason").val(pullReason);
      $("#editBlackDiv").show();
    }
    function closeEdit(){
      //清除隐藏div表单内容
      $(".edit_msg").hide();
      $("#pullType").val("0");
      $("#pullReason").val("");
      $("#editBlackDiv").hide();
    }
    function submitEditBlack(){
      var sid=$("#editBlackSid").val();
      var pullType=$("#pullType").val();
      var pullReason=$("#pullReason").val();
      if(pullReason==""||pullReason==null){
        $("#pullReason_msg").show();
        return;
      }

      var url = __ctxPath+"/memBasic/editBlackList";
      $.ajax({
        type : "post",
        contentType : "application/x-www-form-urlencoded;charset=utf-8",
        url : url,
        dataType : "json",
        ajaxStart : function() {
          $("#loading-container").attr(
                  "class",
                  "loading-container");
        },
        ajaxStop : function() {
          //隐藏加载提示
          setTimeout(
                  function() {
                    $("#loading-container")
                            .addClass(
                            "loading-inactive")
                  }, 300);
        },
        data :{"sid":sid,"pullType":pullType,"pullReason":pullReason},
        success : function(response) {
          if (response.success == "true") {
            $("#modal-body-success")
                    .html(
                    "<div class='alert alert-success fade in'><strong>编辑成功，返回列表页!</strong></div>");
            $("#modal-success")
                    .attr(
                    {
                      "style" : "display:block;z-index:9999",
                      "aria-hidden" : "false",
                      "class" : "modal modal-message modal-success"
                    });
            $("#pullBlackDiv").hide();

          } else  {
            $("#model-body-warning")
                    .html(
                    "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                    + "编辑失败!"
                    + "</strong></div>");
            $("#modal-warning")
                    .attr(
                    {
                      "style" : "display:block;z-index:9999",
                      "aria-hidden" : "false",
                      "class" : "modal modal-message modal-warning"
                    });
          }
          return;
        },
        error : function() {
          $("model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
          $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
        }

      });
    }

    //解除黑名单
    function relieveBlack(){
      var checkboxArray=[];
      $("input[type='checkbox']:checked").each(function(i,team){
        var sid=$(this).val().trim();
        checkboxArray.push(sid);
      });
      if (checkboxArray.length > 1) {
        $("#warning2Body").text("只能选择一个用户!");
        $("#warning2").show();
        return;
      } else if (checkboxArray.length == 0) {
        $("#warning2Body").text("请选择要解除的用户!");
        $("#warning2").show();
        return;
      }
      var sid=checkboxArray[0].trim();
      var blackStatus=$("#blackStatus_"+sid).text().trim();
      if(blackStatus=="正常"){
        $("#warning2Body").text("该用户不在黑名单中!");
        $("#warning2").show();
        return;
      }
      //清除隐藏div的数据
      $("#relieveBlackSid").val(sid);
      $(".relieve_msg").hide();
      $("#relServiceId").val("");
      $("#relieveReason").val("");
      $("#relieveBlackDiv").show();
    }
    function closeEdit(){
      //清除隐藏div表单内容
      $(".relieve_msg").hide();
      $("#relServiceId").val("");
      $("#relieveReason").val("");
      $("#relieveBlackDiv").hide();
    }
    function submitRelieveBlack(){
      var sid=$("#relieveBlackSid").val();
      var relServiceId=$("#relServiceId").val();
      var relieveReason=$("#relieveReason").val();
      if(relServiceId==""||relServiceId==null){
        $("#relServiceId_msg").show();
        return;
      }
      if(relieveReason==""||relieveReason==null){
        $("#relieveReason_msg").show();
        return;
      }

      var url = __ctxPath+"/memBasic/relieveBlackList";
      $.ajax({
        type : "post",
        contentType : "application/x-www-form-urlencoded;charset=utf-8",
        url : url,
        dataType : "json",
        ajaxStart : function() {
          $("#loading-container").attr(
                  "class",
                  "loading-container");
        },
        ajaxStop : function() {
          //隐藏加载提示
          setTimeout(
                  function() {
                    $("#loading-container")
                            .addClass(
                            "loading-inactive")
                  }, 300);
        },
        data :{"sid":sid,"relServiceId":relServiceId,"relieveReason":relieveReason},
        success : function(response) {
          if (response.success == "true") {
            $("#modal-body-success")
                    .html(
                    "<div class='alert alert-success fade in'><strong>解除成功，返回列表页!</strong></div>");
            $("#modal-success")
                    .attr(
                    {
                      "style" : "display:block;z-index:9999",
                      "aria-hidden" : "false",
                      "class" : "modal modal-message modal-success"
                    });
            $("#pullBlackDiv").hide();

          } else  {
            $("#model-body-warning")
                    .html(
                    "<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
                    + "编辑失败!"
                    + "</strong></div>");
            $("#modal-warning")
                    .attr(
                    {
                      "style" : "display:block;z-index:9999",
                      "aria-hidden" : "false",
                      "class" : "modal modal-message modal-warning"
                    });
          }
          return;
        },
        error : function() {
          $("model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
          $("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
        }

      });
    }
  </script>
  <!-- 加载样式 -->
  <script type="text/javascript">
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
            <div class="widget-header ">黑名单信息</h5>
              <div class="widget-buttons">
                <a href="#" data-toggle="maximize"></a> <a href="#"
                                                           data-toggle="collapse" onclick="tab('pro');"> <i
                      class="fa fa-minus" id="pro-i"></i>
              </a> <a href="#" data-toggle="dispose"></a>
              </div>
            </div>
            <div class="widget-body" id="pro">
              <div class="table-toolbar">
                <ul class="topList clearfix">
                  <li class="col-md-4"><label class="titname">拉黑时间：</label>
                    <input type="text" id="reservationPull" /></li>
                  <li class="col-md-4"><label class="titname">解除时间：</label>
                    <input type="text" id="reservationBack" /></li>
                  <li class="col-md-4"><label class="titname">拉黑客服ID：</label>
                    <input type="text" id="pullId_input" /></li>
                  <li class="col-md-4"><label class="titname">解除客服ID：</label>
                    <input type="text" id="backId_input" /></li>
                    <li class="col-md-4"><label class="titname">账号：</label>
                    <input type="text" id="username_input" /></li>
                    <li class="col-md-4"><label class="titname">拉黑类型：</label>
                    <select type="text" id="blacklisttype_input" >
                    <option value="">请选择</option>
                    <option value="0">恶意下单</option>
                    <option value="1">恶意评论</option>
                    </select></li>
                  <li class="col-md-6">
                    <a onclick="query();" class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询</a>
                    <a onclick="reset();"class="btn btn-primary"> <i class="fa fa-random"></i> 重置</a>
                    <a onclick="editBlack();"class="btn btn-primary"> <i class="fa fa-random"></i> 编辑</a>
                    <a onclick="relieveBlack();"class="btn btn-primary"> <i class="fa fa-random"></i> 解除</a>
                  </li>
                </ul>

                <table class="table table-bordered table-striped table-condensed table-hover flip-content"
                       id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                  <thead>
                  <tr role="row" style='height:35px;'>
                    <th style="text-align: center;" width="2%">选择</th>
                    <th style="text-align: center;" width="10%">账户</th>
                    <th style="text-align: center;" width="10%">拉黑客服</th>
                    <th style="text-align: center;" width="10%">拉黑时间</th>
                    <th style="text-align: center;" width="10%">拉黑类型</th>
                    <th style="text-align: center;" width="10%">拉黑原因</th>
                    <th style="text-align: center;" width="10%">解除客服</th>
                    <th style="text-align: center;" width="10">解除时间</th>
                    <th style="text-align: center;" width="10%">解除原因</th>
                    <th style="text-align: center;" width="10%">状态</th>
                  </tr>
                  </thead>
                  <tbody>
                  </tbody>
                </table>
                <div class="pull-left" style="padding: 10px 0;">
                  <form id="product_form" action="">
                    <input type="hidden" id="m_timePullStartDate_form" name="m_timePullStartDate"/>
                    <input type="hidden" id="m_timePullEndDate_form" name="m_timePullEndDate"/>
                    <input type="hidden" id="m_timeBackStartDate_form" name="m_timeBackStartDate"/>
                    <input type="hidden" id="m_timeBackEndDate_form" name="m_timeBackEndDate"/>
                    <input type="hidden" id="username_from" name="cid" />
                    <input type="hidden" id="blacklisttype_from" name="listtype" />
                    <input type="hidden" id="pullId_from" name="pullId" />
                    <input type="hidden" id="backId_from" name="backId" />
                    <input type="hidden" id="cache" name="cache" value="1" />
                  </form>
                </div>
                <div id="olvPagination"></div>
              </div>
              <!-- Templates -->
              <p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
                                                  <td align="left">
                                                    <div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
                                                      <label style="padding-left:9px;">
                                                        <input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
                                                        <span class="text"></span>
                                                      </label>
                                                    </div>
                                                  </td>
                                                  <td align="center" id="cid_{$T.Result.sid}">
                                                    {#if $T.Result.cid == "" || $T.Result.cid == null}--
                                                    {#else}{$T.Result.cid}
                                                    {#/if}
                                                  </td>
                                                  <td align="center" id="pullId_{$T.Result.sid}">
                                                    {#if $T.Result.service_id == "" || $T.Result.service_id == null}--
                                                    {#else}{$T.Result.service_id}
                                                    {#/if}
                                                  </td>
                                                  <td align="center" id="pullTime_{$T.Result.sid}">
                                                    {#if $T.Result.pull_time == "" || $T.Result.pull_time == null}--
                                                    {#else}{$T.Result.pull_time}
                                                    {#/if}
                                                  </td>
                                                  <td align="center" id="pullType_{$T.Result.sid}">
                                                    {#if $T.Result.pull_reason_type == "" || $T.Result.pull_reason_type == null}--
                                                    {#/if}
                                                    {#if $T.Result.pull_reason_type == "0"}恶意下单
                                                    {#/if}
                                                    {#if $T.Result.pull_reason_type == "1"}恶意评论
                                                    {#/if}
                                                  </td>
                                                  <td align="center" id="pullReason_{$T.Result.sid}">
                                                    {#if $T.Result.pull_reason_desc == "" || $T.Result.pull_reason_desc == null}--
                                                    {#else}{$T.Result.pull_reason_desc}
                                                    {#/if}
                                                  </td>

                                                  <td align="center" id="backId_{$T.Result.sid}">
                                                    {#if $T.Result.relService_id == "" || $T.Result.relService_id == null}--
                                                    {#else}{$T.Result.relService_id}
                                                    {#/if}
                                                  </td>
                                                  <td align="center" id="backTime_{$T.Result.sid}">
                                                    {#if $T.Result.relieve_time == "" || $T.Result.relieve_time == null}
                                                    {#else}{$T.Result.relieve_time}
                                                    {#/if}
                                                  </td>
                                                  <td align="center" id="backReason_{$T.Result.sid}">
                                                    {#if $T.Result.relieve_reason == "" || $T.Result.relieve_reason == null}--
                                                    {#else}{$T.Result.relieve_reason}
                                                    {#/if}
                                                  </td>
                                                  <td align="center" id="blackStatus_{$T.Result.sid}">
                                                    {#if $T.Result.current_status == "" || $T.Result.current_status == null}--
                                                    {#/if}
                                                    {#if $T.Result.current_status == "0"}正常
                                                    {#/if}
                                                    {#if $T.Result.current_status == "1"}已拉黑
                                                    {#/if}
                                                  </td>
                                                </tr>
											{#/for}
									    {#/template MAIN}
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
</div>

<!--编辑黑名单 -->
<div class="modal modal-darkorange"
     id="editBlackDiv">
  <div class="modal-dialog"
       style="width: 800px; height: auto; margin: 4% auto;">
    <div class="modal-content">
      <div class="modal-header">
        <button aria-hidden="true" data-dismiss="modal" class="close"
                type="button" onclick="closeEdit();">×</button>
        <h4 class="modal-title">编辑单</h4>
      </div>
      <div class="page-body">
        <div class="row">
          <form method="post" class="form-horizontal">
            <div class="col-xs-12 col-md-12">
              <input type="hidden" id="editBlackSid"/>
              <div class="col-md-12" style="padding: 10px 100px;">
                <label class="col-md-5 control-label"
                       style="line-height: 20px; text-align: right;">拉黑类型：</label>
                <div class="col-md-6">
                  <select id="pullType">
                    <option value="0" checked="checked">恶意下单</option>
                    <option value="1">恶意评论</option>
                  </select>
                </div>
                <br>&nbsp;
              </div>


              <div class="col-md-12" style="padding: 10px 100px;">
                <label class="col-md-5 control-label"
                       style="line-height: 20px; text-align: right;">拉黑原因：</label>
                <div class="col-md-6">
                  <input type="text" class="form-control" name="name"
                         id="pullReason" />
                  <span id="pullReason_msg" style="color:red;display:none;" class="edit_msg">不能为空!</span>
                </div>
                <br>&nbsp;
              </div>

            </div>
            <br>&nbsp;
            <div class="form-group">
              &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
              &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
              &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
              <input class="btn btn-danger" onclick="submitEditBlack();" style="width: 25%;"
                     id="submit" type="button" value="确定" />
            </div>
          </form>
        </div>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!--解除黑名单 -->
<div class="modal modal-darkorange"
     id="relieveBlackDiv">
  <div class="modal-dialog"
       style="width: 800px; height: auto; margin: 4% auto;">
    <div class="modal-content">
      <div class="modal-header">
        <button aria-hidden="true" data-dismiss="modal" class="close"
                type="button" onclick="closeRelieveBlack();">×</button>
        <h4 class="modal-title">解除黑名单</h4>
      </div>
      <div class="page-body">
        <div class="row">
          <form method="post" class="form-horizontal">
            <div class="col-xs-12 col-md-12">
              <input type="hidden" id="relieveBlackSid"/>
              <div class="col-md-12" style="padding: 10px 100px;">
                <label class="col-md-5 control-label"
                       style="line-height: 20px; text-align: right;">客服ID：</label>
                <div class="col-md-6">
                  <input type="text" class="form-control" name="name"
                         id="relServiceId" />
                  <span id="relServiceId_msg" style="color:red;display:none;" class="relieve_msg">不能为空!</span>
                </div>
                <br>&nbsp;
              </div>

              <div class="col-md-12" style="padding: 10px 100px;">
                <label class="col-md-5 control-label"
                       style="line-height: 20px; text-align: right;">解除原因：</label>
                <div class="col-md-6">
                  <input type="text" class="form-control" name="name"
                         id="relieveReason" />
                  <span id="relieveReason_msg" style="color:red;display:none;" class="relieve_msg">不能为空!</span>
                </div>
                <br>&nbsp;
              </div>

            </div>
            <br>&nbsp;
            <div class="form-group">
              &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
              &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
              &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
              <input class="btn btn-danger" onclick="submitRelieveBlack();" style="width: 25%;"
                     type="button" value="确定" />
            </div>
          </form>
        </div>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
</body>
</html>

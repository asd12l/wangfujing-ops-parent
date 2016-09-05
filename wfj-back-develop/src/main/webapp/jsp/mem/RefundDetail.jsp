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
      $("#reservation").daterangepicker();
      $("#refund_cid").val(cid);
      initOlv();
    });

    function productQuery(){
      $("#reOrderNo_from").val($("#reOrderNo_input").val().trim());
      $("#orderNo_from").val($("#orderNo_input").val().trim());
      var strTime = $("#reservation").val();
      if(strTime!=""){
        strTime = strTime.split("- ");
        $("#m_timeStartDate_form").val(strTime[0].replace("/","-").replace("/","-"));
        $("#m_timeEndDate_form").val(strTime[1].replace("/","-").replace("/","-"));
      }else{
        $("#m_timeStartDate_form").val("");
        $("#m_timeEndDate_form").val("");
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
      $("#reOrderNo_input").val("");
      $("#orderNo_input").val("");
      $("#reservation").val("");
      productQuery();
    }
    //初始化包装单位列表
    function initOlv() {
      var url = __ctxPath+"/memBasic/getMemRefund?cid="+cid;
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
      $("#pageBody").load(__ctxPath+"/jsp/mem/RefundDetail.jsp");
    }
    function back(){
      $("#pageBody").load(__ctxPath+"/jsp/mem/MemberRefundView.jsp");
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
            <div class="widget-header ">
              <h5 class="widget-caption">退货记录信息</h5>
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
                  <li class="col-md-4"><label class="titname">退货时间：</label>
                    <input type="text" id="reservation" /></li>
                  <li class="col-md-4"><label class="titname">退货单号：</label>
                    <input type="text" id="reOrderNo_input" /></li>
                  <li class="col-md-4"><label class="titname">订单号：</label>
                    <input type="text" id="orderNo_input" /></li>
                  <li class="col-md-6">
                    <a onclick="query();" class="btn btn-yellow">
                      <i class="fa fa-eye"></i> 查询
                    </a>
                    <a onclick="reset();" class="btn btn-primary">
                      <i class="fa fa-random"></i> 重置
                    </a>
                    <a onclick="back();" class="btn btn-primary">
                      <i class="fa fa-random"></i> 返回上一级
                    </a>
                  </li>
                </ul>
                <table class="table table-bordered table-striped table-condensed table-hover flip-content"
                       id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                  <thead>
                  <tr role="row" style='height:35px;'>
                    <th style="text-align: center;" width="10%">退货单号</th>
                    <th style="text-align: center;" width="10%">订单号</th>
                    <th style="text-align: center;" width="10%">应退金额</th>
                    <th style="text-align: center;" width="10%">实退金额</th>
                    <th style="text-align: center;" width="10%">退货单状态</th>
                    <th style="text-align: center;" width="10%">退货申请时间</th>
                    <th style="text-align: center;" width="10%">退货原因</th>
                  </tr>
                  </thead>
                  <tbody>
                  </tbody>
                </table>
                <div class="pull-left" style="padding: 10px 0;">
                  <form id="product_form" action="">
                    <input type="hidden" id="refund_cid" name="cid" />
                    <input type="hidden" id="reOrderNo_from" name="refundNo" />
                    <input type="hidden" id="orderNo_from" name="orderNo" />
                    <input type="hidden" id="m_timeStartDate_form" name="startTime"/>
                    <input type="hidden" id="m_timeEndDate_form" name="endTime"/>
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
                                                  <td align="center">
                                                    {#if $T.Result.refundNo == "" || $T.Result.refundNo == null}--
                                                    {#else}{$T.Result.refundNo}
                                                    {#/if}
                                                  </td>
                                                  <td align="center">
                                                    {#if $T.Result.orderNo == "" || $T.Result.orderNo == null}--
                                                    {#else}{$T.Result.orderNo}
                                                    {#/if}
                                                  </td>
                                                  <td align="center">
                                                    {#if $T.Result.refundAmount == "" || $T.Result.refundAmount == null}
                                                    {#else}{$T.Result.refundAmount}
                                                    {#/if}
                                                  </td>
                                                  <td align="center">
                                                    {#if $T.Result.needRefundAmount == "" || $T.Result.needRefundAmount == null}--
                                                    {#else}{$T.Result.needRefundAmount}
                                                    {#/if}
                                                  </td>
                                                  <td align="center">
                                                    {#if $T.Result.refundStatusDesc == "" || $T.Result.refundStatusDesc == null}--
                                                    {#else}{$T.Result.refundStatusDesc}
                                                    {#/if}
                                                  </td>

                                                  <td align="center">
                                                    {#if $T.Result.refundTimeStr == "" || $T.Result.refundTimeStr == null}--
                                                    {#else}{$T.Result.refundTimeStr}
                                                    {#/if}
                                                  </td>
                                                  <td align="center">
                                                    {#if $T.Result.refundReason == "" || $T.Result.refundReason == null}--
                                                    {#else}{$T.Result.refundReason}
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
</body>
</html>
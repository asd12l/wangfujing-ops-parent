<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
    <script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
    <script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
    <style type='text/css'>
        #product_tab{width:70%;margin-left:130px;}
        #sid0{width:30px;}
        td,th{text-align:center;}
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <script type="text/javascript">
        __ctxPath = "${pageContext.request.contextPath}";
        var productPagination;
        $(function() {
            initUserRole();
            $("#pageSelect").change(userRoleQuery);
        });
        function userRoleQuery(){
            var params = $("#gp_form").serialize();
            //alert("表单序列化后请求参数:"+params);
            params = decodeURI(params);
            productPagination.onLoad(params);
        }

        //新增区间
        function addGp(){
            var url = __ctxPath+"/jsp/search/gp/gpAdd.jsp";
            $("#pageBody").load(url);
        }





        //初始化
        function initUserRole() {
            var url = __ctxPath+"/gp/getGpList";
            productPagination = $("#productPagination").myPagination({
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
                        ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
                    },
                    ajaxStop: function() {
                        //隐藏加载提示
                        setTimeout(function() {
                            ZENG.msgbox.hide();
                        }, 300);
                    },
                    callback: function(data) {
                        if(data.success == true){
                            $("#product_tab tbody").setTemplateElement("product-list").processTemplate(data);
                        }else{
                            $("#model-body-warning").html("<div class='alert alert-warning fade in'><i></i><strong>"+data.message+"</strong></div>");
                            $("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
                        }

                    }
                }
            });
        }
    </script>
</head>
<body>
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
                            <span class="widget-caption"><h5>gp管理</h5></span>
                            <div class="widget-buttons">
                                <a href="#" data-toggle="maximize"></a>
                                <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                    <i class="fa fa-minus" id="pro-i"></i>
                                </a>
                                <a href="#" data-toggle="dispose"></a>
                            </div>
                        </div>
                        <div class="widget-body" id="pro">
                            <form id="gp_form" action="">
                                <div class="table-toolbar">
                                    <a id="editabledatatable_new" onclick="addGp();" class="btn btn-primary glyphicon glyphicon-plus">
                                        新增
                                    </a>
                                    <div class="btn-group pull-right">

                                        <select id="pageSelect" name="pageSize">
                                            <option selected="selected">5</option>
                                            <option >10</option>
                                            <option>15</option>
                                            <option>20</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                            <table class="table table-striped table-hover table-bordered" id="product_tab">
                                <thead class="flip-content bordered-darkorange">
                                <tr role="row">
                                    <th style="width: 30%;">标题</th>
                                    <th>地址</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div id="productPagination"></div>
                        </div>
                        <!-- Templates -->
                        <p style="display:none">
									<textarea id="product-list" rows="0" cols="0">

										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td id="title_{$T.Result.gp}">
														{$T.Result.title}
													</td>
													<td id="{$T.Result.gp}" value="{$T.Result.field}">
                                                        <a href="http://{$T.urlTemplate}{$T.Result.gp}">http://{$T.urlTemplate}{$T.Result.gp}</a>
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
</body>
</html>
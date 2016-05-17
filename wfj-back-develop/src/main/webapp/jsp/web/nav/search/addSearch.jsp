<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- 热门搜索列表弹窗 -->
    <div class="modal modal-darkorange" id="addSearchDIV">
        <div class="modal-dialog" style="width: 70%;height: 80%;">
            <!-- Page Container -->
            <div class="page-container">
                <!-- Page Body -->
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeDiv();">×</button>
                                        <h5 class="widget-caption">添加热门搜索</h5>
 
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');"> <i class="fa fa-minus" id="pro-i"></i>
 
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                        <div class="col-md-2">
                                            <a id="editabledatatable_new" onclick="addSearch();" class="btn btn-primary" style="width: 100%;"> <i class="fa fa-random"></i> 添加</a> </div>
                                        <div class="mtb10"> <span>主标题:</span> 
                                            <input type="text" id="mainTitle_input" style="width: 10%;">     <a class="btn btn-default shiny" onclick="query();">查询</a>     <a class="btn btn-default shiny" onclick="reset();">重置</a>
 
                                        </div>
                                    </div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="search_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr>
                                                <th style="text-align: center;" width="5%">选择</th>
                                                <th style="text-align: center;">主标题</th>
                                                <th style="text-align: center;">副标题</th>
                                                <th style="text-align: center;">图片地址</th>
                                                <th style="text-align: center;">链接</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                    <div class="pull-left" style="padding: 10px 0;">
                                        <form id="search_form" action="">
                                            <div class="col-lg-12">
                                                <select id="pageSelect" name="pageSize" style="padding: 0 12px;">
                                                    <option>5</option>
                                                    <option selected="selected">10</option>
                                                    <option>15</option>
                                                    <option>20</option>
                                                </select>
                                            </div>
                                        </form>
                                        <input type="hidden" id="mainTitle_from" name="mainTitle">
                                        <input type="hidden" id="navSid">
                                    </div>
                                    <div id="searchPagination"></div>
                                </div>
                                <!-- Templates -->
                                <p style="display: none">
                                    <textarea id="search-list" rows="0" cols="0">
                                    <!-- {#template MAIN} 
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
                                                    <td align="center">{$T.Result.mainTitle}</td>
                                                    <td align="center">{$T.Result.subTitle}</td>
                                                    <td align="center">{$T.Result.pict}</td>
                                                    <td align="center">{$T.Result.link}</td>
                                                </tr>
                                            {#/for}
                                        {#/template MAIN}   -->
                                    </textarea>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
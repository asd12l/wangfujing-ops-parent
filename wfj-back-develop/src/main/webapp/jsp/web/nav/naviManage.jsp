<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="col-lg-3 col-sm-3 col-xs-3">
        <div class="web-header">导航目录</div>
        <ul id="navTree" class="ztree"></ul>
    </div>
    <div class="col-lg-9 col-sm-9 col-xs-9 p0 rightdiv">
        <div class="widget-header">
                <h5 class="widget-caption">导航管理</h5>
 
        </div>
        <form id="category_form" action="">
            <input type="hidden" id="cid" name="cid">
        </form>
        <div class="tabbable">
            <ul class="nav nav-tabs" id="myTab">
                <li class="active"><a data-toggle="tab" href="#hootBrand">热门品牌 </a>
                </li>
                <li class="tab-green"><a data-toggle="tab" href="#promotion">促销活动</a>
                </li>
                <li class="tab-green"><a data-toggle="tab" href="#hotword">热门搜索</a>
                </li>
                <li class="tab-green"><a data-toggle="tab" href="#navword">导航关键词</a>
                </li>
            </ul>
            <div class="tab-content" style="height: auto;">
                <!-- 导航管理 -->
                <!-- 热门品牌 -->
                <div id="hootBrand" class="tab-pane active">
                    <div class="btn-group clearfix">
                        <a onclick="addFloorBrand();" class="btn btn-labeled btn-palegreen">    <i class="btn-label glyphicon glyphicon-ok"></i>添加热门品牌</a>     
                        <a onclick="deleteBrand();" class="btn btn-labeled btn-darkorange"> <i class="btn-label glyphicon glyphicon-remove"></i>删除热门品牌</a>
                    </div>
                    <div class="centerDiv">
                        <table class="table table-hover table-bordered" id="hootBrand_tab">
                            <thead>
                                <tr role="row">
                                    <th style="text-align: center;" width="75px;">选择</th>
                                    <th style="text-align: center;">编号</th>
                                    <th style="text-align: center;">名称</th>
                                    <th style="text-align: center;">链接</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                    <!-- Templates -->
                    <p style="display: none">
                        <textarea id="hootBrand-list" rows="0" cols="0">
						<!-- {#template MAIN} {#foreach $T.list as Result} <tr class="gradeX">
                                    <td align="left">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
                                                <span class="text"></span>
                                            </label>
                                        </div>
                                    </td>
                                    <td align="center" id="brandsid_{$T.Result.sid}">{$T.Result.brandSid}</td>
                                    <td align="center" id="brandname_{$T.Result.sid}">{$T.Result.brandName}</td>
                                    <td align="center" id="brandlink_{$T.Result.sid}">{$T.Result.brandLink}</td>
                                    <td align="center" style="display:none;" id="brandisShow_{$T.Result.sid}">
                                    {#if $T.Result.isShow == 1}
                                        <span class="label label-success graded">1</span>
                                    {#elseif $T.Result.isShow == 0}
                                        <span class="label label-lightyellow graded">0</span>
                                    {#/if}
                                    </td>
                                    <td align="center" style="display:none;" id="flag_{$T.Result.sid}">
                                    {#if $T.Result.flag == 1}
                                        <span>1</span>
                                    {#elseif $T.Result.flag == 0}
                                        <span>0</span>
                                    {#/if}
                                    </td>
                                </tr>
                            {#/for}
                        {#/template MAIN}   -->
                        </textarea>
                    </p>
                </div>
                <!-- 促销活动 -->
                <div id="promotion" class="tab-pane">
                    <div class="btn-group clearfix">
                        <a onclick="addPromotion();" class="btn btn-labeled btn-palegreen"> <i class="btn-label glyphicon glyphicon-ok"></i>添加促销活动</a>     
                    	<a id="editabledatatable_new" onclick="updatePromotion();" class="btn btn-labeled btn-blue"><i class="btn-label glyphicon glyphicon-wrench"></i> 编辑促销活动 </a>
                        <a onclick="deletePromotion();" class="btn btn-labeled btn-darkorange"> <i class="btn-label glyphicon glyphicon-remove"></i>删除促销活动</a>
                    </div>
                    <div class="table-scrollable centerDiv">
                        <table class="table table-striped table-bordered table-hover" id="promotion_tab">
                            <thead>
                                <tr role="row">
                                    <th style="text-align: center;">选择</th>
                                    <th style="text-align: center;">活动名称</th>
                                    <th style="text-align: center;">链接</th>
                                    <th style="text-align: center;">图片</th>
                                    <th style="text-align: center;">顺序</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        <!-- Templates -->
                        <p style="display: none">
                            <textarea id="promotion-list" rows="0" cols="0">                                
                            <!-- {#template MAIN} {#foreach $T.list as Result} <tr class="gradeX">
                                        <td align="left">
                                            <div class="checkbox" style="margin-bottom: 0;margin-top: 0;">
												<label style="padding-left: 7px;">
                                                    <input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
                                                    <span class="text"></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td align="center" id="proName_{$T.Result.sid}">{$T.Result.promotionName}</td>
                                        <td style="white-space: normal;" align="center" id="proLink_{$T.Result.sid}">{$T.Result.promotionLink}</td>
                                        <td style="white-space: normal;" align="center" id="proPict_{$T.Result.sid}">{$T.resource_root_path}{$T.Result.pict}</td>
                                        <td align="center" id="proSeq_{$T.Result.sid}">{$T.Result.seq}</td>
                                        <td align="center" style="display:none;" id="proIsShow_{$T.Result.sid}">
                                        {#if $T.Result.isShow == 1}1
                                        {#elseif $T.Result.isShow == 0}0
                                        {#/if}
                                        </td>
                                        <td align="center" style="display:none;" id="proFlag_{$T.Result.sid}">
                                        {#if $T.Result.flag == 1}1
                                        {#elseif $T.Result.flag == 0}0
                                        {#/if}
                                        </td>
                                    </tr>
                                {#/for}
                            {#/template MAIN}   -->
                            </textarea>
                        </p>
                    </div>
                </div>
                <!-- 热门搜索 -->
                <div id="hotword" class="tab-pane">
                    <input type="hidden" id="siteId" name="siteId">
                    <input type="hidden" id="channelId" name="channelId">
                    <input type="hidden" id="navId" name="navId">
                    <div class="btn-group clearfix">
                        <a onclick="addHotwordDiv();" class="btn btn-labeled btn-palegreen">    <i class="btn-label glyphicon glyphicon-ok"></i>添加关键词</a>     
                        <a onclick="deleteHotWord();" class="btn btn-labeled btn-darkorange"> <i class="btn-label glyphicon glyphicon-remove"></i>删除关键词</a>
                    </div>
                    <div class="centerDiv">
                        <table class="table table-hover table-bordered" id="hotword_tab_db">
                            <thead>
                                <tr role="row">
                                    <th style="text-align: center;" width="75px;">选择</th>
                                    <th style="text-align: center;">关键词</th>
                                    <th style="text-align: center;">链接</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        <!-- Templates -->
                        <p style="display: none">
                            <textarea id="hotword-list-db" rows="0" cols="0">                                
                            <!-- {#template MAIN} {#foreach $T.list as Result} <tr class="gradeX">
                                        <td align="left">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
                                                    <span class="text"></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td align="center" id="brandname_{$T.Result.sid}">{$T.Result.hotword}</td>
                                        <td align="center" id="brandlink_{$T.Result.sid}">{$T.Result.link}</td>
                                    </tr>
                                {#/for}
                            {#/template MAIN}   -->
                            </textarea>
                        </p>
                    </div>
                </div>
                <!-- 导航关键词 -->
                <div id="navword" class="tab-pane">
                    <div class="btn-group clearfix">
                        <a onclick="addNavWord();" class="btn btn-labeled btn-palegreen"> <i class="btn-label glyphicon glyphicon-ok"></i>添加导航关键词</a>     
                        <a onclick="deleteNavWord();" class="btn btn-labeled btn-darkorange"> <i class="btn-label glyphicon glyphicon-remove"></i>删除导航关键词</a>
                    </div>
                    <div class="centerDiv">
                        <table class="table table-hover table-bordered" id="navword_tab">
                            <thead>
                                <tr role="row">
                                    <th style="text-align: center;" width="75px;">选择</th>
                                    <th style="text-align: center;">关键词名称</th>
                                    <th style="text-align: center;">链接</th>
                                    <th style="text-align: center;">顺序</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        <!-- Templates -->
                        <p style="display: none">
                            <textarea id="navword-list" rows="0" cols="0">                                
                            <!-- {#template MAIN} {#foreach $T.list as Result} <tr class="gradeX">
                                        <td align="left">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
                                                    <span class="text"></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td align="center" id="proName_{$T.Result.sid}">{$T.Result.navWordName}</td>
                                        <td align="center" id="proLink_{$T.Result.sid}">{$T.Result.navWordLink}</td>
                                        <td align="center" id="proSeq_{$T.Result.sid}">{$T.Result.seq}</td>
                                        <td align="center" style="display:none;" id="proIsShow_{$T.Result.sid}">
                                        {#if $T.Result.isShow == 1}
                                            <span class="label label-success graded">1</span>
                                        {#elseif $T.Result.isShow == 0}
                                            <span class="label label-lightyellow graded">0</span>
                                        {#/if}
                                        </td>
                                        <td align="center" style="display:none;" id="proFlag_{$T.Result.sid}">
                                        {#if $T.Result.flag == 1}
                                            <span>1</span>
                                        {#elseif $T.Result.flag == 0}
                                            <span>0</span>
                                        {#/if}
                                        </td>
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
    <!-- 热门关键词 -->
    <%@ include file="chnnlHotSearch/addHotWord.jsp" %>
        <%@ include file="viewNav.jsp" %>
            <%@ include file="editNav.jsp" %>
                <%@ include file="addNav.jsp" %>
                    <%-- <%@ include file="brand/addBrand.jsp" %>
                        <%@ include file="brand/editBrand.jsp" %> --%>
                            <%@ include file="promotion/addPromotion.jsp" %>
                                <%@ include file="promotion/editPromotion.jsp" %>
                                    <%@ include file="navword/addNavWord.jsp" %>
                                        <%@ include file="search/addSearch.jsp" %>
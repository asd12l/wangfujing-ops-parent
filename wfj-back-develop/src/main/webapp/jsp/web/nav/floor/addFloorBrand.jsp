<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- 品牌列表弹窗 -->
    <div class="modal modal-darkorange" id="addBrandDIV">
        <div class="modal-dialog clearfix" style="width: 70%;">
            <div class="row widget">
                <div class="widget-header">
                    <h5 class="widget-caption">品牌列表</h5>
                    <div class="widget-buttons">    
                    	<a href="#" aria-hidden="true" data-toggle="collapse" data-dismiss="modal" onclick="closeDiv();"><i class="fa fa-times"></i></a>
                    </div>
                </div>
                <div class="widget-body" id="pro" style="height: 500px; overflow: auto;">
                    <div class="table-toolbar clearfix">
                        <div class="col-sm-12">
                            <label>品牌编码：</label>
                            <input type="text" id="orderNo_input" class="clear_input" style="width: 20%;">　
                            <label>品牌名称：</label>
                            <input type="text" id="brandName_input" class="clear_input" style="width: 20%;">　　
                            <label><a onclick="olvQuery();" class="btn btn-default">查询</a>
                            </label>　
                            <label><a onclick="resetBrand();" class="btn btn-default">重置</a>
                            </label>　
                            <label><a onclick="addDivBrand();" class="btn btn-default">添加</a>
                            </label>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="floor_brand_tab">
                        <thead class="flip-content bordered-darkorange">
                            <tr role="row">
                                <th style="text-align: center;" width="75px;">选择</th>
                                <th style="text-align: center;">品牌编码</th>
                                <th style="text-align: center;">品牌名称</th>
                                <th style="text-align: center;">品牌类型</th>
                                <th id="two" style="text-align: center;display:none;">门店类型</th>
                                <th id="two2" style="text-align: center;display:none;">所属集团品牌</th>
                                <th style="text-align: center;">拼音</th>
                                <th style="text-align: center;">中文名称</th>
                                <th style="text-align: center;">英文名称</th>
                                <th style="text-align: center;">是否展示</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div class="pull-left" style="padding: 10px 0;">
                        <form id="brand_form" action="">
                            <select id="brand_pageSelect" name="pageSize" style="padding: 0 12px;">
                                <option>5</option>
                                <option selected="selected">10</option>
                                <option>15</option>
                                <option>20</option>
                            </select>
                            <input type="hidden" id="brandName_from" name="brandName">
                            <input type="hidden" id="brandNo_from" name="brandSid">
                            <input type="hidden" id="brandSids_form" name="brandSids">
                        </form>
                    </div>
                    <div id="brandPagination"></div>
                    <!-- Templates -->
                    <p style="display: none">
                        <textarea id="floor_brand-list" rows="0" cols="0">                            
                        <!-- {#template MAIN} {#foreach $T.list as Result} 
                        		<tr class="gradeX">
                                    <td align="left" class="brandTypeTd">
                                        <div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
                                            <label>
                                                <input type="checkbox" id="tdCheckbox_{$T.Result.brandSid}" value="{$T.Result.brandSid}" >
                                                <span class="text"></span>
                                            </label>
                                        </div>
                                    </td>
                                    <td align="center" id="brandSid_{$T.Result.brandSid}">{$T.Result.brandSid}</td>
                                    <td align="center" id="brandName_{$T.Result.brandSid}">{$T.Result.brandName}</td>
                                    <td align="center" id="brandType_{$T.Result.brandSid}" brandType="{$T.Result.brandType}">
                                        {#if $T.Result.brandType == 0}
                                            <span>集团品牌</span>
                                        {#else}
                                            <span>门店品牌</span>
                                        {#/if}
                                        {#if $T.Result.url == null}
                                            <input type="hidden" id="brandUrl_{$T.Result.brandSid}" value="" />
                                        {#else}
                                            <input type="hidden" id="brandUrl_{$T.Result.brandSid}" value="{$T.Result.url}"  />
                                        {#/if}
                                        <input type="hidden" id="brandPict_{$T.Result.brandSid}" value="{$T.Result.brandpic1}"  />
                                        <input type="hidden" id="brandpic2_{$T.Result.brandSid}" value="{$T.Result.brandpic2}"  />
                                    </td>
                                     
                                    {#if $T.Result.brandType == 1}
                                        <td align="center" style="display:none;" id="shopType_{$T.Result.brandSid}" shopType="{$T.Result.shopType}">
                                            {#if $T.Result.shopType == 0}
                                                <span>北京</span>
                                            {#elseif $T.Result.shopType == 1}
                                                <span>外埠</span>
                                            {#else}
                                                <span>电商</span>
                                            {#/if}
                                        </td>
                                        <td align="center" style="display:none;" id="brandFatherName_{$T.Result.brandSid}">{$T.Result.brandFatherName}</td>
                                    {#/if}
                                    <td align="center" style="display:none;" id="shopSid_{$T.Result.brandSid}">{$T.Result.shopSid}</td>
                                    <td align="center" style="display:none;" id="status_{$T.Result.brandSid}">{$T.Result.status}</td>
                                    <td align="center" style="display:none;" id="parentSid_{$T.Result.brandSid}">{$T.Result.parentSid}</td>
                                    <td align="center" style="display:none;" id="shopType_{$T.Result.brandSid}">{$T.Result.shopType}</td>
                                    <td align="center" style="display:none;" id="shopSid_{$T.Result.brandSid}">{$T.Result.shopSid}</td>
                                    <td align="center" id="spell_{$T.Result.brandSid}">{$T.Result.spell}</td>
                                    <td align="center" id="brandNameSecond_{$T.Result.brandSid}">{$T.Result.brandNameSecond}</td>
                                    <td align="center" id="brandNameEn_{$T.Result.brandSid}">{$T.Result.brandNameEn}</td>
                                    <td align="center" style="display:none;" id="status_{$T.Result.brandSid}">
                                        {#if $T.Result.status == 0}
                                            <span>有效</span>
                                        {#else}
                                            <span>无效</span>
                                        {#/if}
                                    </td>
                                    <td align="center" id="isDisplay_{$T.Result.brandSid}" isDisplay="{$T.Result.isDisplay}">
                                        {#if $T.Result.isDisplay == 0}
                                            <span class="label label-success graded">是</span>
                                        {#else}
                                            <span class="label label-lightyellow graded">否</span>
                                        {#/if}
                                    </td>
                                    <td align="center" style="display:none;" id="brandcorp_{$T.Result.brandSid}">{$T.Result.brandcorp}</td>
                                    <td align="center" style="display:none;" id="brandDesc_{$T.Result.brandSid}">{$T.Result.brandDesc}</td>
                                    <td align="center" style="display:none;" id="brandSpecialty_{$T.Result.brandSid}">{$T.Result.brandSpecialty}</td>
                                    <td align="center" style="display:none;" id="brandSuitability_{$T.Result.brandSid}">{$T.Result.brandSuitability}</td>
                                    <td align="center" style="display:none;" id="optRealName_{$T.Result.brandSid}">{$T.Result.optRealName}</td>
                                    <td align="center" style="display:none;" id="optUpdateTimeStr_{$T.Result.brandSid}">{$T.Result.optUpdateTimeStr}</td>
                                </tr>
                                {#/for}
                            {#/template MAIN}    -->
                        </textarea>
                    </p>
                </div>
            </div>
        </div>
    </div>
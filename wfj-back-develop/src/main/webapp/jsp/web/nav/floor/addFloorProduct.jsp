<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- 商品列表弹窗 -->
    <div class="modal modal-darkorange" id="addProductDIV" style="margin-top: -15px;">
        <div class="modal-dialog clearfix" style="width: 70%;">
            <div class="page-container">
                <div class="" id="pageBodyRight">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                	<h5 class="widget-caption">商品列表</h5>
                                    <div class="widget-buttons">    
                                    	<a href="#" aria-hidden="true" data-toggle="collapse" data-dismiss="modal" onclick="closeDiv();"><i class="fa fa-times"></i></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                        <div class="mtb10">
                                            <table>
                                                <tbody><tr>
                                                    <td>编　　码：</td>
                                                    <td>
                                                        <input type="text" id="skuCode_input" class="clear_input" style="width:180px">　　　
                                                    </td>
                                                    <td>标准品名：</td>
                                                    <td>
                                                        <input type="text" id="skuName_input" class="clear_input" style="width:180px">　　　
                                                    </td>
                                                    <td>分类编码：</td>
                                                    <td>
                                                        <input type="text" id="cateZSCode_input" class="clear_input" style="width:180px">
                                                    </td>
                                                </tr>
                                                <!-- <tr>
                                                    <td>分　　类：</td>
                                                    <td>
                                                        <input type="text" id="cateZSName_input" class="clear_input" style="width:180px">　　　
                                                    </td>
                                                    <td>门　　店：</td>
                                                    <td>
                                                        <select data-toggle="simplecolorpicker" class="shopeCode_select" id="shopCode_select" onchange="getShoppeCode();" style="width: 180px; padding: 0px 0px">
                                                            <option value="">全部</option>
                                                        </select>　　　
                                                    </td>
                                                    <td>专　　柜：</td>
                                                    <td>
                                                        <select class="shoppeCode_select" id="shoppeCode_select" style="width: 180px; padding: 0px 0px">
                                                            <option value="">全部</option>
                                                        </select>
                                                    </td>
                                                </tr> -->
                                                <tr>
                                                    <td>类　　型：</td>
                                                    <td>
                                                        <select id="proType_select" style="width: 180px; padding: 0px 0px">
                                                            <option value="">全部</option>
                                                            <option value="1">普通商品</option>
                                                            <option value="2">赠品</option>
                                                            <option value="3">礼品</option>
                                                            <option value="4">虚拟商品</option>
                                                            <option value="5">服务类商品</option>
                                                        </select>    
                                                    </td>
                                                    <td>
                                                    	<a class="btn btn-default" onclick="queryPro();">查询</a></td>
                                                    <td><a class="btn btn-default" onclick="resetProduct();">重置</a>　
                                                    	<a class="btn btn-default" onclick="addProduct();">添加</a>
                                                    </td>
                                                </tr>
                                            </tbody></table>
                                        </div>
                                    </div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="product_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr>
                                                <th style="text-align: center;" width="5%">选择</th>
                                                <th style="text-align: center;">编码</th>
                                                <th style="text-align: center;">标准品名</th>
                                                <th style="text-align: center;">产品名称</th>
                                                <th style="text-align: center;">集团品牌名称</th>
                                                <th style="text-align: center;">类型</th>
                                                <th style="text-align: center;">商品价格</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                    <div class="pull-left" style="padding: 10px 0;">
                                        <form id="floor_product_form" action="">
                                            <input type="hidden" id="skuCode_from" name="skuCode">
                                            <input type="hidden" id="skuName_from" name="skuName">
                                            <input type="hidden" id="shopCode_from" name="shopCode">
                                            <input type="hidden" id="shoppeCode_from" name="shoppeCode">
                                            <input type="hidden" id="cateZSCode_from" name="cateZSCode">
                                            <input type="hidden" id="cateZSName_from" name="cateZSName">
                                            <input type="hidden" id="proType_from" name="proType">
                                            <input type="hidden" id="proSids_from" name="proSids">
                                            <div class="col-lg-12">
                                                <select id="pro_pageSelect" name="pageSize" style="padding: 0 12px;">
                                                    <option>5</option>
                                                    <option selected="selected">10</option>
                                                    <option>15</option>
                                                    <option>20</option>
                                                </select>
                                            </div>
                                        </form>
                                    </div>
                                    <div id="productPagination"></div>
                                </div>
                                <!-- Templates -->
                                <p style="display: none">
                                    <textarea id="product-list" rows="0" cols="0">
                                    <!-- {#template MAIN} {#foreach $T.list as Result} 
                                    			<tr class="gradeX">
                                                    <td align="left">
                                                        <div class="checkbox" style="margin-bottom: 0;margin-top: 0;">
                                                            <label style="padding-left:9px;">
                                                                <input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
                                                                <span class="text"></span>
                                                            </label>
                                                        </div>
                                                    </td>
                                                    <td align="center">{$T.Result.skuCode}</td>
                                                    <td align="center">{$T.Result.skuName}</td>
                                                    <td align="center" id="name_{$T.Result.sid}">{$T.Result.spuName}</td>
                                                    <td align="center">{$T.Result.brandGroupName}</td>
                                                    <td align="center">
                                                        {#if $T.Result.proType == 1}普通商品
                                                        {#elseif $T.Result.proType == 2}赠品
                                                        {#elseif $T.Result.proType == 3}礼品
                                                        {#elseif $T.Result.proType == 4}虚拟商品
                                                        {#elseif $T.Result.proType == 5}服务类商品
                                                        {#/if}
                                                    </td>
                                                    <td align="center" id="salePrice_{$T.Result.sid}">{$T.Result.salePrice}</td>
                                                    <td style="display:none;" id="primaryImgUrl_{$T.Result.sid}">{$T.Result.primaryImgUrl}</td>
                                                    <td style="display:none;" id="category_{$T.Result.sid}">{$T.Result.category}</td>
                                                    <td style="display:none;" id="categoryName_{$T.Result.sid}">{$T.Result.categoryName}</td>
                                                    <td style="display:none;" id="statCategoryName_{$T.Result.sid}">{$T.Result.statCategoryName}</td>
                                                    <td style="display:none;" id="brandGroupName_{$T.Result.sid}">{$T.Result.brandGroupName}</td>
                                                    <td style="display:none;" id="brandGroupCode_{$T.Result.sid}">{$T.Result.brandGroupCode}</td>
                                                    <td style="display:none;" id="spuCode_{$T.Result.sid}">{$T.Result.spuCode}</td>
                                                    <td style="display:none;" id="proSkuCode_{$T.Result.sid}">{$T.Result.skuCode}</td>
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
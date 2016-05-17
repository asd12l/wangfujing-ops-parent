<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="modal modal-darkorange" id="addHotBrandDIV">
        <div class="modal-dialog" style="width: 400px; margin: 100px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeDiv();">×</button>
                        <h4 class="modal-title">添加热门品牌</h4>
 
                </div>
                <div class="modal-body">
                    <div class="bootbox-body">
                        <div class="row" style="padding: 10px;">
                            <div class="col-md-12">
                                <form id="addHotForm" method="post" class="form-horizontal" enctype="multipart/form-data">
                                    <input type="hidden" id="nav_sid_hot" name="navSid" value="${navSid}">
                                    <div class="form-group">    <span style="color:red;">*</span>品牌名称：
                                        <input type="text" placeholder="必填" class="form-control" id="hot_add_name" name="name">
                                    </div>
                                    <div class="form-group">品牌链接：
                                        <input type="text" placeholder="" class="form-control" id="hot_add_link" name="link">
                                    </div>
                                    <div class="form-group">顺序：
                                        <input type="text" placeholder="" class="form-control" id="hot_add_seq" name="seq">
                                    </div>
                                    <div class="form-group" id="floorType">是否有效
                                        <div class="radio">
                                            <label>
                                                <input class="basic" type="radio" id="hot_isShow_1" name="isShow" value="1" checked="checked"> <span class="text">是</span>
 
                                            </label>
                                            <label>
                                                <input class="basic" type="radio" id="hot_isShow_0" name="isShow" value="0"> <span class="text">否</span>
 
                                            </label>
                                        </div>
                                        <div class="radio" style="display: none;">
                                            <label>
                                                <input class="inverted" type="radio" name="isShow"> <span class="text"></span>
 
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group" id="floorType">有无标签
                                        <div class="radio">
                                            <label>
                                                <input class="basic" type="radio" id="hot_flag_1" name="flag" value="1" checked="checked"> <span class="text">有</span>
 
                                            </label>
                                            <label>
                                                <input class="basic" type="radio" id="hot_flag_2" name="flag" value="2"> <span class="text">无</span>
 
                                            </label>
                                        </div>
                                        <div class="radio" style="display: none;">
                                            <label>
                                                <input class="inverted" type="radio" name="flag"> <span class="text"></span>
 
                                            </label>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" type="button" onclick="addHotBrandForm();">保存</button>
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeDiv();" type="button">返回</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
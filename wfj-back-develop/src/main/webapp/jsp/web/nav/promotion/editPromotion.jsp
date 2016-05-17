<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="modal modal-darkorange" id="editPromotionDIV">
        <div class="modal-dialog" style="width: 400px; margin: 100px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeDiv();">×</button>
                        <h4 class="modal-title">修改促销活动</h4>
                </div>
                <div class="modal-body">
                    <div class="bootbox-body">
                        <div class="row">
                            <div class="col-md-12">
                                <form id="editPromotionForm" method="post" class="form-horizontal" enctype="multipart/form-data">
                                    <input type="hidden" id="sid_promo" name="sid" value="">
                                    <input type="hidden" id="editPromoNodeId" name="nodeId" value="">
                                    <div class="form-group">
                                        <div class="col-lg-4 col-sm-4 col-xs-4 web-tr"><span style="color:red;">*</span>活动名称：</div>
                                        <div class="col-lg-8 col-sm-8 col-xs-8">
                                            <input type="text" placeholder="" class="form-control" id="name_promo" name="name">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-4 col-sm-4 col-xs-4 web-tr"><span style="color:red;">*</span>活动链接：</div>
                                        <div class="col-lg-8 col-sm-8 col-xs-8">
                                            <input type="text" placeholder="" class="form-control" id="link_promo" name="link">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-4 col-sm-4 col-xs-4 web-tr">活动图片：</div>
                                        <div class="col-lg-8 col-sm-8 col-xs-8">
                                            <input onchange="uploadlinkImg(this.id)" type="file" id="id_proEditPict" name="name_proEditPict" accept=".gif,.jpg,.png" /> 
											<input type="hidden" id="hidden_proEditPict" name="pict">
											<div id="msg_proEditPict">
												<img id="img_proEditPict" width="96px" height="96px" src="">
											</div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-4 col-sm-4 col-xs-4 web-tr"><span style="color:red;">*</span>顺&#12288;&#12288;序：</div>
                                        <div class="col-lg-8 col-sm-8 col-xs-8">
                                        	<div class="spinner spinner-horizontal spinner-two-sided">
	                                            <div class="spinner-buttons	btn-group spinner-buttons-left">
	                                                <button type="button" class="btn spinner-down danger">
	                                                    <i class="fa fa-minus"></i>
	                                                </button>
	                                            </div>
	                                            <input type="text" class="spinner-input form-control clear_input" id="seq_promo"
												name="seq" placeholder="" />
	                                            <div class="spinner-buttons	btn-group spinner-buttons-right">
	                                                <button type="button" class="btn spinner-up blue">
	                                                    <i class="fa fa-plus"></i>
	                                                </button>
	                                            </div>
	                                        </div>
                                        </div>
                                    </div>
                                    <div class="form-group" id="floorType">
                                        <div class="col-lg-4 col-sm-4 col-xs-4 web-tr">是否有效：</div>
                                        <div class="col-lg-8 col-sm-8 col-xs-8">
                                            <div class="radio">
                                                <label>
                                                    <input class="basic" type="radio" id="isShowPro_1" name="isShow" value="1"> <span class="text">是</span>
 
                                                </label>
                                                <label>
                                                    <input class="basic" type="radio" id="isShowPro_0" name="isShow" value="0"> <span class="text">否</span>
 
                                                </label>
                                            </div>
                                            <div class="radio" style="display: none;">
                                                <label>
                                                    <input class="inverted" type="radio" name="isShow"> <span class="text"></span>
 
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- <div class="form-group" id="floorType">
                                    有无标签
                                    <div class="radio">
                                        <label> <input class="basic" type="radio"
                                            id="isPro_1" name="flag" value="1" checked="checked"> <span
                                            class="text">有</span>
                                        </label> <label> <input class="basic" type="radio"
                                            id="isPro_0" name="flag" value="0" > <span
                                            class="text">无</span>
                                        </label>
                                    </div>
                                    <div class="radio" style="display: none;">
                                        <label> <input class="inverted" type="radio"
                                            name="flag"> <span class="text"></span>
                                        </label>
                                    </div>
                                </div> -->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" type="button" onclick="editPromotionForm();">保存</button>
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeDiv();" type="button">返回</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
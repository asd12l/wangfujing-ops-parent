/*
 * @(#)Constants.java 2015-7-10
 * 
 * 王府井集团拥有完全的版权
 * 使用者必须经过许可
 */
package com.wangfj.wms.util;

/**
 * Constant Definition/定义的常量
 *
 * @Class Name Constants
 * @Author wangsy
 * @Create In 2015年7月10日
 */
public interface Constants {
    /**
     * *************** CODE STYLE ********************
     */
    public static final String ARROW = " -> ";
    public static final String COLON = " : ";
    public static final String STRING_EMPTY_SPACE = " ";
    public static final String COMA = " , ";
    public static final String EXCLAMATION = " ! ";
    public static final String START = "Start ";
    public static final String END = "End ";
    public static final String DATE = " Date: ";
    public static final String EMPTY_LIST_ARRAY = "Empty List/ Array returned";
    public static final String NEW_LINE = "\n";
    public static final String WILDCARD = "%";

    /**
     * *************** SYSTEM RELATED SECTION - START ********************
     */
    public static final String SYS_ERR_404 = "SYS_ERR_404";
    public static final String SYS_ERR_404_DES = "Resource not found";
    public static final String SYS_ERR_404_DES_CN = "未找到资源";

    public static final String INV_ERR_001 = "INV_ERR_001";
    public static final String INV_ERR_001_DES = "The resource has been existed";
    public static final String INV_ERR_001_DES_CN = "资源已经存在";

    public static final String SYS_ERR_500 = "SYS_ERR_500";
    public static final String SYS_ERR_500_DES = "Internal System Error";
    public static final String SYS_ERR_500_DES_CN = "系统内部错误";

    public static final String VALIDATION_EXCEPTION = "VALIDATION_EXCEPTION";
    public static final String VALIDATION_EXCEPTION_DES_CN = "Validation Problem";
    public static final String DUPLICATE_ENTITY_EXCEPTION = "DUPLICATE_ENTITY_EXCEPTION";

    /**
     * 数据格式错误
     */
    public static final String INV_ERR_003 = "INV_ERR_003";
    public static final String INV_ERR_003_DES = "Wrong data format";
    public static final String INV_ERR_003_DES_CN = "数据格式错误";
    /**
     * 数据为空
     */
    public static final String INV_ERR_004 = "INV_ERR_004";
    public static final String INV_ERR_004_DES = "Cannot be null ";
    public static final String INV_ERR_004_DES_CN = "不能为空";
    /**
     * 没有通过数据校验
     */
    public static final String INV_ERR_006 = "INV_ERR_006";
    public static final String INV_ERR_006_DES = "Data not passed the validate";
    public static final String INV_ERR_006_DES_CN = "没有通过数据校验";

    public static final String INV_ERR_007 = "INV_ERR_007";
    public static final String INV_ERR_007_DES = "The message is empty";
    public static final String INV_ERR_007_DES_CN = "该消息是空的";

    public static final String INV_ERR_008 = "INV_ERR_008";
    public static final String INV_ERR_008_DES = "The input data have format problems";
    public static final String INV_ERR_008_DES_CN = "输入参数错误";

    public static final String SUCCESS = "true";
    public static final String FAILURE = "false";
    /**
     * A 添加 *
     */
    public static final String A = "A";
    /**
     * U 修改 *
     */
    public static final String U = "U";
    /**
     * D 删除 *
     */
    public static final String D = "D";

    public static final Integer PUBLIC_0 = 0;
    public static final Integer PUBLIC_1 = 1;
    public static final Integer PUBLIC_2 = 2;
    public static final Integer PUBLIC_3 = 3;
    public static final Integer PUBLIC_4 = 4;
    public static final Integer PUBLIC_5 = 5;
    public static final Integer PUBLIC_6 = 6;
    public static final Integer PUBLIC_7 = 7;
    public static final Integer PUBLIC_8 = 8;
    public static final Integer PUBLIC_9 = 9;
    public static final Integer PUBLIC_10 = 10;
    /**
     * 商品简称不能大于36字节
     */
    public static final Integer PUBLIC_36 = 36;

    public static final String Y = "Y";
    public static final String N = "N";

    public static final String YES = "YES";
    public static final String NO = "NO";

    public static final String STATUS_ERROR = "STATUS_ERROR";
    public static final String EXCEPTION_ERROR = "Exception Error";
    public static final String EXCEPTION_ERROR_CN = "错误";
    public static final String EXCEPTION_ERROR_CAUSE = "Exception Error Message";
    public static final String EXCEPTION_ERROR_CAUSE_CN = "错误信息";
    public static final String EXCEPTION_ERROR_MSG = "Exception Error Cause";
    public static final String EXCEPTION_ERROR_MSG_CN = "错误原因";

    public static final String FIELD_COULD_NOT_BE_NULL = "Could not be null";

    public static final String ERROR_PARSE_001 = "ERROR_PARSE_001";
    public static final String ERROR_PARSE_001_DES = "Parse faild";
    public static final String ERROR_CONVERTER_PARSE = "Error while parsing/setting in populator/converter";
    public static final String ERROR_UPDATE_FAILED = "Update failed";

    /**
     * 条码表
     */
    // 条码类型
    /**
     * 0 单条码 *
     */
    public static final int PCMBARCODE_CODE_TYPE_LESS = 0;
    /**
     * 1 多条码 *
     */
    public static final int PCMBARCODE_CODE_TYPE_MANY = 1;
    /**
     * 门店条码 *
     */
    public static final String PCMBARCODE_CODE_TYPE_SE_STR = "SE";
    /**
     * 电商国标条码 *
     */
    public static final String PCMBARCODE_CODE_TYPE_IE_STR = "IE";
    /**
     * 电商自编条码 *
     */
    public static final String PCMBARCODE_CODE_TYPE_ZE_STR = "ZE";
    /**
     * 商品企业内部条码 *
     */
    public static final String PCMBARCODE_CODE_TYPE_YE_STR = "YE";
    /**
     * 国标条码 *
     */
    public static final String PCMBARCODE_CODE_TYPE_GE_STR = "GE";
    /**
     * 0门店条码 *
     */
    public static final int PCMBARCODE_CODE_TYPE_SE = 0;
    /**
     * 1电商国标条码 *
     */
    public static final int PCMBARCODE_CODE_TYPE_IE = 1;
    /**
     * 2电商自编条码 *
     */
    public static final int PCMBARCODE_CODE_TYPE_ZE = 2;
    /**
     * 3商品企业内部条码 *
     */
    public static final int PCMBARCODE_CODE_TYPE_YE = 3;
    /**
     * 4国标条码 *
     */
    public static final int PCMBARCODE_CODE_TYPE_GE = 4;
    /**
     * 多包装默认 *
     */
    public static final String PCMBARCODE_CODE_MOUNT = "1";
    /**
     * 门店品牌表
     */
    // 门店类型
    /**
     * 0 北京 *
     */
    public static final int PCMBRAND_SHOP_TYPE_BEIJING = 0;
    /**
     * 1 外埠 *
     */
    public static final int PCMBRAND_SHOP_TYPE_WAIHU = 1;
    /**
     * 2 电商erp *
     */
    public static final int PCMBRAND_SHOP_TYPE_DSERP = 2;
    // 品牌类型
    /**
     * 0 集团品牌 *
     */
    public static final int PCMBRAND_BRAND_TYPE_GROUP = 0;
    /**
     * 1 门店品牌 *
     */
    public static final int PCMBRAND_BRAND_TYPE = 1;

    /**
     * 产品表状态
     */
    /**
     * 0 未启用 *
     */
    public static final int PCMPRODUCT_PRO_ACTIVE_BIT_NOENABLE = 0;
    /**
     * 1 启用 *
     */
    public static final int PCMPRODUCT_PRO_ACTIVE_BIT_ENABLE = 1;
    /**
     * 0 未上架 *
     */
    public static final int PCMPRODUCT_PRO_SELLING_NOSHELVES = 0;
    /**
     * 1 上架 *
     */
    public static final int PCMPRODUCT_PRO_SELLING_SHELVES = 1;

    /**
     * 商品明细表（SKU）/默认0
     */
    /**
     * 0 未计划 *
     */
    public static final int PCMPRODETAIL_PHOTO_STATUS_NOPLAN = 0;
    /**
     * 1 已计划 *
     */
    public static final int PCMPRODETAIL_PHOTO_STATUS_PLANED = 1;
    /**
     * 2 已拍照未上传店内 *
     */
    public static final int PCMPRODETAIL_PHOTO_STATUS_TWO = 2;
    /**
     * 3 已上传店内未到IDC *
     */
    public static final int PCMPRODETAIL_PHOTO_STATUS_THREE = 3;
    /**
     * 4 已上传至IDC 完成 *
     */
    public static final int PCMPRODETAIL_PHOTO_STATUS_FOUR = 4;
    /**
     * 5 表示拍照部已计划导购未确认 *
     */
    public static final int PCMPRODETAIL_PHOTO_STATUS_FIVE = 5;
    /**
     * 0 未启用 *
     */
    public static final int PCMPRODETAIL_ACTIVE_BIT_NOENABLE = 0;
    /**
     * 1 启用 *
     */
    public static final int PCMPRODETAIL_ACTIVE_BIT_ENABLE = 1;
    /**
     * 0 未上架 *
     */
    public static final int PCMPRODETAIL_PRO_SELLING_NOSHELVES = 0;
    /**
     * 1 上架 *
     */
    public static final int PCMPRODETAIL_PRO_SELLING_SHELVES = 1;
    /**
     * 0 普通商品（实物类）
     */
    public static final int PCMPRODETAIL_PROTYPE_GENERALGOODS = 0;
    /**
     * 1 赠品
     */
    public static final int PCMPRODETAIL_PROTYPE_GIFT = 1;
    /**
     * 2 礼品
     */
    public static final int PCMPRODETAIL_PROTYPE_PRESENT = 2;
    /**
     * 3 虚拟商品（充值卡，购物卡）
     */
    public static final int PCMPRODETAIL_PROTYPE_VIRTUALGOODS = 3;
    /**
     * 4 服务类商品（礼品包装，购物接送服务，停车服务）（注：礼品不可卖，赠品可卖）
     */
    public static final int PCMPRODETAIL_PROTYPE_SERVICEGOODS = 4;

    /** 组织机构表 **/
    /**
     * 0 状态可用 *
     */
    public static final int PCMORGANIZATION_STATUS_AVAILABLE = 0;
    /**
     * 1 状态禁用 *
     */
    public static final int PCMORGANIZATION_STATUS_DISABLE = 1;
    /**
     * 0机构类别-集团 *
     */
    public static final int PCMORGANIZATION_TYPE_GROUP_INT = 0;
    public static final String PCMORGANIZATION_TYPE_GROUP = "GROUP";
    /**
     * 1机构类别-大区 *
     */
    public static final int PCMORGANIZATION_TYPE_REGION_INT = 1;
    public static final String PCMORGANIZATION_TYPE_REGION = "REGION";
    /**
     * 2机构类别-城市 *
     */
    public static final int PCMORGANIZATION_TYPE_CITY_INT = 2;
    public static final String PCMORGANIZATION_TYPE_CITY = "CITY";
    /**
     * 3机构类别-门店 *
     */
    public static final int PCMORGANIZATION_TYPE_STORE_INT = 3;
    public static final String PCMORGANIZATION_TYPE_STORE = "STORE";
    /** 门店类型 **/
    /**
     * 0电商 *
     */
    public static final int PCMORGANIZATION_STORE_TYPE_DS = 0;
    public static final String PCMORGANIZATION_STORE_TYPE_DS_STR = "电商";
    /**
     * 1北京 *
     */
    public static final int PCMORGANIZATION_STORE_TYPE_BJ = 1;
    public static final String PCMORGANIZATION_STORE_TYPE_BJ_STR = "北京";
    /**
     * 2其他门店 *
     */
    public static final int PCMORGANIZATION_STORE_TYPE_MD = 2;
    public static final String PCMORGANIZATION_STORE_TYPE_MD_STR = "其他门店";
    /**
     * 3集货仓 *
     */
    public static final int PCMORGANIZATION_STORE_TYPE_JH = 3;
    public static final String PCMORGANIZATION_STORE_TYPE_JH_STR = "集货仓";
    /**
     * 4门店物流室 *
     */
    public static final int PCMORGANIZATION_STORE_TYPE_WL = 4;
    public static final String PCMORGANIZATION_STORE_TYPE_WL_STR = "门店物流室";

    /** 库存表 **/
    /**
     * 库存类型1001销售库 *
     */
    public static final int PCMSTOCK_TYPE_SALE = 1001;
    /**
     * 库存类型1002残次品库 *
     */
    public static final int PCMSTOCK_TYPE_DEFECTIVE = 1002;
    /**
     * 库存类型1003退货商品库 *
     */
    public static final int PCMSTOCK_TYPE_RETURN = 1003;
    /**
     * 库存类型1004备品物料库 *
     */
    public static final int PCMSTOCK_TYPE_RETREAT = 1004;
    /**
     * 库存类型1007测试库 *
     */
    public static final int PCMSTOCK_TYPE_TEST = 1007;
    /**
     * 库存类型1008微闪锁定库 *
     */
    public static final int PCMSTOCK_TYPE_LOCK = 1008;
    /**
     * 借出 *
     */
    public static final int PCMSTOCK_TYPE_BORROW = 1010;
    /**
     * 归还 *
     */
    public static final int PCMSTOCK_TYPE_REBORROW = 1011;
    /**
     * 调出 *
     */
    public static final int PCMSTOCK_OUT_TRANSFER = 1012;
    /**
     * 调入 *
     */
    public static final int PCMSTOCK_IN_TRANSFER = 1013;
    /* 锁定记录表 */
    /**
     * 已支付解锁 *
     */
    public static final int PCMSTOCK_YES_UNLOCK = 1021;
    /**
     * 未支付解锁 *
     */
    public static final int PCMSTOCK_NO_UNLOCK = 1022;
    /**
     * 未支付锁定 *
     */
    public static final int PCMSTOCK_NO_LOCK = 1023;
    /**
     * 已减库 *
     */
    public static final int PCMSTOCK_REDUCE_STOCK = 1024;
    /**
     * 全量 *
     */
    public static final String PCMSTOCK_TYPE_ALL = "ALL";
    /**
     * 增量 *
     */
    public static final String PCMSTOCK_TYPE_DELTA = "DELTA";

    /** 专柜商品表 **/
    /**
     * 可售状态 0 可售 *
     */
    public static final int PCMSHOPPEPRODECT_SALE_STATUS_YES = 0;
    /**
     * 可售状态 1 不可售 *
     */
    public static final int PCMSHOPPEPRODECT_SALE_STATUS_NO = 1;
    /**
     * 是否负库存销售0允许 *
     */
    public static final int PCMSHOPPEPRODECT_NEGATIVE_STOCK_YES = 0;
    /**
     * 是否负库存销售1不允许 *
     */
    public static final int PCMSHOPPEPRODECT_NEGATIVE_STOCK_NO = 1;
    /**
     * 专柜商品类型1普通商品 *
     */
    public static final int PCMSHOPPEPRODECT_PRO_TYPE_ORDINARY = 1;
    /**
     * 专柜商品类型2大码商品 *
     */
    public static final int PCMSHOPPEPRODECT_PRO_TYPE_ERP = 2;
    /**
     * 是否管库存0管 *
     */
    public static final int PCMSHOPPEPRODECT_IS_STOCK_YE = 0;
    /**
     * 是否管库存1不管 *
     */
    public static final int PCMSHOPPEPRODECT_IS_STOCK_BG = 1;
    /**
     * 是否管库存2自库 *
     */
    public static final int PCMSHOPPEPRODECT_IS_STOCK_ZK = 2;
    /**
     * 是否管库存3虚库 *
     */
    public static final int PCMSHOPPEPRODECT_IS_STOCK_XK = 3;
    /**
     * 是否管库存Y管 *
     */
    public static final String PCMSHOPPEPRODECT_IS_STOCK_Y_STR = "Y";
    /**
     * 是否管库存BG不管 *
     */
    public static final String PCMSHOPPEPRODECT_IS_STOCK_BG_STR = "BG";
    /**
     * 是否管库存ZK自库 *
     */
    public static final String PCMSHOPPEPRODECT_IS_STOCK_ZK_STR = "ZK";
    /**
     * 是否管库存XK虚库 *
     */
    public static final String PCMSHOPPEPRODECT_IS_STOCK_XK_STR = "XK";
    /**
     * 是否管库存0管 *
     */
    public static final char PCMSHOPPEPRODECT_IS_STOCK_YES = '0';
    /**
     * 是否管库存1不管 *
     */
    public static final char PCMSHOPPEPRODECT_IS_STOCK_NO = '1';
    /**
     * 是否管库存Y管 *
     */
    public static final char PCMSHOPPEPRODECT_IS_STOCK_Y = 'Y';
    /**
     * 是否管库存N不管 *
     */
    public static final char PCMSHOPPEPRODECT_IS_STOCK_N = 'N';
    /**
     * 是否支持货到付款(0支持) *
     */
    public static final int PCMSHOPPEPRODECT_IS_COD_YES = 0;
    /**
     * 是否支持货到付款(1不支持) *
     */
    public static final int PCMSHOPPEPRODECT_IS_COD_NO = 1;
    /**
     * 物流属性(0 液体) *
     */
    public static final int PCMSHOPPEPRODECT_TMS_TYPE_Z1 = 0;
    /**
     * 物流属性(Z001液体) *
     */
    public static final String PCMSHOPPEPRODECT_TMS_TYPE_Z1_STR = "Z001";
    /**
     * 物流属性(1 易碎) *
     */
    public static final int PCMSHOPPEPRODECT_TMS_TYPE_Z2 = 1;
    /**
     * 物流属性(Z002 易碎 ) *
     */
    public static final String PCMSHOPPEPRODECT_TMS_TYPE_Z2_STR = "Z002";
    /**
     * 物流属性(2 液体和易碎) *
     */
    public static final int PCMSHOPPEPRODECT_TMS_TYPE_Z3 = 2;
    /**
     * 物流属性(Z003 液体和易碎) *
     */
    public static final String PCMSHOPPEPRODECT_TMS_TYPE_Z3_STR = "Z003";
    /**
     * 物流属性(3 粉末) *
     */
    public static final int PCMSHOPPEPRODECT_TMS_TYPE_Z4 = 3;
    /**
     * 物流属性(Z004 粉末) *
     */
    public static final String PCMSHOPPEPRODECT_TMS_TYPE_Z4_STR = "Z004";
    /** ERP商品表 **/
    /**
     * 大码类型:0 价格码 *
     */
    public static final int PCMERPPRODUCT_CODE_TYPE_PRICE = 0;
    /**
     * 大码类型(1 长期统码) *
     */
    public static final int PCMERPPRODUCT_CODE_TYPE_LONG = 1;
    /**
     * 大码类型(2 促销统码) *
     */
    public static final int PCMERPPRODUCT_CODE_TYPE_PROMOTION = 2;
    /**
     * 大码类型(3 特卖统码) *
     */
    public static final int PCMERPPRODUCT_CODE_TYPE_SPECOFFER = 3;
    /**
     * 大码类型(4 扣率码) *
     */
    public static final int PCMERPPRODUCT_CODE_TYPE_DISCOUNT = 4;
    /**
     * 大码类型(5 促销扣率码) *
     */
    public static final int PCMERPPRODUCT_CODE_TYPE_PROMOTIONDISCOUNT = 5;
    /**
     * 大码类型(6 单品码) *
     */
    public static final int PCMERPPRODUCT_CODE_TYPE_SKU = 6;
    /**
     * 经营方式(0 经销) *
     */
    public static final int PCMERPPRODUCT_PRODUCT_TYPE_Z1 = 0;
    /**
     * 经营方式(Z001 经销) *
     */
    public static final String PCMERPPRODUCT_PRODUCT_TYPE_Z1_STR = "Z001";
    /**
     * 经营方式(1 代销) *
     */
    public static final int PCMERPPRODUCT_PRODUCT_TYPE_Z2 = 1;
    /**
     * 经营方式(Z002 代销 ) *
     */
    public static final String PCMERPPRODUCT_PRODUCT_TYPE_Z2_STR = "Z002";
    /**
     * 经营方式(2 联营) *
     */
    public static final int PCMERPPRODUCT_PRODUCT_TYPE_Z3 = 2;
    /**
     * 经营方式(Z003 联营) *
     */
    public static final String PCMERPPRODUCT_PRODUCT_TYPE_Z3_STR = "Z003";
    /**
     * 经营方式(3 平台服务) *
     */
    public static final int PCMERPPRODUCT_PRODUCT_TYPE_Z4 = 3;
    /**
     * 经营方式(Z004 平台服务) *
     */
    public static final String PCMERPPRODUCT_PRODUCT_TYPE_Z4_STR = "Z004";
    /**
     * 经营方式(4 租赁) *
     */
    public static final int PCMERPPRODUCT_PRODUCT_TYPE_Z5 = 4;
    /**
     * 经营方式(Z005 租赁) *
     */
    public static final String PCMERPPRODUCT_PRODUCT_TYPE_Z5_STR = "Z005";
    /**
     * 商品状态(Y正常) *
     */
    public static final String PCMERPPRODUCT_PRO_STATUS_NORMAL_STR = "Y";
    /**
     * 商品状态(X停售) *
     */
    public static final String PCMERPPRODUCT_PRO_STATUS_STOPSALE_STR = "X";
    /**
     * 商品状态(T停货) *
     */
    public static final String PCMERPPRODUCT_PRO_STATUS_STOP_STR = "T";
    /**
     * 商品状态(P暂停使用) *
     */
    public static final String PCMERPPRODUCT_PRO_STATUS_PAUSE_STR = "P";
    /**
     * 商品状态(N已删除) *
     */
    public static final String PCMERPPRODUCT_PRO_STATUS_DELETE_STR = "N";
    /**
     * 商品状态(M淘汰) *
     */
    public static final String PCMERPPRODUCT_PRO_STATUS_PASS_STR = "M";
    /**
     * 商品状态(0正常) *
     */
    public static final int PCMERPPRODUCT_PRO_STATUS_NORMAL = 0;
    /**
     * 商品状态(1停售) *
     */
    public static final int PCMERPPRODUCT_PRO_STATUS_STOPSALE = 1;
    /**
     * 商品状态(2停货) *
     */
    public static final int PCMERPPRODUCT_PRO_STATUS_STOP = 2;
    /**
     * 商品状态(3暂停使用) *
     */
    public static final int PCMERPPRODUCT_PRO_STATUS_PAUSE = 3;
    /**
     * 商品状态(4已删除) *
     */
    public static final int PCMERPPRODUCT_PRO_STATUS_DELETE = 4;
    /**
     * 商品状态(5淘汰) *
     */
    public static final int PCMERPPRODUCT_PRO_STATUS_PASS = 5;
    /**
     * 是否允许促销(0 允许) *
     */
    public static final int PCMERPPRODUCT_IS_PROMOTION_YES = 0;
    /**
     * 是否允许促销(1 不允许) *
     */
    public static final int PCMERPPRODUCT_IS_PROMOTION_NO = 1;
    /**
     * 是否允许调价(0 允许) *
     */
    public static final int PCMERPPRODUCT_IS_ADJUST_PRICE_YES = 0;
    /**
     * 是否允许调价(1 不允许) *
     */
    public static final int PCMERPPRODUCT_IS_ADJUST_PRICE_NO = 1;
    /**
     * 业态类型（1百货） *
     */
    public static final int PCMERPPRODUCT_FORMAT_TYPE_DEPARTMENT = 1;
    /**
     * 业态类型（2超市） *
     */
    public static final int PCMERPPRODUCT_FORMAT_TYPE_SUPERMARKET = 2;
    /**
     * 业态类型（3电商） *
     */
    public static final int PCMERPPRODUCT_FORMAT_TYPE_ONLINE = 3;
    /** 行政机构 **/
    /**
     * 省 *
     */
    public static final String PCMREGION_TYPE_PROVINCE = "PROVINCE";
    /**
     * 市 *
     */
    public static final String PCMREGION_TYPE_CITY = "CITY";
    /**
     * 区 *
     */
    public static final String PCMREGION_TYPE_DISTRICT = "DISTRICT";

    /**
     * 工业分类 *
     */
    public static final int INDUSTRYTCATEGORY = 0;
    /**
     * 管理分类 *
     */
    public static final int MANAGECATEGORY = 1;
    /**
     * 统计分类 *
     */
    public static final int STATISTICSCATEGORY = 2;
    /**
     * 展示分类 *
     */
    public static final int SHOWCATEGORY = 3;

    /**
     * 电商门店编码 D001
     */
    public static final String STORE_DS = "D001";
    /**
     * 商品和库存准入导入前的校验数量限制
     */
    public static final int VALIDPRODUCTDTO_PRODUCTCOUNT = 200;
    /**
     * 批量库存 数量限制
     */
    public static final int STOCK_LINE_COUNT = 200;
    /**
     * 批量导入库存数量限制
     */
    public static final int STOCK_IN_COUNT = 100;
    /**
     * 用于生成品类编码
     */
    public static final String GY = "GY";

    public static final String TJ = "TJ";

    public static final String GL = "GL";

    public static final String ZS = "ZS";

    /**
     * 价格类型 1:全渠道;2:电商;3:微信;4:APP;5:线下 *
     */
    public static final String PRICE_TYPE = "1;2;3;4;5";
    /**
     * 价格渠道 *
     */
    public static final String DEFAULT_PRICE_TYPE = "1";
    /**
     * 变价操作 *
     */
    public static final String ACTIONCODEA = "A";
    public static final String ACTIONCODEU = "U";
    public static final String ACTIONCODED = "D";
    /**
     * 价格删除标识 *
     */
    public static final Integer PRICE_DEL_FLAG = 1;
    /**
     * 价格类型 1标识零售价 2 短期价 *
     */
    public static final String PRICE_TYPE_1 = "1";
    public static final String PRICE_TYPE_2 = "2";
    /**
     * 价格零售时间 *
     */
    public static final String PRICE_RETAIL_DATE = "99991231";
    public static final int PRICE_LINE_COUNT = 200;

    /**
     * 品牌的logo，banner图片尺寸要求
     */
    public static final int BRAND_LOGO_PIC_WIDTH = 180;
    public static final int BRAND_LOGO_PIC_HEIGHT = 120;
    public static final int BRAND_BANNER_PIC_WIDTH = 790;
    public static final int BRAND_BANNER_PIC_HEIGHT = 316;
    /**
     * 商品图片尺寸要求
     */
    public static final int PRO_PIC_WIDTH = 1000;
    public static final int PRO_PIC_HEIGHT = 1000;
    /**
     * 尺码对照表图片尺寸要求
     */
    public static final int SIZECODE_PIC_WIDTH = 900;
    /**
     * 精包装图片尺寸要求
     */
    public static final int PACKIMG_PIC_WIDTH = 900;
    /**
     * 退货图片尺寸要求OMS
     */
    public static final int REFUND_BANNER_PIC_WIDTH = 500;
    public static final int REFUND_BANNER_PIC_HEIGHT = 200;
    public static final int REFUND_BANNER_PIC_WIDTH_MAX = 2000;
    public static final int REFUND_BANNER_PIC_HEIGHT_MAX = 1500;
    public static final int REFUND_BANNER_PIC_SIZE_MAX = 1*1024*1024;

}

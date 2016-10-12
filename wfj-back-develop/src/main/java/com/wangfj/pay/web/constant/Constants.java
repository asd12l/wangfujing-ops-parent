package com.wangfj.pay.web.constant;

public class Constants {
	
	public static final String PAY_CORE_URL="pay_core_url";
	public static final String SELECT_PAY_ORDER_LIST="select_payOrder_list";
	public static final String SELECT_PAY_ORDER_DETAIL_LIST="select_payOrderDetail_list";
	public static final String SELECT_PAY_BUSINESS_STATION_LIST="select_payBusinessStation_list";
	public static final String SELECT_PAY_CHANNEL_LIST = "select_pay_channel_list";
	public static final String CHECK_ORDER_EXPORT = "check_order_export";
	public static final String CHECK_CHANNEL_EXPORT = "check_channel_export";
	public static final String SELECT_PAY_BALANCE_LIST = "select_pay_balance_list";
	public static final String SELECT_PAY_VERIFICA_COUNT="select_pay_verifica_count";
	public static final String CHECK_BALANCE_EXPORT = "cehck_balance_export";
	public static final String SELECT_STATISTICS_LIST="select_statistics_list";//统计查询
	public static final String SELECT_MERCHANT_LIST="select_merchant_list";//查询签约商户管理
	public static final String UPDATE_MERCHANT_LIST="update_merchant_list";//修改签约商户管理
	public static final String ADD_MERCHANT_LIST="add_merchant_list";//添加签约商户
	public static final String CHECK_STATISTICS_EXPORT="cehck_balance_export";	//导出excel
	//业务平台查询
	public static final String SELECT_PAY_BUSINESS_LIST = "select_pay_business_list";
	//添加业务平台接口
	public static final String ADD_BUSINESS_PLATFORM_INTERFACE="add_business_platform_interface";
	//更新业务平台接口
	public static final String UPDATE_BUSINESS_PLATFORM_INTERFACE="update_business_platform_interface";
	//添加支付渠道
	public static final String ADD_PAY_CHANNEL="add_pay_channel";
	//删除业务平台接口
	public static final String DELETE_BUSINESS_PLATFORM_INTERFACE="delete_business_platform_interface";
	//根据收银台类型查询银行列表
	public static final String SELECT_PAY_BUSINESS_BANK_LIST = "select_pay_business_bank_list";
	//查询支付渠道列表
	public static final String SELECT_BUSINNESS_CHANNEL_LIST = "select_businness_channel_list";
	//查询渠道账户列表
	public static final String SELECT_PARTNER_ACCOUNT = "select_partner_account";
	//删除支付渠道
	public static final String DELETE_PAY_CHANNEL = "delete_pay_channel";
	//更新支付渠道
	public static final String UPDATE_PAY_CHANNEL = "update_pay_channel";
	//根据名称检查业务平台
	public static final String CHECK_BUSINESS = "check_business";
	//检查支付渠道是否存在
	public static final String CHECK_PAY_CHANNEL = "check_pay_channel";
	public static final String ADD_PAYPARTNER_ACCOUNT_ID="add_paypartner_account_id";//添加渠道号
	public static final String SELECT_PAYPARTNER_ACCOUNT_LIST="select_paypartner_account_list";//查询渠道号
    public  static final String UPDATE_PAYPARTNER_ACCOUNT="update_paypartner_account";
    
    //支付介质地址
    public static final String MEDIUM_CORE_URL = "medium_core_url"; 
    //查询支付系统
    public static final String FIND_ALL_PAY_SYSTEM_LIST="find_all_pay_system_list";
    //查询支付介质zTree
    public static final String FIND_ALL_PAY_MEDIUM_ZTREE = "find_all_pay_medium_zTree";
    //检查支付系统
    public static final String CHECK_PAY_SYSTEM = "check_pay_system";
    //添加支付系统
	public static final String ADD_PAY_SYSTEM = "add_pay_system";
	//更新支付系统
	public static final String UPDATE_PAY_SYSTEM = "update_pay_system";
	//设置支付介质
	public static final String SET_PAY_MEDIUM = "set_pay_medium";
	
	//查找支付介质
	public static final String FIND_ALL_PAY_MEDIUM_LIST = "find_all_pay_medium_list";
	//检查支付介质
	public static final String CHECK_PAY_MEDIUM = "check_pay_medium";
	//添加支付介质
	public static final String ADD_PAY_MEDIUM = "add_pay_medium";
	//更新支付介质
	public static final String UPDATE_PAY_MEDIUM = "update_pay_medium";
	//查询支付类型列表
	public static final String SELECT_PAY_TYPE_LIST = "select_pay_type_list";
	//删除支付介质
	public static final String DELETE_MEDIUM_BY_CODE = "delete_medium_by_code";
	//根据partner查询一条信息
    public static final String  SELECT_PARTNER_ACCOUNT_BYPARTNER="select_partner_account_bypartner";
    //在添加渠道号信息时插入一条支付介质
    public static final String  SELECT_ALLMEDIUM_ZTREELIST="select_allMedium_ztreeList";   
    //在添加渠道号信息时插入一条支付介质
    public static final String  SELECT_ALLSYSTEM_NOPARAM="select_allSystem_noParam";
    //单笔订单查询
	public static final String SINGLE_ORDER_QUERY = "single_order_query";
	//订单补偿列表 
	public static final String FIND_ALL_ORDER_COMPENSATE = "find_all_order_compensate";
	public static final String SELECT_STATISTICS_EXPORT = "select_statistics_export";
	//查询用户权限列表
	public static final String SELECT_USER_RIGHTS = "select_user_rights";
	//UAC地址
	public static final String UAC_CORE_URL = "uac_core_url";
	//查询用户
	public static final String FIND_USER_LIST = "find_user_list";
	//查询权限by用户名
	public static final String FIND_RIGHTS_BY_USER_ID = "find_rights_by_user_id";
	//查询支付渠道费率
	public static final String SELECT_CHANNEL_FEE_RATE_LIST = "select_channel_fee_rate_list";
	//添加支付渠道费率
	public static final String ADD_CHANNEL_FEE_RATE="add_channel_fee_rate";
	//修改支付渠道费率
	public static final String UPDATE_CHANNEL_FEE_RATE="update_channel_fee_rate";
	//查询渠道费率类型
	public static final String SELECT_CHANNEL_FEE_RATE_TYPE="select_channel_fee_rate_type";
	//保存角色权限
	public static String SAVE_USER_RIGHTS="save_user_rights";
	//查询渠道支付类型(下拉选)
	public static final String SELECT_PAY_CHANNEL_TYPE="select_pay_channel_type";
	//查询支付渠道(下拉选)
	public static final String SELECT_PAY_CHANNEL="select_pay_channel";
	//netty项目ops接入log监控地址2016-09-27
	public static final String WFJ_LOG_JS="log_js";
}

package com.constants;

import java.io.File;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * 说 明     : 系统配置文件
 * author: 陆湘星
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 */
public class SystemConfig {
	public static String BACK_ENVIRONMENT = "";

    //系统配置文件
    public final static String SYSTEM_PROPERTIES_FILE_NAME = "system.properties";
    //定时任务配置文件
    public final static String CRON_CONFIG_FILE_NAME = "cron.xml";
    //字符分隔符
    public final static String STRING_SPLIT_TAG = "|";
    //ldap服务器地址
    public static String WSCLIENT_URL = "";
    public static String UAC_URL = "";
    //商品精包装预览地址
    public static String PACKIMG_URL = "";

    public static String SYSTEM_ROLE = "";
    public static String SUPER_ADMIN = "";
    public static String SYSTEM_WMS = "SYSTEM_WMS";
    public static String SYSTEM_OMS_BACK = "SYSTEM_OMS_BACK";
    public static String ROLE_WMS_ADMIN = "";

    public static String CMS_CND_PATH ="";
    public static String CMS_CND_IP="";
    public static String ROLE_JIRA_ADMIN = "";
    public static String SSD_SYSTEM_URL = "";
    public static String CMS_OUTER_SYSTEM_URL = "";

    public static String PHOTO_SYSTEM_URL = "";

    public static String WMS_SYSTEM_URL = "";

    public static String STATIC_SYSTEM_URL = "";
    public static String LOCAL_URL = "";
    public static String MQ_POST_URL = "";

    public static String SSD_SYSTEM_INNER_URL = "";
    public static String CMS_SYSTEM_URL = "";

    public static String IMAGE_SERVER = "";

    public static String IMAGE_BRAND_SERVER = "";

    public static String CMS_IMAGE_SERVER = "";
    public static String CMS_IMAGE_SERVERS = "";

    public static String PHOTO_SERVER = "";

    //网站品类树参数channelSid=2
    public static String WEB_PROCAT_TREE = "";
    //erp品类树参数 channelSid=1
    public static String ERP_PROCAT_TREE = "";
    public static String SEARCH_URL = "";
    public static String FTP_HOST = "";
    public static String FTP_USERNAME = "";
    public static String FTP_PASSWORD = "";

    public static String FTP_PROPACKIMG = "";

    public static String PROMOTION_PATH = "";
    public static String BRAND_IMAGE_PATH = "";
    public static String PRODUCT_IMAGE_PATH = "";
    public static String SIZECODE_IMAGE_PATH = "";
    public static String IMAGE_REFUND_SERVER = "";//OMS
    public static String REFUND_IMAGE_PATH = "";//OMS
    public static String ADVERTISE_IMAGE_PATH = "";
    public static String ADVERTISE_FLASH_PATH = "";
    public static String STYLELIST_IMAGE_PATH = "";
    public static String TEMPLATE_IMAGE_PATH = "";
    public static String TOPIC_IMAGE_PATH = "";

    public static String SALEMSG_PATH = "";
    public static String FTP_PORT = "";
    public static String FLASH_PLAN = "";
    public static String WSG_SYN = "";
    public static String PRODUCT_KEY = "";
    //网站地址
    public static String WEBADDRESS = "";
    //获取product产品链接数量的请求地址
    public static String PRODUCT_COUNT_URL = "";
    //获取product产品链接数据的请求地址
    public static String PRODUCT_SEO_URL = "";
    //生存sitemap_index.xml 文件的地址
    public static String GEN_PATH = "";
    
    //UAC路径
    public static String UAC_PATH = "";
    
    public static String CDN_URL = "";
    
    public static boolean ISCDNENABLE = true;
    
    /**
     * **************************系统配置文件配置********************************
     */
    //#Debug模式 1:默认（根据部署来确定） 2.debug 3.info  4.ws 5.warn 6.fatal 7.error 8.fatal 9.nolog
    public final static String SYSTEM_PROPERTIES_DEBUG_LEVEL = "debug";
    public static String SYSTEM_PROPERTIES_DEBUG_LEVEL_VALUE = "2";
    //#部署类型   1:开发 （默认）  2:测试   3:部署web 4.部署为web任务机 -- 用于 日志显示
    public final static String SYSTEM_PROPERTIES_DEPLOYTYPE_NAME = "deploy";
    public static String SYSTEM_PROPERTIES_DEPLOYTYPE_VALUE = "3";
    public static String SYSTEM_PROPERTIES_CRONTYPE_VALUE = "4";

    /*****************************系统配置文件配置*********************************/
    static {
        InputStream in = Constants.class.getClassLoader().getResourceAsStream(SYSTEM_PROPERTIES_FILE_NAME);
        Properties p = new Properties();
        try {
            p.load(in);
            SYSTEM_PROPERTIES_DEBUG_LEVEL_VALUE = p.getProperty(SYSTEM_PROPERTIES_DEBUG_LEVEL);
            SYSTEM_PROPERTIES_DEPLOYTYPE_VALUE = p.getProperty(SYSTEM_PROPERTIES_DEPLOYTYPE_NAME);
            WSCLIENT_URL = p.getProperty("wsClientUrl");
            UAC_URL = p.getProperty("uacValidateUrl");
            SYSTEM_ROLE = p.getProperty("system_role");
            SUPER_ADMIN = p.getProperty("super_admin");
            ROLE_WMS_ADMIN = p.getProperty("orle_wms_admin");
            ROLE_JIRA_ADMIN = p.getProperty("role_jira_admin");
            SSD_SYSTEM_URL = p.getProperty("ssd_system");
            STATIC_SYSTEM_URL = p.getProperty("static_system");
            LOCAL_URL = p.getProperty("local_url");
            MQ_POST_URL = p.getProperty("mq_post_url");
            PACKIMG_URL = p.getProperty("packimg_url");

            IMAGE_REFUND_SERVER = p.getProperty("image_refund_server");//OMS
        	REFUND_IMAGE_PATH = p.getProperty("refund_image_path");//OMS
        	
            CMS_CND_PATH = p.getProperty("cms_cdn_path");
            CMS_CND_IP = p.getProperty("cms_cdn_ip");
            SSD_SYSTEM_INNER_URL = p.getProperty("ssd_systemToInner");
            CMS_SYSTEM_URL = p.getProperty("cms_system");
            CMS_OUTER_SYSTEM_URL = p.getProperty("cms_outer_system");

            PHOTO_SYSTEM_URL = p.getProperty("photo_system");
            WMS_SYSTEM_URL = p.getProperty("wms_system");

            WEB_PROCAT_TREE = p.getProperty("web_procat_tree");
            ERP_PROCAT_TREE = p.getProperty("erp_procat_tree");
            FTP_HOST = p.getProperty("ftp_host");
            SEARCH_URL = p.getProperty("search_url");
            FTP_USERNAME = p.getProperty("ftp_username");
            FTP_PASSWORD = p.getProperty("ftp_password");
            FTP_PORT = p.getProperty("ftp_port");
            //商品精包装图片路径
            FTP_PROPACKIMG = p.getProperty("ftp_propackimg");
            //活动图片保存路径
            PROMOTION_PATH = p.getProperty("image_path");
            //保存品牌图片路径
            BRAND_IMAGE_PATH = p.getProperty("brand_image_path");
            //保存商品图片路径
            PRODUCT_IMAGE_PATH = p.getProperty("product_image_path");
            //保存尺码对照表图片路径
            SIZECODE_IMAGE_PATH = p.getProperty("sizeCode_image_path");

            //广告图片路径
            ADVERTISE_IMAGE_PATH = p.getProperty("advertise_image_path");
            //广告视频路径
            ADVERTISE_FLASH_PATH = p.getProperty("advertise_flash_path");
            //楼层样式图片路径
            STYLELIST_IMAGE_PATH = p.getProperty("stylelist_image_path");
            //模板图片路径
            TEMPLATE_IMAGE_PATH = p.getProperty("template_image_path");
            // 专题模板图片路径
            TOPIC_IMAGE_PATH = p.getProperty("topic_image_path");

            SALEMSG_PATH = p.getProperty("saleMsg_image_path");
            FLASH_PLAN = p.getProperty("flash_plan");
            WSG_SYN = p.getProperty("wsg_synchro");
            PRODUCT_KEY = p.getProperty("product_key");
            WEBADDRESS = p.getProperty("webaddress");
            PRODUCT_COUNT_URL = SSD_SYSTEM_URL + "/web/seoCount.html";
            PRODUCT_SEO_URL = SSD_SYSTEM_URL + "/web/seoProducts.html";
            GEN_PATH = p.getProperty("gen_path") + File.separator;

            IMAGE_SERVER = p.getProperty("image_server");
            IMAGE_BRAND_SERVER = p.getProperty("image_brand_server");
            CMS_IMAGE_SERVER = p.getProperty("cms_image_server");
            CMS_IMAGE_SERVERS = p.getProperty("cms_image_servers");
            PHOTO_SERVER = p.getProperty("photo_server");
            
            BACK_ENVIRONMENT = p.getProperty("back_environment");
            
            CDN_URL = p.getProperty("cms_cnd_url");
            
            UAC_PATH = p.getProperty("uac_path");
            
            ISCDNENABLE = Boolean.parseBoolean(p.getProperty("isCdnEnable"));
        } catch (Exception e) {
            Logger logger = Logger.getLogger(Constants.class);
            logger.error(e.getLocalizedMessage(), e);
        }
    }

}

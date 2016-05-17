package com.constants;
/**
 * 说 明     : 操作信息常量
 * author: 陆湘星 
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 **/
public class InfoConstants {
	private static String INFO_CODE_SUCCESS = "SUCCESS";
	private static String INFO_CODE_FAIL = "FAIL";
	private static String INFO_CODE_EXCEPTION = "EXCEPTION";
	
	public enum CodeInfo {
		操作成功(INFO_CODE_SUCCESS,"操作成功!"),
		登陆成功(INFO_CODE_SUCCESS,"登陆成功!"),
		操作失败(INFO_CODE_FAIL,"操作失败!"),
		验证失败(INFO_CODE_FAIL,"验证失败!"),
		操作异常(INFO_CODE_EXCEPTION,"操作异常!"),
		
		验证没通过(INFO_CODE_FAIL,"验证没通过! "),
		SQL连接错误(INFO_CODE_EXCEPTION,"SQL错误! ")
        ;
    	private String code;
    	private String codeInfo;
		private CodeInfo() { 	}
		private CodeInfo(String code, String codeInfo) {
			this.code = code;
			this.codeInfo = codeInfo;
		}
		public String getCodeInfo() {
			return codeInfo;
		}
		public void setCodeInfo(String codeInfo) {
			this.codeInfo = codeInfo;
		}

		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}
	}
	
	public enum DeployType{
		开发(1,"开发"),
		测试(2,"测试"),
		部署web(3,"部署web"),
		部署为web任务机(4,"部署为web任务机")		
		;
		private int value;
		private String desc;

		private DeployType() {
		}

		private DeployType(int value, String desc) {
			this.value = value;
			this.desc = desc;
		}

		public int getValue() {
			return value;
		}

		public void setValue(int value) {
			this.value = value;
		}

		public String getDesc() {
			return desc;
		}

		public void setDesc(String desc) {
			this.desc = desc;
		}
	}
	
	
	public enum DebugType{
		默认(1,"默认（根据部署来确定） "),
		debug(2,"debug"),
		Info(5,"info"),
		exception(6,"exception"),		
		nolog(10,"nolog")
		;
		private int value;
		private String name;
		private DebugType(int value) {
            this.value = value;
        }
	  	private DebugType(int value,String name) {
	            this.value = value;
	            this.name = name;
	    }
		public int getValue() {
			return value;
		}
		public void setValue(int value) {
			this.value = value;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
	}	
}

package com.wangfj.back.util;
/**
 * 说明:
 * @author guansq
 * @date 2012-12-10 下午02:56:48
 * @modify 
 */
public class ErrorCodeConstants {
	public enum ErrorCode {
		/**
		 * 错误编码规范：
		 * 长度：7位 00 0 00 00
		 * 含义：
		 * 		12位：系统，物流系统是51
		 * 		3位：消息等级，默认为1
		 * 		45位：模块，tms(01)
		 * 		67位：具体错误
		 * 		系统异常：2110001-2110099
		 */
		
		SYSTEM_ERROR("2110001", "系统运行异常！"), 
		CALL_SRC_ERROR("2120001", "接口调用方来源不明！"),
		PARAM_ERROR("2110002", "参数不正确！"),
		USERNAME_NULL_ERROR("5110101","用户名不能为空"),
		PWD_NULL_ERROR("5110102","密码不能为空"),
		LOGIN_ERROR("5110103","用户名或密码错误"),
		PERMISSION_ERROR("5110104","没有权限");
		
		private String errorCode;
		private String memo;
		private ErrorCode() {};
		private ErrorCode(String errorCode, String memo) {
			this.errorCode = errorCode;
			this.memo = memo;
		}
		public String getErrorCode() {
			return errorCode;
		}
		public void setErrorCode(String errorCode) {
			this.errorCode = errorCode;
		}
		public String getMemo() {
			return memo;
		}
		public void setMemo(String memo) {
			this.memo = memo;
		}
	}
}

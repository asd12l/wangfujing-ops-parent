package com.framework;

import com.framework.page.Page;
import com.utils.BeanUtil;

/**
 * 说 明     : 查询条件接口
 * author: 陆湘星
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 **/
public class AbstractCondtion  extends Page{
	private Long sid;//主键sid
	public String userName;  //用户名
	public String password;  //密码
	public String ipAddress; //IP地址
	public String macAddress; //mac地址
	
	protected String extTableName; //扩展表名
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getMacAddress() {
		return macAddress;
	}

	public void setMacAddress(String macAddress) {
		this.macAddress = macAddress;
	}
	
	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String toString() {
		return "[ sid=" + sid + ", userName=" + userName + ", password=" + password + ", macAddress=" + macAddress + ",ipAddress="+ipAddress+"]\r\n"
		+ "[ currentPage ="+this.currentPage +",startRecords ="+this.startRecords +", pageSize="+this.pageSize+"]\r\n" 
		+ "["+ BeanUtil.Obj2UrlParams(this)+"]";
	}
}

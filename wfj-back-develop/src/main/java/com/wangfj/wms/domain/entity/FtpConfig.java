package com.wangfj.wms.domain.entity;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

public class FtpConfig {

	private int id;
	private String ftp_name;
	private String ftp_pwd;
	private String ftp_address;
	private int ftp_port;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFtp_name() {
		return ftp_name;
	}
	public void setFtp_name(String ftp_name) {
		this.ftp_name = ftp_name;
	}
	public String getFtp_pwd() {
		return ftp_pwd;
	}
	public void setFtp_pwd(String ftp_pwd) {
		this.ftp_pwd = ftp_pwd;
	}
	public String getFtp_address() {
		return ftp_address;
	}
	public void setFtp_address(String ftp_address) {
		this.ftp_address = ftp_address;
	}
	public int getFtp_port() {
		return ftp_port;
	}
	public void setFtp_port(int ftp_port) {
		this.ftp_port = ftp_port;
	}
	public FtpConfig(int id, String ftp_name, String ftp_pwd, String ftp_address) {
		super();
		this.id = id;
		this.ftp_name = ftp_name;
		this.ftp_pwd = ftp_pwd;
		this.ftp_address = ftp_address;
	}
	public FtpConfig() {
		super();
	}
	
	public String toString(){
	Map map = new HashMap();
	map.put("id", id);
	map.put("ftp_pwd", ftp_pwd);
	map.put("ftp_port", ftp_port);
	map.put("ftp_name", ftp_name);
	map.put("ftp_address", ftp_address);
	JSONObject jsonObject = JSONObject.fromObject(map);
	   return jsonObject.toString();
	}

}

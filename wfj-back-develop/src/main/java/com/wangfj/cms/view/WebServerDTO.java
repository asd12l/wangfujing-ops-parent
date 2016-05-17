package com.wangfj.cms.view;

import java.io.Serializable;

public class WebServerDTO implements Serializable{
	
	private Integer id;

	// fields
	private Integer siteId;
	private String name;
	private String ip;
	private Integer port;
	private String username;
	private String password;
	private String encoding;
	private Integer timeout;
	private String path;
	private String url;
	private Integer type;
	
	public WebServerDTO() {
		super();
	}

	public WebServerDTO(Integer id, Integer siteId, String name, String ip, Integer port, String username,
			String password, String encoding, Integer timeout, String path, String url, Integer type) {
		super();
		this.id = id;
		this.siteId = siteId;
		this.name = name;
		this.ip = ip;
		this.port = port;
		this.username = username;
		this.password = password;
		this.encoding = encoding;
		this.timeout = timeout;
		this.path = path;
		this.url = url;
		this.type = type;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSiteId() {
		return siteId;
	}

	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Integer getPort() {
		return port;
	}

	public void setPort(Integer port) {
		this.port = port;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEncoding() {
		return encoding;
	}

	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	public Integer getTimeout() {
		return timeout;
	}

	public void setTimeout(Integer timeout) {
		this.timeout = timeout;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	
}

package com.wangfj.wms.domain.view;

/**
 * 属性属性值JSON DTO
 * 
 * @Class Name ParametersDto
 * @Author wangsy
 * @Create In 2015年9月8日
 */
public class ParametersDto {
	private Long propSid;
	private String propName;
	private Long valueSid;
	private String valueName;

	public Long getPropSid() {
		return propSid;
	}

	public void setPropSid(Long propSid) {
		this.propSid = propSid;
	}

	public Long getValueSid() {
		return valueSid;
	}

	public void setValueSid(Long valueSid) {
		this.valueSid = valueSid;
	}

	public String getPropName() {
		return propName;
	}

	public void setPropName(String propName) {
		this.propName = propName;
	}

	public String getValueName() {
		return valueName;
	}

	public void setValueName(String valueName) {
		this.valueName = valueName;
	}

	@Override
	public String toString() {
		return "ParametersDto [propSid=" + propSid + ", propName=" + propName + ", valueSid="
				+ valueSid + ", valueName=" + valueName + "]";
	}

}

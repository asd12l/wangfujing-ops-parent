/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.domain.view.RoleResourceVO.java
 * @Create By chengsj
 * @Create In 2013-7-10 下午2:51:04
 * TODO
 */
package com.wangfj.wms.domain.view;

/**
 * @Class Name RoleResourceVO
 * @Author chengsj
 * @Create In 2013-7-10
 */
public class RoleResourceVO {

	private String rolesSid;

    private String resourcesSid;

	public String getRolesSid() {
		return rolesSid;
	}

	public void setRolesSid(String rolesSid) {
		this.rolesSid = rolesSid;
	}

	public String getResourcesSid() {
		return resourcesSid;
	}

	public void setResourcesSid(String resourcesSid) {
		this.resourcesSid = resourcesSid;
	}

	@Override
	public String toString() {
		return "RoleResourceVO [rolesSid=" + rolesSid + ", resourcesSid="
				+ resourcesSid + "]";
	}
	
	
}

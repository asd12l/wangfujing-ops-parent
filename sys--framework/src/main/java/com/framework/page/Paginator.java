package com.framework.page;

import java.util.List;
/**
 * 说 明     : 分类数据处理类
 * author: 陆湘星
 * data  : 2012-12-6
 * email : xiangxingchina@163.com
 **/
public class Paginator extends Page{
//	private int totalRecords;
	protected List list;
	
	public int getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(Integer totalRecords) {
		if(totalRecords==null)totalRecords=0;
		this.totalRecords = totalRecords;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}
	
	public void setPage(Page page){  
		this.start = page.getStart();
		this.limit = page.getLimit();
	}
}

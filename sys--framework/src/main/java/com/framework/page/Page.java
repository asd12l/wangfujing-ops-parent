package com.framework.page;

import com.constants.Constants;
/**
 * 说 明     : 分页对象
 * author: 陆湘星
 * data  : 2012-12-6
 * email : xiangxingchina@163.com
 **/
public class Page {
	protected Integer start = 0;
	protected Integer limit = Constants.PAGE_SIZE;
	
	public int pageSize 	= 10  ; 		//每页显示数
	public int currentPage 	= 1  ; 				//当前页面数
	protected int totalRecords  = 0  ;			//总记录数
	protected int totalPages  	= 0  ;			//总页数
	protected int startRecords 		= 0  ; 		//开始条数
	protected int endRecords  		= 0  ; 		//截至条数
	public int page 	= 1  ; 				//当前页面数
	
	public Page() {
	}
	public Page(int pageSize,int currentPage,int totalRecords,int totalPages) {
		this.limit = pageSize;
		if(currentPage<= 1) currentPage = 1;
		this.pageSize = pageSize;
		this.currentPage = currentPage; 
		this.totalPages = totalPages;
		this.totalRecords = totalRecords;
		build();
	} 
	
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.limit = pageSize;
		this.pageSize = pageSize;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		if(currentPage<=1){ currentPage = 1 ; this.start = 0; }
		this.currentPage = currentPage;
	}
	
	public int getTotalRecords() {
		return totalRecords;
	}
	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}
	public void setTotalRecordsBuild(int totalRecords) {
		this.totalRecords = totalRecords;
		build();
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	
	public int getStartRecords() {
		return startRecords;
	}

	public void setStartRecords(int startRecords) {
		this.startRecords = startRecords;
		this.start = this.startRecords;
	}

	public int getEndRecords() {
		return endRecords;
	}

	public void setEndRecords(int endRecords) {
		this.endRecords = endRecords;
	}
	
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
		this.startRecords = start;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
		this.pageSize = limit;
	}
	
	public void build(){
		this.totalPages = (this.totalRecords+this.pageSize-1)/pageSize; //总页数
		if(this.currentPage>=this.totalPages)	this.currentPage = this.totalPages;
		this.startRecords = (this.currentPage - 1) * pageSize+1;
//		 if (this.startRecords + this.pageSize > this.totalRecords)
//             this.endRecords = this.totalRecords;
//         else
        	 this.endRecords = this.startRecords + this.pageSize-1;
		 this.start = this.startRecords;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
}

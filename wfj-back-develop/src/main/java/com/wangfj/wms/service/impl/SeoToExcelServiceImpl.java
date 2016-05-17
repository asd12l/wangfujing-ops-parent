package com.wangfj.wms.service.impl;


import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wangfj.order.entity.ExcelFile;
import com.wangfj.wms.domain.entity.SeoBrand;
import com.wangfj.wms.domain.entity.SeoHotWord;
import com.wangfj.wms.domain.entity.SeoLongKeyword;
import com.wangfj.wms.persistence.SeoBrandMapper;
import com.wangfj.wms.persistence.SeoHotWordMapper;
import com.wangfj.wms.persistence.SeoLongKeywordMapper;
import com.wangfj.wms.service.ISeoToExcelService;
@Service("seoToExcelService")
public class SeoToExcelServiceImpl implements ISeoToExcelService{
	
	@Autowired
	private SeoBrandMapper seoBrandMapper;
	@Autowired
	private SeoHotWordMapper seoHotWordMapper;
	@Autowired
	private SeoLongKeywordMapper seoLongKeywordMapper;
	
	
	
	public String seoDataConvertToExcel(HttpServletResponse response,
			String title,Map<String,Object> map) {
		List<String> header = new ArrayList<String>();
		header.add("编号");
		header.add("名称");
		header.add("链接");
		header.add("是否有效");
	
		List<List<String>> data = new ArrayList<List<String>>();
		
		
		String type = (String) map.get("selectType");
		map.remove("selectType");
		if("1".equals(type)){
			List<SeoBrand> list1 = this.seoBrandMapper.selectListByParam(map);
			
			for(SeoBrand sb:list1){
				List<String> inlist = new ArrayList<String>();
				
				inlist.add(sb.getSid()==null?"":sb.getSid().toString());//
				inlist.add(sb.getBrandName()==null?"":sb.getBrandName());//
				inlist.add(sb.getBrandLink()==null?"":sb.getBrandLink());//
				inlist.add(sb.getFlag()==null?"":sb.getFlag().toString());//

				data.add(inlist);
			}
			
		}else if ("2".equals(type)){
			List<SeoHotWord> list2 = this.seoHotWordMapper.selectListByParam(map);
			for(SeoHotWord shw:list2){
				List<String> inlist = new ArrayList<String>();
				
				inlist.add(shw.getSid()==null?"":shw.getSid().toString());//
				inlist.add(shw.getHotName()==null?"":shw.getHotName());//
				inlist.add(shw.getHotLink()==null?"":shw.getHotLink());//
				inlist.add(shw.getFlag()==null?"":shw.getFlag().toString());//

				data.add(inlist);
			}
		}else{
			List<SeoLongKeyword> list3 = this.seoLongKeywordMapper.selectListByParam(map);
			for(SeoLongKeyword slk:list3){
				List<String> inlist = new ArrayList<String>();
				
				inlist.add(slk.getSid()==null?"":slk.getSid().toString());//
				inlist.add(slk.getLongName()==null?"":slk.getLongName());//
				inlist.add(slk.getLongLink()==null?"":slk.getLongLink());//
				inlist.add(slk.getFlag()==null?"":slk.getFlag().toString());//

				data.add(inlist);
			}
		}
		
	
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	
	
	
	
	
}

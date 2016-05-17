/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperNoticeTypeMapperTest.java
 * @Create By chengsj
 * @Create In 2013-11-18 下午3:11:35
 * TODO
 */
package com.wangfj.back.mapper;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.util.Assert;

import com.framework.testCase.AbstractTest;
import com.wangfj.wms.domain.entity.NoticeType;
import com.wangfj.wms.persistence.NoticeTypeMapper;

/**
 * @Class Name NoticeTypeMapperTest
 * @Author chengsj
 * @Create In 2013-11-18
 */
public class NoticeTypeMapperTest extends AbstractTest{
	NoticeTypeMapper noticeTypeMapper;
	
	@Before
	public void setUp() throws Exception {
		super.setUp();
		this.noticeTypeMapper = context.getBean(NoticeTypeMapper.class);
		Assert.notNull(noticeTypeMapper, "mapper can not be null");
	}
	
//	@Test
	public void testInsert() {
		NoticeType noticeType = new NoticeType();
		this.noticeTypeMapper.insert(noticeType);
	}
	
	@Test
	public void testUpdate() {
		NoticeType n = new NoticeType();
		n.setSid(333);
		n.setName("zhansan");
		n.setMemo("memo");
		Integer sid = this.noticeTypeMapper.updateByPrimaryKey(n);
		System.out.println(sid);
	}
	
//	@Test
	public void testSelectAll() {
		List<NoticeType> list = this.noticeTypeMapper.selectAll();
		for(NoticeType noticeType : list) {
			System.out.println(noticeType.getName());
		}
		
	}
//	@Test
	public void testSelectByPrimaryKey() {
			NoticeType n = this.noticeTypeMapper.selectByPrimaryKey(66);
			System.out.println(n.getName());
		
	}
//	@Test
	public void testSelectByParms() {
		NoticeType record = new NoticeType();
		record.setName("活动");
		List<NoticeType> list = this.noticeTypeMapper.selectByParams(record);
		for(NoticeType noticeType : list) {
			System.out.println(noticeType.getSid()+":"+noticeType.getName());
		}
	}
//	@Test
	public void testDelete() {
		Integer sid = 9333;
		this.noticeTypeMapper.deleteByPrimaryKey(sid);
	}
}

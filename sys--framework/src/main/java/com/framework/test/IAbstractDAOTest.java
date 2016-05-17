package com.framework.test;

import java.sql.SQLException;

/**
 * desc   : 抽象DAO
 * author : luxiangxing
 * data   : 2013-2-14
 * email  : xiangxingchina@163.com
 **/
public interface IAbstractDAOTest {
	public void testFindObjBySid() throws SQLException;
	public void testQueryObjsList()throws SQLException;
	public void testQueryObjsCount()throws SQLException;
	public void testInsert() throws SQLException;
	public void testUpdate() throws SQLException;
	public void testDelete() throws SQLException;
}

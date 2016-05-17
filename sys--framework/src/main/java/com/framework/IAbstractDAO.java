package com.framework;

import java.sql.SQLException;
import java.util.List;


/**
 * desc   : 抽象DAO类
 * author : luxiangxing
 * data   : 2013-2-14
 * email  : xiangxingchina@163.com
 **/
public interface IAbstractDAO<C extends AbstractCondtion,P extends AbstractPOEntity,V extends AbstractVOEntity>{
	public V findObjBySid(Long sid) throws SQLException;
	public List<V> queryObjsList(C c)throws SQLException;
	public Integer queryObjsCount(C c)throws SQLException;
	public void insert(P p)throws SQLException;
	public void update(P p)throws SQLException;
	public void delete(Long sid)throws SQLException;
}

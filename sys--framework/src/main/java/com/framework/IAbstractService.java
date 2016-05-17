package com.framework;

import java.sql.SQLException;

import com.framework.page.Paginator;
import com.framework.returnObj.Infos;

/**
 * desc   : 抽象Service类
 * author : luxiangxing
 * data   : 2013-2-14
 * email  : xiangxingchina@163.com
 **/
public interface IAbstractService <C extends AbstractCondtion,P extends AbstractPOEntity,V extends AbstractVOEntity>{
	public V findObjBySid(Infos infos,Long sid) throws SQLException;
	public Paginator queryObjs(Infos infos,C cond) throws SQLException;
	public void insert(Infos infos,C cond) throws SQLException;
	public void update(Infos infos,C cond) throws SQLException;
	public void delete(Infos infos,Long sid) throws SQLException;
}

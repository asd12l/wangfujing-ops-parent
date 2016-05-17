/**
 * @Probject Name: backendWeb_mysql
 * @Path: com.wangfj.base.BaseTestContext.java
 * @Create By chengsj
 * @Create In 2013-6-6 下午4:48:34
 * TODO
 */
package com.wangfj.wms.base;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.transaction.TransactionConfiguration;

/**
 * @Desc  测试基类(继承它可实现使用事务的单元测试)
 * @Class Name BaseTestContext
 * @Author chengsj
 * @Create In 2013-6-6
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = false)
public class BaseTestContext extends AbstractTransactionalJUnit4SpringContextTests{

}

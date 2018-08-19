package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.SonghuoStatisticsDao;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class SonghuoStatisticsDaoTest {

	@Resource private SonghuoStatisticsDao songhuoStatisticsDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		System.out.println(songhuoStatisticsDao.getSonghuoStatistics("小严", "2010-01-01", "2019-01-01"));
	    //System.out.println(songhuoStatisticsDao.getAllCustomerName());
	}

}

package org.npc.plantSCM.daoTest;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.npc.plantSCM.dao.InformDao;
import org.npc.plantSCM.po.Inform;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-*.xml"})
public class InformDaoTest {

	@Resource
	private InformDao informDao;
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		Inform i = new Inform();
		i.setInformTime("2018-05-01");
		i.setInformContent("去买银");
  informDao.insertInform(i);
	    System.out.println(informDao.getInform());
	}

}

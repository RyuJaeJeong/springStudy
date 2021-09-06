package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.sample.Restaurant;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SampleTests {

	@Setter(onMethod_ = { @Autowired })
	private Restaurant restaurant;
	
	@Test
	public void testExist() {
		//의존성 주입테스트
		assertNotNull(restaurant);
		
		log.info(restaurant);
		log.info("---------------------------");
		log.info(restaurant.getChef());
	}
	
	
	
}

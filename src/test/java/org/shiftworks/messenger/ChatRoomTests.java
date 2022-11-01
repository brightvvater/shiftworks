package org.shiftworks.messenger;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shiftworks.domain.ChatRoomVO;
import org.shiftworks.mapper.ChatRoomMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//context 경로를 알아야 테스트 가능
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ChatRoomTests {

	@Autowired
	ChatRoomMapper mapper;
	
	@Test
	public void testInsert() {
		ChatRoomVO chatRoom = new ChatRoomVO();
		chatRoom.setRoom_id(2);
		chatRoom.setRoom_name("test");
		
		log.info(mapper.insertChatRoom(chatRoom));
	}
	
	@Test
	public void testGetList() {
		mapper.getList(1).forEach(chatRoom->log.info(chatRoom));
	}
	
	@Test
	public void testDelete() {
		mapper.deleteChatRoom(2);
	}
}

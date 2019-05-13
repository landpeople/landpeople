package happy.land.people.model.lee;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.TestDto;

@Service
public class LeeServiceImpl implements ILeeService {

	private Logger logger = LoggerFactory.getLogger(LeeServiceImpl.class);

	@Autowired
	private ILeeDao dao;
	
	@Override
	public List<String> chatList_SelectAll() {
		logger.info("● Service chatList_SelectAll 실행");
		return dao.chatList_SelectAll();
	}
}
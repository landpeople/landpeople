package happy.land.people.model.cho;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.cho.ChoDto;

@Repository
public class ChoDaoImpl implements IChoDao {

	private Logger logger = LoggerFactory.getLogger(ChoDaoImpl.class);
	
	@Autowired
	private SqlSessionTemplate session;
	private final String NS = "cho_test.";
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public boolean signUp(ChoDto dto) {
		System.out.println("signUp 다오임플");
		
		String passwordEncode = passwordEncoder.encode(dto.getUser_password());
		dto.setUser_password(passwordEncode);
		return session.insert(NS+"signUpU",dto)>0? true:false;
	}

	@Override
	public boolean authkeyUpdate(ChoDto dto) {
		return session.update(NS+"authkeyUpdate",dto)>0? true:false;
	}

	@Override
	public ChoDto login(ChoDto dto) {
		logger.info("login 실행");
		
		// db의 pw값
		ChoDto DBPWDto = session.selectOne(NS+"login", dto);
		String DBPW = DBPWDto.getUser_password();
		
		//전달 받은 pw값
		String reqPW = dto.getUser_password();
		
		System.out.println("db의pw값:"+DBPW);
		System.out.println("전달받은PW값:"+reqPW);
		
		if(passwordEncoder.matches(reqPW, DBPW)) {
			logger.info("-------------패스워드일치------------");
			return DBPWDto;
		}
		
		
		return session.selectOne(NS+"login", dto);
	}

	@Override
	public boolean deleteUser(String user_email) {
		return false;
	}

	@Override
	public boolean userInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int emailDupChk(String user_email) {
		return session.update(NS+"emailDupChk",user_email);
	}

	@Override
	public int nicknameDupChk(String user_nickname) {
		return session.update(NS+"nicknameDupChk",user_nickname);
	}

	@Override
	public boolean authStatusUpdate(String user_email) {
		return session.update(NS+"authStatusUpdate",user_email)>0? true:false;
	}

}

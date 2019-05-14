package happy.land.people.model.cho;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.cho.ChoDto;

@Repository
public class ChoDaoImpl implements IChoDao {

	@Autowired
	private SqlSessionTemplate session;
	private final String NS = "cho_test.";
	
	
	@Override
	public boolean signUp(ChoDto dto) {
		System.out.println("signUp 다오임플");
		return session.insert(NS+"signUpU",dto)>0? true:false;
	}

	@Override
	public boolean authkeyUpdate(ChoDto dto) {
		return session.update(NS+"authkeyUpdate",dto)>0? true:false;
	}

	@Override
	public ChoDto login(ChoDto dto) {
		// TODO Auto-generated method stub
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

package happy.land.people.model.cho;

import java.util.Map;

import happy.land.people.dto.cho.ChoDto;

public class ChoDaoImpl implements IChoDao {

	@Override
	public boolean signUp(ChoDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean authkeyUpdate(ChoDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ChoDto login(ChoDto dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteUser(String user_email) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean userInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int emailDupChk(String user_email) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int nicknameDupChk(String user_nickname) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean authStatusUpdate(ChoDto user_emailchk) {
		// TODO Auto-generated method stub
		return false;
	}

}

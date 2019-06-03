package happy.land.people.model.user;


import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.LPUserDto;

@Repository
public class LPUserDaoImpl implements ILPUserDao {

	private Logger logger = LoggerFactory.getLogger(LPUserDaoImpl.class);

	@Autowired
	private SqlSessionTemplate session;
	private final String NS = "user.";

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public boolean user_signUp(LPUserDto dto) {
		
		String user_email = dto.getUser_email();
		int n = session.selectOne(NS + "user_emailDupChk", user_email);
		
		
		
		System.out.println("n의값"+n);
		System.out.println("dto다오임플에서:"+dto);
		LPUserDto edto =session.selectOne(NS+"user_emailAuthChk", dto);
		System.out.println(edto);
		
		if(n > 0 && dto.getUser_auth().equalsIgnoreCase("U")) {
			return false; // 이미 회원 가입된 사람이라면 바로 화면에서 빠져나오도록 함
		}else if(n>0 && dto.getUser_auth().equalsIgnoreCase("N")) {
			if(dto.getUser_auth().equalsIgnoreCase(edto.getUser_auth())) {
				System.out.println("이미 네이버로 가입한사람");
				return true;
			}else {
				System.out.println("이미 다른 가입폼으로 같은 이메일로 가입했는데 네이버 또했을시");
				return false;
			}
			
		}else if(n>0 && dto.getUser_auth().equalsIgnoreCase("G")) {
			if(dto.getUser_auth().equalsIgnoreCase(edto.getUser_auth())) {
			System.out.println("이미 구글로 가입한사람");
			return true;
			}else {
				System.out.println("이미 다른 가입폼으로 같은 이메일로 가입했는데 구글로 했을시");
				return false;
			}
		}
		
		
		System.out.println("signUp 다오임플");
		boolean isc = false;
		if (dto.getUser_auth().equalsIgnoreCase("U")) {
			logger.info("daoimpl에 signup메소드에 유저입니다");
			String passwordEncode = passwordEncoder.encode(dto.getUser_password());
			dto.setUser_password(passwordEncode);
			isc = session.insert(NS + "user_signUp", dto) > 0 ? true : false;
		}
		else if (dto.getUser_auth().equalsIgnoreCase("N")) {
			System.out.println("네이버 로그인");
			user_email = dto.getUser_email();
//			n = session.selectOne(NS + "emailDupChk", user_email);
//			if (n > 0) {
//				System.out.println("이미 네이버로 가입한사람");
//				return true;
//			}
			logger.info("daoimpl에 signup메소드에 네이버입니다");
			isc = session.insert(NS + "user_signUpN", dto) > 0 ? true : false;
		}else {
			System.out.println("구글 로그인");
			user_email = dto.getUser_email();
//			n = session.selectOne(NS + "emailDupChk", user_email);
//			if (n > 0) {
//				System.out.println("이미 구글로 가입한사람");
//				return true;
//			}
			logger.info("daoimpl에 signup메소드에 구글입니다");
			isc = session.insert(NS + "user_signUpG", dto) > 0 ? true : false;
		}
		return isc;
	}

	@Override
	public boolean user_authkeyUpdate(LPUserDto dto) {
		return session.update(NS + "user_authkeyUpdate", dto) > 0 ? true : false;
	}

	// 로그인 다오인데 비밀번호 불일치할떄 로그인이 안되게 설정해줘야함....흠....
	@Override
	public LPUserDto user_login(LPUserDto dto) {
		logger.info("login 실행");

		String email = dto.getUser_email();
		System.out.println(email);
		// 이제 여기는 일반 가입자만 오니까 비밀번호 일치하는지 확인해주면됨

		// db의 pw값
		LPUserDto DBPWDto = session.selectOne(NS + "user_login", dto);
		System.out.println("DBPWDto:" + DBPWDto);

		// api가입자는 비번 널임
		if (DBPWDto.getUser_password() == null) {
			return DBPWDto;
		}

		// 암호화된 비번
		String DBPW = DBPWDto.getUser_password();
		System.out.println("DBPW:" + DBPW);

		// 전달 받은 pw값
		String reqPW = dto.getUser_password();

		System.out.println("db의pw값:" + DBPW);
		System.out.println("전달받은PW값:" + reqPW);

		if (passwordEncoder.matches(reqPW, DBPW)) {
			logger.info("-------------패스워드일치------------");
			return DBPWDto;
		} else {
			logger.info("--------------패스워드 불일치----------");
			DBPWDto.setUser_password("no");
			System.out.println(DBPWDto.getUser_password());
			return DBPWDto;
		}

	}

	@Override
	public boolean user_deleteUser(String user_email) {
		return session.update(NS + "user_delflag", user_email) > 0 ? true : false;
	}

	// 회원정보 수정인데
	@Override
	public boolean user_userInfo(LPUserDto dto) {
		
		boolean isc = false;
		
		System.out.println("여기는 userInfo"+dto);
		
		// 여기에다가 비밀번호 닉네임 어케어케?
		if (dto.getUser_auth().equalsIgnoreCase("U")) {
			System.out.println("유저로들어옴");
			if (dto.getUser_nickname()==null || dto.getUser_nickname().length()==0) {
				System.out.println("닉네임 길이가 0");
				String passwordEncode = passwordEncoder.encode(dto.getUser_password());
				dto.setUser_password(passwordEncode);
				session.update(NS + "user_modifyPassword", dto);
				return isc = true;
			}else if(dto.getUser_password().length()==0) {
				System.out.println("비밀번호 길이가 0");
				session.update(NS+"user_modifyNickname",dto);
				return isc = true;
			}else {
				System.out.println("나머지 닉넴 비번둘다바꿀떄");
				String passwordEncode = passwordEncoder.encode(dto.getUser_password());
				dto.setUser_password(passwordEncode);
				session.update(NS + "user_modifyPassword", dto);
				session.update(NS+"user_modifyNickname",dto);
				return isc = true;
			}
		}else {
			isc = session.update(NS + "user_modifyNickname", dto) > 0 ? true : false;
		}

		
//		if (dto.getUser_nickname() == null) {
//			return session.update(NS + "modifyPassword", dto) > 0 ? true : false;
//		}
//		boolean isc = session.update(NS + "modifyNickname", dto) > 0 ? true : false;

		return isc;
	}

	// 이메일 중복체크
	@Override
	public int user_emailDupChk(String user_email) {

		logger.info("이메일중복체크 다오임플");

		System.out.printf("이메일중복체크 ------" + session.selectOne(NS + "user_emailDupChk", user_email));
		return session.selectOne(NS + "user_emailDupChk", user_email);
	}

	// 닉네임중복체크
	@Override
	public int user_nicknameDupChk(String user_nickname) {
		logger.info("닉네임 중복체크 다오 임플");
		return session.selectOne(NS + "user_nicknameDupChk", user_nickname);
	}

	@Override
	public boolean user_authStatusUpdate(String user_email) {
		return session.update(NS + "user_authStatusUpdate", user_email) > 0 ? true : false;
	}

	@Override
	public boolean user_findPW(LPUserDto dto) {

		return true;
	}

	@Override
	public int user_emailAuthChk(String user_email) {
		logger.info("비밀번호찾기 가입자 확인하고 auth주기");

		LPUserDto dto = session.selectOne(NS + "user_emailAuthChk", user_email);
		System.out.printf("이쿼리가 반환하는거뭔지보기용" + session.selectOne(NS + "user_emailAuthChk", user_email));

		System.out.println("이메일:" + dto.getUser_email());
		System.out.println("어스:" + dto.getUser_auth());

		if (dto.getUser_email() == null) {
			return 0;
		} else if (dto.getUser_auth().equals("U")) {
			return 1;
		} else if (dto.getUser_auth().equals("N")) {
			return 2;
		} else if (dto.getUser_auth().equals("G")) {
			return 3;
		} else {
			return 4;
		}

	}


	@Override
	public LPUserDto user_apiEmailDupChk(String user_email) {

		return session.selectOne(NS+"user_apiEmailDupChk", user_email);
	}

}

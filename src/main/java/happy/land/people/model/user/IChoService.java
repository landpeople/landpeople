package happy.land.people.model.user;

import java.util.Map;

import happy.land.people.dto.cho.ChoDto;

public interface IChoService {
	//회원가입
	public boolean signUp(ChoDto dto);
	//로그인
	public ChoDto login(ChoDto dto);
	//회원탈퇴
	public boolean deleteUser(String user_email);
	//정보수정
	public boolean userInfo(ChoDto dto); 
	//이메일중복체크
	public int emailDupChk(String user_email);
	//닉네임중복체크
	public int nicknameDupChk(String user_nickname);
	//이메일 인증키 저장
	public boolean authkeyUpdate(ChoDto dto);
	//이메일 인증 상태 변경
	public boolean authStatusUpdate(String user_email);
	//이메일로 하는 비밀번호 수정 (비밀번호 찾기)
	public boolean findPW(ChoDto dto);
	
	//비밀번호 찾기 할때 이메일 무슨가입자인지 구별하는 
		public int emailAuthChk(String user_email);
		
		//api사용자 이메일 중복체크
		public ChoDto apiEmailDupChk(String user_email);
}

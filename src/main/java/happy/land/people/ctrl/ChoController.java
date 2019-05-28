package happy.land.people.ctrl;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;

import happy.land.people.dto.cho.ChoDto;
import happy.land.people.model.chat.IChatService;
import happy.land.people.model.cho.IChoService;
import happy.land.people.naver.NaverLoginBO;

@Controller
public class ChoController {

	private Logger logger = LoggerFactory.getLogger(ChoController.class);

	@Autowired
	private IChoService iChoService;

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	@Autowired
	IChatService iLeeService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	// 메인페이지로가는 컨트롤러
	@RequestMapping(value = "/mainPage.do", method = RequestMethod.GET)
	public String mainPage() {
		return "foward:./index.jsp";
	}

	// 로그인 페이지로 가는 컨트롤러 + 네이버 값받아오는거 추가함
	@RequestMapping(value = "/loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginPage(Model model, HttpSession session) {
		logger.info("loginPage 컨트롤러");

		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);

		// 네이버
		model.addAttribute("url", naverAuthUrl);

		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		System.out.println("구글:" + url);

		model.addAttribute("google_url", url);
    
		return "users/loginPage";
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, ChoDto dto) throws Exception {
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		System.out.println(naverLoginBO.getUserProfile(oauthToken).toString());
		model.addAttribute("result", apiResult);

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonArray = (JSONObject) jsonParser.parse(apiResult);
		JSONObject resultObject = (JSONObject) jsonArray.get("response");
		System.out.println(resultObject.get("email"));
		// dto.setUser_email(jsonArray.get("email").);

		String user_email = (String) resultObject.get("email");

		dto.setUser_email(user_email);
		String[] user_name = user_email.split("@");
		dto.setUser_nickname(user_name[0]);
		dto.setUser_auth("N");
		boolean isc = iChoService.signUp(dto);
		System.out.println("isc===="+isc);
		System.out.println("dto===="+dto);
		session.setAttribute("ldto", dto);
        return isc?"foward:./index.jsp":"404";
    }
 
    //구글 로그인 성공시 콜백
    @RequestMapping(value="/callbackgoogle.do" , method= {RequestMethod.POST,RequestMethod.GET})
    public String callbackGoogle(Model model, @RequestParam String code, HttpSession session , ChoDto dto) {
    	System.out.println("여기는 googleCallback");
    
    	
    	/*
    	OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations(); 
    	AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(), null); 
    	String accessToken = accessGrant.getAccessToken(); 
    	Long expireTime = accessGrant.getExpireTime(); 
    	if (expireTime != null && expireTime < System.currentTimeMillis()) 
    	{ accessToken = accessGrant.getRefreshToken(); 
    	logger.info("accessToken is expired. refresh token = {}" , accessToken); }
    	Connection<Google>connection = googleConnectionFactory.createConnection(accessGrant); 
    	Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi(); 
    	PlusOperations plusOperations = google.plusOperations(); 
    	Person person = plusOperations.getGoogleProfile();

    	System.out.println(person.getAccountEmail());
    	*/
    	//String user_email = 

		//dto.setUser_email(user_email);
		//String[] user_name = user_email.split("@");
		//dto.setUser_nickname(user_name[0]);
		//dto.setUser_auth("N");
		//boolean isc = iChoService.signUp(dto);
		//session.setAttribute("ldto", dto);
    	
    	
    	OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
    	AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(), null);
    	String accessToken = accessGrant.getAccessToken();
    	Long expireTime = accessGrant.getExpireTime();
    	
    	System.out.println("exp"+expireTime);
    	
    	boolean isc = expireTime < System.currentTimeMillis();
    	
    	System.out.println("isc:-----"+isc);
    
    	System.out.println("accessToken:-----"+accessToken);
    	
    	if (expireTime != null && expireTime < System.currentTimeMillis()) { 
    	accessToken = accessGrant.getRefreshToken();
    	
    	logger.info("accessToken is expired. refresh token = {}" , accessToken); 
    	
    	} 
    	
    	
    	System.out.println("accessGrant:+========"+accessGrant);
    	Connection<Google>connection = googleConnectionFactory.createConnection(accessGrant);
    	System.out.println("connection:-----"+connection);

    	Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
    	
    	System.out.println(google);
    	
    	/*
    	Connection<Google>connection = googleConnectionFactory.createConnection(accessGrant);
    	Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
    	PlusOperations plusOperations = google.plusOperations(); 
    	Person person = plusOperations.getGoogleProfile();

    	String gemail =  person.getAccountEmail();
    	Map<String, String> map	= person.getEmails();
    	Set<String> set = person.getEmailAddresses();
    	
    	
    	System.out.println("Acemai"+gemail);
    	System.out.println("map"+map);
    	System.out.println("set"+set);
    	
    	dto.setUser_email(gemail);
    	
    	
    	*/
		return "forward:./index.jsp";
	}

	// 여기는 나중에 한다 ^^ 로그인기능 => 다 됐다 로그인 기능
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(ChoDto dto, HttpSession session,HttpServletResponse response, HttpServletRequest request) throws IOException {

		// 
		
		
		
		
		
		int n2 = iChoService.emailDupChk(dto.getUser_email());
		
		if(n2 == 0 ) {
			System.out.println("가입안한사람임");
			
			String emailno = "emailno";
			request.setAttribute("eno", emailno);
			return "users/loginPage";
		}

		
		
		
		
		
		//여기서 막아버리자 로그인시 확인하는거 api인지 일반인지  api면 api가입자라고 보여주자
		System.out.println("login쿼리 실행전");
		ChoDto ldto = iChoService.login(dto);
		System.out.println("login쿼리 실행후");
		
		
		
		if(ldto.getUser_delflag().equals("T")) {
			System.out.println("회원탈퇴자");
			String delflag = "delflag";
			request.setAttribute("delflag", delflag);
			
			return "users/loginPage";
		}
		

		System.out.println(ldto);
		
		
		if(ldto.getUser_password().equals("no")) {
			//비밀번호 일치 x
			//쫓아내
			System.out.println("비번 틀렸다");
			
			String no = "no";
			
			request.setAttribute("no", no);
			
			return "users/loginPage";
		}else {
			//비밀번호 일치 
			// 이메일인증여부 확인
			// 인증했으면 로긴
			// 안했으면 쫓아내
			if(ldto.getUser_emailchk().equals("N")) {
				System.out.println("비번 일치 이메일 인증안함");
				
				String eChk = "eChk";
				
				request.setAttribute("eChk", eChk);
				
				return "users/loginPage";
				
			}else {
				System.out.println("비번 일치 이메일인증 함");
				
			
			}
		}
		
		
		
		int n = iLeeService.chatList_SelectOne(ldto.getUser_nickname());
		if (n == 0) {
			iLeeService.chatList_Insert(ldto.getUser_nickname());
		}
		session.setAttribute("ldto", ldto);
		
		
		
		return "forward:./index.jsp";
	}

	// 로그아웃
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session, ChoDto dto) {
		logger.info("logout");

		System.out.println("로그아웃.do 현재 세션 : " + session);

		session.invalidate();
		return "redirect:./index.jsp";
	}

	// 회원가입 페이지로가기 ^^
	@RequestMapping(value = "/regiForm.do", method = RequestMethod.GET)
	public String regiForm() {
		logger.info("regiForm 컨트롤러");

		return "users/sign/regiForm";
	}

	
	// 회원가입(db에저장하기 헤헤) 일반유저
	@RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
	public String signUp(HttpServletRequest req, ChoDto dto) {

		dto.setUser_auth("U");
		boolean isc = iChoService.signUp(dto);

		return isc ? "users/sign/emailSubmit" : "404";
	}

	// 이메일 링크 클릭으로 들어옴
	@RequestMapping(value = "/mailConfirm.do", method = RequestMethod.GET)
	public String mailConfirm(ChoDto dto) {
//		System.out.println(dto); //==	logger.info(dto.toString());
		boolean isc = iChoService.authStatusUpdate(dto.getUser_email());
		return isc ? "users/sign/auth" : "error";
	}
	
	//이메일 입력하는페이지로가기
	@RequestMapping(value="/inputemail.do",method=RequestMethod.GET)
	public String inputemail() {
		
		return "users/pwforget/inputemail";
	}
	
	
	//아작스인데 이메일 유저인지 네이버인지 구글인지 구별해주는 컨트롤러
	@RequestMapping(value="/findEmailchk.do" , method=RequestMethod.POST)
	@ResponseBody
	public String findEmailchk(String user_email,ChoDto dto) {
		logger.info("여기는 비밀번호찾기할떄 이메일 뭐야 무슨가입자인지 그리고 가입했는지 구별해주는곳");
		
		String email = user_email;
		System.out.println(email);
		
		int n =iChoService.emailAuthChk(user_email);
		
		System.out.println("n은 뭘 리턴하니?"+n);
		
		// 0=비회원 1=유저 2=네이버 3=구글
		if(n == 0) {
			logger.info("======가입하지 않은회원");
			return "0";
		}else if (n==1) {
			System.out.println("n=1 유저");
			return "U";
		}else if(n==2) {
			System.out.println("n=2 네이버");
			return "N";
		}else if(n==3) {
			System.out.println("n=3 구글");
			return "G";
		}else {
			System.out.println("어드민ㅋㅋ");
			return "4";
		}
		
		
	}
	
	
	//이메일로 링크보내주기
	@RequestMapping(value="/findPW.do" , method=RequestMethod.GET)
	public String findPW(ChoDto dto) {
		iChoService.findPW(dto);
		return "users/pwforget/pwemailSubmit";
	}
	
	
	//비밀번호 찾기로 와서 비밀번호 수정페이지로보내주기
	@RequestMapping(value="/pwforget.do",method=RequestMethod.GET)
	public String pwforget(ChoDto dto,HttpServletRequest request) {
		request.setAttribute("user_email", dto.getUser_email());
		System.out.println(dto.getUser_email());
		return "users/pwforget/pwforget";
	}
	
	//비밀번호찾기로 비밀번호 수정 완료했을때 오는 컨트롤러
	@RequestMapping(value="/modifyPwSuc.do" , method=RequestMethod.POST)
	public String modifyPwSuc(ChoDto dto) {
		
		System.out.println("dto이메일"+dto.getUser_email());
		
		dto.setUser_auth("U");
		dto.setUser_email(dto.getUser_email());
		iChoService.userInfo(dto);
		
		
		return "users/loginPage";
	}
	
	
	//회원가입 이메일 중복 체크
	@RequestMapping(value="/emailchk.do" , method=RequestMethod.POST,produces="application/text; charset=utf-8")
	@ResponseBody
	public String emailChk(String user_email) {
		logger.info("이메일 중복체크 컨트롤러");
		String email = user_email;
		
		System.out.println(email);
		
		
		int n=iChoService.emailDupChk(user_email);
		
		System.out.println("이메일이 있으면 1 없으면 0 이떠야함:"+n);
		return (n==0) ? "0":"1"; //0은 사용가능 1은 사용x 
	}
	
	//회원가입 닉네임 중복 체크
	@RequestMapping(value="/nicknamecheck.do" , method=RequestMethod.POST,produces="application/text; charset=utf-8")
	@ResponseBody
	public String nicknameChk(String user_nickname) {
		logger.info("닉네임 중복체크");
		
		System.out.println(user_nickname);
		
		int n = iChoService.nicknameDupChk(user_nickname);
		System.out.println("닉네임 있으면 1 없으면 0 이떠야함:"+n);
		return (n==0)?"0":"1";//0은 사용가능 1은 사용x 
	}
	
	
	
	
	
	
	//마이페이지
	@RequestMapping(value="/mypage.do", method= {RequestMethod.GET ,RequestMethod.POST})
	public String mypage(HttpSession session) {
		ChoDto ldto =(ChoDto) session.getAttribute("ldto");
		System.out.println(ldto);
		if(ldto == null) {
			return "redirect:./index.jsp";
		}
		
		
		return "users/mypage";
	}
	
	
	//마이페이지 수정 완료
	@RequestMapping(value="/modifyMypage.do" , method=RequestMethod.POST)
	public String modifyMypage(ChoDto dto, HttpSession session) {
		ChoDto userDto = (ChoDto)session.getAttribute("ldto");
		System.out.println("dto잘봤냐"+dto);
		dto.setUser_auth(userDto.getUser_auth());
		iChoService.userInfo(dto);
		
		return "forward:./index.jsp";
	}
	
	
	//회원탈퇴페이지로가기
	@RequestMapping(value="/delpage.do" , method=RequestMethod.GET)
	public String delflagPage() {
		logger.info("회원탈테페이지로 ㄱㄱㄱ     ///오니?");
		return "users/delpage";
	}
	
	// 회원탈퇴
	@RequestMapping(value="/delflag.do" , method=RequestMethod.GET)
	public String delflag(ChoDto dto ,HttpSession session) {
		ChoDto ldto =(ChoDto) session.getAttribute("ldto");
		
		System.out.println(ldto);
		
		
		iChoService.deleteUser(ldto.getUser_email());
		session.invalidate();
		return "forward:./index.jsp";
	}
	
}

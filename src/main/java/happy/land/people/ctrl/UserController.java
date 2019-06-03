package happy.land.people.ctrl;

import java.io.IOException;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.github.scribejava.core.model.OAuth2AccessToken;

import happy.land.people.dto.AuthInfo;
import happy.land.people.dto.LPUserDto;
import happy.land.people.model.chat.IChatService;
import happy.land.people.model.user.ILPUserService;
import happy.land.people.naver.NaverLoginBO;

@Controller
public class UserController {

	private Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private ILPUserService iUserService;

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	// google
	@Inject
	private AuthInfo authInfo;

	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;

	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	@Autowired
	IChatService iLeeService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	// 메인페이지로가는 컨트롤러
	@RequestMapping(value = "/mainPage.do", method = RequestMethod.GET)
	public String mainPage() {
		return "forward:./index.jsp";
	}

	// 로그인 페이지로 가는 컨트롤러 + 네이버 값받아오는거 추가함
	@RequestMapping(value = "/loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginPage(Model model, HttpSession session, HttpServletResponse response) {
		logger.info("loginPage 컨트롤러");

		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);

		// 네이버
		model.addAttribute("url", naverAuthUrl);

		// URL을 생성한다.
		String url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		System.out.println("/googleLogin, url : " + url);
		model.addAttribute("google_url", url);

		return "user/login";
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session,
			LPUserDto dto, HttpServletResponse response,HttpServletRequest request) throws Exception {
		System.out.println("여기는  네이버 callback");
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

		// 실험
		System.out.println(user_email);
		System.out.println("dto에 뭐가전달됬을까? 네이버로하면?" + dto);

		dto.setUser_email(user_email);
		String[] user_name = user_email.split("@");
		dto.setUser_nickname(user_name[0]);
		dto.setUser_auth("N");

		System.out.println(dto);

//로그인시 아이디를 확인해 그리고 있으면 auth를 반환해 없으면 그냥 자연스럽게 흘러가 ~~

		boolean isc = iUserService.signUp(dto);

		if (isc ==false) {
			System.out.println("여기는 네이버콜백컨트롤러 구글이메일이랑 네이버 이메일이 같을시 일로옴");
			String apiEmailDup = "apiEmailDup";
			request.setAttribute("apiEmailDupN", apiEmailDup);
			return "user/login";
		} 
		session.setAttribute("ldto", dto);
		return "forward:./index.jsp";
	}

	// 구글 로그인 성공시 콜백
	@RequestMapping(value = "/callbackgoogle.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String callbackGoogle(Model model, @RequestParam String code, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("여기는 googleCallback");

		System.out.println(code);

		// RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
		parameters.add("code", code);
		parameters.add("client_id", authInfo.getClientId());
		parameters.add("client_secret", authInfo.getClientSecret());
		parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
		parameters.add("grant_type", "authorization_code");

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(
				parameters, headers);
		ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token",
				HttpMethod.POST, requestEntity, Map.class);
		Map<String, Object> responseMap = responseEntity.getBody();

		// id_token 라는 키에 사용자가 정보가 존재한다.
		// 받아온 결과는 JWT (Json Web Token) 형식으로 받아온다. 콤마 단위로 끊어서 첫 번째는 현 토큰에 대한 메타 정보, 두
		// 번째는 우리가 필요한 내용이 존재한다.
		// 세번째 부분에는 위변조를 방지하기 위한 특정 알고리즘으로 암호화되어 사이닝에 사용한다.
		// Base 64로 인코딩 되어 있으므로 디코딩한다.

		String[] tokens = ((String) responseMap.get("id_token")).split("\\.");
		Base64 base64 = new Base64(true);
		String body = new String(base64.decode(tokens[1]));

		System.out.println(tokens.length);
		System.out.println(new String(Base64.decodeBase64(tokens[0]), "utf-8"));
		System.out.println(new String(Base64.decodeBase64(tokens[1]), "utf-8"));

		// Jackson을 사용한 JSON을 자바 Map 형식으로 변환
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> result = mapper.readValue(body, Map.class);
		System.out.println(result.get("email"));

		String user_email = (String) result.get("email");

		LPUserDto dto = new LPUserDto();

		dto.setUser_email(user_email);
		dto.setUser_auth("G");

		String[] user_name = user_email.split("@");
		dto.setUser_nickname(user_name[0]);

		System.out.println(dto);

		boolean isc = iUserService.signUp(dto);
		System.out.println(isc);
		
		if (isc ==false) {
			System.out.println("여기는 네이버콜백컨트롤러 구글이메일이랑 네이버 이메일이 같을시 일로옴");
			String apiEmailDup = "apiEmailDup";
			request.setAttribute("apiEmailDupG", apiEmailDup);
			return "user/login";
		} 
		
		session.setAttribute("ldto", dto);
		return "forward:./index.jsp";
	}

	// 여기는 나중에 한다 ^^ 로그인기능 => 다 됐다 로그인 기능
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(LPUserDto dto, HttpSession session, HttpServletResponse response, HttpServletRequest request)
			throws IOException {

		//

		int n2 = iUserService.emailDupChk(dto.getUser_email());

		if (n2 == 0) {
			System.out.println("가입안한사람임");

			String emailno = "emailno";
			request.setAttribute("eno", emailno);
			return "user/login";
		}

		// 여기서 막아버리자 로그인시 확인하는거 api인지 일반인지 api면 api가입자라고 보여주자
		System.out.println("login쿼리 실행전");
		LPUserDto ldto = iUserService.login(dto);
		System.out.println("login쿼리 실행후");

		if (ldto.getUser_delflag().equals("T") && ldto.getUser_password() != null) {
			System.out.println("회원탈퇴자");
			String delflag = "delflag";
			request.setAttribute("delflag", delflag);

			return "user/login";
		}

		System.out.println(ldto);

		if (ldto.getUser_password() == null) {
			System.out.println("api가입자");
			String apiuser = "apiuser";
			request.setAttribute("apiuser", apiuser);
			return "user/login";
		}

		if (ldto.getUser_password().equals("no")) {
			// 비밀번호 일치 x
			// 쫓아내
			System.out.println("비번 틀렸다");

			String no = "no";

			request.setAttribute("no", no);

			return "user/login";
		} else {
			// 비밀번호 일치
			// 이메일인증여부 확인
			// 인증했으면 로긴
			// 안했으면 쫓아내
			if (ldto.getUser_emailchk().equals("N")) {
				System.out.println("비번 일치 이메일 인증안함");

				String eChk = "eChk";

				request.setAttribute("eChk", eChk);

				return "user/login";

			} else {
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
	public String logout(HttpSession session, LPUserDto dto) {
		logger.info("logout");

		System.out.println("로그아웃.do 현재 세션 : " + session);

		session.invalidate();
		return "redirect:./index.jsp";
	}

	// 회원가입 페이지로가기 ^^
	@RequestMapping(value = "/regiForm.do", method = RequestMethod.GET)
	public String regiForm() {
		logger.info("regiForm 컨트롤러");

		return "user/signup";
	}

	// 회원가입(db에저장하기 헤헤) 일반유저
	@RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
	public String signUp(HttpServletRequest req, LPUserDto dto) {

		dto.setUser_auth("U");
		boolean isc = iUserService.signUp(dto);

		return isc ? "user/signupEmail" : "404";
	}

	// 이메일 링크 클릭으로 들어옴
	@RequestMapping(value = "/mailConform.do", method = RequestMethod.GET)
	public String mailConfirm(LPUserDto dto) {
//		System.out.println(dto); //==	logger.info(dto.toString());
		boolean isc = iUserService.authStatusUpdate(dto.getUser_email());
		System.out.println("-----------------------------------------" + isc);
		return isc ? "user/infoEmail" : "error";
	}

	// 이메일 입력하는페이지로가기
	@RequestMapping(value = "/inputemail.do", method = RequestMethod.GET)
	public String inputemail() {

		return "user/inputEmail";
	}

	// 아작스인데 이메일 유저인지 네이버인지 구글인지 구별해주는 컨트롤러
	@RequestMapping(value = "/findEmailchk.do", method = RequestMethod.POST)
	@ResponseBody
	public String findEmailchk(String user_email, LPUserDto dto, HttpServletRequest request) {
		logger.info("여기는 비밀번호찾기할떄 이메일 뭐야 무슨가입자인지 그리고 가입했는지 구별해주는곳");

		int n2 = iUserService.emailDupChk(dto.getUser_email());

		if (n2 == 0) {
			System.out.println("가입안한사람임");

			return "0";
		}

		String email = user_email;
		System.out.println(email);

		int n = iUserService.emailAuthChk(user_email);

		System.out.println("n은 뭘 리턴하니?" + n);

		// 0=비회원 1=유저 2=네이버 3=구글
		if (n == 0) {
			logger.info("======가입하지 않은회원");
			return "0";
		} else if (n == 1) {
			System.out.println("n=1 유저");
			return "U";
		} else if (n == 2) {
			System.out.println("n=2 네이버");
			return "N";
		} else if (n == 3) {
			System.out.println("n=3 구글");
			return "G";
		} else {
			System.out.println("어드민ㅋㅋ");
			return "4";
		}

	}

	// 이메일로 링크보내주기
	@RequestMapping(value = "/findPW.do", method = RequestMethod.GET)
	public String findPW(LPUserDto dto) {
		iUserService.findPW(dto);
		return "user/findPwEmail";
	}

	// 비밀번호 찾기로 와서 비밀번호 수정페이지로보내주기
	@RequestMapping(value = "/pwforget.do", method = RequestMethod.GET)
	public String pwforget(LPUserDto dto, HttpServletRequest request) {
		request.setAttribute("user_email", dto.getUser_email());
		System.out.println(dto.getUser_email());
		return "user/modifyPwEmail";
	}

	// 비밀번호찾기로 비밀번호 수정 완료했을때 오는 컨트롤러
	@RequestMapping(value = "/modifyPwSuc.do", method = RequestMethod.POST)
	public String modifyPwSuc(LPUserDto dto) {

		System.out.println("dto이메일" + dto.getUser_email());
		dto.setUser_auth("U");
		
		System.out.println(dto);
		
		iUserService.userInfo(dto);

		return "user/login";
	}

	// 회원가입 이메일 중복 체크
	@RequestMapping(value = "/emailchk.do", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String emailChk(String user_email) {
		logger.info("이메일 중복체크 컨트롤러");
		String email = user_email;

		System.out.println(email);

		int n = iUserService.emailDupChk(user_email);

		System.out.println("이메일이 있으면 1 없으면 0 이떠야함:" + n);
		return (n == 0) ? "0" : "1"; // 0은 사용가능 1은 사용x
	}

	// 회원가입 닉네임 중복 체크
	@RequestMapping(value = "/nicknamecheck.do", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String nicknameChk(String user_nickname) {
		logger.info("닉네임 중복체크");

		System.out.println(user_nickname);

		int n = iUserService.nicknameDupChk(user_nickname);
		System.out.println("닉네임 있으면 1 없으면 0 이떠야함:" + n);
		return (n == 0) ? "0" : "1";// 0은 사용가능 1은 사용x
	}

	// 마이페이지
	@RequestMapping(value = "/mypage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String mypage(HttpSession session) {
		LPUserDto ldto = (LPUserDto) session.getAttribute("ldto");
		System.out.println(ldto);
		if (ldto == null) {
			return "redirect:./index.jsp";
		}

		return "user/modifyInfo";
	}

	// 마이페이지 수정 완료
	@RequestMapping(value = "/modifyMypage.do", method = RequestMethod.POST)
	public String modifyMypage(LPUserDto dto, HttpSession session) {
		LPUserDto userDto = (LPUserDto) session.getAttribute("ldto");
		System.out.println("수정했을떄 받아오는 dto---" + dto);
		System.out.println("session에 담겨있는 dto---"+userDto);
		dto.setUser_auth(userDto.getUser_auth());
		iUserService.userInfo(dto);
    
		session.setAttribute("ldto", dto);
		return "forward:./index.jsp";
	}

	// 회원탈퇴페이지로가기
	@RequestMapping(value = "/delpage.do", method = RequestMethod.GET)
	public String delflagPage() {
		logger.info("회원탈테페이지로 ㄱㄱㄱ     ///오니?");
		return "user/deleteAccount";
	}

	// 회원탈퇴
	@RequestMapping(value = "/delflag.do", method = RequestMethod.GET)
	public String delflag(LPUserDto dto, HttpSession session) {
		LPUserDto ldto = (LPUserDto) session.getAttribute("ldto");

		System.out.println(ldto);

		iUserService.deleteUser(ldto.getUser_email());
		session.invalidate();
		return "forward:./index.jsp";
	}

}

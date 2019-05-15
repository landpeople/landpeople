package happy.land.people.ctrl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import happy.land.people.dto.cho.ChoDto;
import happy.land.people.model.cho.IChoService;
import happy.land.people.model.lee.ILeeService;

@Controller
public class ChoController {

	private Logger logger = LoggerFactory.getLogger(ChoController.class);

	@Autowired
	private IChoService iChoService;

	@Autowired
	ILeeService iLeeService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	// 메인페이지로가는 컨트롤러
	@RequestMapping(value = "/mainPage.do", method = RequestMethod.GET)
	public String mainPage() {
		return "redirect:./index.jsp";
	}

	@RequestMapping(value = "/loginPage.do", method = RequestMethod.GET)
	public String loginPage() {
		logger.info("loginPage 컨트롤러");

		return "users/loginPage";
	}

	// 여기는 나중에 한다 ^^ 로그인기능 => 다 됐다 로그인 기능
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(ChoDto dto, HttpSession session) {

		ChoDto ldto = iChoService.login(dto);

		System.out.println(ldto);
		iLeeService.chatList_Insert(ldto.getUser_nickname());
		session.setAttribute("ldto", ldto);

		return "forward:./index.jsp";
	}

	// 회원가입 페이지로가기 ^^
	@RequestMapping(value = "/regiForm.do", method = RequestMethod.GET)
	public String regiForm() {
		logger.info("regiForm 컨트롤러");

		return "users/sign/regiForm";
	}

	// 회원가입(db에저장하기 헤헤)
	@RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
	public String signUp(HttpServletRequest req, ChoDto dto) {

		boolean isc = iChoService.signUp(dto);

		return isc ? "users/sign/auth" : "404";
	}

	// 이메일 링크 클릭으로 들어옴
	@RequestMapping(value = "/mailConfirm.do", method = RequestMethod.GET)
	public String mailConfirm(ChoDto dto) {
//		System.out.println(dto); //==	logger.info(dto.toString());
		boolean isc = iChoService.authStatusUpdate(dto.getUser_email());
		return isc ? "users/sign/auth" : "error";
	}

}

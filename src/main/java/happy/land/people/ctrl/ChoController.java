package happy.land.people.ctrl;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ChoController {

	private Logger logger = LoggerFactory.getLogger(ChoController.class);
	
	@RequestMapping(value="/loginPage.do", method=RequestMethod.GET)
	public String loginPage() {
		logger.info("loginPage 컨트롤러");
		
		return "users/loginPage";
	}
	
	
	
	// 여기는 나중에 한다 ^^
	@RequestMapping(value="/login.do" ,method=RequestMethod.POST)
	public String login(HttpServletRequest req) {
		logger.info("login 컨트롤러");
		
		String email = req.getParameter("user_email");
		String pw = req.getParameter("user_password");
		
		System.out.println("아이디:"+email);
		System.out.println("비밀번호:"+pw);
		
		
		return "redirect:./index.jsp";
	}
	
	
	//회원가입 페이지로가기 ^^
	@RequestMapping(value="/regiForm.do" , method=RequestMethod.GET)
	public String regiForm() {
		logger.info("regiForm 컨트롤러");
		
		
		return "users/sign/regiForm";
	}
	
	//회원가입
	@RequestMapping(value="/signUp.do" , method=RequestMethod.POST)
	public String signUp() {
		
		return null;
	}
	
	
	
}

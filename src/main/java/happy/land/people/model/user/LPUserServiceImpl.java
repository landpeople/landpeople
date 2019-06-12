package happy.land.people.model.user;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import happy.land.people.beans.MailUtils;
import happy.land.people.beans.TempKey;
import happy.land.people.dto.LPUserDto;
@Service
public class LPUserServiceImpl implements ILPUserService {

	@Autowired
	private ILPUserDao iUserDao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	private Logger logger = LoggerFactory.getLogger(LPUserServiceImpl.class);
	
	@Override
	public boolean user_signUp(LPUserDto dto) {
		System.out.println("signUp 서비스 임플");
		boolean isc = iUserDao.user_signUp(dto);
		System.out.println("==============================================================="+isc);
		
		// 만약에 user_auth가 n 이거나 g면 바로 가입 u면 이메일인증 하기
		String user_auth = dto.getUser_auth();
		System.out.println(user_auth);
		if(user_auth.equals("N")) {
			return isc;
		}else if(user_auth.equals("G")) {
			return isc;
		}else {
		//authkey 임시 생성 후 dto 같이 담아줌
		String user_emailkey = new TempKey().getKey(50, false);
		dto.setUser_emailkey(user_emailkey);
		System.out.println(dto);
		
		isc = iUserDao.user_authkeyUpdate(dto);
		
		// 메일 관련
		// 메일 내용 담을 변수(email, authkey만 보낼예정)
		String mailContent = new StringBuffer()
				.append("	<div style=\"background-color: #F9F9F9;\">\r\n" + 
						"		<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"\r\n" + 
						"		<div style=\"margin: 0px auto; max-width: 640px; background: transparent;\">\r\n" + 
						"			<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: transparent;\" border=\"0\">\r\n" + 
						"				<tbody>\r\n" + 
						"					<tr>\r\n" + 
						"						<td style=\"text-align: center; vertical-align: top; direction: ltr; font-size: 0px; padding: 40px 0px;\">\r\n" + 
						"							<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"							<div style=\"vertical-align: top; display: inline-block; direction: ltr; font-size: 13px; text-align: left; width: 100%;\">\r\n" + 
						"								<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
						"									<tbody>\r\n" + 
						"										<tr>\r\n" + 
						"											<td align=\"center\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: collapse; border-spacing: 0px;\" border=\"0\">\r\n" + 
						"													<tbody>\r\n" + 
						"														<tr>\r\n" + 
						"															<td style=\"width: 138px;\"><a href=\"http://192.168.4.31:8091/LandPeople/\" target=\"_blank\" rel=\"noreferrer noopener\"><img alt=\"\" title=\"\" height=\"38px\" src=\"http://192.168.4.31:8091/LandPeople/img/logo2.JPG\" style=\"border: none; border-radius:; display: block; outline: none; text-decoration: none; width: 300px; height: auto; width=\"138\" ></a></td>\r\n" + 
						"														</tr>\r\n" + 
						"													</tbody>\r\n" + 
						"												</table></td>\r\n" + 
						"										</tr>\r\n" + 
						"									</tbody>\r\n" + 
						"								</table>\r\n" + 
						"							</div>\r\n" + 
						"							<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"						</td>\r\n" + 
						"					</tr>\r\n" + 
						"				</tbody>\r\n" + 
						"			</table>\r\n" + 
						"		</div>\r\n" + 
						"		<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"		<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"      \r\n" + 
						"      \r\n" + 
						"      <!-- 아래래래ㅐ -->\r\n" + 
						"      \r\n" + 
						"      \r\n" + 
						"		<div style=\"max-width: 640px; margin: 0 auto; box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.1); border-radius: 4px; overflow: hidden\">\r\n" + 
						"			<div style=\"margin: 0px auto; max-width: 640px; background: #ffffff;\">\r\n" + 
						"				<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: #ffffff;\" border=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"text-align: center; vertical-align: top; direction: ltr; font-size: 0px; padding: 40px 50px;\">\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"								<div style=\"vertical-align: top; display: inline-block; direction: ltr; font-size: 13px; text-align: left; width: 100%;\">\r\n" + 
						"									<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
						"										<tbody>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"left\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><div style=\"cursor: auto; color: #737F8D; font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px; line-height: 24px; text-align: left;\">\r\n" + 
						"\r\n" + 
						"														<h2 style=\"font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-weight: 500; font-size: 20px; color: #4F545C; letter-spacing: 0.27px;\">안녕하세요.</h2>\r\n" + 
						"														<p>육지사람 에 회원 가입 해 주셔서 감사합니다! 시작하기 전에, 저희는 당신이 맞는지 확인 해야 합니다. 아래의 이메일 인증 주소를 클릭해주세요.</p>\r\n" + 
						"\r\n" + 
						"													</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"center\" style=\"word-break: break-word; font-size: 0px; padding: 10px 25px; padding-top: 20px;\"><table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate;\" border=\"0\">\r\n" + 
						"														<tbody>\r\n" + 
						"															<tr>\r\n" + 
						"																<td align=\"center\" valign=\"middle\" style=\"border: none; border-radius: 3px; color: white; cursor: auto; padding: 15px 19px;\" bgcolor=\"#7289DA\">")
				.append("<a href='http://192.168.4.31:8091/LandPeople/mailConform.do?user_email=")
				.append(dto.getUser_email())
				.append("&authkey=").append(dto.getUser_emailkey())
				.append("'style=\"text-decoration: none; line-: 100%; background: #7289da; color: white; font-family: ubuntu, helvetica, arial, sans-serif; font-size: 15px; font-weight: normal; text-transform: none; margin: 0px;\" target=\"_blank\" rel=\"noreferrer noopener\"> 이메일 인증 </a></td>\r\n" + 
						"															</tr>\r\n" + 
						"														</tbody>\r\n" + 
						"													</table></td>\r\n" + 
						"											</tr>\r\n" + 
						"											<tr>\r\n" + 
						"												<td style=\"word-break: break-word; font-size: 0px; padding: 30px 0px;\"><p style=\"font-size: 1px; margin: 0px auto; border-top: 1px solid #DCDDDE; width: 100%;\"></p>\r\n" + 
						"													<!--[if mso | IE]><table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size:1px;margin:0px auto;border-top:1px solid #DCDDDE;width:100%;\" width=\"640\"><tr><td style=\"height:0;line-height:0;\">&nbsp;</td></tr></table><![endif]--></td>\r\n" + 
						"											</tr>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"left\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><div style=\"cursor: auto; color: #747F8D; font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 13px; line-height: 16px; text-align: left;\">\r\n" + 
						"														<p>\r\n" + 
						"															도움이 필요하신가요? <a href=\"https://www.youtube.com/watch?v=wzon0-QUuNE\" style=\"font-family: whitney, helvetica neue, helvetica, arial, lucida grande, sans-serif; color: #7289da;\" rel=\"noreferrer noopener\" target=\"_blank\">지원팀에 문의</a>하세요.\r\n" + 
						"														</p>\r\n" + 
						"\r\n" + 
						"													</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"										</tbody>\r\n" + 
						"									</table>\r\n" + 
						"								</div>\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</div>\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      </div></td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<div style=\"margin: 0px auto; max-width: 640px; background: transparent;\">\r\n" + 
						"				<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: transparent;\" border=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"text-align: center; vertical-align: top; direction: ltr; font-size: 0px; padding: 0px;\">\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"								<div style=\"vertical-align: top; display: inline-block; direction: ltr; font-size: 13px; text-align: left; width: 100%;\">\r\n" + 
						"									<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
						"										<tbody>\r\n" + 
						"											<tr>\r\n" + 
						"												<td style=\"word-break: break-word; font-size: 0px;\"><div style=\"font-size: 1px; line-height: 12px;\">&nbsp;</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"										</tbody>\r\n" + 
						"									</table>\r\n" + 
						"								</div>\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</div>\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table></div>\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<div style=\"margin: 0 auto; max-width: 640px; background: #ffffff; box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.1); border-radius: 4px; overflow: hidden;\">\r\n" + 
						"				<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: #ffffff;\" border=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"text-align: center; vertical-align: top; font-size: 0px; padding: 0px;\">\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</div>\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<div style=\"margin: 0px auto; max-width: 640px; background: transparent;\">\r\n" + 
						"				<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: transparent;\" border=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"text-align: center; vertical-align: top; direction: ltr; font-size: 0px; padding: 20px 0px;\">\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"								<div style=\"vertical-align: top; display: inline-block; direction: ltr; font-size: 13px; text-align: left; width: 100%;\">\r\n" + 
						"									<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
						"										<tbody>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"center\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><div style=\"cursor: auto; color: #99AAB5; font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 12px; line-height: 24px; text-align: center;\">\r\n" + 
						"														육지사람에서 보냄 • <a href=\"http://192.168.4.31:8091/LandPeople\" style=\"color: #1eb0f4; text-decoration: none;\" rel=\"noreferrer noopener\" target=\"_blank\">육지사람사이트 확인</a>\r\n" + 
						"													</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"center\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><div style=\"cursor: auto; color: #99AAB5; font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 12px; line-height: 24px; text-align: center;\">Mountain, 7515-1, Jungsangandong-ro, Seogwipo-si, Jeju-do, Republic of Korea</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"										</tbody>\r\n" + 
						"									</table>\r\n" + 
						"								</div>\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</div>\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<img width=\"1px\" height=\"1px\" alt=\"\" src=\"http://email.mailgun.discordapp.com/o/eJwVjDkOwyAQAF8TSsQuazAFRaT4IcuhgISNhZO836QZaYqZ5ClTgiCqRwVOGQVKT6IEOQ2eZIiW12atdg9SO9f2_h4y1Sv2kfg8Zey7KB4zrxgQLWkE44C1cwxklxDianUQw3_KqK3F0ufn4F8e__QGpaYk2Q\">\r\n" + 
						"\r\n" + 
						"\r\n" + 
						"\r\n" + 
						"		</div>\r\n" + 
						"	\r\n" + 
						"	</div>")
				.toString();
		
		
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			
			// 메일 제목
			sendMail.setSubject("[LandPeople] 서비스 메일 인증");
			// 메일 내용 (html전송)
			sendMail.setText(mailContent);
			// 메일 보내는 계정
			sendMail.setFrom("info.happy0612@gmail.com", "육지사람");
			// 메일 받는 사람
			sendMail.setTo(dto.getUser_email());
			
			sendMail.send();
			
		} catch (MessagingException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		}
		return isc;
	}

	@Override
	public LPUserDto user_login(LPUserDto dto) {
		return iUserDao.user_login(dto);
	}

	@Override
	public boolean user_deleteUser(String user_email) {
		return iUserDao.user_deleteUser(user_email);
	}

	@Override
	public boolean user_userInfo(LPUserDto dto) {
		return iUserDao.user_userInfo(dto);
	}

	@Override
	public int user_emailDupChk(String user_email) {
		logger.info("이메일중복체크 서비스임플");
		return iUserDao.user_emailDupChk(user_email);
	}

	@Override
	public int user_nicknameDupChk(String user_nickname) {
		logger.info("닉네임 중복체크 서비스 임플");
		return iUserDao.user_nicknameDupChk(user_nickname);
	}

	@Override
	public boolean user_authkeyUpdate(LPUserDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean user_authStatusUpdate(String user_email) {
		return iUserDao.user_authStatusUpdate(user_email);
	}

	
	// 비빌번호찾기한사람한테 이메일 보내주는 메소드
	@Override
	public boolean user_findPW(LPUserDto dto) {
		System.out.println("findPW 서비스 임플");
		boolean isc = iUserDao.user_findPW(dto);
		System.out.println("====================================="+isc);
		
		//authkey 임시 생성 후 dto 같이 담아줌
		String user_emailkey = new TempKey().getKey(50, false);
		dto.setUser_emailkey(user_emailkey);
		System.out.println(dto);
		
		isc = iUserDao.user_authkeyUpdate(dto);
		
		// 메일 관련
		// 메일 내용 담을 변수(email, authkey만 보낼예정)
		String mailContent = new StringBuffer()
				.append("	<div style=\"background-color: #F9F9F9;\">\r\n" + 
						"		<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"\r\n" + 
						"		<div style=\"margin: 0px auto; max-width: 640px; background: transparent;\">\r\n" + 
						"			<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: transparent;\" border=\"0\">\r\n" + 
						"				<tbody>\r\n" + 
						"					<tr>\r\n" + 
						"						<td style=\"text-align: center; vertical-align: top; direction: ltr; font-size: 0px; padding: 40px 0px;\">\r\n" + 
						"							<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"							<div style=\"vertical-align: top; display: inline-block; direction: ltr; font-size: 13px; text-align: left; width: 100%;\">\r\n" + 
						"								<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
						"									<tbody>\r\n" + 
						"										<tr>\r\n" + 
						"											<td align=\"center\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: collapse; border-spacing: 0px;\" border=\"0\">\r\n" + 
						"													<tbody>\r\n" + 
						"														<tr>\r\n" + 
						"															<td style=\"width: 138px;\"><a href=\"http://192.168.4.31:8091/LandPeople/\" target=\"_blank\" rel=\"noreferrer noopener\"><img alt=\"\" title=\"\" height=\"38px\" src=\"http://192.168.4.31:8091/LandPeople/img/logo2.JPG\" style=\"border: none; border-radius:; display: block; outline: none; text-decoration: none; width: 300px; height: auto; width=\"138\" ></a></td>\r\n" + 
						"														</tr>\r\n" + 
						"													</tbody>\r\n" + 
						"												</table></td>\r\n" + 
						"										</tr>\r\n" + 
						"									</tbody>\r\n" + 
						"								</table>\r\n" + 
						"							</div>\r\n" + 
						"							<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"						</td>\r\n" + 
						"					</tr>\r\n" + 
						"				</tbody>\r\n" + 
						"			</table>\r\n" + 
						"		</div>\r\n" + 
						"		<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"		<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"      \r\n" + 
						"      \r\n" + 
						"      <!-- 아래래래ㅐ -->\r\n" + 
						"      \r\n" + 
						"      \r\n" + 
						"		<div style=\"max-width: 640px; margin: 0 auto; box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.1); border-radius: 4px; overflow: hidden\">\r\n" + 
						"			<div style=\"margin: 0px auto; max-width: 640px; background: #ffffff;\">\r\n" + 
						"				<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: #ffffff;\" border=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"text-align: center; vertical-align: top; direction: ltr; font-size: 0px; padding: 40px 50px;\">\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"								<div style=\"vertical-align: top; display: inline-block; direction: ltr; font-size: 13px; text-align: left; width: 100%;\">\r\n" + 
						"									<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
						"										<tbody>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"left\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><div style=\"cursor: auto; color: #737F8D; font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px; line-height: 24px; text-align: left;\">\r\n" + 
						"\r\n" + 
						"														<h2 style=\"font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-weight: 500; font-size: 20px; color: #4F545C; letter-spacing: 0.27px;\">안녕하세요.</h2>\r\n" + 
						"														<p>비밀번호를 잊으셨군요 !<br> Sad.... 비밀번호 수정을 하시려면 아래 버튼을 눌러주세요!</p>\r\n" + 
						"\r\n" + 
						"													</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"center\" style=\"word-break: break-word; font-size: 0px; padding: 10px 25px; padding-top: 20px;\"><table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate;\" border=\"0\">\r\n" + 
						"														<tbody>\r\n" + 
						"															<tr>\r\n" + 
						"																<td align=\"center\" valign=\"middle\" style=\"border: none; border-radius: 3px; color: white; cursor: auto; padding: 15px 19px;\" bgcolor=\"#7289DA\">")
				.append("<a href='http://192.168.4.31:8091/LandPeople/pwforget.do?user_email=")
				.append(dto.getUser_email())
				.append("&authkey=").append(dto.getUser_emailkey())
				.append("'style=\"text-decoration: none; line-: 100%; background: #7289da; color: white; font-family: ubuntu, helvetica, arial, sans-serif; font-size: 15px; font-weight: normal; text-transform: none; margin: 0px;\" target=\"_blank\" rel=\"noreferrer noopener\">  비밀번호 수정 </a></td>\r\n" + 
						"															</tr>\r\n" + 
						"														</tbody>\r\n" + 
						"													</table></td>\r\n" + 
						"											</tr>\r\n" + 
						"											<tr>\r\n" + 
						"												<td style=\"word-break: break-word; font-size: 0px; padding: 30px 0px;\"><p style=\"font-size: 1px; margin: 0px auto; border-top: 1px solid #DCDDDE; width: 100%;\"></p>\r\n" + 
						"													<!--[if mso | IE]><table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size:1px;margin:0px auto;border-top:1px solid #DCDDDE;width:100%;\" width=\"640\"><tr><td style=\"height:0;line-height:0;\">&nbsp;</td></tr></table><![endif]--></td>\r\n" + 
						"											</tr>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"left\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><div style=\"cursor: auto; color: #747F8D; font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 13px; line-height: 16px; text-align: left;\">\r\n" + 
						"														<p>\r\n" + 
						"															도움이 필요하신가요? <a href=\"https://www.youtube.com/watch?v=wzon0-QUuNE\" style=\"font-family: whitney, helvetica neue, helvetica, arial, lucida grande, sans-serif; color: #7289da;\" rel=\"noreferrer noopener\" target=\"_blank\">지원팀에 문의</a>하세요.\r\n" + 
						"														</p>\r\n" + 
						"\r\n" + 
						"													</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"										</tbody>\r\n" + 
						"									</table>\r\n" + 
						"								</div>\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</div>\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      </div></td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<div style=\"margin: 0px auto; max-width: 640px; background: transparent;\">\r\n" + 
						"				<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: transparent;\" border=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"text-align: center; vertical-align: top; direction: ltr; font-size: 0px; padding: 0px;\">\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"								<div style=\"vertical-align: top; display: inline-block; direction: ltr; font-size: 13px; text-align: left; width: 100%;\">\r\n" + 
						"									<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
						"										<tbody>\r\n" + 
						"											<tr>\r\n" + 
						"												<td style=\"word-break: break-word; font-size: 0px;\"><div style=\"font-size: 1px; line-height: 12px;\">&nbsp;</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"										</tbody>\r\n" + 
						"									</table>\r\n" + 
						"								</div>\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</div>\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table></div>\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<div style=\"margin: 0 auto; max-width: 640px; background: #ffffff; box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.1); border-radius: 4px; overflow: hidden;\">\r\n" + 
						"				<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: #ffffff;\" border=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"text-align: center; vertical-align: top; font-size: 0px; padding: 0px;\">\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</div>\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"640\" style=\"width:640px;\">\r\n" + 
						"        <tr><td style=\"line-height:0px;font-size:0px;mso-line-height-rule:exactly;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<div style=\"margin: 0px auto; max-width: 640px; background: transparent;\">\r\n" + 
						"				<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 0px; width: 100%; background: transparent;\" border=\"0\">\r\n" + 
						"					<tbody>\r\n" + 
						"						<tr>\r\n" + 
						"							<td style=\"text-align: center; vertical-align: top; direction: ltr; font-size: 0px; padding: 20px 0px;\">\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td style=\"vertical-align:top;width:640px;\">\r\n" + 
						"      <![endif]-->\r\n" + 
						"								<div style=\"vertical-align: top; display: inline-block; direction: ltr; font-size: 13px; text-align: left; width: 100%;\">\r\n" + 
						"									<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
						"										<tbody>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"center\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><div style=\"cursor: auto; color: #99AAB5; font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 12px; line-height: 24px; text-align: center;\">\r\n" + 
						"														육지사람에서 보냄 • <a href=\"http://192.168.4.31:8091/LandPeople\" style=\"color: #1eb0f4; text-decoration: none;\" rel=\"noreferrer noopener\" target=\"_blank\">육지사람사이트 확인</a>\r\n" + 
						"													</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"											<tr>\r\n" + 
						"												<td align=\"center\" style=\"word-break: break-word; font-size: 0px; padding: 0px;\"><div style=\"cursor: auto; color: #99AAB5; font-family: Whitney, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 12px; line-height: 24px; text-align: center;\">Mountain, 7515-1, Jungsangandong-ro, Seogwipo-si, Jeju-do, Republic of Korea</div></td>\r\n" + 
						"											</tr>\r\n" + 
						"										</tbody>\r\n" + 
						"									</table>\r\n" + 
						"								</div>\r\n" + 
						"								<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"							</td>\r\n" + 
						"						</tr>\r\n" + 
						"					</tbody>\r\n" + 
						"				</table>\r\n" + 
						"			</div>\r\n" + 
						"			<!--[if mso | IE]>\r\n" + 
						"      </td></tr></table>\r\n" + 
						"      <![endif]-->\r\n" + 
						"			<img width=\"1px\" height=\"1px\" alt=\"\" src=\"http://email.mailgun.discordapp.com/o/eJwVjDkOwyAQAF8TSsQuazAFRaT4IcuhgISNhZO836QZaYqZ5ClTgiCqRwVOGQVKT6IEOQ2eZIiW12atdg9SO9f2_h4y1Sv2kfg8Zey7KB4zrxgQLWkE44C1cwxklxDianUQw3_KqK3F0ufn4F8e__QGpaYk2Q\">\r\n" + 
						"\r\n" + 
						"\r\n" + 
						"\r\n" + 
						"		</div>\r\n" + 
						"	\r\n" + 
						"	</div>")
				.toString();
	
		
		
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			
			// 메일 제목
			sendMail.setSubject("[LandPeople] 비밀번호 찾기 메일");
			// 메일 내용 (html전송)
			sendMail.setText(mailContent);
			// 메일 보내는 계정
			sendMail.setFrom("info.happy0612@gmail.com", "육지사람");
			// 메일 받는 사람
			sendMail.setTo(dto.getUser_email());
			
			sendMail.send();
			
		} catch (MessagingException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		return isc;
	}

	@Override
	public int user_emailAuthChk(String user_email) {
		logger.info("비밀번호찾기 가입자 확인하고 auth주기");
		
		
		
		
		
		return iUserDao.user_emailAuthChk(user_email);
	}

	@Override
	public LPUserDto user_apiEmailDupChk(String user_email) {
		return iUserDao.user_apiEmailDupChk(user_email);
	}

}

package happy.land.people.ctrl;

import java.util.HashMap;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import happy.land.people.model.ISketchBookService;

@Controller
public class JungController {

	private Logger logger = LoggerFactory.getLogger(JungController.class);
	
	@Autowired
	private ISketchBookService iSketchBookService;
	
	
	
	
	@ResponseBody
	@RequestMapping(value="/CancelLike.do",method=RequestMethod.GET)
	public Map<String, String> cancelLike(String user_email, String sketch_id, Model model){
		logger.info("JungController 실행");
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", "128@happy.com");
		map.put("sketch_id", "0004");
		boolean isc = iSketchBookService.likeCancel(map);
		System.out.println(isc+"!!!!!!!!!!!~~!@!@!@!@!@");
		logger.info("Controller CancelLike {}", isc);
		
		Map<String,String> result = new HashMap<String,String>();
		result.put("result", "lpcontent");
		return result;
	}
	
}
	


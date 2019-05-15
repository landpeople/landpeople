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

import happy.land.people.dto.LpcollectDto;
import happy.land.people.model.ISketchBookService;

@Controller
public class JungController {

	private Logger logger = LoggerFactory.getLogger(JungController.class);
	
	@Autowired
	private ISketchBookService iSketchBookService;
	
	
	@ResponseBody
	@RequestMapping(value="/CancelLike.do",method=RequestMethod.GET)
	public Map<String, String> cancelLike(String user_email, String sketch_id){
		logger.info("JungController 실행");
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", "128@happy.com");
		map.put("sketch_id", "0004");
		String like = iSketchBookService.selLike(map);		
		Map<String,String> result = new HashMap<String,String>();
	
		boolean isc = false;
		if(like.equalsIgnoreCase("F")) {
			map.put("like", "T");
			isc = iSketchBookService.likeCancel(map);
			result.put("result", "T");
		}else {
			map.put("like", "F");
			isc = iSketchBookService.likeCancel(map);
			result.put("result", "F");
		}		
				
		System.out.println(isc+"!!!!!!!!!!!~~!@!@!@!@!@");
		//logger.info("Controller CancelLike {}", isc);	
				
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="Scrape.do", method=RequestMethod.GET)
	public Map<String, String> scrapeState(String user_email, String sketch_id, LpcollectDto dto ) {
		boolean isc = iSketchBookService.collectInsert(dto);
		System.out.println(isc+"스크랩 최초 등록~~~~~ 성공");
		logger.info("scrapeState 실행 {}", isc);
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", "130@happy.com");
		map.put("sketch_id", "0007");
		String scrape = iSketchBookService.selScrape(map);
	
		Map<String, String> sresult =new HashMap<String, String>();
	 	
		boolean sisc = false;
		if(scrape.equalsIgnoreCase("F")) {
			map.put("scrape", "T");
			sisc = iSketchBookService.scrapeChange(map);
			sresult.put("sresult", "T");
		}else {
			map.put("scrape", "F");
			sisc = iSketchBookService.scrapeChange(map);
			sresult.put("sresult", "F");
		}
		
		
		return sresult;
	}

}
	


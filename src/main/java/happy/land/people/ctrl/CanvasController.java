package happy.land.people.ctrl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;
import happy.land.people.dto.LPTextDto;
import happy.land.people.dto.LPUserDto;
import happy.land.people.model.canvas.ILPCanvasService;
import happy.land.people.model.canvas.ILPDaysService;
import happy.land.people.model.canvas.ILPMapdataService;
import happy.land.people.model.canvas.ILPTextService;

@Controller
public class CanvasController {
	
	@Autowired
	private ILPMapdataService mapService;
	
	@Autowired
	private ILPDaysService daysService;
	
	@Autowired
	private ILPCanvasService canvasService;
	
	@Autowired
	private ILPTextService textService;
	
	 @RequestMapping(value="detailCanvas.do",method=RequestMethod.GET)
	    public String detailDaysCanvas(HttpSession session, HttpServletRequest request,String sketch_id) throws IOException{
	    	// 스케치북 id에 따른 캔버스의 개수
	    	if(sketch_id == null || sketch_id == "")
	    		sketch_id = "1";
	    	int canvasCnt = canvasService.canvasCnt(sketch_id);
	    	//스케치북 번호를 세션에 추가
	    	session.setAttribute("sketch_id", sketch_id);
	    	//접속한 유저의 정보(나중에 로그인 다 구현되면 바꿀것)
	    	LPUserDto userDto = new LPUserDto();
	    	userDto.setUser_email("kim@kim.com");
	    	session.setAttribute("user", userDto);
	    	//스케치북 작성자의 정보(나중에 스케치북 연동 끝나면 바꿀것)
	    	session.setAttribute("sketch_email", "kim@kim.com");
	    	
	    	System.out.println("해당 스케치북의 캔버스 개수:"+canvasCnt);
	    	
	    	// 캔버스 리스트
	    	List<LPCanvasDto> canvasList = canvasService.canvasSelectType(sketch_id);
	    	// 일정 캔버스 리스트 
	    	Map<Integer,List<LPDaysDto>> map = new HashMap<Integer,List<LPDaysDto>>();
	    	// 자유 캔버스 리스트
	    	Map<Integer,List<LPTextDto>> freeMap = new HashMap<Integer,List<LPTextDto>>();
	    	System.out.println(canvasList);
	    	// 캔버스 개수에 맞게 map에 canvas를 입력
	    	for(int i=0; i < canvasCnt ; i++) {    		
	    		if(canvasList.get(i).getCan_type().equalsIgnoreCase("1")) {    		
	    			List<LPDaysDto> daysList =  daysService.daysSelectAll(canvasList.get(i).getCan_id());
	    			map.put(i, daysList);      			
	    		}
	    		else {
	    			// 자유 캔버스는 여기에 
	    			List<LPTextDto> textList = textService.textSelectOne(canvasList.get(i).getCan_id());
	    			freeMap.put(i,textList);
	    		}    		
	    	}
	    	System.out.println(map);
	    	// 일정 캔버스 화면으로 보내기
	    	request.setAttribute("daysList", map);
	    	// 캔버스 타입들
	    	request.setAttribute("daysType", canvasList);
	    	// 자유 캔버스 화면으로 보내기
	    	request.setAttribute("textList", freeMap);  
	    	
	    	return "detailCanvas";
	    }
	 
	 // 수정폼으로 이동
	    @RequestMapping(value="updateCanvas.do",method=RequestMethod.POST)
	    public String updateDaysFrom(HttpSession session,String nowPageNo, Model model){
	        //캔버스 세팅	
	    	LPCanvasDto canvasDto = new LPCanvasDto();
	    	canvasDto.setCan_pageno(nowPageNo);
	    	// 스케치북 세팅
	    	String sketch_id = (String)session.getAttribute("sketch_id");    	
	    	canvasDto.setSketch_id(sketch_id);
	    	// 보고 있는 페이지의 캔버스 id값을 가져옴
	    	String id = canvasService.canvasSelectID(canvasDto);
	    	// 캔버스 dto 세팅
	    	canvasDto = canvasService.canvasSelectOne(id);
	    	session.setAttribute("canvas", canvasDto);
	    	if(canvasDto.getCan_type().equalsIgnoreCase("1")) {
		    	// 일정 캔버스 세팅
		    	List<LPDaysDto> daysDto = daysService.daysSelectAll(id);
		    	session.setAttribute("days", daysDto);
		    	return "updateDaysCanvas";
		    	
	    	}else{
	    		// 자유 캔버스
	    		List<LPTextDto> list = textService.textSelectOne(id);
	    		model.addAttribute("textList", list);
	    		return "updateFreeCanvas_"+(Integer.parseInt(canvasDto.getCan_type())-1);
	    	}     	
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="deleteCanvas.do",method=RequestMethod.POST)
	    public Map<String,String> deleteDaysFrom(HttpSession session,@RequestParam("nowPageNo") String nowPageNo){
	    	// 페이지 번호 , 캔버스 id     	
	    	System.out.println("페이지번호:"+nowPageNo);
	    	LPCanvasDto canvasDto = new LPCanvasDto();
	    	canvasDto.setCan_pageno(nowPageNo);
	    	// 스케치북 세팅
	    	String sketch_id = (String)session.getAttribute("sketch_id");
	    	canvasDto.setSketch_id(sketch_id);
	    	System.out.println("스케치북 번호:"+sketch_id);
	    	// 보고 있는 페이지의 캔버스 id값을 가져옴
	    	String id = canvasService.canvasSelectID(canvasDto);
	    	// 캔버스 dto 세팅
	    	canvasDto = canvasService.canvasSelectOne(id);
	    	
	    	// 삭제를 위해 Map에 담음 (담을값들 can_id,can_type,sketch_id,pageNo)
	    	Map<String,String> delMap = new HashMap<String,String>();
	    	delMap.put("can_id", id);
	    	delMap.put("can_type", canvasDto.getCan_type());
	    	delMap.put("sketch_id", canvasDto.getSketch_id());
	    	delMap.put("pageNo", canvasDto.getCan_pageno());
	    	System.out.println(delMap);
	    	// 삭제
	    	canvasService.canvasDelete(delMap);
	    	Map<String,String> result = new HashMap<String,String>();
	    	result.put("result", sketch_id);
	    	return result;	    	
	    }  
}

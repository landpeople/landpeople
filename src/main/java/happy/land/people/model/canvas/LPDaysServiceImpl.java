package happy.land.people.model.canvas;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;

@Service
public class LPDaysServiceImpl implements ILPDaysService{

	@Autowired
	private ILPDaysDao daysDao;
	
	@Autowired
	private ILPCanvasDao canvasDao;
	
	@Override
	public int daysInsert(Map<String,Object> val,LPCanvasDto canvasDto) throws ParseException {
		int cnt = 0;	
		String can_content = (String)val.get("canvasTitle");
		canvasDto.setCan_title(can_content);
		Map<String,String> increaseMap = new HashMap<String,String>();
		increaseMap.put("pageNo",canvasDto.getCan_pageno());
		increaseMap.put("id", canvasDto.getSketch_id());
		cnt = canvasDao.canvasIncreasePage(increaseMap);
		cnt = canvasDao.canvasInsert(canvasDto);
    	String canvasID = canvasDao.canvasSelectID(canvasDto);
    	canvasDto.setCan_id(canvasID);
    	// 캔버스 생성 완료   	
    	for(int i = 0; i < val.size()-1 ; i++) {
    		Map<String,String> map = (Map<String,String>)val.get("days"+i);
    	   	SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	   	System.out.println(map);
    		LPDaysDto dto = new LPDaysDto(canvasDto.getCan_id(), map.get("title"), map.get("content"), formatDate.parse(map.get("startDate")), formatDate.parse(map.get("endDate")), map.get("x") , map.get("y"), map.get("address"));
    		cnt += daysDao.daysInsert(dto);
    	}    
		return cnt;
	}

	@Override
	public List<LPDaysDto> daysSelectAll(String cal_id) {
		// TODO Auto-generated method stub
		return daysDao.daysSelectAll(cal_id);
	}

	@Override
	public LPDaysDto daysSelectOne(String days_id) {
		// TODO Auto-generated method stub
		return daysDao.daysSelectOne(days_id);
	}

	@Override
	public int daysDelete(String cal_id) {
		// TODO Auto-generated method stub
		return daysDao.daysDelete(cal_id);
	}
	
	@Override
	public int daysUpdate(Map<String,Object> val,String can_id) throws ParseException {
		int cnt = 0;
		// 해당 캔버스의 일정내용 싹 지우기
		cnt = daysDao.daysDelete(can_id);	
    	
    	for(int i = 0; i < val.size() ; i++) {
    		Map<String,String> map = (Map<String,String>)val.get("days"+i);
    	//System.out.println(map);   
    		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    		LPDaysDto dto = new LPDaysDto(can_id, map.get("title"), map.get("content"), formatDate.parse(map.get("startDate")), formatDate.parse(map.get("endDate")), map.get("x") , map.get("y"), map.get("address"));
    		cnt += daysDao.daysInsert(dto);
    	}     
		return cnt;
	}

}

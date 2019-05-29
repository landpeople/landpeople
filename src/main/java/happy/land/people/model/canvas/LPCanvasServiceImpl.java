package happy.land.people.model.canvas;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;

@Service
public class LPCanvasServiceImpl implements ILPCanvasService{

	@Autowired
	private ILPCanvasDao canvasDao;
	
	@Autowired
	private ILPDaysDao daysDao;
	
	@Autowired
	private ILPTextDao freeDao;
	
	@Override
	public int canvasCnt(String id) {
		// TODO Auto-generated method stub
		return canvasDao.canvasCnt(id);
	}

	@Override
	public List<LPCanvasDto> canvasSelectType(String id) {
		// TODO Auto-generated method stub
		return canvasDao.canvasSelectType(id);
	}

	@Override	
	public int canvasInsert(LPCanvasDto dto) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String,String>();
		map.put("pageNo", dto.getCan_pageno());
		map.put("id", dto.getSketch_id());
		int  chk = canvasDao.canvasIncreasePage(map);
		return canvasDao.canvasInsert(dto);
	}

	@Override
	public String canvasSelectID(LPCanvasDto dto) {
		// TODO Auto-generated method stub
		return canvasDao.canvasSelectID(dto);
	}

	@Override
	public List<LPDaysDto> canvasDownloadExcel(String id) {
		// TODO Auto-generated method stub
		return daysDao.canvasDownloadExcel(id);
	}

	@Override
	public LPCanvasDto canvasSelectOne(String id) {
		// TODO Auto-generated method stub
		return canvasDao.canvasSelectOne(id);
	}

	@Override
	public int canvasDelete(Map<String, String> map) {
		// TODO Auto-generated method stub
		// 가져와야 할 Map의 데이터 can_id,can_type,sketch_id,pageNo
		int delChk = 0;
		if(map.get("can_type").equalsIgnoreCase("1"))
			daysDao.daysDelete(map.get("can_id"));
		else {
			// 자유 캔버스 삭제
			freeDao.textDelete(map.get("can_id"));
		}
		delChk = canvasDao.canvasDelete(map.get("can_id"));
		Map<String,String> delMap = new HashMap<String,String>();
		delMap.put("pageNo",map.get("pageNo"));
		delMap.put("sketch_id", map.get("sketch_id"));
		canvasDao.canvasDecreasePage(delMap);				
		return delChk;
	}

}

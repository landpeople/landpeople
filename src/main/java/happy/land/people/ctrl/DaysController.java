package happy.land.people.ctrl;

import java.io.FileInputStream;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.ss.usermodel.HorizontalAlignment;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;
import happy.land.people.dto.LPMapdataDto;
import happy.land.people.model.canvas.ILPCanvasService;
import happy.land.people.model.canvas.ILPDaysService;
import happy.land.people.model.canvas.ILPMapdataService;

@Controller
public class DaysController {
	
	@Autowired
	private ILPMapdataService mapService;
	
	@Autowired
	private ILPDaysService daysService;
	
	@Autowired
	private ILPCanvasService canvasService;
	
	
	 @RequestMapping(value="loadMap.do")
	    public String loadMap() throws IOException {
	    	FileInputStream inputStream = new FileInputStream("D:\\LandPeople_20190507.xlsx");
	    	@SuppressWarnings("resource")
			XSSFWorkbook workbook = new XSSFWorkbook(inputStream);//엑셀읽기
	        XSSFSheet sheet = workbook.getSheetAt(0);//시트가져오기 0은 첫번째 시트
	        
	        int rows = sheet.getPhysicalNumberOfRows();// 총 행 개수
	        int cols = 6;// 총 열개수
	        XSSFCell cell;        
	        String[] result = new String[rows];
	        for(int i = 0 ; i < rows ; i++) {
	        	String value = "";
	        	for(int j = 0; j < cols ; j++) {
	        		cell = sheet.getRow(i).getCell(j);   
	        		if(cell != null) {
			        	if(cell.getCellTypeEnum() == CellType.BLANK){
			                value +=" ";
			            }
			        	else if(cell.getCellTypeEnum() == CellType.FORMULA){
			        		value+=cell.getCellFormula()+"/";
			        	}
			        	else if(cell.getCellTypeEnum() == CellType.NUMERIC) {
			        		 value+=cell.getNumericCellValue()+"/";
			        	}
			        	else if(cell.getCellTypeEnum() == CellType.STRING) {
			        		value+=cell.getStringCellValue()+"/";
			        	}
			        	else if(cell.getCellTypeEnum() == CellType.ERROR) {
			        		 value+=cell.getErrorCellValue()+"/";
			        	}
	        		}	        	            
	        	}
	        	System.out.println(value);
	        	result[i] = new String(value);
	        }       
	               
	        mapService.mapInsert(result);	        
	        
	        return "1";
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="showFood.do",method=RequestMethod.POST)
	    public Map<String,List<LPMapdataDto>> showFood(String type){    	
	    	List<LPMapdataDto> mapList = mapService.mapSelectType(type);    
	    	System.out.println(mapList.get(0));
	    	Map<String,List<LPMapdataDto>> result = new HashMap<String,List<LPMapdataDto>>();
	    	result.put("result", mapList);    	
	    	return result;
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="showTrip.do",method=RequestMethod.POST)
	    public Map<String,List<LPMapdataDto>> showTrip(String type){    	
	    	List<LPMapdataDto> mapList = mapService.mapSelectType(type);    
	    	System.out.println(mapList.get(0));
	    	Map<String,List<LPMapdataDto>> result = new HashMap<String,List<LPMapdataDto>>();
	    	result.put("result", mapList);    	
	    	return result;
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="showRest.do",method=RequestMethod.POST)
	    public Map<String,List<LPMapdataDto>> showRest(String type){    	
	    	List<LPMapdataDto> mapList = mapService.mapSelectType(type);    
	    	System.out.println(mapList.get(0));
	    	Map<String,List<LPMapdataDto>> result = new HashMap<String,List<LPMapdataDto>>();
	    	result.put("result", mapList);    	
	    	return result;
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="updateDaysCanvas.do",method=RequestMethod.POST)
	    public Map<String, String> updateDaysCanvas(HttpSession session,@RequestBody Map<String, Object> val) throws ParseException{
	    	// 캔버스 가져 오기
	    	LPCanvasDto canvasDto =  (LPCanvasDto)session.getAttribute("canvas");
	    	    	
	    	if(canvasDto!= null) {    		
	    	}
	    	   		 
	    	daysService.daysUpdate(val, canvasDto.getCan_id());
	    	
	    	Map<String,String> result = new HashMap<String,String>();
	    	String sketch_id = (String)session.getAttribute("sketch_id");
	    	result.put("result", sketch_id);
	    	return result;
	    }
	    
	    @RequestMapping(value="canvasDownloadExcel.do",method=RequestMethod.GET)
	    public void canvasDownloadExcel(HttpServletResponse response) throws IOException {
	    	List<LPDaysDto> canvasList = canvasService.canvasDownloadExcel("1");
	    	
	    	XSSFWorkbook workbook = new XSSFWorkbook();
	    	XSSFSheet sheet = null; 
	    	XSSFRow row= null;
	    	XSSFCell cell = null;
	    	
	        // 테이블 헤더용 스타일
	        XSSFCellStyle headStyle = workbook.createCellStyle();

	        // 가는 경계선을 가집니다.
	        headStyle.setBorderTop(BorderStyle.THIN);
	        headStyle.setBorderBottom(BorderStyle.THIN);
	        headStyle.setBorderLeft(BorderStyle.THIN);
	        headStyle.setBorderRight(BorderStyle.THIN);
	        //가운데 정렬
	        headStyle.setAlignment(HorizontalAlignment.CENTER);	  
	    	 
	    	// 데이터 부분 생성	   
		    int rowNo = 1;
		    int days = 1;
		    // 이전 아이디 체크
		    String beforeId = "0";	    
		    System.out.println(canvasList.size());
	    	for(int i= 0; i < canvasList.size() ; i++) {
	    		// 아이디가 같으면 같은 일자이므로
	    		if(!(canvasList.get(i).getCan_id().equalsIgnoreCase(beforeId))) {    			
	    			sheet = workbook.createSheet(days+"일차");
	    			sheet.setColumnWidth(0, 20*256);
	    			sheet.setColumnWidth(1, 10*256);
	    			sheet.setColumnWidth(2, 10*256);
	    			sheet.setColumnWidth(3, 50*256);
	    			row = sheet.createRow(0);
	          	 	cell = row.createCell(0);
	    	       	cell.setCellStyle(headStyle);
	    	       	cell.setCellValue("일정제목");
	    	       	cell = row.createCell(1);
	    	      	cell.setCellStyle(headStyle);
	    	      	cell.setCellValue("출발시간");
	    	      	cell = row.createCell(2);
	    	       	cell.setCellStyle(headStyle);
	    	       	cell.setCellValue("도착시간");
	    	       	cell = row.createCell(3);
	    	       	cell.setCellStyle(headStyle);
	    	       	cell.setCellValue("주소");
	    	       	days++;
	    			rowNo = 1;   			
	    		} 
			    row = sheet.createRow(rowNo);
	   	        cell = row.createCell(0);   	        
	    	    cell.setCellValue(canvasList.get(i).getDays_title());
	   	        cell = row.createCell(1); 
	   	        
	   	        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-mm-dd HH:mm");
	   	        String sDate = transFormat.format(canvasList.get(i).getDays_sdate());
	   	        String[] split_sDate = sDate.split(" ");
	   	        // split_sTime[0] 시간 , split_sTime[1] 분
	   	        String[] split_sTime = split_sDate[1].split(":");   	        
	   	        // 12보다 크면 오후 작으면 오전
	   	        String result_sDate = "";
	   	        if(Integer.parseInt(split_sTime[0]) >= 12) {
	   	        	if(Integer.parseInt(split_sTime[0]) >= 22 )
	   	        		result_sDate = "오후 "+(Integer.parseInt(split_sTime[0])-12)+":"+split_sTime[1]; 
	   	        	else 
	   	        		result_sDate = "오후 0"+(Integer.parseInt(split_sTime[0])-12)+":"+split_sTime[1]; 
	   	        }else {
	   	        	result_sDate = "오전 "+split_sTime[0]+":"+split_sTime[1];
	   	        }   	        
	   	        cell.setCellValue(result_sDate);
	   	        cell = row.createCell(2);   	   
	   	        
	   	        String eDate = transFormat.format(canvasList.get(i).getDays_edate());
	   	        String[] split_eDate = eDate.split(" ");
	   	        // split_sTime[0] 시간 , split_sTime[1] 분
	   	        String[] split_eTime = split_eDate[1].split(":");   	        
	   	        // 12보다 크면 오후 작으면 오전
	   	        String result_eDate = "";
	   	        if(Integer.parseInt(split_eTime[0]) >= 12) {
	   	        	if(Integer.parseInt(split_eTime[0]) >= 22 )
	   	        		result_eDate = "오후 "+(Integer.parseInt(split_eTime[0])-12)+":"+split_eTime[1]; 
	   	        	else 
	   	        		result_eDate = "오후 0"+(Integer.parseInt(split_eTime[0])-12)+":"+split_eTime[1]; 
	   	        }else {
	   	        	result_eDate = "오전 "+split_eTime[0]+":"+split_eTime[1];
	   	        }   	        
	   	        cell.setCellValue(result_eDate);
	   	        cell = row.createCell(3);   	       
		        cell.setCellValue(canvasList.get(i).getDays_address());
		        rowNo++;    
		        beforeId = canvasList.get(i).getCan_id();
	    	}


	    		SimpleDateFormat simpleFormat = new SimpleDateFormat ( "yyyyMMdd");
	    		Date time = new Date();  
	        	String fileName = simpleFormat.format(time) + "_testdays.xls";
	        	
	    	    // 컨텐츠 타입과 파일명 지정
	    	    response.setContentType("ms-vnd/excel");
	    	    response.setHeader("Content-Disposition", "attachment;filename="+fileName);
	    	    // 엑셀 출력
	    	    workbook.write(response.getOutputStream());
	    	    workbook.close();       	
	    }  
	    
	    @RequestMapping(value="insertDaysForm.do",method=RequestMethod.POST)
	    public String insertDaysFrom(HttpSession session,String nowPageNo){
	    	// 페이지 번호 , 캔버스 id     	
	    	String sketch_id = (String)session.getAttribute("sketch_id");
	    	LPCanvasDto dto = new LPCanvasDto("0001", sketch_id, "제목은 대충", "1", nowPageNo);
	    	session.setAttribute("canvas", dto);
	    	return "canvas/insertDaysCanvas";
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="insertDaysCanvas.do",method=RequestMethod.POST)
	    public Map<String, String> insertDaysCanvas(HttpSession session,@RequestBody Map<String, Object> val) throws ParseException{
	    	// 캔버스 생성 부분 
	    	LPCanvasDto canvasDto =  (LPCanvasDto)session.getAttribute("canvas");
	    	daysService.daysInsert(val, canvasDto);
	    	
	    	Map<String,String> result = new HashMap<String,String>();
	    	String sketch_id = (String)session.getAttribute("sketch_id");
	    	result.put("result", sketch_id);
	    	return result;
	    }
}

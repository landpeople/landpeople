package happy.land.people.ctrl;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import happy.land.people.dto.kim.LPMapdataDto;
import happy.land.people.model.kim.ILPMapdataService;

@Controller
public class KimController {
	
	@Autowired
	private ILPMapdataService mapService;
	
	
    @RequestMapping(value="loadMap.do")
    public String loadMap() throws IOException {
    	FileInputStream inputStream = new FileInputStream("D:\\LandPeople_20190507.xlsx");
    	@SuppressWarnings("resource")
		XSSFWorkbook workbook = new XSSFWorkbook(inputStream);//엑셀읽기
        XSSFSheet sheet = workbook.getSheetAt(0);//시트가져오기 0은 첫번째 시트
        
        int rows = sheet.getPhysicalNumberOfRows();// 총 행 개수
        int cols = 7;// 총 열개수
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
               
        for(int i = 1; i < result.length; i++) {
        	String[] value = result[i].split("/");
        	
        	LPMapdataDto mapDto = new LPMapdataDto(value[0], value[1], value[2], value[3], value[4]," ");        
            mapService.mapInsert(mapDto);
        }
        
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

}

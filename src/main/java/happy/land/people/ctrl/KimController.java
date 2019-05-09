package happy.land.people.ctrl;

import java.io.FileInputStream;
import java.io.IOException;

import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class KimController {
	
	
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
       
        String[] value = result[1].split("/");
        System.out.println(value[1]);
        return "1";
    }

}

package happy.land.people.ctrl;

import java.io.FileInputStream;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import org.omg.CORBA.Request;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jdo.LocalPersistenceManagerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;
import happy.land.people.dto.LPMapdataDto;
import happy.land.people.dto.LPTextDto;
import happy.land.people.model.canvas.ILPCanvasService;
import happy.land.people.model.canvas.ILPDaysService;
import happy.land.people.model.canvas.ILPMapdataService;
import happy.land.people.model.canvas.ILPTextService;

@Controller
public class KimController {
	
    @RequestMapping(value="canvasDownloadImage.do",method=RequestMethod.GET)
    public void canvasDownloadImage(HttpServletResponse response) {
    	
    }
}
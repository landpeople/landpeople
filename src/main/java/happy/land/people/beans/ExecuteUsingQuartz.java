package happy.land.people.beans;

import java.io.File;
import java.io.FileNotFoundException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.WebUtils;

import happy.land.people.ctrl.JangController;
import happy.land.people.model.jang.IManagerService;
import happy.land.people.model.jang.ManagerDaoImpl;
public class ExecuteUsingQuartz {
	
	private SqlSessionTemplate sqlSession;
	private Logger logger = LoggerFactory.getLogger(ExecuteUsingQuartz.class);
	
	private IManagerService iManagerService;
	
	@Autowired
	private HttpServletRequest request;
	
	public void delFile() {
		
		try {
//			String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/tempFolder");
			String path = request.getSession().getServletContext().getRealPath("tempFolder");
			System.out.println("폴더 경로 : "+path);
			
			File delFolder =new File(path);

			if(delFolder.exists()) {
				System.out.println("=====스케쥴러 파일 삭제 실행=====");
				File[] fileList = delFolder.listFiles();

				for (int i = 0; i < fileList.length; i++) {
					fileList[i].delete();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

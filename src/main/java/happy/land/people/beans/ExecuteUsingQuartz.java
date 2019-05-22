package happy.land.people.beans;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.util.WebUtils;

public class ExecuteUsingQuartz {

	@Autowired
	private HttpServletRequest request;
	
	@Scheduled
	public void delFile(){
		 System.out.println("작동 작동");
	
		 String realPath;
		 
			try {
//				realPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/tempFolder");
				realPath = request.getSession().getServletContext().getRealPath("/tempFolder");
				System.out.println("상대 경로 : "+realPath);
				System.out.println("request : "+request);
				
				File delFolder =new File(realPath);
				
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

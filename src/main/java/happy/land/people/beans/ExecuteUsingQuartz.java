package happy.land.people.beans;

import java.io.File;
import java.io.FileNotFoundException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.util.WebUtils;

public class ExecuteUsingQuartz {
	
	public void delFile(HttpServletRequest request) {
		
		try {
			String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/tempFolder");
			System.out.println("폴더 경로 : "+path);
			
			File delFolder =new File(path);

			if(delFolder.exists()) {
				System.out.println("=====스케쥴러 파일 삭제 실행=====");
				File[] fileList = delFolder.listFiles();

				for (int i = 0; i < fileList.length; i++) {
					fileList[i].delete();
				}
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public void test() {
		System.out.println("스케줄러 실행!");
	}
}

package com.naver.erp;

import java.io.File;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// Spring 에서 파일 업로드하는 클래스 선언
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
public class FileUpload {
	
	private MultipartFile multipartFile; 
	private String uploadDir;			 
	private String newFileName;
	private File file;
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	// 생성자 선언
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	public FileUpload() { }
	public FileUpload(
			MultipartFile multipartFile // 업로드된 파일을 관리하는 MultipartFile 객체
			,String uploadDir			// 업로드된 파일을 저장할 폴더명
	)	throws Exception{
		this.uploadDir = uploadDir;
		this.multipartFile = multipartFile;
		if(this.multipartFile!=null) {
			upLoadFile();
		}
	}

	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	// 파일 업로드 실행 메소드
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	public void upLoadFile() throws Exception {
		
		//try{
			String ori_file_name = multipartFile.getOriginalFilename();
			String file_extension = ori_file_name.substring(ori_file_name.lastIndexOf(".")+1);
			newFileName = UUID.randomUUID() + "." + file_extension;
			//---------------------------------
			file = new File(uploadDir + newFileName);
			//---------------------------------
			multipartFile.transferTo(file);
			System.out.println("<파일 업로드 성공>"+uploadDir + newFileName + " 파일!\n");
		//	}catch(Exception e){
		// 		System.out.println("<예외발생장소> FileUpload 클래스 upLoadFile 메소드!\n");
		// 		System.out.println("<예외발생사유> 파일 업로드 경로 이상! " + uploadDir );
		// 		newFileName = null;
		//		file = null;
		//	}	
			
	}

	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	// 파일 업로드 시 만들어진 새로운 파일명 리턴 메소드 선언
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	public String getNewFileName() {
		return newFileName;
	}

	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	// 업로드된 파일 삭제하기 메소드 선언
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	public void delete() {
		if(file!=null) {
			file.delete();
			System.out.print("<파일 삭제 성공> " + newFileName + "파일!\n");
		}
	}

	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	// 매개변수로 전달되는 파일 삭제하기 메소드 선언
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	public void delete(String file_name) {
		if(file_name==null || file_name.isEmpty()) {
			return;
		}
		File file2 = new File(file_name );
		if(file2.isFile()) {
			file2.delete();
			System.out.println("<파일 삭제 성공>" +file_name + " 파일!\n");
		}
	}
}









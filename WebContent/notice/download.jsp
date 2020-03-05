<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String filename = request.getParameter("name");
	
	String path = request.getParameter("path");
	String realFolder =  getServletContext().getRealPath(path);
	System.out.println(path);
	System.out.println(realFolder);
	
	String filePath = realFolder + "\\" + filename;
	
	try{
	
		out.clear();
		
		out = pageContext.pushBody();
		
		File file = new File(filePath);
		
		byte b[] = new byte[4096];
		
		response.reset();
		
		response.setContentType("application/octet-stream");
		
		String Encoding = new String(filename.getBytes("UTF-8"),"8859_1");
		
		response.setHeader("Content-Disposition", "attatchment; filename = " + Encoding);
		
		FileInputStream is = new FileInputStream(filePath);
		
		ServletOutputStream sos = response.getOutputStream();
		
		int numRead;
		
		while((numRead = is.read(b,0,b.length))!=-1){
			sos.write(b,0,numRead);
		}
		
		sos.flush();
		sos.close();
		is.close();
		
	}catch(Exception err){
		err.printStackTrace();
	}
 
%>





<%@page import="collection.CollectionDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
%>

<jsp:useBean id="cBean" class="collection.CollectionBean"/>
<jsp:setProperty property="*" name="cBean"/>

<%
	String realPath = application.getRealPath("/upload");
	System.out.println(realPath);
	
	int maxSize = 1024 * 1024 * 5;
	
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
		
	cBean.setContent(multi.getParameter("content"));
	cBean.setName(multi.getParameter("name"));
	cBean.setPasswd(multi.getParameter("passwd"));
	cBean.setSubject(multi.getParameter("subject"));
	
	cBean.setFile(multi.getFilesystemName("file"));
	
	cBean.setDate(new Timestamp(System.currentTimeMillis()));
	
	CollectionDAO cdao = new CollectionDAO();
	
	cdao.insertCollection(cBean);
	
	response.sendRedirect("../collections.jsp");
	
%>
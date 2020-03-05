<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String id = (String)session.getAttribute("id");

	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");
	
%>
	<%--생성할 객체에 대한 클래스 경로 --%>
	<jsp:useBean id="bBean" class="board.BoardBean" />
	<%-- request객체에서 꺼내온 모든 값을 BoardBean객체의 모든 setter메소드 호출하여 모든 변수에 저장 --%>
	<jsp:setProperty property="*" name="bBean"/>

<%
	String realPath = application.getRealPath("/upload");
	System.out.println(realPath);
	
	int maxSize = 1024 * 1024 * 5;
	
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
		
	bBean.setContent(multi.getParameter("content"));
	bBean.setName(multi.getParameter("name"));
	bBean.setPasswd(multi.getParameter("passwd"));
	bBean.setSubject(multi.getParameter("subject"));
	
	bBean.setFile(multi.getFilesystemName("file"));

	bBean.setDate(new Timestamp(System.currentTimeMillis()));

	bBean.setIp(request.getRemoteAddr());
	
	BoardDAO bdao = new BoardDAO();
	
	bdao.insertBoard(bBean);
	
	response.sendRedirect("../notice.jsp");

%>
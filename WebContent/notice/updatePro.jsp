<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	
	String realPath = application.getRealPath("/upload");
	int maxSize = 1024 * 1024 * 5; // 5MB
	
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	

%>
	<jsp:useBean id="bBean" class="board.BoardBean"/>
	<jsp:setProperty property="*" name="bBean"/>

	<%-- UPDATE작업을 위한 BoardDAO객체 생성 --%>
	<jsp:useBean id="bdao" class="board.BoardDAO"/>
	
<%

	if (multi.getFilesystemName("file") != null) {
		// 새롭게 수정할 파일 있음
		bBean.setFile(multi.getFilesystemName("file"));
	} else {
		// 기존 파일이름
		bBean.setFile(multi.getParameter("file2"));
	}

	int check = bdao.updateBoard(bBean);
 

	if(check == 1){ //수정 성공 -> notice,jsp로 이동
%>
	<script type="text/javascript">
		window.alert("수정 성공");
		location.href="../notice.jsp?pageNum=<%=pageNum%>";
	</script>
<%
	} else{ //수정 실패 비밀번호 틀림 -> 이전 페이지 update.jsp로  되돌아 가게 하기
%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>
<%
	}
%>
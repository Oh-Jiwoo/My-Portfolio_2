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

<jsp:useBean id="cBean" class="collection.CollectionBean"/>
<jsp:setProperty property="*" name="cBean"/>
<jsp:useBean id="cDao" class="collection.CollectionDAO"/>

<%
	if (multi.getFilesystemName("file") != null) {
		// 새롭게 수정할 파일 있음
		cBean.setFile(multi.getFilesystemName("file"));
	} else {
		// 기존 파일이름
		cBean.setFile(multi.getParameter("file2"));
	}
	
	int check = cDao.updateCollection(cBean);
	
	
	if(check == 1){ //수정 성공 -> notice,jsp로 이동
%>
	<script type="text/javascript">
		window.alert("수정 성공");
		location.href="../collections.jsp?pageNum=<%=pageNum%>";
	</script>
<%
	}else{
%>
	<script type="text/javascript">
		alert("올바르지 않은 비밀번호");
		history.back();
	</script>
<%
	}
%>



<%@page import="java.sql.Timestamp"%>
<%@page import="collection.CollectionDAO"%>
<%@page import="collection.CollectionBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
	<!--[if IE 7]>
		<link rel="stylesheet" href="css/ie7.css" type="text/css">
	<![endif]-->
</head>

<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");

	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	CollectionDAO dao = new CollectionDAO();
	
	CollectionBean bean = dao.getCollecion(num);
	
	int DBnum = bean.getNum();
	int DBReadcount = bean.getReadcount();
	String DBName = bean.getName();
	Timestamp DBDate = bean.getDate();
	String DBSubject = bean.getSubject();
	String DBContent = "";
	
	if(bean.getContent() != null){
		DBContent = bean.getContent().replace("<br>", "\r\n");
	}
%>

<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top2.jsp"/>
	
	<!-- 본문  -->
	<div id=wrap>
		<article>
			<h1>Update</h1>
			<form action="cupdatePro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
				
				<input type="hidden" name="num" value="<%=num%>">
			
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=DBName%>"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="subject" value="<%=DBSubject%>"></td>
				</tr>
				<tr>
					<td>파일</td>
					<td>
						<input type="file" name="file">
						<%=bean.getFile() %>
						<input type="hidden" name="file2" value="<%=bean.getFile() %>">
					</td>
				</tr>
				<tr>
					<td>글내용</td>
					<td>
						<textarea name="content" rows="12" cols="40"><%=DBContent%></textarea>
					</td>
				</tr>
			</table>
		
			<!-- 게시판 -->
			<div id="table_search">
				<input type="submit" value="글수정" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글목록" class="btn" onclick="location.href='../collections.jsp?pageNum=<%=pageNum%>'">
			</div>
			</form>
			<div id="page_control"></div>
		</article>
	</div>
	<div class="clear"></div>
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>
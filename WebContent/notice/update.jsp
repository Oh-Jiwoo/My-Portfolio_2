<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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

	/*글 수정을 위한 하나의 글 정보를 검색하여 가져와서 화면에 출력하는 페이지*/
	
	String id = (String)session.getAttribute("id");
	
	if(id==null){
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = new BoardDAO();
	
	BoardBean boardbean = dao.getBoard(num);
	
	int DBnum = boardbean.getNum(); 
	int DBReadcount = boardbean.getReadcount(); 
	String DBName = boardbean.getName(); 
	Timestamp DBDate = boardbean.getDate(); 
	String DBSubject = boardbean.getSubject(); 
	String DBContent = ""; 
	
	if(boardbean.getContent() != null){
		DBContent = boardbean.getContent().replace("<br>","\r\n");
	}

%>

<body>
	<!-- 헤더들어가는 곳 -->
	<jsp:include page="../inc/top2.jsp"/>
	
	<!-- 본문  -->
	<div id="wrap">
		
		<article>
			<h1>Notice Update</h1>
			<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
				
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
						<%=boardbean.getFile() %>
						<input type="hidden" name="file2" value="<%=boardbean.getFile() %>">
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
				<input type="button" value="글목록" class="btn" onclick="location.href='../notice.jsp?pageNum=<%=pageNum%>'">
			</div>
			</form>
			<div id="page_control"></div>
		</article>	
	</div>
		
	<div class="clear"></div>
	<!-- 푸터  -->
	<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>
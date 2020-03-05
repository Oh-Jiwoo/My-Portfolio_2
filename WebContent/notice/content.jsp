<%@page import="java.text.SimpleDateFormat"%>
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
	/*글 상세보기 페이지*/
	
		request.setCharacterEncoding("UTF-8");

		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
	
		BoardDAO dao = new BoardDAO();

		dao.updateReadCount(num);
	
		BoardBean boardbean = dao.getBoard(num);

		int DBnum = boardbean.getNum(); //검색한 글번호
		int DBReadcount = boardbean.getReadcount(); //검색한 글의 조회수
		String DBName = boardbean.getName(); //검색한 글을 작성한 사람의 이름
		Timestamp DBDate = boardbean.getDate(); //검색한 글을 작성한 날짜 및 시간
		String DBSubject = boardbean.getSubject(); //검색한 글의 글제목
		String DBContent = ""; //검색한 글내용을 저장할 용도의 변수

		if(boardbean.getContent() != null){
			DBContent = boardbean.getContent().replace("\r\n", "<br>");
		}
		
		int DBRe_ref = boardbean.getRe_ref(); //주글과 답글이 같은 값을 가질수 있는 유일한 그룹값
		int DBRe_lev = boardbean.getRe_lev(); //주글(답글)의 들여쓰기 정도값
		int DBRe_seq = boardbean.getRe_seq(); //주글(답글)들을 board테이블에 추가하면 글의 순서

%>
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top2.jsp"/>
	
	<!-- 본문  -->
	<div id=wrap>
		<article>
			<h1 align="center">Notice Content</h1>
			<table>
				<tr>
					<th>WRITER</th>
					<td align="center"><%=DBName %></td>
					<th>DATE</th>
					<td align="center"><%=new SimpleDateFormat("yyyy.MM.dd").format(DBDate)%></td>
				</tr>
				<tr>
					<th>SUBJECT</th>
					<td colspan="3"><%=DBSubject %></td>
				</tr>
				<tr>
					<th>FILE</th>
					<td colspan="3">
						<% 
						if(boardbean.getFile() != null){ %>
						<a href="download.jsp?path=upload&name=<%=boardbean.getFile() %>"><%=boardbean.getFile() %></a>
						<%
						}else{
						%>
						&nbsp;
						<%	
						}
						%>
					</td>
				</tr>
				<tr>
					<th>CONTENT</th>
					<td valign="top" style="padding-top: 8px; padding-bottom: 8px;" colspan="3" height="200px">
						<%=DBContent %>
					</td>
				</tr>
			</table>
		</article>
	
		<div class="post_btn_block">
		<%
			String id = (String)session.getAttribute("id");
		
			if(id != null){
		%>
			<input type="button" value="글수정" class="btn" onclick="location.href='update.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
			
			<input type="button" value="글삭제" class="btn" onclick="location.href='delete.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'"> 
			
			<input type="button" value="답글쓰기" class="btn" 
			onclick="location.href='reWrite.jsp?num=<%=DBnum%>&re_ref=<%=DBRe_ref%>&re_lev=<%=DBRe_lev%>&re_seq=<%=DBRe_seq%>'">
		<% 		
			}
		%>
		<input type="button" value="글목록" class="btn" onclick="location.href='../notice.jsp?pageNum=<%=pageNum%>'">
		</div>
	</div>
		<div class="clear"></div>
		
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>
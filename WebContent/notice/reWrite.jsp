<%@page import="board.BoardBean"%>
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

	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");
	
	int num =  Integer.parseInt(request.getParameter("num")); //주글번호
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));//주글그룹값
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));//주글 들여쓰기 정도값
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));//주글 순서


%>

<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top2.jsp"/>
	
	<!-- 본문 -->
	<div id="wrap">
	
		<article>
			<h1>Notice Update</h1>
		<form action="reWritePro.jsp" method="post">
			
			<%--주글에 대한 정보 전달 --%>
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="re_ref" value="<%=re_ref%>">
			<input type="hidden" name="re_lev" value="<%=re_lev%>">
			<input type="hidden" name="re_seq" value="<%=re_seq%>">
				
			<%--답글에 대한 정보 전달 --%>	
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="[답글]"></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td>
						<textarea name="content" rows="13" cols="40">
						</textarea>
					</td>
				</tr>				
			</table>
			
		<div id="table_search">
			<input type="submit" value="답글작성" class="btn">
			<input type="reset" value="다시작성" class="btn">
			<input type="button" value="글목록" class="btn" onclick="location.href='../notice.jsp'">
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
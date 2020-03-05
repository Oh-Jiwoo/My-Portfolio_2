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
<body>
	<!-- 헤더들어가는 곳 -->
	<jsp:include page="../inc/top2.jsp"/>

	<!-- 본문  -->
	<div id="wrap">
	
		<%
			String id = (String)session.getAttribute("id");
		
			if(id == null){
				response.sendRedirect("../member/login.jsp");
			}
		
			int num= Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
		%>
		
		<article>
			<h1>Writer</h1>
			<form action="cdeletePro.jsp?pageNum=<%=pageNum%>" method="post">
			
			<%-- deletePro.jsp로 삭제할 글번호 요청! --%>
			<input type="hidden" name="num" value="<%=num%>">
			
			<table id="collection">
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
			</table>
					
					<div id="table_search">
						<input type="submit" value="글삭제" class="btn"> 
						<input type="reset" value="다시작성" class="btn">
						<input type="button" value="글목록" class="btn" onclick="location.href='../collections.jsp?pageNum=<%=pageNum%>'">
					</div>
				</form>
		
			<div class="clear"></div>
			
		</article>
	
	</div>
	
	<div class="clear"></div>
	<!-- 푸터  -->
	<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>
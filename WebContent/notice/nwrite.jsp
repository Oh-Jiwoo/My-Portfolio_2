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
%>
		<article>
			<h1>Notice Writer</h1>
			<form action="nwritePro.jsp" method="post" enctype="multipart/form-data">
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=id%>" readonly></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>글 제목</td>
					<td><input type="text" name="subject"></td>
				</tr>
				<tr>
					<td>파일</td>
					<td><input type="file" name="file"></td>
				</tr>
				<tr>
					<td>글 내용</td>
					<td><textarea rows="13" cols="40" name="content"></textarea></td>
				</tr>
				
			</table>
					
					<div id="table_search">
						<input type="submit" value="글쓰기" class="btn"> 
						<input type="reset" value="다시작성" class="btn">
						<input type="button" value="글목록" class="btn" onclick="location.href='../notice.jsp'">
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
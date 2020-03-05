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
	<!-- 헤더 -->
	<jsp:include page="../inc/top2.jsp"/>
	
	<!-- 본문 -->
	<div id="wrap">
	<div class="login">
		<article>
			<h1 align="center" style="font-size: 45px;">Login</h1>
			<form action="loginPro.jsp" id="join" method="post">
				<fieldset>
					<label>User ID</label> <input type="text" name="id"><br>
					<label>Password</label> <input type="password" name="passwd"><br>
				<div class="clear"></div>
					<div id="buttons">
						<input type="submit" value="login" class="submit"> 
						<input type="reset" value="cancel" class="cancel">
					</div>
					
					<hr>
					
					<div>
						Not a member yet? &nbsp; <a href="join.jsp">join us</a>
					</div>
					
				</fieldset>
			</form>
		</article>
	</div>
	</div>
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>
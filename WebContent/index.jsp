<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css" type="text/css">
	<!--[if IE 7]>
		<link rel="stylesheet" href="css/ie7.css" type="text/css">
	<![endif]-->
</head>
<body>

	<div class="header">
		<div>
			<a href="index.jsp" id="logo"><img src="images/logo.png" alt="logo"></a>
			<ul>
				<li class="selected">
					<a href="index.jsp">Home</a>
				</li>
				<li>
					<a href="about.jsp">About</a>
				</li>
				<li>
					<a href="collections.jsp">Collections</a>
					<ul>
						<li>
							<a href="collections.jsp">Women's</a>
						</li>
						<li>
							<a href="collections.jsp">Men's</a>
						</li>
					</ul>
				</li>
				<li>
					<a href="notice.jsp">Notice</a>
				</li>
				<li>
					<a href="locator.jsp">Store Locator</a>
				</li>
				<%
					String id = (String)session.getAttribute("id");
					
					if(id == null){
				%>
				<li id="login">
					<a href="member/login.jsp">login</a>   |  
					<a href="member/join.jsp">join</a>
				</li>
				<%
					} else {
				%>
				<li id="login">
					<a href="member/changeInfo.jsp"><%=id %>님 |</a>
					<a href="member/logout.jsp">logout</a>
				</li>
				<%
					}
				%>
			</ul>
			
		</div>
		<div class="featured">
			<img src="images/bg-absolute.png" alt="">
			<div>
				<h3>Less... <br> Is More...</h3>
				<a href="collections.jsp">2023 Spring Collection</a>
			</div>
		</div>
	</div>
	
	
	<div class="body">
		<div>
			<h2>Welcome to the 2023 Spring collection from Saverio Salermo</h2>
			<p>
				This website template has been designed by <a href="http://www.freewebsitetemplates.com/">Free Website Templates</a> for you, for free. You can replace all this text with your own text. You can remove any link to our website from this website template, you're free to use this website template without linking back to us. If you're having problems editing this website template, then don't hesitate to ask for help on the <a href="http://www.freewebsitetemplates.com/forums/">Forums</a>.
			</p>
			<ul>
				<li>
					<a href="collections.jsp"><img src="images/figure2.jpg" alt=""></a> <a href="collections.jsp">Spring Collection</a>
				</li>
				<li>
					<a href="collections.jsp"><img src="images/figure3.jpg" alt=""></a> <a href="collections.jsp">Summer Collection</a>
				</li>
				<li>
					<a href="collections.jsp"><img src="images/figure4.jpg" alt=""></a> <a href="collections.jsp">The Artist</a>
				</li>
				<li>
					<a href="collections.jsp"><img src="images/figure5.jpg" alt=""></a> <a href="collections.jsp">The Salermo Blog</a>
				</li>
			</ul>
		</div>
	</div>
	
	
	<div class="footer">
		<div>
			<p>
				&#169; Saverio Salermo
			</p>
			<ul>
				<li>
					<a href="#">Privacy Policy</a>
				</li>
				<li>
					<a href="#">Terms And Conditons</a>
				</li>
			</ul>
			<div class="connect">
				<a href="http://freewebsitetemplates.com/go/twitter/" id="twitter">Twitter</a> <a href="http://freewebsitetemplates.com/go/facebook/" id="facebook">Facebook</a> <a href="http://freewebsitetemplates.com/go/googleplus/" id="googleplus">Google+</a>
			</div>
		</div>
	</div>
	
</body>
</html>
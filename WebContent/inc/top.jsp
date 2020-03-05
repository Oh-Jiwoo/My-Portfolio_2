<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
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
					<a href="member/login.jsp">login</a> |  
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
</header>
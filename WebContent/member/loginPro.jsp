<%@page import="member.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	memberDAO memberdao = new memberDAO();   
	
	int check = memberdao.userCheck(id,passwd); 

	if(check == 1){ 
		session.setAttribute("id", id);
		
		response.sendRedirect("../index.jsp");
			
	}else if(check == 0){ 
%>

	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.go(-1);
	</script>
	
<% 
	}else{ 
%>	
	
	<script>
	
		alert("존재하지않는 아이디입니다.");
		history.back();
	
	</script>
	
<%	
	}
%>

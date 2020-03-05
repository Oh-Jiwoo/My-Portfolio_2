<%@page import="collection.CollectionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num")); //삭제할 글번호
	String pageNum = request.getParameter("pageNum"); //삭제할 글이 속해 있는 페이지번호
	String passwd = request.getParameter("passwd"); //글삭제를 위해 입력한 글에 대한 비밀번호
	
	CollectionDAO cdao = new CollectionDAO();
	
	int check = cdao.deleteCollection(num,passwd); //삭제할 글번호, 삭제를 위해 입력했던 글의 비밀번호
	 
	if(check == 1){ //삭제에 성공
	%>
		<script type="text/javascript">
			alert("삭제 성공");
			location.href = "../collections.jsp?pageNum=<%=pageNum%>";
		</script>
	<%
	}else{ //삭제에 실패
	%>
		<script>
			alert("비밀번호 틀림");
			history.back(); <%--이전 delete.jsp로 이동 --%>
		</script>
	
	<%		
	}

%>
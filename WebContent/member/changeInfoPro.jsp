<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	request.setCharacterEncoding("UTF-8");
%>

	<jsp:useBean id="dao" class="member.memberDAO"/>
	<jsp:useBean id="bean" class="member.memberBean"/>
	<jsp:setProperty property="*" name="bean"/>
	
<%
	
	String name = bean.getName();
	String gender = bean.getGender();
	String email = bean.getEmail();
	String postcode = bean.getPostcode();
	String address = bean.getAddress();
	String address2 = bean.getAddress2();
	String mtel = bean.getMtel();	
	bean.setId((String)session.getAttribute("id"));

	dao.updateMember(bean); 
%>   


<script>
	alert("회원정보 수정 성공");
	location.href = "changeInfo.jsp";
</script>
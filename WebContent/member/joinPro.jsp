<%@page import="member.memberDAO"%>
<%@page import="member.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String address2 = request.getParameter("address2");
	String mtel = request.getParameter("mtel");
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	birth = year + "-" + month + "-" + day;

	memberBean memberbean = new memberBean();
	
	memberbean.setId(id);
	memberbean.setPasswd(passwd);
	memberbean.setName(name);
	memberbean.setBirth(birth);
	memberbean.setGender(gender);
	memberbean.setEmail(email);
	memberbean.setPostcode(postcode);
	memberbean.setAddress(address);
	memberbean.setAddress2(address2);
	memberbean.setMtel(mtel);


	memberDAO memberdao = new memberDAO();
	memberdao.insertMember(memberbean); 
	
	response.sendRedirect("login.jsp");
%>
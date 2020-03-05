<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Notice</title>
<link rel="stylesheet" href="css/style.css" type="text/css">
	<!--[if IE 7]>
		<link rel="stylesheet" href="css/ie7.css" type="text/css">
	<![endif]-->
	
	<% 
		BoardDAO boardDAO = new BoardDAO();
	
		int count = boardDAO.getBoardCount();
		
		int pageSize = 10;
		
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		 
		int startRow = (currentPage -1) * pageSize;
		
		List<BoardBean> list = null;
		
		if(count > 0){
			list = boardDAO.getBoradList(startRow, pageSize);
		}
	%>
	
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="inc/top.jsp"/>
	
	<!-- 본문 -->
	<div id="wrap">
	<article>
		<h1 align="center" style="font-size: 45px;">Notice</h1>
		<div class="count_search_block">
			<div class="count">
				<span style="font-size: 18px;">[ 총 게시글 수 : <b><%=count %></b> ]</span>
			</div>
		</div>
		
		<table>
			<thead>
				<tr>
					<th class="num">NO.</th>
					<th class="subject">TITLE</th>
					<th class="writer">WRITER</th>
					<th class="date">DATE</th>
					<th class="views">VIEWS</th>
				</tr>
			</thead>
		<tbody>
	<%		
		if(count > 0){
			for(int i=0; i<list.size(); i++){
				BoardBean bean = list.get(i);		
	%>
			<tr class="row" onclick="location.href='notice/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
				<td class="num"><%=bean.getNum()%></td>
				<td class="subject">
	<%
			int wid = 0; 
			
			if(bean.getRe_lev() > 0){ wid = bean.getRe_lev() * 10;
	%>
			<img src="${pageContext.request.contextPath}/images/blank.gif" alt="화살표이미지">
			<img src="${pageContext.request.contextPath}/images/arrow.png" alt="화살표이미지">
	<%}%>
				<%=bean.getSubject()%></td>
				<td class="writer"><%=bean.getName() %></td>
				<td class="date"><%= new SimpleDateFormat("yyyy-MM-dd").format(bean.getDate())%></td>
				<td class="views"><%=bean.getReadcount() %></td>
			</tr>
	<%}
		}else{
	%>
			<tr>
				<td align="center" colspan="5">등록된 게시글이 없습니다.</td>
			</tr>
	<%}%>
		</tbody>
	</table>
				
	<%
	
		String id = (String)session.getAttribute("id");
	
		if(id != null){
	%>
		
		<div class="writing"> 
			<input type="button" value="글쓰기" class="btn" onclick="location.href='notice/nwrite.jsp'">				
		</div>
		
	<%
		}
	%>
				
		<div class="page">
			<div class="pagebtn">
			<%
			
			if(count > 0){
				int pageCount = count / pageSize + (count%pageSize == 0? 0 : 1);
				
				int pageBlock = 2;
				
				int startPage = ( (currentPage/pageBlock) - (currentPage%pageBlock == 0? 1 : 0 )) * pageBlock + 1 ;
				
				int endPage = startPage + pageBlock -1;
				
				if(endPage > pageCount){
					
					endPage = pageCount;
				}
				
				if(startPage > pageBlock){
			%>
			
				<a href ="notice.jsp?pageNum=<%=startPage-pageBlock%>">[prev]</a>
			
			<%
			}
				
			//[1] [2] 페이지번호 나타내기
				for(int i=startPage; i<=endPage; i++){
			%>
			
				<a href="notice.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			
			<%
			}
			
				if(endPage < pageCount){
			%>
			
				<a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">[next]</a>
			
			<%
				}
			}
	
			%>
			</div>
		</div>
	</article>	
	</div>
	<!-- 푸터 -->
	<jsp:include page="inc/bottom.jsp"/>
</body>
</html>
<%@page import="comment.CommentBean"%>
<%@page import="collection.CollectionBean"%>
<%@page import="java.util.List"%>
<%@page import="collection.CollectionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>
<link rel="stylesheet" href="css/style.css" type="text/css">
	<!--[if IE 7]>
		<link rel="stylesheet" href="css/ie7.css" type="text/css">
	<![endif]-->

</head>
<% 
	CollectionDAO collectionDAO = new CollectionDAO();
 	
	int count = collectionDAO.getCollectionCount();
	
	int pageSize = 6;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	 
	int startRow = (currentPage -1) * pageSize;
	
	List<CollectionBean> list = null;
	
	if(count > 0){
		list = collectionDAO.getCollectionList(startRow, pageSize);
	}
%>
<body>
	<!-- 헤더 -->
	<jsp:include page="inc/top.jsp"/>
	
	<div class="body">
		<div class="collections">
			<div class="navigation">
				<ul>
					<li class="selected">
						<a href="#">Summer 2023</a>
					</li>
					<li>
						<a href="#">Spring 2023</a>
					</li>
					<li>
						<a href="#">Evening 2023</a>
					</li>
					<li>
						<a href="#">Winter 2023</a>
					</li>
					<li>
						<a href="#">Autumn 2023</a>
					</li>
					<li>
						<a href="#">The Forever Collection</a>
					</li>
				</ul>
			</div>
		
			<div>
				<h2>Summer 2023 Collection</h2>
				
				<table>
				<%
					if(count > 0){
				%>
					<tr>
				<%	
					int f=0;
					
					for(int i=0; i<list.size(); i++){
							CollectionBean bean = list.get(i);
							f++;
							if(!(f%3==0)){
				%>
						<td onclick="location.href='collection/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
							<img src="upload/<%=bean.getFile()%>" width="250" height="370" class="hideme">
						</td>
				<%
							}else{
				%>
							<td onclick="location.href='collection/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
								<img src="upload/<%=bean.getFile()%>" width="250" height="370" class="hideme">
							</td>
						</tr>
						<tr>
				<%
							}
						}
					} else {
				%>
					<tr align="center">
						<td cospan="5" >게시판 글 없음</td>	
					</tr>
				<%
					}
				%>	
				</table>
				<%
				String id = (String)session.getAttribute("id");

				if(id != null){
				%>
				
				<div id="table_search"> 
					<input type="button" value="글쓰기" class="btn" onclick="location.href='collection/cwrite.jsp'">				
				</div>
				
				<%
				}
				%>
			</div>
			
			<div id="page_control">
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
					
					<a href ="collections.jsp?pageNum=<%=startPage-pageBlock%>">[prev]</a>
				
				<%
				}
					
				//[1] [2] 페이지번호 나타내기
					for(int i=startPage; i<=endPage; i++){
				%>
				
					<a href="collections.jsp?pageNum=<%=i%>">[<%=i%>]</a>
				
				<%
				}
				
					if(endPage < pageCount){
				%>
				
					<a href="collections.jsp?pageNum=<%=startPage+pageBlock%>">[next]</a>
				
				<%
					}
				}
		
				%>
			</div>	
		</div>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="inc/bottom.jsp"/>
</body>
</html>
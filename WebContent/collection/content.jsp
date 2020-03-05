<%@page import="java.util.List"%>
<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="collection.CollectionBean"%>
<%@page import="collection.CollectionDAO"%>
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
	
	
	<%
	request.setCharacterEncoding("UTF-8");

 	int num = Integer.parseInt(request.getParameter("num"));
 	String pageNum = request.getParameter("pageNum");

	CollectionDAO dao = new CollectionDAO();

	dao.updateReadCount(num);

	CollectionBean colletionbean = dao.getCollecion(num);

	int DBnum = colletionbean.getNum();
	int DBReadcount = colletionbean.getReadcount();
	String DBName = colletionbean.getName();
	Timestamp DBDate = colletionbean.getDate();
	String DBSubject = colletionbean.getSubject();
	String DBContent = "";
	
	if(colletionbean.getContent() != null){
		DBContent = colletionbean.getContent().replace("\r\n", "<br>");
	}
	
	CollectionBean bean = new CollectionBean();
	
	CommentDAO mDAO = new CommentDAO();
	
	CommentBean mBean = new CommentBean();
	
	int count = mDAO.getCommentCount(num);
	
	List<CommentBean> list = null;
	
	if(count > 0){
		list = mDAO.getCommentList(num);
	}
%>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
	
		function addComm(b_num){
			
			var _id = $("input[id='c_id']").val();
			var _num = b_num;
			var _ment = $("#c_ment").val();
			var __id = _id;
			var __num = _num;
			var __ment = _ment;
			if(_id == "null"){
				alert("회원만 댓글 작성이 가능합니다.");
				return;
			}
			$.ajax({
				type:"post",
				async:false,
				url:"http://localhost:8090/Jiwoo_Project/addComment",
				dataType:"xml",
				data:{c_id:__id,b_num:__num,c_ment:__ment},
				success:function(data,textStatus){
					location.href=location.href;
				}
			});
		} //addComm
		
		function delComm(_dbnum,_idx){
			var _dbid = $("input[id='c_id']").val();
			var _num = _dbnum;
			var _id = _dbid;
			var _idx = _idx;
			
			$.ajax({
				type:"post",
				async:false,
				url:"http://localhost:8090/Jiwoo_Project/deleteComment",
				dataType:"text",
				data:{id:_id,num:_num,idx:_idx},
				success:function(data,textStatus){
					location.href = location.href;
					if(data == "success"){
					}else{
						alert("댓글 쓴 본인만 지울 수 있습니다.");
					}
					
				}
			}); 
		} //delComm
		
		
	
	</script>
	
</head>

<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top2.jsp"/>
	
	<!-- 본문  -->
	<div class="c_content">
	<div id=wrap>
		<article>
			<h1>Content</h1>
			<table id="collection">
				<tr>
					<th>글 번호</th>
					<td><%=DBnum %></td>
					<th>조회수</th>
					<td><%=DBReadcount %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%=DBName %></td>
					<th>작성일</th>
					<td><%=new SimpleDateFormat("yyyy.MM.dd").format(DBDate)%></td>
				</tr>
				<tr>
					<th>글 제목</th>
					<td colspan="3"><%=DBSubject %></td>
				</tr>
				<tr>
					<th>파일</th>
					<td colspan="3">
						<img src="../upload/<%=colletionbean.getFile()%>" width="250" height="370">
					</td>
				</tr>
				<tr>
					<th>글내용</th>
					<td colspan="3"><%=DBContent %></td>
				</tr>
			</table>
		</article>
		
		<hr>
		
		<%String id = (String)session.getAttribute("id"); %>
		
		<table id="comment" frame="void">
			<h2>Comment</h2>
				<tr>
					<th calss="writer">작성자</th>
					<th class="content" width="500px">글내용</th>
					<th class="date">작성일</th>
				</tr>
			<%
				if(count > 0){
					for( int i=0; i<list.size(); i++){
						CommentBean mbean = list.get(i);
			%>
				<tr>
					<td id="c_id" class="writer"><%=mbean.getId()%></td>
					<td id="#" width="500px" class="content"><%=mbean.getMent()%></td>
					<td class="date"><%=new SimpleDateFormat("yyyy-MM-dd").format(mbean.getDate())%></td> 
					<td><input type="button" id="delbtn" onclick="delComm(<%=num%>,<%=mbean.getIdx() %>)" value="삭제"></td>
				</tr>  
			<%			
					}
				}else{
			%>
				<tr>
					<td colspan="4" align="center">작성된 댓글이 없습니다.</td>
				</tr>
			<%
				}
			%>
        	<div>
            	<input type="hidden" id="c_id" value="<%=id%>">
            	<tr>
	            	<td>
	                    <div> <%=id %> </div>
	                </td>
	                <td width="500" colspan="3">
	                    <div>
	                        <textarea id="c_ment" name="c_ment" rows="1" cols="50" placeholder="댓글 작성"></textarea>
	                        <input type="button" onclick="addComm(<%=num%>)" value="등록" class="btn">
	                    </div>
	                </td>
	            </tr>
           </div>
        </table>
		
		<hr>
		
		<div id="comm">
		<%
		
			if(id != null){
		%>
			<input type="button" value="글수정" class="btn" onclick="location.href='cupdate.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
			
			<input type="button" value="글삭제" class="btn" onclick="location.href='cdelete.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'"> 
		<% 		
			}
		%>
			<input type="button" value="글목록" class="btn" onclick="location.href='../collections.jsp?&pageNum=<%=pageNum%>'">
		</div>
		

		</div>
	</div>
	<div class="clear"></div>
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>
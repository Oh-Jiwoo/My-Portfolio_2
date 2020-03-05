<%@page import="member.memberBean"%>
<%@page import="member.memberDAO"%>
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
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	//우편번호
	function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                
            } 

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("postcode").value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address2").focus();
        }
    }).open();
}
	
		
	</script>
</head>
<%
	
		String id = (String)session.getAttribute("id");
	
		memberDAO dao = new memberDAO();
		memberBean bean = dao.getMember(id);
		
		String name = bean.getName();
		String gender = bean.getGender();
		String email = bean.getEmail();
		String postcode = bean.getPostcode();
		String address = bean.getAddress();
		String address2 = bean.getAddress2();
		String mtel = bean.getMtel();
	
	%>
<body>
	
	<!-- 헤더 -->
	<jsp:include page="../inc/top2.jsp"/>
	
	
	<!-- 본문 -->
	<div id=wrap>
		<article>
			<div id="changeInfo">
				<h1>Edit member information</h1>
			</div>
			<form action="changeInfoPro.jsp" method="post">
				<div id="user_info_form">
				<table>
					<tr>
						<th class="label_td"><label for="id">ID</label></th>
						<td><%=id %></td>
					</tr>
					<tr>
						<th class="label_td"><label for="name">Name</label></th>
						<td><input type="text" name="name" id="name" value="<%=name %>" placeholder="이름" required/></td>
					</tr>
					<tr>
						<th class="label_td"><label for="male">Gender</label></th>
						<td>
							<select name="gender">
								<option value="gender">성별</option>
								<option value="m">Man</option>
								<option value="w">Woman</option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="label_td"><label for="address">Address</label></th>
						<td>
							<input type="text" name="postcode" id="postcode" value="<%=postcode %>" placeholder="우편번호" class="textWithBtn" required>
							<input type="button" onclick="execDaumPostcode()" value="찾기" class="btn"><br/>
							<input type="text" name="address" id="address" value="<%=address %>" placeholder="주소" required readonly><br/>
							<input type="text" name="address2" id="address2" value="<%=address2 %>" placeholder="상세주소" required><br/>
						</td>
					</tr>
					<tr>
						<th class="label_td"><label for="email">E-mail</label></th>
						<td>
							<input type="text" name="email" id="email" value="<%=email %>" placeholder="이메일" required/>
						</td>
					</tr>
					<tr>
						<th class="label_td"><label for="mtel">Mobile Phone Number</label></th>
						<td>
							<input type="text" name="mtel" id="mtel" value="<%=mtel%>" placeholder="핸드폰번호" required/>
						</td>
					</tr>
				</table>
				</div>
				<div id="pass_recheck_btn">
					<input type="submit" value="수정" class="btn"/>
					<input type="reset" value="취소" class="btn"/>
				</div>
			</form>
		</article>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp"/>
	
</body>
</html>
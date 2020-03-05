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
		function winopen(){
			if(document.fr.id.value == ""){
				alert("아이디를 입력하세요.");
				document.fr.id.focus();
				return;
			}
			var fid = document.fr.id.value;
			window.open("ID_Check.jsp?userid="+fid,"","width=400,height=200");
		}
		
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
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top2.jsp"/>
	
	<!-- 본문 -->
	<div id=wrap>
	<div class="join">
		<article>
			<h1 align="center" style="font-size: 45px;">Join Us</h1>
				<form action="joinPro.jsp" id="join" method="post" name="fr">
					<fieldset>
						<label>User ID</label> <input type="text" name="id" class="id"  required>
						<input type="button" value="아이디 중복체크" class="dup" onclick="winopen();"><br>
						<label>Password</label> <input type="password" name="passwd"  required><br>
						<label>Retype Password</label> <input type="password" name="passwd2"  required><br>
						<label>Name</label> <input type="text" name="name"  required><br>
						<label>Birth</label>
								<input type="text" name="year" id="year" placeholder="년" required/>
								<span class="divider"></span>
								<select name="month" id="month">
									<option value="mon">월</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select>
								<span class="divider"></span>
								<input type="text" name="day" id="day" placeholder="일" required/><br>
						<label>Gender</label>
							<select name="gender"  required>
								<option value="gender">성별</option>
								<option value="m">Men</option>
								<option value="w">Women</option>
							</select><br>
						<label>E-Mail</label> <input type="email" name="email"  required><br>
						<label>Address</label>
							<input type="text" name="postcode" id="postcode" placeholder="우편번호">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" name="address" id="address" placeholder="주소"> 
							<input type="text" name="address2" id="address2" placeholder="상세주소"  required><br>
						<label>Mobile Phone Number</label> <input type="text" name="mtel"><br>
						<div id="buttons">
						<input type="submit" value="join us" class="submit"> 
						<input type="reset" value="cancel" class="cancel">
					</div>
					</fieldset>
					
					<div class="clear"></div>
					
				</form>
		</article>
	</div>
	</div>
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css" type="text/css">
	<!--[if IE 7]>
		<link rel="stylesheet" href="css/ie7.css" type="text/css">
	<![endif]-->
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="inc/top.jsp"/>
	
	<!-- 본문 -->
	<div class="body">
		<div class="locator">
			<div class="search">
				<h3>Store Locator</h3>
				<form action="index.jsp">
					<label for="country">Enter Country</label>
					<input type="text" id="country">
					<label for="city">City</label>
					<input type="text" id="city">
					<input type="submit" value="Find Nearest Store" id="submit">
				</form>
			</div>
			<ul>
				<li>
					<div>
						<h4>High Fashion Store</h4>
						<p>
							COLLECTIONS: MENS WOMENS
						</p>
						<p>
							ADDRESS: 25 Arrowood Drive <br> Jacksonville, FL 32256
						</p>
						<p>
							PHONE: 904-422-5881 <br> HOURS: 10:00-21:00
						</p>
						<a href="#">View Map</a>
					</div>
					<div>
						<h4>Couture Runway Mall</h4>
						<p>
							COLLECTIONS: MENS WOMENS
						</p>
						<p>
							2021 Duck Creek Road <br> San Francisco, CA 94143
						</p>
						<p>
							PHONE: 650-918-4713 <br> HOURS: 10:00-21:00
						</p>
						<a href="#">View Map</a>
					</div>
				</li>
				<li>
					<div>
						<h4>Couture Runway Mall</h4>
						<p>
							COLLECTIONS: MENS WOMENS
						</p>
						<p>
							2021 Duck Creek Road <br> San Francisco, CA 94143
						</p>
						<p>
							PHONE: 650-918-4713 <br> HOURS: 10:00-21:00
						</p>
						<a href="#">View Map</a>
					</div>
					<div>
						<h4>Saverio Salermo Boutique</h4>
						<p>
							COLLECTIONS: MENS WOMENS
						</p>
						<p>
							ADDRESS: 1995 Prudence Street <br> Lincoln Park, MI 48146
						</p>
						<p>
							PHONE: 313-382-3032 <br> HOURS: 10:00-21:00
						</p>
						<a href="#">View Map</a>
					</div>
				</li>
				<li>
					<div>
						<h4>Saverio Salermo Boutique</h4>
						<p>
							COLLECTIONS: MENS WOMENS
						</p>
						<p>
							ADDRESS: 1995 Prudence Street <br> Lincoln Park, MI 48146
						</p>
						<p>
							PHONE: 313-382-3032 <br> HOURS: 10:00-21:00
						</p>
						<a href="#">View Map</a>
					</div>
					<div>
						<h4>High Fashion Store</h4>
						<p>
							COLLECTIONS: MENS WOMENS
						</p>
						<p>
							ADDRESS: 25 Arrowood Drive <br> Jacksonville, FL 32256
						</p>
						<p>
							PHONE: 904-422-5881 <br> HOURS: 10:00-21:00
						</p>
						<a href="#">View Map</a>
					</div>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="inc/bottom.jsp"/>
</body>
</html>
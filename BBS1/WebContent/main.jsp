<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>로그인</title>
</head>
<body>
	<%
		String userID = null; //로그인이 안된 사람은 널값이 담기고
		if(session.getAttribute("userID") != null) { //세션에 있다면(로그인했다면)
			userID = (String) session.getAttribute("userID"); // userID가 담김
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a href="main.jsp" class="navbar-brand">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null) { //로그인이 안된사람은 회원가입이나 로그인을 할 수 있도록
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else { //로그인된 사람이 보는 navigation bar
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>울릉도 오징어 뱃길따라 이백리 외로운 섬하나 새들의 고향, 그 누가 아무리 자기네 땅이라고 우겨도 독도는 우리땅</p>
				<p><a class="btn btn-primary btn-pull" href="" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	<div class="container"><!-- 캐로샐이용 -->
		<div class="carousel slide" id="myCarousel" data-ride="carousel">
			<ol class="carousel-indicators"><!--캐로샐을 지칭할 목록들 -->
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1" ></li>
				<li data-target="#myCarousel" data-slide-to="2" ></li>
			</ol>
			<div class="carousel-inner"><!-- 캐로샐 이너 아이템들 -->
				<div class="item active"> <!-- 맨처음 띄어져있을것에 active -->
					<img src="images/gandi.jpg"/>
				</div>
				<div class="item">
					<img src="images/tom.jpg"/>
				</div>
				<div class="item">
					<img src="images/lee.jpg"/>
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev"><!-- < -->
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next"><!-- > -->
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>
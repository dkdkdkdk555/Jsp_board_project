<%@page import="bbs.BbsDAO"%>
<%@page import="bbs.Bbs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>글 수정</title>
</head>
<body>
	<%
		String userID = null; //로그인이 안된 사람은 널값이 담기고
		if(session.getAttribute("userID") != null) { //세션에 있다면(로그인했다면)
			userID = (String) session.getAttribute("userID"); // userID가 담김
		}
		//<게시판 글 수정하기>		
		//1.요청과함께 넘어온 파라미터를 담는다. 
		int bbsID = Integer.parseInt(request.getParameter("bbsID"));
		//2.int bbsID를 이용하여 해당게시글의 제목 과 내용을 셀렉트해와서 글쓰기 양식에 맞춰 복원해 놓는다.
		//getBbs로 Bbs객체를 얻기
		Bbs bbs = new BbsDAO().getBbs(bbsID);
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
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
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
		<div class="row">
			<form method="post" action="updateAction.jsp"> <!-- 글작성내용을 write.jsp로 보내기 위해 form태그로 감싼다. -->
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd"><!--striped는 게시판의 홀수와 짝수 row들이 번갈아가면서 색깔이 다르게 둬서 보기 좋게하는 요소 -->
					<thead>
						<tr><!--colspan=2 는 두개의 칼럼을 합친다. -->
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정하기</th>
						</tr>
					</thead>
					<tbody>
						<input type="hidden" name="bbsID" value="<%=bbsID %>" />
						<tr><!-- maxlength는 글자수 제한 -->
							<td><input type="text" class="form-control" value="<%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>" name="bbsTitle" maxlength="50"/></td>
						</tr>
						<tr>
							<td><textarea class="form-control" name="bbsContent" maxlength="2048" style="height:350px"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기" /><!-- 인풋태그를 버튼으로 맨들기 -->
			</form>	
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
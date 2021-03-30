<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="bbs.BbsDAO" %>
    <%@ page import="bbs.Bbs" %>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>게시판</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		
		String userID = null; //로그인이 안된 사람은 널값이 담기고
		if(session.getAttribute("userID") != null) { //세션에 있다면(로그인했다면)
			userID = (String) session.getAttribute("userID"); // userID가 담김
		}
		
		//현재게시판이 몇번째 페이지인지 알려주기 위해 
		int pageNumber =1; //초기값 1페이지
		if(request.getParameter("pageNumber")!=null) { //pageNumber란 name으로 파라미터가 넘어왔다면
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd"><!--striped는 게시판의 홀수와 짝수 row들이 번갈아가면서 색깔이 다르게 둬서 보기 좋게하는 요소 -->
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(Bbs tmp : list) { %>
						<tr>
							<td><%=tmp.getBbsID() %></td>
							<td><a href="view.jsp?bbsID=<%=tmp.getBbsID() %>"><%=tmp.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
									.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
							<td><%=tmp.getUserID() %></td>
							<td><%=tmp.getCount() %></td>
							<td><%=tmp.getBbsDate().substring(0, 11) + tmp.getBbsDate().substring(11, 13) + "시" + tmp.getBbsDate().substring(14, 16) + "분" %></td>
						</tr>
				<%} %>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) { //1이 아니라면 모두 2페이지 이상이기 때문에 이전 버튼 필요
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				}if(bbsDAO.nextPage(pageNumber + 1)) { //다음페이지가 존재 한다면
			%>	
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>	
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a><!--pull-right : 버튼이 오른쪽에 고정되게하는 속성 -->
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
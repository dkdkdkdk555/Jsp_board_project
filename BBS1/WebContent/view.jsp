<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "bbs.Bbs" %>
    <%@ page import = "bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>게시판</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) { 
			userID = (String) session.getAttribute("userID"); 
		}
		int bbsID=0; //초기값 설정
		if(request.getParameter("bbsID") != null){ //정상적으로 bbsID가 넘어 왔다면
			bbsID = Integer.parseInt(request.getParameter("bbsID")); //넘어온데이터로 int bbsID를 수정
		}
		
		if(bbsID == 0) { %>
			<script>
				alert('해당 게시물이 존재하지 않습니다.');
				location.href = 'bbs.jsp';
			</script>	
	<%  }
		new BbsDAO().countUp(bbsID);  //방문시 조회수 +1
		
		Bbs bbs = new BbsDAO().getBbs(bbsID); //bbsID가 null이 아니라서 유효한 정보라면 getBbs()를 실행해 Bbs(게시글)객체를 리턴받는다.
		
		if(userID!=null) { //로그인한 경우 만 적용
			if (userID.equals(bbs.getUserID())) { //만약 글쓴이와 현재 로그인된 사용자가 같다면 조회수 +1 취소
				new BbsDAO().countCancel(bbsID);		
			}
		}
		
		int result = 0;
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
						<tr><!--colspan=3 는 3개의 칼럼을 합친다. -->
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr><!-- maxlength는 글자수 제한 -->
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
									.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getUserID() %></td>
						</tr>
						<tr>
							<%
								if(userID != null) {
									if(userID.equals(bbs.getUserID())) { //로그인되있고 자기글인 상태
										result = bbs.getCount() - 1;	
									} else { //로그인했는데 자기글이 아닌상태
										result = bbs.getCount();
									}
								} else { //로그인안한상태
									result = bbs.getCount();
								}
							%>
							<td>조회수</td>
							<td colspan="2"><%=result %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="height:200px; text-align:left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
								.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
					</tbody>
				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					if(userID != null && userID.equals(bbs.getUserID())) { //글의 작성자와 현재 게시글의 작성자가 같다면
				%>
						<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
				<%
					}
				%>					
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
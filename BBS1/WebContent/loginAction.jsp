<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.UserDAO" %>
    <%@ page import = "java.io.PrintWriter"%> <!-- 자바스크립트문장을 사용하기 위해 임포트 <script>태그를 대신한다. -->
    <% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/><!-- user클래스를 자바빈즈로서 사용한다. class="경로", scope="page=현재페이지에서만 사용될수있게" -->
<jsp:setProperty name="user" property="userID"/><!-- login페이지에서 넘겨준 userID=name을 받아서 넣어주는.. request.getParameter("userID")를 대신한 거 같다. -->
<jsp:setProperty name="user" property="userPassword"/><!-- = request.getParameter("userPassword"); -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 액션</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) { //로그인이 되있다면
			userID = (String) session.getAttribute("userID");  //세션에서 값 얻어옴
		}
		if(userID != null) { //로그인하면서 String userID 가 참조를 하게 됫다면%> 
			<script>
				alert('이미 로그인 되어있습니다.');
				location.href = 'main.jsp';
			</script>
	<%	}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1) { 
			session.setAttribute("userID", user.getUserID());
			%>
			<script>
				location.href = 'main.jsp'; //대입된 경로로 이동하는 메소드
			</script>		
	<%  }else if (result == 0) { %>
			<script>
				alert('비밀번호가 틀립니다.');
				history.back(); //이전 페이지로 이동하는 메소드
			</script>
	<%  }else if (result == -1) { %>
			<script>
				alert('존재하지 않는 아이디입니다.');
				history.back();
			</script>
	<%  }else if (result == -2) { %>
			<script>
				alert('데이터베이스 오류가 발생했습니다.');
				history.back();
			</script>
	<%} %>

</body>
</html>
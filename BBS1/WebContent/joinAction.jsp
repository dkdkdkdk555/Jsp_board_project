<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.UserDAO" %>
    <% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<jsp:setProperty name="user" property="userName"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 액션</title>
</head>
<body>
	<% //로그인한 사용자는 회원 가입 폼에 접근할 수 없도록
		String userID = null;
		if(session.getAttribute("userID") != null) { //로그인이 되있다면
			userID = (String) session.getAttribute("userID");  //세션에서 값 얻어옴
		}
		if(userID != null) { //로그인하면서 String userID 가 참조를 하게 됫다면 %> 
			<script>
				alert('이미 로그인 되어있습니다.');
				location.href = 'main.jsp';
			</script>
	<%} %>
	<!-- 회원가입폼에 하나라도 입력을 안한경우 -->
	<% 	if(user.getUserID() == null || user.getUserPassword() == null || user.getUserGender() == null || user.getUserEmail() == null || user.getUserName() == null) { %>
		<script>
			alert('입력이 안 된 사람이 있습니다.');
			history.back();
		</script>	
	<!-- 모두 입력을 한 경우 -->	
	<%} else { 
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
	 	if(result == -1) { %>
	 	<!-- userID에 primarykey 제약조건을 걸어놨으니 그에 충족하지 못해 join함수가 -1을 리턴하면 -->
			<script>
				alert('이미 존재하는 아이디입니다.');
				history.back();
			</script>
		<!-- 정상적으로 회원가입이 된경우 main.jsp 를 요청한다. -->		
		<%} else { 
			session.setAttribute("userID", user.getUserID());//세션에 저장 %>
			<script>
				location.href = 'main.jsp';
			</script>		
		<%}
	 	
	 	
	 }%>
		

</body>
</html>
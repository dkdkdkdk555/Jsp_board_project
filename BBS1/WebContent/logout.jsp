<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP게시판 웹 사이트 :: 로그아웃 </title>
</head>
<body>
	<%
		session.invalidate(); //세션을 빼앗기도록 해서 로그아웃 시켜중
	%>
	<script>
		location.href='main.jsp';
	</script>
</body>
</html>
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	//1. bbsID라는 키값으로 넘어온 데이터 받기
    	int bbsID = Integer.parseInt(request.getParameter("bbsID"));
    	//2. 해당 bbsID를 가진 게시물을 DB에서 찾아 삭제하기
    	boolean isSuccess = new BbsDAO().deleteBbs(bbsID);
    	//3. 응답 
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>	
	<%if(isSuccess) { %>
		alert('삭제성공!');
		location.href="bbs.jsp";
	<%} else {%>
		alert('삭제실패 ㅠㅠㅠㅠㅠㅠ');
		location.href="view.jsp";
	<%} %>
</script>
</body>
</html>
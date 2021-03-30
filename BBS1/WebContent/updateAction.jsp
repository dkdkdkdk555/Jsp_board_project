<%@page import="bbs.BbsDAO"%>
<%@page import="bbs.Bbs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setCharacterEncoding("utf-8");
    	//넘어온 파라미터로 해당 게시글 찾아서 업데이트 해주기
    	int bbsID = Integer.parseInt(request.getParameter("bbsID"));
    	String bbsTitle = request.getParameter("bbsTitle");
    	String bbsContent = request.getParameter("bbsContent");
    	
    	Bbs bbs = new BbsDAO().getBbs(bbsID);
    	bbs.setBbsID(bbsID);
    	bbs.setBbsTitle(bbsTitle);
    	bbs.setBbsContent(bbsContent);
    	boolean isSuccess = new BbsDAO().bbsUpdate(bbs);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%if(isSuccess) { %>
	<script>
		alert('게시글 수정 완료!');
		location.href="view.jsp?bbsID=" + <%=bbsID %>;
	</script>
<%} else { %>
	<script>
		alert('게시글 수정 실패!!!!!');
		location.href="view.jsp?bbsID=" + <%=bbsID %>;
	</script>
<%} %>
</body>
</html>
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "bbs.Bbs" %><!-- 임폴트도 필수다 -->
    <% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/> <!--dto클래스가 있어야 사용가능한가부다. -->
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
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
		if(userID == null) { //로그인하면서 String userID 가 참조를 하게 됫다면 %> 
			<script>
				alert('로그인을 하세요');
				location.href = 'login.jsp';
			</script>
	<%} else  { %>
		<% 	if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) { %>
			<script>
				alert('입력이 안 된 사항이 있습니다.');
				history.back();
			</script>	
		<%} else { 
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		 	if(result == -1) { %>
				<script>
					alert('글쓰기에 실패했습니다.');
					history.back();
				</script>
			<%} else { %>
				<script>
					location.href = 'bbs.jsp';
				</script>		
			<%}
			}		
		}
	%>
</body>
</html>
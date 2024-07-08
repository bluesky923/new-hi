<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connection.jsp" %>
<!-- "deleteExecute.jsp" -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 삭제 요청 처리</title>
</head>
<body>
	<h1>회원정보 삭제</h1>
	<%
		// 사용자가 요청한 전송방식을 변경하여 저장
		String method = request.getMethod().toLowerCase();
		
		String message = "";
	
		if(method.equals("get")){
			message = "올바른 요청이 아닙니다";
		}else{
			// post 방식으로 요청
			String paramNum = request.getParameter("num");
			int num = 0;
			if(paramNum != null){
				num = Integer.parseInt(paramNum);
			}
			
			PreparedStatement pstmt = conn.prepareStatement(
				"DELETE from member where num = ?"
			);
			pstmt.setInt(1, num);
			// "DELETE from member where num = 5"
			int result = pstmt.executeUpdate();
			
			if(result == 1){
				message = num+"회원 정보 삭제 완료";
			}else{
				message = "회원 정보 삭제 실패";
			}
			
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		
		} // END POST
	%>
	<h3><%= message %></h3>
	<a href="memberList.jsp">회원 목록</a>
	</body>
</html>



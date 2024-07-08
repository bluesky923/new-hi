<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="connection.jsp" %>
<%
	String id = request.getParameter("uid");
	String pass = request.getParameter("upw");
	// 사용할 쿼리 질의 객체 선택
	String statement = request.getParameter("stmt");
	// stmt, pstmt, cstmt
	Statement stmt = null;
	PreparedStatement pstmt = null;
	CallableStatement cstmt = null;
	ResultSet rs = null;
	
	// select * from member where id = 'id001' and pass = 'pw001';
	
	if(statement.equals("stmt")){
		out.println("Statement <bt/>");
		stmt = conn.createStatement();
		String sql = "select * from member where id = '"+id+"' and pass = '"+pass+"'";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		
	}else if(statement.equals("pstmt")) {
		out.println("PreparedStatement <bt/>");
		String sql = "select * from member where id = ? and pass = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pass);
		rs = pstmt.executeQuery();
		
		
	}else if(statement.equals("cstmt")) {
		out.println("CallableStatement <bt/>");
		String sql = "call logincheck(?,?)";
		cstmt = conn.prepareCall(sql);
		cstmt.setString(1, id);
		cstmt.setString(2, pass);
		
		rs = cstmt.executeQuery();
		
	}
	
	// ResultSet 객체가 정상적으로 생성이 되었고
	// 검색된 행이 존재 할 때
	if(rs != null && rs.next()){
		int num = rs.getInt("num");
		String rsId = rs.getString(2);
		String rsPass = rs.getString(3);
		String rsName = rs.getString("name");
		String rsAddr = rs.getString(5);
		
		out.println("num : "+num+"<br/>");
		out.println("rsId : "+rsId+"<br/>");
		out.println("rsPass : "+rsPass+"<br/>");
		out.println("rsName : "+rsName+"<br/>");
		out.println("rsAddr : "+rsAddr+"<br/>");
	}else{
		out.println("존재하지 않는 사용자입니다<br/>");
	}
	
	if(rs != null) rs.close();
	if(stmt != null) stmt.close();
	if(conn != null) conn.close();
	
%>
<h4><a href="login.jsp">로그인 페이지</a></h4>
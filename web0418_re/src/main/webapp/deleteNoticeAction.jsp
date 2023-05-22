<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>

<% 
	//리퀘스트 요청값에 대한 유효성 검사
	if(request.getParameter("noticeNo") == null
			|| request.getParameter("noticePw") == null
			|| request.getParameter("noticeNo").equals("")
			|| request.getParameter("noticePw").equals("")) {
		response.sendRedirect("./noticeList.jsp");
		return; //코드 진행 종료 , 반환값을 남길 때(else 블럭 절약)
	} 

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticePw = request.getParameter("noticePw");
	
	//디버깅		
	System.out.println(noticeNo+"<--deleteNoticeAction noticeNo");
	System.out.println(noticePw+"<--deleteNoticeAction noticePw");
			
	//delete from notice where notice_no=?(setInt) and notice_pw=?(setString)
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	String sql= "delete from notice where notice_no=? and notice_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, noticeNo);
	stmt.setString(2, noticePw);
	
	System.out.println(stmt +"<--deletenoticeAction sql");
	
	int row = stmt.executeUpdate();
	
	//삭제 실패시(비밀번호 틀림)
	
	//디버깅
	System.out.println(row +"<--deletenoticeAction row");
	
	
	if(row == 0) { 
		response.sendRedirect("./deleteNoticeForm.jsp?noticeNo="+noticeNo); //noticeone도 괜춘
		
	} else {
		response.sendRedirect("./noticeList.jsp");
	}

%>

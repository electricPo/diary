<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>


<%
	//리퀘스트 요청값에 대한 유효성 검사
	if(request.getParameter("scheduleNo") == null //해당값이 넘어왔을 때
		|| request.getParameter("schedulePw") == null
		|| request.getParameter("scheduleNo").equals("")
		|| request.getParameter("schedulePw").equals("")) {
		
		response.sendRedirect("./scheduleList.jsp"); //페이지로 이동
		return; //코드진행 종료
		
	}
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String schedulePw = request.getParameter("schedulePw");

	//디버깅
	System.out.println(scheduleNo+"<--deleteScheduleAction /scheduleNo");
	System.out.println(schedulePw+"<--deleteScheduleAction /schedulePw");

	//delete from schedule where schedule_no=?(setInt) and schedule_pw=?(setString)
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");

	String sql= "delete from schedule where schedule_no=? and schedule_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, scheduleNo);
	stmt.setString(2, schedulePw);
	
	System.out.println(stmt +"<--deleteScheduleAction sql");
	
	int row = stmt.executeUpdate(); // executeQuery() select문과 같은 결과값을 필요로 하는 곳에 사용
									// cf.executeUpdate() : 결과 값이 나오지 않아도 되는 경우 사용한다.
	
	//삭제 실패시(비밀번호 틀림)
	
	//디버깅
	System.out.println(row +"<--deleteScheduleAction / row");
	
	
	if(row == 0) { 
		response.sendRedirect("./scheduleList.jsp?scheduleNo="+scheduleNo);
		
	} else {
		response.sendRedirect("./home.jsp"); //비밀번호 맞았을 때
	}
%>




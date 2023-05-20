<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	//post 방식 인코딩 처리
	request.setCharacterEncoding("utf-8");	

	
	//validation(요청 파라미터값 유효성 검사)
	if(request.getParameter("scheduleDate") == null 
	      || request.getParameter("scheduleTime") == null   
	      || request.getParameter("scheduleColor") == null
	      || request.getParameter("scheduleMemo") == null
	      
	      || request.getParameter("scheduleDate").equals("")
	      || request.getParameter("scheduleTime").equals("")
	      || request.getParameter("scheduleColor").equals("")
	      || request.getParameter("scheduleMemo").equals("")) {
	   
	   response.sendRedirect("./scheduleList.jsp");
	   return;
	}
	
	//값들을 DB테이블에 입력
	String scheduleDate = request.getParameter("scheduleDate"); //date도 String 타입으로 입력
	String scheduleTime = request.getParameter("scheduleTime");
	String scheduleColor = request.getParameter("scheduleColor");
	String scheduleMemo = request.getParameter("scheduleMemo");
	
	//디버깅
	System.out.println(scheduleDate + " <-- insertScheduleAction/param/scheduleDate");
	System.out.println(scheduleTime + " <-- insertScheduleAction/param/scheduleTime");
	System.out.println(scheduleColor + " <-- insertScheduleAction/param/scheduleColor");
	System.out.println(scheduleMemo + " <-- insertScheduleAction/param/scheduleMemo");

	//DB 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	
	String sql = "insert into schedule(schedule_date, schedule_time, schedule_memo, schedule_color, createdate, updatedate) values(?,?,?,?,now(),now())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	//?값 4개
			
	stmt.setString(1, scheduleDate);
	stmt.setString(2, scheduleTime);
	stmt.setString(3, scheduleMemo);
	stmt.setString(4, scheduleColor);
	
	//디버깅
	System.out.println(stmt + " <-- insertScheduleAction stmt");
	
	int row = stmt.executeUpdate();
	//if문으로 리다이렉션
	if(row==1) {
		System.out.println("insertScheduleAction 정상 입력");
	} else {
		System.out.println("insertScheduleAction 비정상 입력 row : "+ row);
	}
	
	String y = scheduleDate.substring(0,4);
	int m = Integer.parseInt(scheduleDate.substring(5,7))-1 ;
	String d = scheduleDate.substring(8);
	
	System.out.println(y + " <-- insertScheduleAction y");
	System.out.println(m + " <-- insertScheduleAction m");
	System.out.println(d + " <-- insertScheduleAction d");
	
	response.sendRedirect("./scheduleListByDate.jsp?y="+y+"&m="+m+"&d="+d);
%>

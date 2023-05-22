<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>


<%

	//request 인코딩 설정

	request.setCharacterEncoding("utf-8");

	//유효성 검사
	//schedule_date schedule_time schedule_memo schedule_color 
	//scheduleNo가 안 넘어왔을 때
	if(request.getParameter("scheduleNo") == null
			||request.getParameter("scheduleDate") == null
			||request.getParameter("scheduleTime") == null
			||request.getParameter("scheduleMemo") == null
			||request.getParameter("scheduleColor") == null
			||request.getParameter("schedulePw") == null
	
			||request.getParameter("scheduleNo").equals("")
			||request.getParameter("scheduleDate").equals("")
			||request.getParameter("scheduleTime").equals("")
			||request.getParameter("scheduleMemo").equals("")
			||request.getParameter("scheduleColor").equals("")
			||request.getParameter("schedulePw").equals("")){
			response.sendRedirect("./scheduleList.jsp"); //이 페이지로 돌려보낸다
			
			return;
		
	}
	
	//유효성 검사에 대한 디버깅
	System.out.println(request.getParameter("scheduleDate")+ "<-updateScheduleAction /param / scheduleDate");
	System.out.println(request.getParameter("scheduleTime")+ "<-updateScheduleAction /param / scheduleTime");
	System.out.println(request.getParameter("scheduleMemo")+ "<-updateScheduleAction /param / scheduleMemo");
	System.out.println(request.getParameter("scheduleColor")+ "<-updateScheduleAction /param / scheduleColor");
	System.out.println(request.getParameter("scheduleNo")+ "<-updateScheduleAction /param / scheduleNo");
	System.out.println(request.getParameter("schedulePw")+ "<-updateScheduleAction /param / schedulePw");
	
	//값 DB테이블에 입력
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String scheduleDate = request.getParameter("scheduleDate");
	String scheduleTime = request.getParameter("scheduleTime");
	String scheduleMemo = request.getParameter("scheduleMemo");
	String scheduleColor = request.getParameter("scheduleColor");
	String schedulePw = request.getParameter("schedulePw");
	
	//디버깅
	System.out.println(scheduleNo +"<-updateScheduleAction/param/scheduleDate");
	System.out.println(scheduleDate +"<-updateScheduleAction/param/scheduleDate");
	System.out.println(scheduleTime +"<-updateScheduleAction/param/scheduleTime");
	System.out.println(scheduleMemo +"<-updateScheduleAction/param/scheduleMemo");
	System.out.println(scheduleColor +"<-updateScheduleAction/param/scheduleColor");
	System.out.println(schedulePw +"<-updateScheduleAction/param/schedulePw");

	//드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	//확인
	System.out.println("드라이버 로딩");
		
	Connection conn = DriverManager.getConnection(
		      "jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	//쿼리 명령문 //db에 저장된 내용 가져오기
	String sql = "update schedule set schedule_date=?, schedule_time=?, schedule_memo=?, scheduleColor=?,updatedate = now() where schedule_no=?";
	
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// ? 6개
	stmt.setString(1, scheduleDate);
	stmt.setString(2, scheduleTime);
	stmt.setString(3, scheduleMemo);
	stmt.setString(4, scheduleColor);
	stmt.setInt(5, scheduleNo);
	stmt.setString(6, schedulePw);
	
	//디버깅
	System.out.println(stmt + "<-- updateScheduleAction stmt");
	
	// scheduleNo는 int 타입
	int row = stmt.executeUpdate();	
	System.out.println(row + "<-updateScheduleAction / row");
	
	//수정 성공에 따른 리다이렉션
	
	if(row == 0){ //수정 실패한 경우
	response.sendRedirect("./scheduleListByDate.jsp?scheduleDate=" + scheduleDate);
	} else { //수정 성공한 경우
		response.sendRedirect("./scheduleList.jsp?scheduleDate=" + scheduleDate);
		
	}

%>
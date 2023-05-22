<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
		if(request.getParameter("scheduleNo") == null){
			response.sendRedirect("./scheduleList.jsp");
			return;
		}
	//schedule No 받아서 변수에 저장하기
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	//DB연동하는 코드
	//드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	//디버깅체크~
	System.out.println("scheduleOne 드라이버 로딩 성공했어");
	//마리아 디비 연결 유지해줍니다.
	Connection conn = null;
	System.out.println("접속 확인"+conn);
	conn = DriverManager.getConnection( //마리아 디비 가져오기
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	//sql변수에 쿼리 값 저장
	String sql = "select schedule_no, schedule_date, schedule_time, schedule_memo, schedule_color, createdate,updatedate from schedule where schedule_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, scheduleNo);
	System.out.println(stmt + " <-- scheduleOne stmt"); 
	ResultSet rs = stmt.executeQuery(); 
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>scheduleOne</title>
</head>
<body>
<div><!-- 메인메뉴 -->
        <a href="./home.jsp" class="btn btn-outline-primary">홈으로</a>
		<a href="./noticeList.jsp" class="btn btn-outline-primary">공지 리스트</a>
		<a href="./scheduleList.jsp" class="btn btn-outline-primary">일정 리스트</a>
	</div>
	<h1 class="alert alert-danger">스케줄 상세보기</h1>
	<%
		if(rs.next()){
	%>
		<table class="table table-striped">
			<tr>
				<td>스케줄번호</td>
				<td><%=rs.getInt("schedule_no")%></td>
			</tr>
			<tr>
				<td>스케줄날짜</td>
				<td><%=rs.getString("schedule_date")%></td>
			</tr>
			<tr>
				<td>시간</td>
				<td><%=rs.getString("schedule_time")%></td>
			</tr>
			<tr>
				<td>메모</td>
				<td><%=rs.getString("schedule_memo")%></td>
			</tr>
			<tr>
				<td>색상</td>
				<td><%=rs.getString("schedule_color")%></td>
			</tr>
			<tr>
				<td>만든날</td>
				<td><%=rs.getString("createdate")%></td>
			</tr>
			<tr>
				<td>수정날</td>
				<td><%=rs.getString("updatedate")%></td>
			</tr>
		</table>
	<%		
		}
	%>
	<div>
		<a href="./updateScheduleForm.jsp?scheduleNo=<%=scheduleNo%>" class="btn btn-outline-primary">수정</a> <!--  물음표 뒤에 있는 값을 보내준다 -->
		<a href="./deleteScheduleForm.jsp?scheduleNo=<%=scheduleNo%>" class="btn btn-outline-primary">삭제</a> <!--  물음표 뒤에 있는 값을 보내준다 -->
	</div>
</body>
</html>
[출처] updateScheduleForm, updateScheduleAction, deleteScheduleForm, deleteSchduleAction(scheduleOne추가) (자바 교실) | 작성자 GDJ66 권원중
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %> 


<%
	//유효성 검사
	if(request.getParameter("scheduleNo") == null
			|| request.getParameter("scheduleNo").equals("")) { //해당값이 들어오면
		response.sendRedirect("./scheduleList.jsp");
		return; //코드 진행 종료 
	} 
	//scheduleNo 가져오기
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo")); 
	
		//확인
	System.out.println(scheduleNo +"<--updatescheduleForm / scheduleNo 값 확인");

	
	//db연결
	Class.forName("org.mariadb.jdbc.Driver"); //error : Parameter at position 2 is not set
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select schedule_no scheduleNo, schedule_date scheduleDate, schedule_time scheduleTime, schedule_memo scheduleMemo, schedule_color scheduleColor, createdate, updatedate from schedule where schedule_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);

	stmt.setInt(1, scheduleNo);
	System.out.println(stmt + " <-- scheduleOne stmt"); 
	ResultSet rs = stmt.executeQuery(); 
	
	//ResultSet -> ArrayList<schedule>
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	while(rs.next()){
		Schedule s = new Schedule();
		s.scheduleNo = rs.getInt("scheduleNo");
		s.scheduleTime = rs.getString("scheduleTime");
		s.scheduleDate = rs.getString("scheduleDate"); //전체 날짜가 아닌 월만
		s.scheduleMemo = rs.getString("scheduleMemo"); //전체 메모가 아닌 5글자만
		s.scheduleColor = rs.getString("scheduleColor");
		scheduleList.add(s);
		
	}

%>

<!DOCTYPE html>
<html>
<head>
    <!-- 부트스트랩 코드 복사 붙여넣기 // 안 하면 페이지 구현 안 됨 -->
    <!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	
       
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>HOME</title>
        
        <!-- 노란색 바탕의 테마가 적용되어야 하는데 안 됨 -->
        
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Simple line icons-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.5.5/css/simple-line-icons.min.css" rel="stylesheet" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    
    <body id="page-top">
        <!-- Navigation-->
        <a class="menu-toggle rounded" href="./home.jsp"><i class="fas fa-bars"></i></a>
        <nav id="sidebar-wrapper">
            <ul class="sidebar-nav">
            	
            	<!-- 메인메뉴 -->
            	<!-- 메뉴바만 보이고 내용은 숨겨야하는데 안 됨 -->
            	
                <li class="sidebar-brand"><a href="./home.jsp">홈으로</a></li>
                <li class="sidebar-nav-item"><a href="./noticeList.jsp">공지 리스트</a></li>
                <li class="sidebar-nav-item"><a href="./scheduleList.jsp">일정 리스트</a></li>

            </ul>
        </nav>
    <!-- Header-->
    <header class="masthead d-flex align-items-center">
	
	<!-- 수정해야 할 것 : schedule_memo, schedule_color-->
 	<div class="container px-4 px-lg-5 text-center">
                <h1 class="mb-1">일정 수정</h1>
                <h3 class="mb-5"><em>:)</em></h3>
    <form action="./updateScheduleAction.jsp" method = "post">
		<table class=" table table-hover">
		<%
			for(Schedule s:scheduleList){
				
		%>	
			
			
			<tr>
				<td>no</td>
				<td><%=s.scheduleNo%></td>
			</tr>
			<tr>
				<td>date</td>
				<td><%=s.scheduleDate%></td>
			</tr>
			<tr>
				<td>time</td>
				<td><input type="time" value="<%=s.scheduleTime%>"></td>
			</tr>
			<tr>
				<td>memo</td>
				<td><textarea row="3" cols="30" value ="<%=s.scheduleMemo%>"></textarea></td>
			</tr>
			<tr>
				<td>color</td>
				<td><input type="color" value="<%=s.scheduleColor%>"></td>
			</tr>
		

			<tr>
				<td colspan="2">
					<button type="submit" class="btn btn-primary btn-xl" href="./noticeList.jsp">수정</button></td>
			
			</tr>
		
		
		
		<%
		
			}
		%>
			
		</table>
		</form>
		</div>
	 </header>
	

	
</body>
</html>
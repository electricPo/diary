<%@page import="javax.print.attribute.standard.PresentationDirection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	// y, m, d 값이 null or "" -> redirection scheduleList.jsp
	
	int y = Integer.parseInt(request.getParameter("y"));
	// 자바API에서 12월 11, 마리아DB에서 12월 12
	int m = Integer.parseInt(request.getParameter("m")) + 1;
	int d = Integer.parseInt(request.getParameter("d"));

	
	System.out.println(y + " <-- scheduleListByDate param y");
	System.out.println(m + " <-- scheduleListByDate param m");
	System.out.println(d + " <-- scheduleListByDate param d");
	
	String strM = m+"";
	if(m<10) {
		strM = "0"+strM;
	}
	String strD = d+"";
	if(d<10) {
		strD = "0"+strD;
	}
	
	// 일별 스케줄 리스트
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select * from schedule where schedule_date = ? order by schedule_time asc";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, y+"-"+strM+"-"+strD);
	System.out.println(stmt + " <-- scheduleListByDate stmt");
	ResultSet rs = stmt.executeQuery();
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
        <title>일정 상세</title>
        
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
<body>
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
	<p>
	<h1 class="mb-1 text-center">일정상세</h1>
	</p>
	<header class="masthead d-flex align-items-center">
	
    <div class="container px-4 px-lg-5 text-center">
           
	<form action="./insertScheduleAction.jsp" method="post">
		<table class=" table table-hover" >
					<tr>
						<th>date</th>
						<td><input type="date" name="scheduleDate" 
									value="<%=y%>-<%=strM%>-<%=strD%>" 
									readonly="readonly"></td>
					</tr>
					<tr>
						<th>time</th>
						<td><input type="time" name="scheduleTime"></td>
					</tr>
					<tr>
						<th>color</th>
						<td>
							<input type="color" name="scheduleColor" value="#00000">
						</td>
					</tr>
					<tr>
						<th>memo</th>
						<td><textarea cols="80" rows="3" name="scheduleMemo"></textarea></td>
					</tr>
				</table>
				<button type="submit" class="btn btn-primary btn-xl">스케줄 입력</button>
			</form>

            </div>
       		</header>
		<br>
	<section class="content-section bg-light" id="about">
            <div class="container px-4 px-lg-5 text-center">
                <div class="row gx-4 gx-lg-5 justify-content-center">
				<div class="col-lg-10">	
					<h1><%=y%>년 <%=m%>월 <%=d%>일 스케줄 목록</h1>
					<table>
						<tr>
							<th>time</th>
							<th>memo</th>
							<th>createdate</th>
							<th>updatedate</th>
							<th>수정</th>
							<th>삭제</th>
						</tr>
						<%
							while(rs.next()) {
						%>
						<tr>
							<td><%=rs.getString("schedule_time")%></td>
							<td><%=rs.getString("schedule_memo")%></td>
							<td><%=rs.getString("createdate")%></td>
							<td><%=rs.getString("updatedate")%></td>
							<td><a  class="btn btn-dark btn-xl" href="./updateScheduleForm.jsp?scheduleNo=<%=rs.getString("schedule_no")%>">수정</a></td>
							<td><a  class="btn btn-dark btn-xl" href="./deleteScheduleForm.jsp?scheduleNo=<%=rs.getString("schedule_no")%>">삭제</a></td>
						</tr>
						<%		
							}
						%>
					</table>
				</div>
			</div>
		</div>
	</section>
	
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %> 
<%
		
		//select notice_no, notice_title, createdate from notice order by createdate desc limit 0,5
		//0부터 5개
		
		//드라이브 로딩
			Class.forName("org.mariadb.jdbc.Driver");

		//db에 접속
			Connection conn  = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
			String sql1 = "select notice_no noticeNo, notice_title noticeTitle, createdate from notice order by createdate desc limit 0,5";
			PreparedStatement stmt1 = conn.prepareStatement(sql1);

			System.out.println(stmt1 +"<--stmt1");
		//ResultSet은 나중에 어레이리스트로 변환
		
			ResultSet rs1 = stmt1.executeQuery();
		
		//ResultSet -> ArrayList<Notice>
			ArrayList<Notice> noticeList = new ArrayList<Notice>(); //한 행이 하나의 notice
				while(rs1.next()){
					Notice n = new Notice();
					n.noticeNo = rs1.getInt("noticeNo");
					n.noticeTitle = rs1.getString("noticeTitle");
					n.createdate = rs1.getString("createdate");
					noticeList.add(n);
				}
				
				
		
		//오늘 일정 // 날짜, 메모 일부, 시간순
		/* 쿼리
		SELECT schedule_no, schedule_date, schedule_memo, substr(schedule_memo,1,10) memo
		FROM SCHEDULE
		WHERE schedule_date = CURDATE() ;
		ORDER BY SCHEDULE-TIME ASC ;
		*/
		/*
		오류메세지:SQLTransientConnectionException: (conn=1559) Parameter at position 1 is not set
		String sql2 = "select schedule_no scheduleNo, day(schedule_date) scheduleDate, substr(schedule_memo, 1,5) scheduleMemo, schedule_color scheduleColor from schedule where year(schedule_date) = ? and month(schedule_date) = ? order by month(schedule_date) asc";
		
		
		
		String sql2 = "select schedule_no scheduleNo, schedule_date scheduleDate, schedule_time scheduleTime, substr(schedule_memo,1,10) scheduleMemo from schedule where schedule_date = curdate() order by schedule_time asc";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		
		
		System.out.println(stmt2 +"<--stmt2"); // 출력 확인
		ResultSet rs2 = stmt2.executeQuery();
		
		
		
		
		//ResultSet -> ArrayList<schedule>
		ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
		while(rs2.next()){
			Schedule s = new Schedule();
			s.scheduleNo = rs2.getInt("scheduleNo");
			s.scheduleDate = rs2.getString("scheduleDate"); //전체 날짜가 아닌 월만
			s.scheduleMemo = rs2.getString("scheduleMemo"); //전체 메모가 아닌 5글자만
			s.scheduleColor = rs2.getString("scheduleColor");
			scheduleList.add(s);
			
		}
		*/
		
		String sql2 = "select schedule_no scheduleNo, schedule_date scheduleDate, schedule_time scheduleTime, substr(schedule_memo,1,10) scheduleMemo from schedule where schedule_date = curdate() order by schedule_time asc";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		System.out.println(stmt2 + " <-- stmt2");
		ResultSet rs2 = stmt2.executeQuery();  
		ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
			while(rs2.next()){
			  Schedule s = new Schedule(); //rs 의 개수만큼 만들어줌
			  s.scheduleNo = rs2.getInt("scheduleNo");
			  s.scheduleDate = rs2.getString("scheduleDate"); // 전체 날짜가 아닌 월만
			  s.scheduleTime = rs2.getString("scheduleTime"); 
			  s.scheduleMemo = rs2.getString("scheduleMemo");//전체 메모가 아닌 설정값만
			  scheduleList.add(s);
			}


%>



<!DOCTYPE html>
<html lang="en">
    <head>
    <!-- 부트스트랩 코드 복사 붙여넣기 // 안 하면 페이지 구현 안 됨 -->
    <!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	
     <!-- !!!!!!!!!부트스트랩 템플릿 -->  
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
            <div class="container px-4 px-lg-5 text-center">
                <h1 class="mb-1">공지사항</h1>
                <h3 class="mb-5"><em>날짜순 최근 공지 5개</em></h3>
                	<table class=" table table-hover" >
							
								<tr>
									<th>
									notice_title
									</th>
									<th>
									createdate
									</th>
								</tr>
							
							
							<%
							for(Notice n:noticeList) {
							%>
								<tr>
									<td>
									<a href="./noticeOne.jsp?noticeNo=<%=n.noticeNo%>">
									<%=n.noticeTitle%>
									</a>
									</td>
									<td><%=n.createdate.substring(0, 10)%></td> <!-- 날짜 시간 자르기(substirng): 0부터 10까지 살림 -->
								</tr>
							<%
								}
							
							%>
							
						</table>
                <a class="btn btn-primary btn-xl" href="./noticeList.jsp">공지사항 리스트로 가기</a>
            </div>
        </header>
        
        <!-- About-->
        <section class="content-section bg-light" id="about">
            <div class="container px-4 px-lg-5 text-center">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-lg-10">
        				<!-- 격언 넣음 -->
                    	<p>
                        <h2>머피의 법칙은 당신의 프로젝트를 피해가지 않는다. </h2>
                        </p>
        <!-- 일정페이지 -->  
                        <h1 class="mb-5"><em>최신 일정</em></h1>
                	<table class=" table table-hover" >
							
								<tr>
									<th>
									schedule_date
									</th>
									<th>
									schedule_time
									</th>
									<th>
									schedule_memo
									</th>
								</tr>
							<%
							for(Schedule s:scheduleList) {
							%>
									 <tr>
						           		 <td>
						               	<%=s.scheduleDate%>
						          		</td>
						            	<td><%=s.scheduleTime%></td>
						           		 <td>
						              	 <a href="./scheduleListByDate.jsp?scheduleMemo=<%=s.scheduleMemo%>"></a>
						            	</td>
						         	</tr>

							<%
								}
							
							%>
							
						</table>
                        <a class="btn btn-dark btn-xl" href="./scheduleList.jsp">일정리스트로 가기</a>
                    </div>
                </div>
            </div>
        </section>
        

    </body>
</html>

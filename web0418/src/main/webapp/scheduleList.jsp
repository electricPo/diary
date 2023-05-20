<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %> <!-- 자바의 모든 클래스 불러오기 -->
<%
	//날짜 클릭하면 새 페이지로 넘어감 // 스케줄 입력 폼(추가 기능) // 달력 밑에 일정의 일부 나오게 // 오늘 날짜가 달력에 표시되게


	//달력 불러오기
	//아무것도 안 불러왔을 때 오늘 날짜 불러오기
	
	int targetYear = 0;
	int targetMonth = 0;
	
	//년 or 월이 요청값에 넘어오지 않으면 오늘 날짜의 년과 월 불러오기
	if(request.getParameter("targetYear") == null 
		|| (request.getParameter("targetMonth") == null)){
		
		Calendar c = Calendar.getInstance(); //특이점: 달력은 new 생성자를 쓰지 않고 getInstance로 객체를 만듦
		targetYear = c.get(Calendar.YEAR);  //month의 숫자는 출력할 때 +1 해준다(알고리즘 망가짐 주의)
		targetMonth = c.get(Calendar.MONTH);
	}	else{
		
			targetYear = Integer.parseInt(request.getParameter("targetYear"));
			targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
			
	}//if-else문 닫기
		
	System.out.println(targetYear + "<-scheduleList/param/targetYear");
	System.out.println(targetMonth + "<-scheduleList/param/targetMonth");
	
	//오늘날짜 
	
	Calendar today = Calendar.getInstance();
	int todayDate = today.get(Calendar.DATE);
	
	// targetMonth 1일
	
	Calendar firstDay = Calendar.getInstance(); //ex) 2023 04 24
	firstDay.set(Calendar.YEAR, targetYear); // 현재 보고싶은 달력의 연도
	firstDay.set(Calendar.MONTH, targetMonth); // 현재 보고싶은 달력의 달
	firstDay.set(Calendar.DATE, 1); //강제로 1로 바꿈  //-> 2023 04 01
	
				//23년 12월을 입력하면 캘린더 API가 24년 1월로 바꿈
				//23년 -1월을 입력하면			22년 12월로 바꿈
			targetYear = firstDay.get(Calendar.YEAR);
			targetMonth = firstDay.get(Calendar.MONTH);
	
	//targetMonth 1일의 요일
	int firstYoil = firstDay.get(Calendar.DAY_OF_WEEK); // 2023 04 01 이 몇번째 요일인지 구함 (일요일=1 , 토요일=7)
	
	//1일앞의 blank 수를 구한다 (일요일 =0, 토요일 =6)
	int startBlank = firstYoil - 1 ;
	
	System.out.println(startBlank + "<-scheduleList/ startBlank");
	
	
	// targetMonth 마지막일
	int lastDate = firstDay.getActualMaximum(Calendar.DATE); //firstDay를 가진 달의 할당 가능한(actual) 가장 큰 숫자
	
	System.out.println(lastDate + "<-scheduleList/ lastDate");
	
	// lastDate 날짜 뒤 blank 수를 구한다 // 전체 td의 갯수 % 7 = 0
	
		//(lastDate + ?) %7 == 0;
	int endBlank = 0; //임의의 수 설정

	if((startBlank + lastDate ) % 7 != 0) {
		endBlank = 7 - (startBlank + lastDate)%7;
	}
	
	//전체 TD의 개수
	int totalTD = startBlank + lastDate + endBlank ;
	
	System.out.println(totalTD + "<-scheduleList/ totalTD");
	
	//db data를 가져오는 알고리즘
	Class.forName("org.mariadb.jdbc.Driver");
	//db에 접속
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	/*
		select schedule_no scheduleNo, day(schedule_date) scheduleDate, substr(schedule_memo, 1,5) scheduleMemo , schedule_color scheduleColor
		from schedule
		where year(schedule_date) = ? and month(schedule_date) = ?
		order by month(schedule_date) asc;
	*/
	PreparedStatement stmt = conn.prepareStatement("select schedule_no scheduleNo, day(schedule_date) scheduleDate, substr(schedule_memo, 1,5) scheduleMemo, schedule_color scheduleColor from schedule where year(schedule_date) = ? and month(schedule_date) = ? order by month(schedule_date) asc");
	stmt.setInt(1, targetYear);
	stmt.setInt(2, targetMonth+1);
	
	System.out.println(stmt +"<--stmt");
	ResultSet rs = stmt.executeQuery();
	
	//ResultSet -> ArrayList<schedule>
	
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	while(rs.next()){
		Schedule s = new Schedule();
		s.scheduleNo = rs.getInt("scheduleNo");
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

	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

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
	<h1><%=targetYear%>년 <%=targetMonth+1%>월</h1> 
	<!-- 알고리즘 깨짐 방지 -> 출력할 때 달을 +1 해준다 -->
	
	<div>
		<a href ="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth-1%>" class="btn btn-primary btn-xl">이전달</a> <!-- targetYear는 그대로 넘겨줌 -->
		<a href ="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth+1%>" class="btn btn-primary btn-xl">다음달</a>
	
	</div>
	
	<table class=" table table-hover" > <!-- 스타일로 테이블 속성 주기 -->
		<tr>
			<%
				for(int i=0; i<totalTD; i+=1) {//1부터 시작하면 7을 찍고 tr이 추가되어서 식이 바뀜
					int num = i-startBlank+1;
						
					if(i!=0 && i%7==0) {
			%>
					</tr><tr>
			<%
					} //if문 닫기
					
				 	String tdStyle = "";
					if(num>0 && num<=lastDate) {   //IF1  // 오늘 날짜이면 배경색 주황색으로 바꾸기
		                  if(today.get(Calendar.YEAR) == targetYear //IF2
		                     && today.get(Calendar.MONTH) == targetMonth
		                     && today.get(Calendar.DATE) == num) {
		    				tdStyle = "background-color:orange;";
		                  }
		   %>
		                  <td style="<%=tdStyle%>">
		                  	<div><!-- 날짜 숫자 -->
		               
		                  	<a href="./scheduleListByDate.jsp?y=<%=targetYear%>&m=<%=targetMonth%>&d=<%=num%>"><%=num%></a>
		                  	</div>
		                  	<div><!-- 일정 memo -->
		                  		<% 
		                  			for(Schedule s : scheduleList){
		                  					if(num == Integer.parseInt(s.scheduleDate)){
		                  		%>
		                  				<div style="color:<%=s.scheduleColor%>"><%=s.scheduleMemo%></div>
		                  		<%		
		                  					}
		                  				}
		                  		
		                  		%>

		                  	</div>
		                  	</td>      
		   <%   
	                   //IF2 닫기
	               } else {
	       %>
	                  <td>&nbsp;</td> <!-- 달력 날짜에 해당하지 않으면 공백으로 두기 -->
	       <%         
	               }//IF1 닫기
	            } //FOR 닫기
	       %>
	      </tr>
   </table>
</body>
</html>
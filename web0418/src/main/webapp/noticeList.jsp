<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %> <!-- 내가 만든 패키지 -->

<%
	//요청 분석(currentPage, ...)
	
	//현재패이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+"<--currentPage");
	
	//페이지당 출력할 행의 수
	
	int rowPerPage = 10 ;
	
	//시작 행번호
	
	int startRow =  (currentPage-1)*rowPerPage;
	
	//int startRow = 0; //startRow : 페이지에 따라 변함
	
			/*
			currentPage		startRow(rowPerPage가 10일 때)
			1				0	<--(currenPage-1)*rowPerPage
			2				110
			3				20
			4				30
			*/
	
	//DB연결 설정
	
		//select notice_no, notice_title, createdate from notice order by createdate desc limit ?,?
		//0부터 10개
		
		//드라이브 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		//db에 접속
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
		PreparedStatement stmt = conn.prepareStatement("select notice_no noticeNo, notice_title noticeTitle, createdate from notice order by createdate desc limit ?,?");
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(stmt +"<--stmt");
		//ResultSet은 나중에 어레이리스트로 변환
		
		//출력할 공지 데이터
		ResultSet rs = stmt.executeQuery();
		//자료구조 ResultSet 타입을 일반적인 타입(자바 배열 or 기본 API 자료구조 타입 : List, Set, Map)
		
		//ResultSet -> ArrayList<Notice>
		ArrayList<Notice> noticeList = new ArrayList<Notice>(); //한 행이 하나의 notice
		while(rs.next()){
			Notice n = new Notice();
			n.noticeNo = rs.getInt("noticeNo");
			n.noticeTitle = rs.getString("noticeTitle");
			n.createdate = rs.getString("createdate");
			noticeList.add(n);
		}
		
		//마지막 페이지
		//select count(*) from notice
		PreparedStatement stmt2 = conn.prepareStatement("select count(*) from notice");
		ResultSet rs2 = stmt2.executeQuery();
		
		
%>

<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>공지사항 리스트</title>
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
                <h1 class="mb-1">공지사항 리스트</h1>
				<table class="table table-hover" >
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
				<%=n.noticeTitle %>
				</a>
				</td>
				<td><%=n.createdate.substring(0, 10)%></td> <!-- 날짜 시간 자르기(substirng): 0부터 10까지 살림 -->
			</tr>
		<%
			} //for문 닫음
		
		
		%>
		
	</table>
	
	
	
	<%
		if(currentPage >1 ){
	%>
			<a href="./noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
	<%		
			
		
		}
		int totalRow = 500; //SQL에서 SELECT COUNT(*) FROM notice; 
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0){
			lastPage = lastPage + 1;
		}
	%>
			<%=currentPage %>
	<%	
		if(currentPage < lastPage){
	%>
		
	<a href="./noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
	<%
		}
	
	%>
	
	
</body>
</html>
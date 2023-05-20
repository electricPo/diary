<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	
	//리퀘스트 요청값에 대한 유효성 검사
	if(request.getParameter("scheduleNo") == null) {
		response.sendRedirect("./scheduleList.jsp");
		return; //코드 진행 종료
	} 

	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	
	//디버깅
	System.out.println(scheduleNo+"<--deleteNoticeForm/param/noticeNo"); //디버깅 양식: 파일제목/변수/값
	
	
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
            <div class="container px-4 px-lg-5 text-center">
                <h1 class="mb-1">일정삭제</h1>
                <h3 class="mb-5"><em>:(</em></h3>
				<form action="./deleteScheduleAction.jsp" method="post">
					<table class=" table table-hover">
						<tr>
							<td>schedule_no</td>
							<td>
							
							<input type="text" name="scheduleNo" value="<%=scheduleNo%>" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>notice_pw</td>
							<td>
								<input type="text" name="schedulePw">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="submit">삭제</button>
							</td>
						</tr>
					</table>
				</form>
				</div>
		</header>
</body>
</html>


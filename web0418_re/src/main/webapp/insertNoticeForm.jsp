<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<h1  class="mb-1">공지 입력</h1>
				<form action="./insertNoticeAction.jsp" method="post">
					<table class=" table table-hover" >
						<tr>
							<td>notice_title</td>
							<td>
								<input type="text" name="noticeTitle">
							</td>
						</tr>
						
						<tr>
							<td>notice_content</td>
							<td><textarea row="5" cols="80" name="noticeContent"></textarea></td>
						</tr>
						
						<tr>
							<td>notice_writer</td>
							<td><input type="text" name="noticeWriter"></td>
						</tr>
						
						<tr>
							<td>notice_pw</td>
							<td><input type="password" name="noticePw"></td>
						</tr>
						
						<tr>
							<td colspan="2">
								<button type="submit" class="btn btn-primary btn-xl" href="./noticeList.jsp">입력</button>
							</td>
						</tr> <!-- 입력하고 나면?-->
					</table>
				</form>
			</div>
		</header>	
	
	
</body>
</html>
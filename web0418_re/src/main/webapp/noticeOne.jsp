<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>

<%
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect("./noticeList.jsp");
		return; //코드 진행 종료 , 반환값을 남길 때( else 블럭 절약)
	} 
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));   //키명은 카멜로
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	String sql = "select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate from notice where notice_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql); //'?'때문에 미완성된 스테이트먼트가 됨
	stmt.setInt(1, noticeNo);//stmt의 '첫번째' 물음표값을 noticeNo로 바꿈, 문자열인 경우 String 붙어야 함
	
	System.out.println(stmt +"<--stmt");
	//ResultSet은 나중에 어레이리스트로 변환
	
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
                <h1 class="mb-1">공지 상세</h1>
				
				<%
					if(rs.next()){ //rs 값이 있으면 출력한다
				%>
						<table class=" table table-hover" >
					
							<tr>
								<td>notice_no</td>
								<td><%=rs.getInt("notice_no") %></td>
							</tr>
							
							<tr>
								<td>notice_title</td>
								<td><%=rs.getString("notice_title") %></td>
							</tr>
							
							<tr>
								<td>notice_content</td>
								<td><%=rs.getString("notice_content") %></td>
							</tr>
							
							<tr>
								<td>notice_writer</td>
								<td><%=rs.getString("notice_writer") %></td>
							</tr>
							
							<tr>
								<td>createdate</td>
								<td><%=rs.getString("createdate") %></td> <!-- date는 String 타입 -->
							</tr>
							
							<tr>
								<td>updatedate</td>
								<td><%=rs.getString("updatedate") %></td>
							</tr>
					</table>
	<%		
		}
	
	%>
								
					<!-- 수정, 삭제 링크 만들기 -->
					<div>
						<a href="./updateNoticeForm.jsp?noticeNo=<%=rs.getInt("notice_no") %>" class="btn btn-dark btn-xl">수정</a>
						<a href="./deleteNoticeForm.jsp?noticeNo=<%=rs.getInt("notice_no") %>" class="btn btn-dark btn-xl">삭제</a> <!-- 비밀번호를 입력해서 삭제하게 -->
					</div>
				</div>
			</header>
	
</body>
</html>
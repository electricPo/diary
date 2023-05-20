<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>

<% 
	//유효성 코드 추가 -> 분기(리스폰스 리다이렉션) -> 리턴으로 종료
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect("./noticeList.jsp");
		return; //코드 진행 종료 , 반환값을 남길 때( else 블럭 절약)
	} 
	
	
	//noticeNo 가져오기
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));   //키명은 카멜로
		//확인
	System.out.println(noticeNo +"<--updateNoticeForm / noticeNo 값 확인");
	
	//드라이버 연결
	Class.forName("org.mariadb.jdbc.Driver");
		//확인
	System.out.println("드라이버 연결 확인");
		
	//db연결
	Connection conn = DriverManager.getConnection(
				"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	String sql = "select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate from notice where notice_no = ?"; 
	//수정 안 할 값은 빼도O
	PreparedStatement stmt = conn.prepareStatement(sql); //'?'때문에 미완성된 스테이트먼트가 됨
	
	//?에 값 넣기		
	stmt.setInt(1, noticeNo);//stmt의 '첫번째' 물음표값을 noticeNo로 바꿈, 문자열인 경우 String 붙어야 함
	
	System.out.println(stmt +"<--stmt");
	//ResultSet은 나중에 어레이리스트로 변환
	
	ResultSet rs = stmt.executeQuery();
	
	//rs.next(); //if문을 사용해야
	
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
			<h1 class="mb-1">수정폼</h1>
	<% 
		if(request.getParameter("msg") != null){
			
	%>
			action페이지로 잘못된 접근이거나 null, 공백을 넘겼다
	<% 
		}
	
	%>
	
	</div>
	<form action="./updateNoticeAction.jsp" method="post"> 
		<table  class=" table table-hover">
			<%
				while(rs.next()) {
			%>
			<tr>
				<td>notice_no</td>
				<td>
					<input type="number" name="noticeNo" value="<%=rs.getInt("notice_no")%>" readonly = readonly>
				</td>
			</tr>
			
			<tr>
				<td>notice_pw</td> <!-- 수정 가능한 항목 -->
				<td>
					<input type="password" name="noticePw">
				</td>
			</tr>
			
			
			<tr>
				<td>notice_title</td> <!-- 수정 가능한 항목 -->
				<td>
					<input type="text" name="noticeTitle" value="<%=rs.getString("notice_title")%>"> 
				</td>
			</tr>
			
			
			<tr>
				<td>notice_content</td> <!-- 수정 가능한 항목 -->
				<td>
					<textarea rows="5" cols="80" name="noticeContent" >
						<%=rs.getString("notice_content")%>
					</textarea> <!-- textarea 닫기... -->
				</td>
			</tr>
			
			<tr>
				<td>notice_writer</td>
				<td>
					<%=rs.getString("notice_writer")%>
				</td>
			</tr>
			
			<tr>
				<td>createdate</td>
				<td>
					<%=rs.getString("createdate")%> <!-- 폼요소가 아니라 액션으로 넘어가지 않음/ createdate는 now로 -->
				</td>
			</tr>
			
			<tr>
				<td>updatedate</td>
				<td>
					<%=rs.getString("updatedate")%> <!-- 폼요소가 아니라 액션으로 넘어가지 않음/ updatedate는 now로 -->
				</td>
			</tr>
			<%
				}
			%>
			
		
		</table>	
		<div>
			<button type="submit" class="btn btn-primary btn-xl">수정</button> <!-- name요소들이 action으로 넘어감 -->
		</div>
		</header>
	
	</form>
</body>
</html>
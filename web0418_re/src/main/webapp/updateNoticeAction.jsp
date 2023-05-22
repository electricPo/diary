<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>



<%
	//유효성검사
	
	//error: 수정 불가
	//해결: println으로 "noticeContent"가 null값임을 발견
	//		textarea 앞 "이 누락되어 있었음
		
		System.out.println(request.getParameter("noticeNo"));
		System.out.println(request.getParameter("noticePw"));
		System.out.println(request.getParameter("noticeTitle"));
		System.out.println(request.getParameter("noticeContent"));

	
	if(request.getParameter("noticeNo")==null	//해당값이면 (잘못된 정보 입력)
		||request.getParameter("noticePw")==null
		||request.getParameter("noticeTitle")==null
		||request.getParameter("noticeContent")==null
		
		||request.getParameter("noticeNo").equals("")
		||request.getParameter("noticePw").equals("")
		||request.getParameter("noticeTitle").equals("")
		||request.getParameter("noticeContent").equals("")){
		
		response.sendRedirect("./updateNoticeForm.jsp"); //다시 수정 폼으로 이동
		return;
	}

	//값들을 db 테이블에 입력
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticePw = request.getParameter("noticePw");
	String noticeContent = request.getParameter("noticeContent");
	
	//디버깅
	System.out.println(noticeTitle +"<-/updateNoticeAction/param/noticeTitle");
	System.out.println(noticePw +"<-/updateNoticeAction/param/noticePw");
	System.out.println(noticeContent +"<-/updateNoticeAction/param/noticeContent");
	System.out.println(noticeNo +"<-/updateNoticeAction/param/noticeNo");
	
	
	//드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
		//확인
	System.out.println("드라이버 로딩");
	
	
	Connection conn = DriverManager.getConnection(
	      "jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	//쿼리 명령문
	String sql = "update notice set notice_title=?, notice_content=?, updatedate=now() where notice_no=? and notice_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	
	// ? 4개(1~4)
	stmt.setString(1, noticeTitle);
	stmt.setString(2, noticeContent);
	stmt.setInt(3, noticeNo);
	stmt.setString(4, noticePw);
	
	// noticeNo는 int 타입
	
	System.out.println(stmt+ "<-updateNoticeAction / row");
	
	//쿼리 진행 확인
	int row = stmt.executeUpdate(); // 디버깅 1(ex:2)이면 1행(ex:2행)입력성공, 0이면 입력된 행이 없다
	
	// row값을 이용한 디버깅
	System.out.println(row+"<-row");
	
	//수정 성공에 따른 리다이렉션
	
	if(row == 0){ //수정 실패한 경우
	response.sendRedirect("./updateNoticeForm.jsp?noticeNo=" + noticeNo);
	} else { //수정 성공한 경우
		response.sendRedirect("./noticeOne.jsp?noticeNo=" + noticeNo);
		
	}
%>
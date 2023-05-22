<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
   //post방식 인코딩 처리
   request.setCharacterEncoding("utf-8"); //post 방식의 인코딩 처리

   // validation(요청 파라미터값 유효성 검사)
   if(request.getParameter("noticeTitle") == null 
         || request.getParameter("noticeContent") == null   
         || request.getParameter("noticeWriter") == null
         || request.getParameter("noticePw") == null
         || request.getParameter("noticeTitle").equals("")
         || request.getParameter("noticeContent").equals("")
         || request.getParameter("noticeWriter").equals("")
         || request.getParameter("noticePw").equals("")) {
      
      response.sendRedirect("./insertNoticeForm.jsp");
      return;
   }
   String noticeTitle = request.getParameter("noticeTitle");
   String noticeContent = request.getParameter("noticeContent");
   String noticeWriter = request.getParameter("noticeWriter");
   String noticePw = request.getParameter("noticePw");
   // 값들을 DB 테이블 입력
   
   //디버깅
	System.out.println(noticeTitle+"<-noticeTitle");
   
   /*
   insert into notice(notice_title, notice_content, notice_writer, notice_pw, createdate, updatedate) 
   values(?,?,?,?,now(),now())
   */
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = DriverManager.getConnection(
         "jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
   
   String sql = "insert into notice(notice_title, notice_content, notice_writer, notice_pw, createdate, updatedate) values(?,?,?,?,now(),now())";
   PreparedStatement stmt = conn.prepareStatement(sql);
   // ? 4개(1~4)
   stmt.setString(1, noticeTitle);
   stmt.setString(2, noticeContent);
   stmt.setString(3, noticeWriter);
   stmt.setString(4, noticePw);
   
   int row = stmt.executeUpdate(); // 디버깅 1(ex:2)이면 1행(ex:2행)입력성공, 0이면 입력된 행이 없다
   // row값을 이용한 디버깅
   System.out.println(row+"<-row");
   //conn.setAutoCommit(true); //오토커밋의 디폴트 값이 트루면 아래 코드 안 써도 됨
	//conn.commit(); //인서트인 경우 commit 필요(반영하기)
   // 다른페이지로 리다이렉트
   response.sendRedirect("./noticeList.jsp");
%>

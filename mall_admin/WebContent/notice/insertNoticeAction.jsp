<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	//레벨 2 이상 보안코드 넣기
	
	//인코딩
	request.setCharacterEncoding("UTF-8");
	//수집
	String managerId = request.getParameter("managerId");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	//디버깅
	System.out.printf("managerId: %s\n noticeTitle: %s\n noticeContent: %s\n",managerId, noticeTitle, noticeContent);
	//전처리
	Notice notice = new Notice();
	notice.setManagerId(managerId);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);

	//dao에서 호출
	NoticeDao.insertNotice(notice);
	
	//noticeList 재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
%>
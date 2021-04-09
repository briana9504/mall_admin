<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//인코딩
	request.setCharacterEncoding("UTF-8");
	//수집
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = manager.getManagerId();
	
	//디버깅
	System.out.printf("<deleteCommentAction.jsp> \n commentNo: %s\n managerId: %s\n noticeNo:%s\n",commentNo, managerId, noticeNo);
	
	//레벨에 따라 부르는게 다름
	if(manager.getManagerLevel() > 1){ // manager.managerLevel == 2 는 혹시 3이 생기면 유지보수 힘듬
		CommentDao.deleteComment(commentNo);
	} else if (manager.getManagerLevel() > 0){
		CommentDao.deleteComment(commentNo, managerId);
	}
	
	//재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>

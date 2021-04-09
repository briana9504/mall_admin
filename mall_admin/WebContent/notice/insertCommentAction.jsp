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
%>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
	//수집
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String commentContent = request.getParameter("commentContent");
	//디버깅
	System.out.printf("<insertCommentAction.jsp> \n noticeNo: %s\n commentContent: %s\n managerId: %s\n", noticeNo, commentContent, manager.getManagerId());
	//전처리(vo)
	Comment comment = new Comment();
	comment.setManagerId(manager.getManagerId());
	comment.setNoticeNo(noticeNo);
	comment.setCommentContent(commentContent);
	
	//CommentDao.insertcomment call
	CommentDao.insertComment(comment);
	
	//noticeOne 재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>
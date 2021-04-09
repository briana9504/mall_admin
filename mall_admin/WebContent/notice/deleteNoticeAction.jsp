<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*"%>
<%
	//레벨 2 이상 보안코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	//issue! comment가 있으면 지울 수 없음
	
	//수집
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	//디버깅
	System.out.printf("noticeNo: %s<deleteNoticeOneAction.jsp>\n",noticeNo);
	//noticeNo에 댓글이 있는지 없는지 확인
	//댓글이 있는 공지글인지 질문?
	int rowCnt = CommentDao.selectCommentCnt(noticeNo);
	if(rowCnt != 0){// 댓글 
		System.out.printf("%s 공지글의 댓글이 %s개 있습니다.", noticeNo,rowCnt);
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
		return;
	}
	
	//dao삭제 메서드 호출
	NoticeDao.deleteNotice(noticeNo);
	//list 재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
%>
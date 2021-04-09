<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*"%>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	//수집
	String ebookISBN = request.getParameter("ebookISBN");
	//디버깅
	System.out.printf("ebookISBN:%s<deleteEbookOne>\n",ebookISBN);
	//dao 삭제 메서드 호출
	EbookDao.deleteEbookOne(ebookISBN);
	//ebookList 재실행
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>

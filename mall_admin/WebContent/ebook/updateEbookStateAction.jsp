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
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookState =request.getParameter("ebookState");
	
	//디버깅
	System.out.printf("ebookISBN: %s\n ebookState: %s\n",ebookISBN,ebookState);
	
	//vo에 넣기
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookState(ebookState);
	
	//dao에서 호출
	EbookDao.updateEbookState(ebook);
	//ebookOne으로 돌아감
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>
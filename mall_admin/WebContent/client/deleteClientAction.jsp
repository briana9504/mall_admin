<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "gdu.mall.vo.*" %>
<%	
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if (manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	//수집코드 구현
	String clientMail = request.getParameter("clientMail");
	System.out.printf("clientMail: %s\n", clientMail);
	//dao에 삭제코드 구현
	ClientDao.deleteClient(clientMail);
	//clientList.jsp 재실행
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>
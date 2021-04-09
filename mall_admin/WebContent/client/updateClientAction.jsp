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
	String clientPw = request.getParameter("clientPw");
	System.out.printf("updateClientMail: %s\n, updateClientPw: %s\n",clientMail,clientPw);
	//dao에 수정코드 구현
	ClientDao.updateClientPw(clientMail,clientPw);
	
	//updateClientForm.jsp 재실행
	response.sendRedirect(request.getContextPath()+"/client/updateClientForm.jsp?clientMail="+clientMail);
%>
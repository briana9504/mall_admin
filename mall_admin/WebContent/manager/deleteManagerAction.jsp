<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.ManagerDao"%>
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
	//수집 코드 구현
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	
	System.out.printf("managerNo:%s\n",managerNo);
	//dao 삭제메서드 호출 코드 구현
	ManagerDao.deleteManager(managerNo);
	
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>
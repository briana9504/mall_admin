<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%	
	//1. 요청 수집(전처리)
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	
	System.out.printf("param managerId: %s\n param managerPw:%s\n",managerId,managerPw);
	//2. 처리
	Manager manager = ManagerDao.login(managerId, managerPw);
	if(manager != null){
		session.setAttribute("sessionManager",manager);
	}
	
	
	
	//3. 출력 or redirect(재요청)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
%>
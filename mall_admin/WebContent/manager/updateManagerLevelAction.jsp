<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.ManagerDao"%>
<%	
	//레벨2 manager 말고는 내쫓음
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
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	
	System.out.printf("managerNo:%s\n managerLevel:%s\n",managerNo,managerLevel);
	//dao 수정메서드 호출해서 코드 구현
	ManagerDao.updateManagerLevel(managerNo, managerLevel);
	
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>
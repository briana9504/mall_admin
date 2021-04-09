<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%	//레벨1이상 manager만 들어오도록
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if (manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%	
	//인코딩
	request.setCharacterEncoding("UTF-8");
	//수집
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	//디버깅
	System.out.printf("<upadteOrdersStateAction.jsp> \n ordersNo: %s\n ordersState: %s\n",ordersNo, ordersState);
	System.out.printf("<upadteOrdersStateAction.jsp> \n currentPage: %s\n rowPerPage: %s\n",currentPage, rowPerPage);
	//dao call
	OrdersDao.updateOrdersState(ordersNo, ordersState);
	//ordersList재실행
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp?currentPage="+currentPage+"&rowPerPage="+rowPerPage);
%>

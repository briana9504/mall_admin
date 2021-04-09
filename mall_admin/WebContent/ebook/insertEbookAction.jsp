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
<%	//issue isbn 중복 막기
	//관리자 인증 코드
	
	//인코딩
	request.setCharacterEncoding("UTF-8");
	//수집
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice =Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	
	//디버깅 확인
	System.out.printf("categoryName: %s\n ebookISBN: %s\n ebookTitle:%s\n ebookAuthor:%s\n ebookCompany:%s\n ebookpageCount:%s\n ebookPrice:%s\n ebookSummary:%s\n",categoryName,ebookISBN,ebookTitle,ebookAuthor,ebookCompany,ebookPageCount,ebookPrice,ebookSummary);
	
	//중복된 isbn 생성 불가 ebookDao에서 호출
	String returnebookISBN = EbookDao.checkEbookISBN(ebookISBN);//isbn 중복된지 확인 코드
	if(returnebookISBN != null){//사용중
		System.out.println("사용중인 ISBN 입니다.");
		response.sendRedirect(request.getContextPath()+"/ebook/insertEbookForm.jsp");
		return;
	}
	//전처리
	Ebook ebook = new Ebook();
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	
	EbookDao.insertEbook(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>
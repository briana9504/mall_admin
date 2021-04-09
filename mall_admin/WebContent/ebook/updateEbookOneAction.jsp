<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!-- 보안코드 넣기 -->
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
	int ebookNo =Integer.parseInt(request.getParameter("ebookNo"));
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice =Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	String ebookState = request.getParameter("ebookState");
	//디버깅 확인
	System.out.printf("ebookNo: %s\n categoryName: %s\n ebookISBN: %s\n ebookTitle:%s\n ebookAuthor:%s\n ebookCompany:%s\n ebookpageCount:%s\n ebookPrice:%s\n ebookSummary:%s\n ebookSate:%s\n", ebookNo,categoryName,ebookISBN,ebookTitle,ebookAuthor,ebookCompany,ebookPageCount,ebookPrice,ebookSummary,ebookState);
	//현재 ebookNo에 따른 ISBN 가져오기
	String currentEbookISBN = EbookDao.checkEbookISBN(ebookNo);
	
	//중복된 isbn 생성불가 확인하기 ! 단 현재 그대로면 그냥 넘어간다.
	if(!ebookISBN.equals(currentEbookISBN)){
		String returnebookISBN = EbookDao.checkEbookISBN(ebookISBN);//isbn 중복된지 확인 코드
		if(returnebookISBN != null){//사용중
			System.out.println("사용중인 ISBN 입니다.");
			response.sendRedirect(request.getContextPath()+"/ebook/updateEbookOneForm.jsp?ebookISBN="+currentEbookISBN);
			//ebookISBN을 사용하면 수정된 ISBN책의 페이지로 간다.
			return;
		}
	}
	//전처리 vo에 넣기
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookState(ebookState);
	
	//dao에 넣어서 update하기
	EbookDao.updateEbookOne(ebook);
	//ebookOne 재실행
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebook.getEbookISBN());
%>
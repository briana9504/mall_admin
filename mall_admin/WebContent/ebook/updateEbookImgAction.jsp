<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	/*multipart/form-data 방식으로는 넘어오면 다른 방식으로 받아야함
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookImg = request.getParameter("ebookImg");
	System.out.println(ebookISBN);
	System.out.println(ebookImg);
	*/
	
	//파일을 다운로드 받을 위치를 세팅하는게 아니라 찾음
	String path = application.getRealPath("img");//img라는 폴더의 OS상의 실제 폴더
	System.out.println(path);
	
	int size = 1024*1024*100;//100MB 1단위는 1byte임
	//컴퓨터는 1000분의 1초 단위를 씀// 1000*60*60*24 = 하루
	//request를 MultipartRequest를 위임하고 path라는 경로에 저장
	//파일 크기를 얼마까지 활용할건지, 어떤 방식으로 들어가는지(인코딩), 이 안에 중복되는 이름이 있으면 어떻게 할건지?
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8",new DefaultFileRenamePolicy());
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg");
	
	System.out.printf("ebook: %s\n ebookImg: %s\n", ebookISBN,ebookImg);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookImg(ebookImg);
	
	EbookDao.updateEbookImg(ebook);
	
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>
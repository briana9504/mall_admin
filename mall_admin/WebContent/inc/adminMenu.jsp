<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header id="header" class="fixed-top ">
    <div class="container d-flex align-items-center">

      <h1 class="logo"><a href="<%=request.getContextPath()%>/adminIndex.jsp">home</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav class="nav-menu d-none d-lg-block">
        <ul>
          <li><a href="<%=request.getContextPath()%>/manager/managerList.jsp">운영자 관리</a></li>
          <li><a href="<%=request.getContextPath()%>/client/clientList.jsp">고객관리</a></li>
          <li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">상품 카테고리 관리</a></li>
          <li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebook 관리</a></li>
          <li><a href="<%=request.getContextPath()%>/orders/ordersList.jsp">주문 관리</a></li>
          <li><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지관리</a></li>
        </ul>
      </nav><!-- .nav-menu -->
      <a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp" class="get-started-btn ml-auto">로그아웃</a>
    </div>
  </header><!-- End Header -->


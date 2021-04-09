<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "java.util.*" %>
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
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, i
  nitial-scale=1.0" name="viewport">

  <title>Contact - Sailor Bootstrap Template</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
  <link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%=request.getContextPath()%>/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">

  <style>
  	.maginBottom{
  		 margin-bottom: 10px;
  	}
  	a {
	  color:  #6c757d;
	}
	.table .thead-dark th {
	  color: #fff;
	  background-color: #556270;
	  border-color: #454d55;
	}
  </style>
</head>
<body>
</head>
<body>
<!-- 페이징되는 리스트 -->
<%
//현재 페이지
	
	int currentPage = 1 ;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//페이지당 게시글 수
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	//시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	
	//dao에서 리스트 호출
	ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersListByPage(beginRow, rowPerPage);
	
	//ordersState list
	String[] ordersStateList = {"주문완료", "주문취소"};
%>
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<main id="main">
	<!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
      <div class="container">

        <div class="d-flex justify-content-between align-items-center">
          <h2>order List</h2>
          <ol>
            <li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
            <li><a href="blog.html">order List</a></li>
          </ol>
        </div>

      </div>
    </section><!-- End Breadcrumbs -->
	 <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container">

	<form action="<%=request.getContextPath()%>/orders/ordersList.jsp" method="post">
			<div class="form-row maginBottom justify-content-end">
				<div class="col-md-1">
					<select class="form-control form-control" name="rowPerPage" aria-label=".form-select-sm example">
						<%
							for(int i=10; i<31; i+=5){
								if(rowPerPage == i){
						%>
								<option value="<%=i %>" selected="selected"><%=i %></option>
						<%
								}else{
						%>
								<option value="<%=i %>"><%=i %></option>
						<% 
								}
							}
						%>
					</select>
				</div>
				<div class="col-md-1">
					<button type= "submit" class="btn btn-link btn-sm">보기</button>
				</div>
			</div>
		</form>
	
	
	<!-- 테이블 -->
	<table class="table table-hover text-center ">
		<thead class="thead-dark">
			<tr>
				<th>ordersNo</th>
				<th>ebookNo</th>
				<th>ebookTitle</th>
				<th>clientNo</th>
				<th>clientMail</th>
				<th>ordersDate</th>
				<th>ordersState</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(OrdersAndEbookAndClient oec: list){
		%>
			<tr>
				<td class="align-middle"><%=oec.getOrders().getOrdersNo()%></td>
				<td class="align-middle"><%=oec.getOrders().getEbookNo() %></td>
				<td class="align-middle text-left"><%=oec.getEbook().getEbookTitle() %></td>
				<td class="align-middle"><%=oec.getOrders().getClientNo() %></td>
				<td class="align-middle text-left"><%=oec.getClient().getClientMail() %></td>
				<td class="align-middle"><%=oec.getOrders().getOrdersDate().substring(0,10) %></td>
				<td>
					<form method="post" action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp">
						<input type="hidden" name="currentPage" value="<%=currentPage%>">
						<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
						<input type="hidden" name="ordersNo" value="<%=oec.getOrders().getOrdersNo()%>">					
						<div class="row g-3 justify-content-center">
							<div>
								<select name="ordersState" class="form-control w-100">
								<%
									for(int i=0;i<2;i++){
										if(oec.getOrders().getOrdersState().equals(ordersStateList[i])){
								%>
											<option selected="selected" value="<%=ordersStateList[i]%>"><%=ordersStateList[i]%></option>	
								<%
									} else{
								%>
											<option value="<%=ordersStateList[i]%>"><%=ordersStateList[i]%></option>	
								<%
										}
									}
								%>			
								</select>
							</div>
							<div>
								<button type="submit" class="btn btn-link btn-sm">변경</button>
							</div>
						</div>
					</form>
				</td>
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<div class="blog-pagination" data-aos="fade-up">
          <ul class="justify-content-center">

<!-- 이전 -->
<%
	if(currentPage>1){
%>
		<li><a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>"><i class="icofont-rounded-left"></i></a></li>
<%
	}
	
	//전체 페이지- 마지막 페이지 구하기
	int totalPage = OrdersDao.totalCount();
	int lastPage = totalPage/rowPerPage;
	if(totalPage%rowPerPage != 0){
		lastPage += 1;
	}
	
	//다음버튼
	
	if(lastPage > currentPage){
%>
		<li><a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>"><i class="icofont-rounded-right"></i></a></li>
<%
	}
%>
	</ul>
	</div>

      </div>
    </section><!-- End Blog Section -->

  </main><!-- End #main -->


  <a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

  <!-- Vendor JS Files -->
  <script src="<%=request.getContextPath() %>/assets/vendor/jquery/jquery.min.js"></script>
  <script src="<%=request.getContextPath() %>/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="<%=request.getContextPath() %>/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="<%=request.getContextPath() %>/assets/vendor/php-email-form/validate.js"></script>
  <script src="<%=request.getContextPath() %>/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="<%=request.getContextPath() %>/assets/vendor/venobox/venobox.min.js"></script>
  <script src="<%=request.getContextPath() %>/assets/vendor/waypoints/jquery.waypoints.min.js"></script>
  <script src="<%=request.getContextPath() %>/assets/vendor/owl.carousel/owl.carousel.min.js"></script>

  <!-- Template Main JS File -->
  <script src="<%=request.getContextPath() %>/assets/js/main.js"></script>

</body>

</html>
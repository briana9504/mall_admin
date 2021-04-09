<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if (manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
		return;
	}
	%>
	<%
	//현재 페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		System.out.printf("currentPage:%s\n", currentPage);
	}
	//페이지당 행의 수
	int rowPerPage = 10;
	if (request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.printf("rowPerPage:%s\n", rowPerPage);
	}
	//검색어
	String searchWord = "";
	if (request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	
	//시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	
	ArrayList<Client> list = ClientDao.selectClientListByPage(beginRow, rowPerPage, searchWord);
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
<title>clientList</title>
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
	.maginBottom {
		margin-bottom: 10px;
	}
	
	a {
		color: #6c757d;
	}
	.table .thead-dark th {
	  color: #fff;
	  background-color: #556270;
	  border-color: #454d55;
	}
</style>
</head>
<body>
	<!-- 페이징되는 리스트 -->

	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>

	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<section id="breadcrumbs" class="breadcrumbs">
			<div class="container">
				<div class="d-flex justify-content-between align-items-center">
					<h2>Client List</h2>
					<ol>
						<li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/client/clientList.jsp">client List</a></li>
					</ol>
				</div>
			</div>
		</section>
		<!-- End Breadcrumbs -->
		<!-- ======= Blog Section ======= -->
		<section id="blog" class="blog">
			<div class="container">
				<!-- 검색기능 -->
				<h4 class="sidebar-title">Search</h4>
				<div class="sidebar-item search-form">
					<form action="<%=request.getContextPath()%>/client/clientList.jsp"
						method="post">
						<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
						<input type="text" name="searchWord" placeholder="client Mail">
						<button type="submit"><i class="icofont-search"></i></button>
					</form>
				</div>
				<!-- End sidebar search formn-->

				<!-- 출력 -->
				<form action="<%=request.getContextPath()%>/client/clientList.jsp"
					method="post">
					<!-- 페이지 게시물 수 바꿀때 검색어도 같이 넘김 -->
					<input type="hidden" name="searchWord" value="<%=searchWord%>">
					<div class="form-row maginBottom justify-content-end">
						<div class="col-md-1">
							<select class="form-control form-control" name="rowPerPage"
								aria-label=".form-select-sm example">
								<%
								for (int i = 10; i < 31; i += 5) {
									if (rowPerPage == i) {
								%>
								<option value="<%=i%>" selected="selected"><%=i%></option>
								<%
									} else {
								%>
								<option value="<%=i%>"><%=i%></option>
								<%
									}
								}
								%>
							</select>
						</div>
						<div class="col-md-1">
							<button type="submit" class="btn btn-link btn-sm">보기</button>
						</div>
					</div>
				</form>
				<table class="table table-hover text-center ">
					<thead class="thead-dark">
						<tr>
							<th>clientMail</th>
							<th>clientDate</th>
							<th>수정</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Client c : list) {
						%>
						<tr>
							<td class="align-middle text-left">&nbsp;&nbsp;<%=c.getClientMail()%></td>
							<td class="align-middle"><%=c.getClientDate().substring(0, 11)%></td>
							<!-- 0~11외에는 자름 -->
							<td><a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=c.getClientMail()%>"><button type="submit" class="btn btn-link btn-sm ">수정</button></a></td>
							<td class="align-middle"><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>">삭제</a></td>
							<!-- 수정삭제 마무리 managerList도 clientList와 동일하게 하기 -->
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<!-- 페이징 -->
				<div class="blog-pagination" data-aos="fade-up">
					<ul class="justify-content-center">
						<%
							//이전버튼
							if (currentPage > 1) {
						%>
						<li><a
							href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><i
								class="icofont-rounded-left"></i></a></li>
						<%
							}
							int totalRow = ClientDao.totalCount(searchWord);
							int lastPage = totalRow / rowPerPage;
							if (totalRow % rowPerPage != 0) {
							lastPage += 1;
							}
							//다음 버튼
							if (currentPage < lastPage) {
						%>
						<li><a
							href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><i
								class="icofont-rounded-right"></i></a></li>
						<%
							}
						%>
					</ul>
				</div>
			</div>
		</section>
		<!-- End Blog Section -->

	</main>
	<!-- End #main -->

	<a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

	<!-- Vendor JS Files -->
	<script src="<%=request.getContextPath()%>/assets/vendor/jquery/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/php-email-form/validate.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/venobox/venobox.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/waypoints/jquery.waypoints.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/owl.carousel/owl.carousel.min.js"></script>

	<!-- Template Main JS File -->
	<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>
</body>
</html>
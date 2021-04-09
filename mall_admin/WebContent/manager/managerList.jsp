<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%
	//레벨2이상 manager만 들어오도록
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if (manager == null) {
		response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
		return;
	} else if (manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
		return;
	}
%>
<%
	//페이지 + 검색기능 넣기
	
	//현재페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		System.out.printf("currentPage: %s <managerList.currentPage> \n", currentPage);
	}
	//페이지당 행의 수
	int rowPerPage = 10;
	if (request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.printf("rowPerPage: %s <managerList.rowPerPage> \n", rowPerPage);
	}
	//검색어
	String searchWord = "";
	if (request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
		System.out.printf("searchWord: %s <managerList.searchWord> \n", searchWord);
	}
	
	int beginRow = (currentPage - 1) * rowPerPage;
	//목록 생성
	ArrayList<Manager> list = ManagerDao.selectManagerList(beginRow, rowPerPage, searchWord);
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>managerList</title>
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

<!-- =======================================================
  * Template Name: Sailor - v2.3.1
  * Template URL: https://bootstrapmade.com/sailor-free-bootstrap-theme/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->

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
					<h2>manager List</h2>
					<ol>
						<li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/manager/managerList.jsp">manager List</a></li>
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
					<form action="<%=request.getContextPath()%>/manager/managerList.jsp" method="post">
						<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
						<input type="text" name="searchWord" placeholder="manager ID">
						<button type="submit">
							<i class="icofont-search"></i>
						</button>
					</form>
				</div>
				<!-- End sidebar search formn-->
				<form action="<%=request.getContextPath()%>/manager/managerList.jsp" method="post">
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
							<th>managerNo</th>
							<th>managerId</th>
							<th>managerName</th>
							<th>managerDate</th>
							<th>managerLevel</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Manager m : list) {
						%>
						<tr>
							<!-- 레벨이 크고, 날짜가 빠른순으로  -->
							<td class="align-middle"><%=m.getManagerNo()%></td>
							<td class="align-middle"><%=m.getManagerId()%></td>
							<td class="align-middle"><%=m.getManagerName()%></td>
							<td class="align-middle"><%=m.getManagerDate().substring(0, 10)%></td>
							<td class="align-middle">

								<form action="<%=request.getContextPath()%>/manager/updateManagerLevelAction.jsp" method="post">
									<input type="hidden" name="managerNo" value="<%=m.getManagerNo()%>">
									<div class="row g-3 justify-content-center">
										<div>
											<select class="form-control w-100" name="managerLevel">
												<%
													for (int i = 0; i < 3; i++) {
														if (m.getManagerLevel() == i) {
												%>
													<option value="<%=i%>" selected="selected"><%=i%></option>
												<!-- 처음에 선택되어 있는 숫자 -->
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
										<div>
											<button type="submit" class="btn btn-link btn-sm ">수정</button>
										</div>
									</div>
								</form>
							<td class="align-middle"><a href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>">삭제</a></td>
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
						<li><a href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><i class="icofont-rounded-left"></i></a></li>
						<%
							}
							int totalRow = ManagerDao.totalCount(searchWord);
							int lastPage = totalRow / rowPerPage;
							if (totalRow % rowPerPage != 0) {
							lastPage += 1;
							}
							//다음 버튼
							if (currentPage < lastPage) {
						%>
						<li><a href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><i class="icofont-rounded-right"></i></a></li>
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
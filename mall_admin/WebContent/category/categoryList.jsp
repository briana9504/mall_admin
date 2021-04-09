<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	//categoryDao로 부터 리스트 받아옴
	ArrayList<Category> list = CategoryDao.categoryList();
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
<title>categoryList</title>
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
	.btn-outline-dark {
	  color: #556270;
	  border-color: #556270;
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
					<h2>category List</h2>
					<ol>
						<li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">category List</a></li>
					</ol>
				</div>

			</div>
		</section>
		<!-- End Breadcrumbs -->
		<!-- ======= Blog Section ======= -->
		<section id="blog" class="blog">
			<div class="container">
				<br>
				<br>
				<br>
				<br>
				<table class="table table-hover text-center">
					<thead class="thead-dark">
						<tr>
							<th>categoryName</th>
							<th>categoryWeight(수정)</th>
							<!-- 레벨 수정하듯이 수정가능 -->
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<%
							for(Category c : list){
						%>
						<tr>
							<td class="align-middle"><%=c.getCategoryName() %></td>
							<td>
								<form action="<%=request.getContextPath()%>/category/updateCategoryWeightAction.jsp" method="post">
									<input type="hidden" name="categoryName" value="<%=c.getCategoryName() %>">
									<div class="row g-3 justify-content-center">
										<div>
											<select name="categoryWeight" class="form-control w-100">
											<%
												for(int i=0; i<list.size(); i++){
													if(i == c.getCategoryWeight()){
											%>
												<option value="<%=i%>" selected="selected"><%=i%></option>
											<%	
													} else{
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
							</td>
							<td class="align-middle"><a href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryName=<%=c.getCategoryName()%>">삭제</a></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<div class="row">
					<div class="col text-right">
						<a href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp"><button type="button" class="btn btn-outline-dark maginBottom">케타고리 추가</button></a>	
					</div>
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
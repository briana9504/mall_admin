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
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
<title>ebookOne</title>
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
.btn-primary {
	border-radius: 4;
	padding: 5px 15px;
	border: 0;
	background-color: #556270;
}

.maginBottom {
	margin-bottom: 20px;
}

.w1 {
	width: 25%;
}
</style>
</head>
<body>
	<%
	ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
	%>

	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<section id="breadcrumbs" class="breadcrumbs">
			<div class="container">

				<div class="d-flex justify-content-between align-items-center">
					<h2>insertEbookForm</h2>
					<ol>
						<li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebookList</a></li>
					</ol>
				</div>
			</div>
		</section>
		<!-- End Breadcrumbs -->
		<!-- ======= Blog Section ======= -->
		<section id="blog" class="blog">
			<div class="container">
				<div class="row">
					<div class="col-lg-8 entries">
						<article class="entry entry-single">
							<h2 class="entry-title"></h2>
							<form method="post"
								action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp">
								<table class="table">
									<tr>
										<td class="w1">categoryName</td>
										<td>
											<select name="categoryName" class="form-control col-md-3" required>
												<option value="">선택</option>
												<%
													for (String cn : categoryNameList) {
												%>
													<option value="<%=cn%>"><%=cn%></option>
												<%
													}
												%>
											</select>
										</td>
									</tr>
									<tr>
										<td>ebookISBN</td>
										<td><input type="text" name="ebookISBN" class="form-control col-md-8" required pattern="^\d{9}-\d{1}$" placeholder="숫자 #########-# 형식으로 입력하세오."></td>
									</tr>
									<tr>
										<td>ebookTitle</td>
										<td><input type="text" name="ebookTitle" class="form-control col-md-8" required></td>
									</tr>
									<tr>
										<td>ebookAuthor</td>
										<td><input type="text" name="ebookAuthor" class="form-control col-md-8" required pattern="^[a-zA-Z가-힣\s]+$"></td>
									</tr>
									<tr>
										<td>ebookCompany</td>
										<td><input type="text" name="ebookCompany" class="form-control col-md-8" required></td>
									</tr>
									<tr>
										<td>ebookPageCount</td>
										<td><input type="text" name="ebookPageCount" class="form-control col-md-8" required pattern="^[0-9]+$">
										</td>
									</tr>
									<tr>
										<td>ebookPrice</td>
										<td><input type="text" name="ebookPrice" class="form-control col-md-8" required pattern="^[0-9]+$">
										</td>
									</tr>
									<tr>
										<td>ebookSummary</td>
										<td><textarea rows="7" name="ebookSummary" class="form-control" required></textarea></td>
									</tr>
								</table>
								<div class="row">
									<div class="col-md-12 float-right">
										<button type="submit" class="btn btn-primary float-right">ebook 추가</button>
									</div>
								</div>
							</form>
						</article>
					</div>
					<!-- End blog entries list -->
					<div class="col-lg-4">
						<div class="sidebar">
							<h3 class="sidebar-title">Categories</h3>
							<hr>
							<div class="sidebar-item categories">
								<ul>
									<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">전체</a></li>
							<%
								for (String s : categoryNameList) {
							%>
					
									<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>"><%=s%></a></li>
							<%
								}
							%>
								</ul>
     						 </div>
						<!-- End sidebar categories-->
						</div>
						<!-- End sidebar tags-->

         		  </div>
					<!-- End sidebar -->

       		  </div>
				<!-- End blog sidebar -->
           </div>
       </section>	
      </main>   
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
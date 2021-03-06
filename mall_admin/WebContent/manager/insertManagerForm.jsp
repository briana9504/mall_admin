<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateClientForm</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

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
	ul {
		margin-top: 5%;
		padding: 0;
		list-style: none;
	}
	
	li {
		position: relative;
		white-space: nowrap;
		padding: 2px 0 5px 5px;
	}
</style>
</head>
<body>

	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<section id="breadcrumbs" class="breadcrumbs">
			<div class="container">
				<div class="d-flex justify-content-between align-items-center">
					<h2>????????? ??????</h2>
					<ol>
						<li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
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
						<div class="blog-comments">
							<div class="reply-form">
								<p>????????? ????????? ?????? ?????????, ????????????, ????????? ????????? ?????????.</p>
								<br>
								<form action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp" method="post">
									<div class="row">
										<div class="col-md form-group">
											<input name="managerId" type="text" class="form-control" placeholder="Your ID" required pattern="^[a-z0-9]{5,20}$">
										</div>
									</div>
									<div class="row">
										<div class="col-md form-group">
											<input name="managerPw" type="password" class="form-control" placeholder="Your password" required pattern="^[a-z0-9\W]{4,10}$">
										</div>
									</div>
									<div class="row">
										<div class="col-md form-group">
											<input name="managerName" type="text" class="form-control" placeholder="Your name" required pattern="^[a-zA-Z???-???\s]{2,100}$">
										</div>
									</div>
									<div class="row">
										<div class="col text-center">
											<button type="submit" class="btn btn-primary">????????? ??????</button>
										</div>
									</div>
								</form>
								<ul>
									<li><i class="ri-check-double-line"></i> ???????????? ?????????????????? ?????? 5?????? 20???????????? ?????????????????????.</li>
									<li><i class="ri-check-double-line"></i> ??????????????? ?????????????????? ?????? ??????????????? ???????????? 4?????? 10???????????? ????????????????????????.</li>
									<li><i class="ri-check-double-line"></i> ????????? ????????? ??????????????? ????????? ????????????.</li>
								</ul>
							</div>
						</div>
						<!-- End blog comments -->
					</div>
				</div>
			</div>
		</section>
	</main>

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
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%
	ArrayList<Notice> noticeList = NoticeDao.selectNoticeList(0, 5);
	ArrayList<Manager> managerList = ManagerDao.selectManagerList(0, 5, "");
	ArrayList<Client> clientList = ClientDao.selectClientListByPage(0, 5, "");
	ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(0, 5, "");
	ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(0, 5);
	//승인대기 중인 매니저 목록
	ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>adminIndex</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="assets/img/favicon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/vendor/icofont/icofont.min.css" rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/venobox/venobox.css" rel="stylesheet">
<link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="assets/css/style.css" rel="stylesheet">

<style>
	.maginBottom {
		margin-bottom: 20px;
	}
</style>
</head>
<body>
	<%
	if (session.getAttribute("sessionManager") == null) {
	%>
	<header id="header" class="fixed-top ">
		<div class="container d-flex align-items-center">
			<h1 class="logo">
				<a href="<%=request.getContextPath()%>/adminIndex.jsp">home</a>
			</h1>
			<!-- Uncomment below if you prefer to use an image logo -->
			<!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

			<nav class="nav-menu d-none d-lg-block">
				<ul>
				</ul>
			</nav>
			<!-- .nav-menu -->
			<a href="#about" class="get-started-btn ml-auto btn-get-started animate__animated animate__fadeInUp scrollto">로그인</a>
		</div>
	</header>
	<!-- End Header -->
	<!-- ======= Hero Section ======= -->
	<section id="hero">
		<div id="heroCarousel" class="carousel slide carousel-fade" data-ride="carousel">

			<ol class="carousel-indicators" id="hero-carousel-indicators"></ol>
			<div class="carousel-inner" role="listbox">

				<!-- Slide 1 -->
				<div class="carousel-item active"
					style="background-image: url(assets/img/slide/slide-2.jpg)">
					<div class="carousel-container">
						<div class="container">
							<h2 class="animate__animated animate__fadeInDown">Welcome to <span>adminIndex</span></h2>
							<p class="animate__animated animate__fadeInUp">쇼핑몰 관리를 위해서는 매니저 로그인을 해주세요.</p>
							<a href="#about" class="btn-get-started animate__animated animate__fadeInUp scrollto">로그인</a>
						</div>
					</div>
				</div>

				<!-- Slide 3 -->
				<div class="carousel-item"
					style="background-image: url(assets/img/slide/slide-3.jpg)">
					<div class="carousel-container">
						<div class="container">
							<h2 class="animate__animated animate__fadeInDown"> Welcome to <span>adminIndex</span></h2>
							<p class="animate__animated animate__fadeInUp">매니저 로그인을 해주세요.</p>
							<a href="#about" class="btn-get-started animate__animated animate__fadeInUp scrollto">매니저 가입</a>
						</div>
					</div>
				</div>
			</div>
			<a class="carousel-control-prev" href="#heroCarousel" role="button" data-slide="prev"> <span class="carousel-control-prev-icon icofont-simple-left" aria-hidden="true"></span> <span class="sr-only">Previous</span></a> 
			<a class="carousel-control-next" href="#heroCarousel" role="button" data-slide="next"> <span class="carousel-control-next-icon icofont-simple-right" aria-hidden="true"></span> <span class="sr-only">Next</span></a>
		</div>
	</section>
	<!-- End Hero -->

	<main id="main">
		<!-- ======= About Section ======= -->
		<section id="about" class="about">
			<div class="container">
				<div class="row content">
					<!-- 로그인 창 넣기 -->
					<div class="col-lg-6">
						<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp">
							<h2>로그인</h2>
							<div class="form-row">
								<div class="col-md-6 form-group">
									<input type="text" name="managerId" class="form-control" id="name" placeholder="Your ID" required pattern="^[a-z0-9]{5,20}$">
									<div class="validate"></div>
								</div>
								<div class="col-md-6 form-group">
									<input type="password" class="form-control" name="managerPw" id="email" placeholder="Your password" required pattern="^[a-z0-9\W]{4,10}$">
									<div class="validate"></div>
								</div>
							</div>
							<div class="text-right">
								<button type="submit" class="btn btn-danger">로그인</button>
							</div>
							<br>
							<div class="text-right">
								<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">매니저 등록</a>
							</div>
						</form>
						<ul>
							<li><i class="ri-check-double-line"></i> 가입시 매니저 승인까지는 시간이 걸립니다.</li>
							<li><i class="ri-check-double-line"></i> 승인 여부를 확인하려면 옆의 목록을 확인해 주세요.</li>
						</ul>
					</div>
					<div class="col-lg-6 pt-4 pt-lg-0">
						<!-- 승인대기 중인 로그인 목록 넣기 -->
						<h3 class="text-center">승인대기 중인 매니저 목록</h3>
						<br>
						<table class="table table-hover text-center">
							<thead>
								<tr>
									<th>managerId</th>
									<th>managerLevel</th>
								</tr>
							</thead>
							<tbody>
								<%
									for (Manager m : list) {
								%>
								<tr>
									<td><%=m.getManagerId()%></td>
									<td><%=m.getManagerDate().substring(0, 11)%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</section>
		<!-- End About Section -->
	</main>
	<!-- End #main -->
	<%
		} else {
	%>
	<!-- ======= Header ======= -->
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- ======= Hero Section ======= -->
	<section id="hero">
		<div id="heroCarousel" class="carousel slide carousel-fade"
			data-ride="carousel">
			<ol class="carousel-indicators" id="hero-carousel-indicators"></ol>
			<div class="carousel-inner" role="listbox">

				<!-- Slide 1 -->
				<div class="carousel-item active"
					style="background-image: url(assets/img/slide/slide-1.jpg)">
					<div class="carousel-container">
						<div class="container">
							<h2 class="animate__animated animate__fadeInDown"> Welcome to <span>adminIndex</span></h2>
							<p class="animate__animated animate__fadeInUp">오늘하루도 화이팅</p>
							<a href="#portfolio" class="btn-get-started animate__animated animate__fadeInUp scrollto">업데이트 내용보기</a>
						</div>
					</div>
				</div>
				<!-- Slide 2 -->
				<div class="carousel-item"
					style="background-image: url(assets/img/slide/slide-2.jpg)">
					<div class="carousel-container">
						<div class="container">
							<h2 class="animate__animated animate__fadeInDown">Welcome to <span>adminIndex</span></h2>
							<p class="animate__animated animate__fadeInUp">오늘 하루도 힘내요.</p>
							<a href="#portfolio" class="btn-get-started animate__animated animate__fadeInUp scrollto">업데이트 내용보기</a>
						</div>
					</div>
				</div>
				<!-- Slide 3 -->
				<div class="carousel-item"
					style="background-image: url(assets/img/slide/slide-3.jpg)">
					<div class="carousel-container">
						<div class="container">
							<h2 class="animate__animated animate__fadeInDown">Welcome to <span>adminIndex</span></h2>
							<p class="animate__animated animate__fadeInUp">즐거운 하루를 보냅시다.</p>
							<a href="#portfolio" class="btn-get-started animate__animated animate__fadeInUp scrollto">업데이트 내용보기</a>
						</div>
					</div>
				</div>
			</div>
			<a class="carousel-control-prev" href="#heroCarousel" role="button" data-slide="prev"> <span class="carousel-control-prev-icon icofont-simple-left" aria-hidden="true"></span> <span class="sr-only">Previous</span></a> 
			<a class="carousel-control-next" href="#heroCarousel" role="button" data-slide="next"> <span class="carousel-control-next-icon icofont-simple-right" aria-hidden="true"></span> <span class="sr-only">Next</span></a>
		</div>
	</section>
	<!-- End Hero -->

	<main id="main">
		<!-- ======= Portfolio Section ======= -->
		<!-- list들 넣기 -->
		<section id="portfolio" class="portfolio">
			<div class="container">

				<div class="section-title">
					<h2></h2>
					<p>최근 업데이트 목록</p>
				</div>
				<div class="row maginBottom">
					<div class="col-lg-12 d-flex justify-content-center">
						<ul id="portfolio-flters">
							<li data-filter="*" class="filter-active">All</li>
							<li data-filter=".filter-clientList">clientList</li>
							<li data-filter=".filter-ebookList">ebookList</li>
							<li data-filter=".filter-managerList">managerList</li>
							<li data-filter=".filter-orderList">orderList</li>
							<li data-filter=".filter-noticeList">noticeList</li>
						</ul>
					</div>
				</div>
				<div class="row portfolio-container maginBottom">
					<div class="col-lg-4 col-md-6 portfolio-item filter-noticeList ">
						<!-- 최근 등록한 공지 5개 -->
						<div>
							<h2 class="text-center">
								noticeList <a href="<%=request.getContextPath()%>/notice/noticeList.jsp"><i class="bx bx-plus"></i></a>
							</h2>
							<table class="table table-dark table-striped">
								<%
									for (Notice n : noticeList) {
								%>
								<tr>
									<td><%=n.getNoticeTitle()%></td>
									<td><%=n.getManagerId()%></td>
								</tr>
								<%
									}
								%>
							</table>
						</div>
					</div>
					<div class="col-lg-4 col-md-6 portfolio-item filter-managerList">
						<!-- 최근 가입한 매니저 5명 -->
						<div>
							<h2 class="text-center">
								managerList <a href="<%=request.getContextPath()%>/manager/managerList.jsp"><i	class="bx bx-plus"></i></a>
							</h2>
							<table class="table table-dark table-striped">
								<%
									for (Manager m : managerList) {
								%>
								<tr>
									<td><%=m.getManagerId()%></td>
									<td><%=m.getManagerName()%></td>
								</tr>
								<%
									}
								%>
							</table>
						</div>
					</div>
					<div class="col-lg-4 col-md-6 portfolio-item filter-clientList">
						<!-- 최근 가입한 고객 5명 -->
						<div>
							<h2 class="text-center">
								clientList<a href="<%=request.getContextPath()%>/client/clientList.jsp"><i class="bx bx-plus"></i></a>
							</h2>
							<table class="table table-dark table-striped">
								<%
									for (Client c : clientList) {
								%>
								<tr>
									<td><%=c.getClientMail()%></td>
									<td><%=c.getClientDate().substring(0, 10)%></td>
								</tr>
								<%
									}
								%>
							</table>
						</div>
					</div>
					<div class="col-lg-4 col-md-6 portfolio-item filter-ebookList">
						<!-- 최근 등록한 상품 5개 -->
						<div>
							<h2 class="text-center">
								ebookList<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><i class="bx bx-plus"></i></a>
							</h2>
							<table class="table table-dark table-striped">
								<%
									for (Ebook e : ebookList) {
								%>
								<tr>
									<td><%=e.getEbookTitle()%></td>
									<td><%=e.getEbookPrice()%></td>
								</tr>
								<%
									}
								%>
							</table>
						</div>
					</div>
					<div class="col-lg-4 col-md-6 portfolio-item filter-orderList">
						<!-- 최근 주문한 주문 5개 -->
						<div>
							<h2 class="text-center">
								ordersList<a href="<%=request.getContextPath()%>/orders/ordersList.jsp"><i class="bx bx-plus"></i></a>
							</h2>
							<table class="table table-dark table-striped">
								<%
									for (OrdersAndEbookAndClient oec : oecList) {
								%>
								<tr>
									<td><%=oec.getOrders().getOrdersNo()%></td>
									<td><%=oec.getEbook().getEbookTitle()%></td>
									<td><%=oec.getClient().getClientMail()%></td>
								</tr>
								<%
									}
								%>
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End Portfolio Section -->
	</main>
	<!-- End #main -->
	<%
		}
	%>

	<a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

	<!-- Vendor JS Files -->
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
	<script src="assets/vendor/php-email-form/validate.js"></script>
	<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="assets/vendor/venobox/venobox.min.js"></script>
	<script src="assets/vendor/waypoints/jquery.waypoints.min.js"></script>
	<script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>

	<!-- Template Main JS File -->
	<script src="assets/js/main.js"></script>
</body>
</html>
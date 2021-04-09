<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.ManagerDao"%>
<%@ page import="gdu.mall.vo.Manager"%>
<%
	request.setCharacterEncoding("UTF-8");
	//1. 수집(id name pw)
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	//디버깅
	System.out.printf("id:%s\n pw:%s\n name:%s\n", managerId, managerPw, managerName);
	
	//2-1. 중복된 아이디가 있으면 managerInsertForm.jsp로 돌아가면서 끝낸다.
	//null이면 사용중인 아이디가 없어 사용가능하고 아니면 사용불가해서 managerInsertForm.jsp로 돌아감
	String returnManagerId = ManagerDao.selectManagerId(managerId);
	if (returnManagerId != null) {//이미 사용중인 아이디가 있음: null이 아니면
		System.out.println("사용중인 아이디 입니다.");
		response.sendRedirect(request.getContextPath() + "/manager/insertManagerForm.jsp");
		//if문 이후에 더 코드가 있으면 계속 코드가 실행됨 끝내는 방법은?
		return;
		//return문이 나오면 jsp파일은 끝난다.
	}
	
	//2-2. 중복된 아이디가 없으면 입력
	ManagerDao.insertManager(managerId, managerPw, managerName);
	//3. 출력: 간단한 메세지 나옴
%>
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

<!-- =======================================================
  * Template Name: Sailor - v2.3.1
  * Template URL: https://bootstrapmade.com/sailor-free-bootstrap-theme/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>
<body>
	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<section id="breadcrumbs" class="breadcrumbs">
			<div class="container">
				<div class="d-flex justify-content-between align-items-center">
					<h2>매니저 등록</h2>
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
						<article class="entry entry-single">
							<p>매니저 등록 성공. 승인 후 사용 가능합니다.</p>
							<p>
								<a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 홈</a>으로
								돌아가기
							</p>
						</article>
					</div>
				</div>
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
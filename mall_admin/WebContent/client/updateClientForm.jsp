<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%	//보안코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if (manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	//request
	String clientMail = request.getParameter("clientMail");
	ArrayList<Client> list = ClientDao.updateClientForm(clientMail);
	for(Client c: list){
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
<title>updateClientForm</title>
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
</style>
</head>
<body>
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<section id="breadcrumbs" class="breadcrumbs">
			<div class="container">
				<div class="d-flex justify-content-between align-items-center">
					<h2>update client form</h2>
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
				<div class="row">
					<div class="col-lg-8 entries">
						<article class="entry entry-single">
							<h2 class="entry-title"></h2>
							<!-- 관리자화면 메뉴(네비게이션) include -->
							<div>
								<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
							</div>
							<p>고객의 패스워드를 재설정 할 수 있습니다.</p>
							<table class="table">
								<tr>
									<td>clientNo</td>
									<td><%=c.getClientNo() %></td>
								</tr>
								<tr>
									<td>clientMail</td>
									<td><%=c.getClientMail() %></td>
								</tr>
								<tr>
									<td class=" align-middle">ClientPw</td>
									<td>
										<form action="<%=request.getContextPath()%>/client/updateClientAction.jsp">
											<input type="hidden" name="clientMail" value="<%=c.getClientMail()%>">
											<div class="row">
												<div class="col-md-6">
													<input type="text" name="clientPw" class="form-control" required pattern="^[a-z0-9]{4,10}$">
												</div>
												<div class="col-md-3">
													<button type="submit" class="btn btn-primary">수정</button>
												</div>
											</div>
										</form>
									</td>
								</tr>
								<tr>
									<td>ClientDate</td>
									<td><%=c.getClientDate().substring(0,11) %></td>
								</tr>
							</table>
	<%
		}
	%>
						</article>
					</div>
				</div>
			</div>
		</section>
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
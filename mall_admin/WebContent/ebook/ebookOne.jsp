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
	//수집
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.printf("ebookISBN: %s<ebookOne.jsp>\n", ebookISBN);
	
	//dao연결
	Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	String[] ebookStateList = EbookDao.ebookStateList();
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

.marginTop {
	margin-top: 5%;
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
					<h2><%=ebook.getEbookTitle()%></h2>
					<ol>
						<li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebook List</a></li>
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
							<!-- ebook One 넣기 -->
							<table class="table">
								<tr>
									<th class="w1">ebookNo</th>
									<td><%=ebook.getEbookNo()%></td>
								</tr>
								<tr>
									<th>categoryName</th>
									<td><%=ebook.getCategoryName()%></td>
								</tr>
								<tr>
									<th>ebookTitle</th>
									<td><%=ebook.getEbookTitle()%></td>
								</tr>
								<tr>
									<th>ebookAuthor</th>
									<td><%=ebook.getEbookAuthor()%></td>
								</tr>
								<tr>
									<th>ebookImg</th>
									<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>">
										<div class="row text-right marginTop">
											<div class="col">
												<a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button class="btn btn-primary btn-sm">이미지 수정</button></a>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>ebookISBN</th>
									<td><%=ebook.getEbookISBN()%></td>
								</tr>
								<tr>
									<th>ebookCompany</th>
									<td><%=ebook.getEbookCompany()%></td>

								</tr>
								<tr>
									<th>ebookDate</th>
									<td><%=ebook.getEbookDate().substring(0, 11)%></td>

								</tr>
								<tr>
									<th>ebookSummary</th>
									<td><%=ebook.getEbookSummary()%>
										<div class="row text-right marginTop">
											<div class="col">
												<a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button class="btn btn-primary btn-sm">책요약 수정</button></a>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>ebookPrice</th>
									<td><%=ebook.getEbookPrice()%></td>
								</tr>
								<tr>
									<th>ebookPageCount</th>
									<td><%=ebook.getEbookPageCount()%></td>
								</tr>
								<tr>
									<th>ebookState</th>
									<td>
										<form method="post" action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">
											<input type="hidden" name="ebookISBN" value="<%=ebook.getEbookISBN()%>">
											<div class="row">
												&nbsp; &nbsp; 
												<select class="form-control col-md-3" name="ebookState">
													<%
														for (String es : ebookStateList) {
															if (es.equals(ebook.getEbookState())) {
													%>
															<option value="<%=es%>" selected="selected"><%=es%></option>
													<%
															} else {
													%>
															<option value="<%=es%>"><%=es%></option>
													<%
															}
														}
													%>
												</select>
												<button type="submit" class="btn btn-link">수정</button>
											</div>
										</form>
									</td>
								</tr>
							</table>
							<div class="entry-footer clearfix">
								<div class="float-right">
									<a href="<%=request.getContextPath()%>/ebook/updateEbookOneForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">전체 수정(이미지 제외)</a>
									 &nbsp; 
									 <a href="<%=request.getContextPath()%>/ebook/deleteEbookOneAction.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">삭제</a>
								</div>
							</div>
						</article>
						<!-- End blog entry -->
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
											ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
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
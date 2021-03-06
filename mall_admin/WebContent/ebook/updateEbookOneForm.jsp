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
	
	th {
		width: 25%;
	}
</style>
</head>
<body>
	<%
	//??????
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.printf("ebookISBN: %s<updateEbookOneForm.jsp>\n",ebookISBN);
	
	//dao??????
	Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	String[] ebookStateList = EbookDao.ebookStateList();
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
					<h2>ebookOne update Form</h2>
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
							<form action="<%=request.getContextPath()%>/ebook/updateEbookOneAction.jsp" method="post">
								<table class="table">
									<tr>
										<th>ebookNo</th>
										<td><input class="form-control col-md-7" type="text" name="ebookNo" readOnly="readonly" value="<%=ebook.getEbookNo() %>"></td>
									</tr>
									<tr>
										<th>categoryName</th>
										<td>
											<select name="categoryName" class="form-control col-md-3">
												<option value="">??????</option>
												<%
													for(String cn: categoryNameList){
														if(cn.equals(ebook.getCategoryName())){
												%>
													<option value="<%=cn%>" selected="selected"><%=cn%></option>
												<%
													} else {
												%>
													<option value="<%=cn%>"><%=cn%></option>
												<%
														}
													}
												%>
											</select>
										</td>
									</tr>
									<tr>
										<th>ebookTitle</th>
										<td><input type="text" class="form-control col-md-7" name="ebookTitle" value="<%=ebook.getEbookTitle() %>"></td>
									</tr>
									<tr>
										<th>ebookAuthor</th>
										<td><input type="text" class="form-control col-md-7" name="ebookAuthor" value="<%=ebook.getEbookAuthor() %>"></td>
									</tr>
									<tr>
										<th>ebookISBN</th>
										<td><input type="text" class="form-control col-md-7" name="ebookISBN" value="<%=ebook.getEbookISBN() %>"></td>
									</tr>
									<tr>
										<th>ebookCompany</th>
										<td><input type="text" class="form-control col-md-7" name="ebookCompany" value="<%=ebook.getEbookCompany() %>"></td>
									</tr>
									<tr>
										<th>ebookDate</th>
										<td><%=ebook.getEbookDate().substring(0,11)%></td>
									</tr>
									<tr>
										<th>ebookSummary</th>
										<td><textarea rows="7" class="form-control" name="ebookSummary"><%=ebook.getEbookSummary() %></textarea></td>
									</tr>
									<tr>
										<th>ebookPrice</th>
										<td><input type="text" class="form-control col-md-7" name="ebookPrice" value="<%=ebook.getEbookPrice() %>"></td>
									</tr>
									<tr>
										<th>ebookPageCount</th>
										<td><input type="text" class="form-control col-md-7" name="ebookPageCount" value="<%=ebook.getEbookPageCount() %>"></td>
									</tr>
									<tr>
										<th>ebookState</th>
										<td>
											<select class="form-control col-md-3" name="ebookState">
											<%
												for(String es: ebookStateList){
													if(es.equals(ebook.getEbookState())){
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
										</td>
									</tr>
								</table>
								<div class="row">
									<div class="col-md-12 float-right">
										<button type="submit" class="btn btn-primary float-right">??????</button>
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
									<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">??????</a></li>
										<%
											for(String s : categoryNameList){
										%>
									
									<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>"><%=s %></a></li>
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
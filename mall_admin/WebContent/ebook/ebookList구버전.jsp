<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	System.out.printf("currentPage:%s <ebookList.jsp>\n", currentPage);
}
//페이지당 행의 수
int rowPerPage = 10;
if (request.getParameter("rowPerPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	System.out.printf("rowPerPage:%s <ebookList.jsp>\n", rowPerPage);
}
//시작 행
int beginRow = (currentPage - 1) * rowPerPage;

//카테고리 변경????
String categoryName = "";
if (request.getParameter("categoryName") != null) {
	categoryName = request.getParameter("categoryName");
	System.out.printf("categoryName:%s <ebookList.jsp>\n", categoryName);
}

System.out.printf("categoryName: %s <ebookList.jsp>\n", categoryName);
//ebookList - ebookdao에서 호출	
ArrayList<Ebook> list = EbookDao.selectEbookListByPage(beginRow, rowPerPage, categoryName);
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
<title>ebookList</title>
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
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<section id="breadcrumbs" class="breadcrumbs">
			<div class="container">
				<div class="d-flex justify-content-between align-items-center">
					<h2>ebook List</h2>
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
				<div id="portfolio" class="portfolio">
					<div class="row">
						<div class="col-lg-12 d-flex justify-content-center">
							<ul id="portfolio-flters">
								<li data-filter=".filter-app"><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">All</a></li>
								<%
									ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
									for (String s : categoryNameList) {
								%>
								<li data-filter=".filter-app"><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>">[<%=s%>]
								</a></li>
								<%
									}
								%>
							</ul>
						</div>
					</div>
				</div>
				
				<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
					<!-- 페이지 게시물 수 바꿀때 검색어도 같이 넘김 -->
					<%
						if (categoryName != null) {
					%>
						<input type="hidden" name="categoryName" value="<%=categoryName%>">
					<%
						}
					%>
					<div class="form-row maginBottom justify-content-end">
						<div class="col-md-1">
							<select class="form-control form-control" name="rowPerPage" aria-label=".form-select-sm example">
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
							<th>categoryName</th>
							<th>ebookISBN</th>
							<th>ebookTitle</th>
							<th>ebookAuthor</th>
							<th>ebookDate</th>
							<th>ebookPrice</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (Ebook e : list) {
						%>
						<tr>
							<td><%=e.getCategoryName()%></td>
							<td><%=e.getEbookISBN()%></td>
							<td class="align-middle text-left"><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle()%></a></td>
							<td class="align-middle text-left"><%=e.getEbookAuthor()%></td>
							<td><%=e.getEbookDate().substring(0, 11)%></td>
							<td><%=e.getEbookPrice()%></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<div class="text-right maginBottom">
					<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button type="button" class="btn btn-outline-dark">ebook 추가</button></a>
				</div>
				<!-- 페이징 -->
				<div class="blog-pagination" data-aos="fade-up">
					<ul class="justify-content-center">
						<%
							if (currentPage > 1) {
								if (categoryName.equals("")) {
						%>
						<li><a
							href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>"><i
								class="icofont-rounded-left"></i></a></li>
						<%
								} else {
						%>
						<li><a
							href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><i
								class="icofont-rounded-left"></i></a></li>
						<%
								}
							}
	
							int totalRow = EbookDao.totalCount(categoryName);
							int lastPage = totalRow / rowPerPage;
							if (totalRow % rowPerPage != 0) {
							lastPage += 1;
							}
						//다음 버튼
							if (currentPage < lastPage) {
								if (categoryName.equals("")) {
						%>
						<li><a
							href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>"><i class="icofont-rounded-right"></i></a></li>
						<%
								} else {
						%>
						<li><a
							href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><i class="icofont-rounded-right"></i></a></li>
						<%
								}
							}
						%>
					</ul>
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
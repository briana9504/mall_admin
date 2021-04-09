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
<html>
<head>
<meta charset="UTF-8">
<title>noticeOne</title>
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
	.maginBottom {
		margin-bottom: 20px;
	}
</style>
</head>
<body>
	<%
		//수집
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		System.out.printf("noticeNo: %s<noticeOne>\n", noticeNo);
		//dao연결
		Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	%>
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<section id="breadcrumbs" class="breadcrumbs">
			<div class="container">
				<div class="d-flex justify-content-between align-items-center">
					<h2>공지</h2>
					<ol>
						<li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">Notice List</a></li>
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
							<h2 class="entry-title">
								&nbsp;
								<%=notice.getNoticeTitle()%>
							</h2>
							<table class="table">
								<tr>
									<th>managerId</th>
									<td><%=notice.getManagerId()%></td>
								</tr>
								<tr>
									<th>noticeDate</th>
									<td><%=notice.getNoticeDate().substring(0, 11)%></td>
								</tr>
								<tr>
									<th>noticeContent</th>
									<td><%=notice.getNoticeContent()%></td>
								</tr>
							</table>

							<hr>
							<div class="text-right">
								<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?noticeNo=<%=notice.getNoticeNo()%>">수정</a>
								<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo()%>">삭제</a>
							</div>
						</article>
						<!-- 댓글 -->
						<div class="blog-comments">
							<h4 class="comments-count">&nbsp;&nbsp;Comments</h4>
							<!-- 댓글 리스트 -->
							<%
								ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
								for (Comment c : commentList) {
							%>
							<div class="comment clearfix">
								<h5><%=c.getManagerId()%><a href="<%=request.getContextPath()%>/notice/deleteCommnetAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=noticeNo%>" class="reply"><i class="icofont-reply"></i> 삭제</a>
								</h5>
								<time datetime="2020-01-01"><%=c.getCommentDate().substring(0, 16)%></time>
								<p>
									<%=c.getCommentContent()%>
								</p>
							</div>
							<%
								}
							%>
							<div class="reply-form">
								<h4 class="maginBottom">Leave a Reply</h4>
								<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp" method="post">
									<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
									<div class="row">
										<div class="col-md-6 form-group">
											<input name="managerId" type="text" class="form-control" value="<%=manager.getManagerId()%>" readOnly="readonly">
										</div>
									</div>
									<div class="row">
										<div class="col form-group">
											<textarea name="commentContent" class="form-control" placeholder="Your Comment" required></textarea>
										</div>
									</div>
									<button type="submit" class="btn btn-primary">댓글 입력</button>
								</form>
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
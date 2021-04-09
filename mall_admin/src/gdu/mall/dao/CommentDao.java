 package gdu.mall.dao;
import gdu.mall.util.*;
import java.sql.*;
import java.util.*;
import gdu.mall.vo.*;

public class CommentDao {
	//게시글에 댓글이 있는지 확인-0리턴 댓글없음 아니면 댓글있음
	public static int selectCommentCnt(int noticeNo) throws Exception{
		int rowCnt = 0;
		String sql="SELECT count(*) cnt from comment WHERE notice_no = ?";
		//DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		//디버깅
		System.out.printf("stmt: %s<CommentDao.selectCommentListByNoticeNo>\n", stmt);
		//쿼리 완성
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			rowCnt = rs.getInt("cnt");
		}
		System.out.printf("rowCnt: %s<CommentDao.SelectCommentCnt>\n", rowCnt);
		return rowCnt;
	}
	//입력
	public static int insertComment(Comment comment) throws Exception{
		//1. sql
		String sql="INSERT INTO comment(notice_no,manager_id,comment_content,comment_date) VALUES(?,?,?,NOW())";
		//2. 초기화
		int rowCnt = 0;
		//3. DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		
		//3-2. 디버깅
		System.out.printf("stmt: %s<CommentDao.insertComment>\n", stmt);
		//4.쿼리 완성
		stmt.executeUpdate();
		//5.리턴값
		return rowCnt;
	}
	//댓글 리스트
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo) throws Exception{
		//select * from comment where notice_no=?
		String sql="SELECT comment_no commentNo, manager_id managerId, comment_content commentContent, comment_date commentDate FROM comment WHERE notice_no=? ORDER BY comment_date DESC";
		//초기화
		ArrayList<Comment> list = new ArrayList<Comment>();
		//DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		//디버깅
		System.out.printf("stmt: %s<CommentDao.selectCommentListByNoticeNo>\n", stmt);
		//쿼리 완성
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			Comment c = new Comment();
			c.setCommentNo(rs.getInt("commentNo"));
			c.setManagerId(rs.getString("managerId"));
			c.setCommentContent(rs.getString("commentContent"));
			c.setCommentDate(rs.getString("commentDate"));
			
			list.add(c);		
		}
		//리턴값
		return list;
		
	}
	//삭제- deleteComment 메서드 오버로딩
	public static int deleteComment(int commentNo) throws Exception{//commentNo
		//delete from comment where comment_no=?
		//sql
		String sql="DELETE FROM comment WHERE comment_no=?";
		//초기화
		int rowCnt = 0;		
		//DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		//디버깅
		System.out.printf("stmt: %s<CommentDao.deleteComment>\n", stmt);
		//쿼리완성
		stmt.executeUpdate();
		
		return rowCnt;
	}
	
	//삭제
	public static int deleteComment(int commentNo, String managerId) throws Exception{//commentNo, managerId
		
		//delete from comment where comment_no=? and manager_id=?
		//sql
		String sql="DELETE FROM comment WHERE comment_no=? and manager_id=?";
		//초기화
		int rowCnt = 0;		
		//DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		//디버깅
		System.out.printf("stmt: %s<CommentDao.deleteComment>\n", stmt);
		//쿼리완성
		stmt.executeUpdate();
		return rowCnt;
	}

}

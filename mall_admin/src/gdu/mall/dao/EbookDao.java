package gdu.mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import gdu.mall.util.*;
import gdu.mall.vo.*;

public class EbookDao {
	//updateEbookState
	public static void updateEbookState(Ebook ebook) throws Exception{
		//sql
				String sql = "UPDATE ebook SET ebook_state=? WHERE ebook_isbn = ?";
				//db연결
				Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, ebook.getEbookState());
				stmt.setString(2, ebook.getEbookISBN());
				//디버깅
				System.out.printf("stmt: %s<EbookDao.updateEbookState>\n",stmt);
				//쿼리 업데이트 완료
				stmt.executeQuery();
	}
	//updateEbookSummary
	public static void updateEbookSummary(Ebook ebook) throws Exception{
		//sql
		String sql = "UPDATE ebook SET ebook_summary=? WHERE ebook_isbn = ?";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookSummary());
		stmt.setString(2, ebook.getEbookISBN());
		//디버깅
		System.out.printf("stmt: %s<EbookDao.updateEbookSummary>\n",stmt);
		//쿼리 업데이트 완료
		stmt.executeQuery();
	}
	
	//updateEbookOne/9개의 정보를 받아 업데이트 하기!
	public static void updateEbookOne(Ebook ebook) throws Exception{
		
		//0.수정 전 ebookISBN 구하기
		String currentEbookISBN = EbookDao.checkEbookISBN(ebook.getEbookNo());
		System.out.printf("currentEbookISBN: %s<EbookDao.updqteEbookOne.jsp>\n", currentEbookISBN);
		//1.sql
		String sql = "UPDATE ebook SET ebook_isbn=?, category_name=? , ebook_title= ?, ebook_author=? , ebook_summary= ?, ebook_company= ?, ebook_page_Count=?, ebook_price=? , ebook_state=? WHERE ebook_isbn=?";
		//2.db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookSummary());
		stmt.setString(6, ebook.getEbookCompany());
		stmt.setInt(7, ebook.getEbookPageCount());
		stmt.setInt(8, ebook.getEbookPrice());
		stmt.setString(9, ebook.getEbookState());
		stmt.setString(10, currentEbookISBN);
		//3.디버깅
		System.out.printf("stmt: %s<EbookDao.updateEbookOne>\n",stmt);
		//4.쿼리 업데이트 완료
		stmt.executeQuery();
		
	}
	//ebookState 배열
	public static String[] ebookStateList() throws Exception{
		//1. 초기화
		String[] list = {"판매중", "품절", "구편절판", "절판"};
		
		return list;
	}
	//ebookOne삭제
	public static void deleteEbookOne(String ebookISBN) throws Exception{
		//sql
		String sql = "DELETE FROM ebook WHERE ebook_isbn= ?";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		
		stmt.executeUpdate();
	}
	
	//img 넣기
	public static int updateEbookImg(Ebook ebook) throws Exception{
		//sql
		String sql="UPDATE ebook SET ebook_img=? WHERE ebook_isbn =?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setString(2, ebook.getEbookISBN());
		int rowCnt = stmt.executeUpdate();
		
		return rowCnt;
	}
	//ISBN 중복 확인
	public static String checkEbookISBN(String ebookISBN) throws Exception{
		//1.sql
		String sql="SELECT ebook_isbn ebookISBN FROM ebook where ebook_isbn=?";
		//2.초기화
		String returnEbookISBN = null;
		//3.db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		
		System.out.printf("stmt: %s <--ebookDao.checkEbookISBN \n",stmt);
		//4.쿼리완성
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnEbookISBN = rs.getString("ebookISBN");
		}
		//5.리턴값
		return returnEbookISBN;
	}
	//ebookNO로 ISBN 확인하기
	public static String checkEbookISBN(int ebookNo) throws Exception{
		//1.sql
		String sql="SELECT ebook_isbn ebookISBN FROM ebook where ebook_no=?";
		//2.초기화
		String currentEbookISBN = null;
		//3.db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		
		System.out.printf("stmt: %s <--ebookDao.checkEbookISBN \n",stmt);
		//4.쿼리완성
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			currentEbookISBN = rs.getString("ebookISBN");
		}
		//5.리턴값
		return currentEbookISBN;
	}
	//
	public static Ebook selectEbookOne(String ebookISBN) throws Exception{
		//sql은 모두 다 가져와야 한다
		String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_summary ebookSummary, ebook_company ebookCompany, ebook_page_Count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_date ebookDate, ebook_state ebookState FROM ebook WHERE ebook_isbn = ?";
		//초기화
		Ebook ebook = null;
		//DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.printf("stmt: %s<EbookDao.selectEbookOne>\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookISBN(rs.getString("ebookISBN"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookDate(rs.getString("ebookDate"));
			ebook.setEbookState(rs.getString("ebookState"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			
		}
		
		return ebook;
	}
	//입력 메서드
	public static int insertEbook(Ebook ebook) throws Exception{
		//1.쿼리 -원래 hide sql에서 해보고 문제 없으면 가져다 붙임
		/*
		 * INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, 
		 * ebook_page_count, ebook_price, ebook_summary,ebook_img, ebook_date, ebook_state )
		 * VALUES (?,?,?,?,?,?,?,?,'default.jpg', NOW(),'판매중')
		 */
		String sql ="INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary,ebook_img, ebook_date, ebook_state ) VALUES (?,?,?,?,?,?,?,?,'default.jpg', NOW(),'판매중')"; 
		//2.초기화
		int rowCnt = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);	
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		
		System.out.printf("stmt: %s<EbookDao.insertEbook>\n", stmt);
		
		rowCnt = stmt.executeUpdate();
		
		return rowCnt;
	}
	//ebooktotalCount구하기
	public static int totalCount(String categoryName) throws Exception{
		//sql - 동적 쿼리임
		String sql = "";
		//초기화
		int totalRow = 0;
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		//쿼리완성
		if(categoryName.equals("")) {//전체보기
			sql = "SELECT COUNT(*) cnt From ebook";
			stmt = conn.prepareStatement(sql);
		} else {//카테고리별 보기
			sql = "SELECT COUNT(*) cnt From ebook WHERE category_name = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
		}
		System.out.printf("stmt: %s<EbookDao.totalCount>\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		//리턴값
		return totalRow;
	}
	//ebookList 만들기 
	public static ArrayList<Ebook> selectEbookListByPage(int beginRow, int rowPerPage, String categoryName) throws Exception{
		//리턴값 초기화
		ArrayList<Ebook> list = new ArrayList<>();
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = null;
		//sql - categoryName에 따른 동적쿼리?
		if(categoryName.equals("")) {//categoryName 없으면
			sql = "SELECT category_name categoryName, ebook_img ebookImg, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {//categoryName 있으면
			sql = "SELECT category_name categoryName, ebook_img ebookImg, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook WHERE category_name = ? ORDER BY ebook_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		System.out.printf("stmt : %s<EbookDao.java>\n",stmt);
		//쿼리완성
		ResultSet rs = stmt.executeQuery();
		
		//리턴값
		while(rs.next()) {
			Ebook e = new Ebook();
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookImg(rs.getString("ebookImg"));
			
			list.add(e);
		}
	
		return list;
	}	
}
	

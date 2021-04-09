package gdu.mall.dao;
import gdu.mall.util.*;
import java.util.*;
import gdu.mall.vo.*;
import java.sql.*;
public class ClientDao {
	//client pw 수정하기
	public static void updateClientPw(String clientMail, String clientPw) throws Exception{
		//1. sql
		String sql = "UPDATE client SET client_pw=PASSWORD(?) WHERE client_mail=?";
		//2. db연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientPw);
		stmt.setString(2, clientMail);
		System.out.printf("stmt updateClientPw :%s\n", stmt);
		
		stmt.executeUpdate();
	}
	//client 수정 목록보기
	public static ArrayList<Client> updateClientForm(String clientMail) throws Exception{
		//1. sql
		String sql = "SELECT client_no as clientNo, client_mail as clientMail, client_pw as clientPw, client_date clientDate FROM client WHERE client_mail=?";
		//2. 초기화
		ArrayList<Client> list = new ArrayList<>();
		//3.db연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);
		System.out.printf("stmt updateCLientForm: %s\n",stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		//4.return값
		while(rs.next()) {
			Client c = new Client();
			c.setClientNo(rs.getInt("clientNo"));
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			c.setClientPw(rs.getString("clientPw"));
			
			list.add(c);
		}
		return list;
	}
	public static void deleteClient(String clientMail) throws Exception{
		//1. sql
		String sql = "DELETE FROM client WHERE client_mail = ?";
		//2. DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);
		System.out.printf("stmt deleteClient :%s\n", stmt);
		
		stmt.executeUpdate();
	}
	//전체 행의 수 -검색 후에도 전체 행이 계속 보임.....searchWord가 있는경우는 ????
	
	public static int totalCount(String searchWord) throws Exception{

		String sql = "";
		int totalRow = 0;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		if(searchWord.equals("")) {
			sql = "SELECT COUNT(*) cnt From client";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT COUNT(*) cnt From client WHERE client_mail like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
		
		System.out.printf("stmt totalClientCount:%s\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		return totalRow;
	}
	/*
	//전체 행의 수
	public static int totalCount(String searchWord) throws Exception{
		String sql = "SELECT COUNT(*) FROM client WHERE client_mail like ?";
		int totalRow = 0;
		
		Connection conn = UBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		System.out.printf("stmt totalClientCount:%s\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRow = rs.getInt("count(*)");
		}
		
		return totalRow;
	}
	*/
	//목록 - 페이지 검색어 시작페이지에따라 목록이 다르게 나옴
	public static ArrayList<Client> selectClientListByPage(int beginRow, int rowPerPage, String searchWord) throws Exception{
		
		
			//!...equals("a") "a"가 아니면 공백도 가능
			// like : client_mail에 ?가 있는지 //검색에 사용
		//2.
		ArrayList<Client> list = new ArrayList<>();
		//3.
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		
		if(searchWord.equals("")) {//검색어가 없으면
			sql = "SELECT client_mail as clientMail, client_date clientDate FROM client ORDER BY client_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.printf("stmt clientListPage: %s\n", stmt);
		} else {// 검색어가 있으면
			sql = "SELECT client_mail as clientMail, client_date clientDate FROM client WHERE client_mail like ? ORDER BY client_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.printf("stmt clientListPage: %s\n", stmt);
		}
		//1.
				/*
				  SELECT client_mail as clientMail, client_date clientDate
				  FROM client
				  ORDER BY client_date DESC
				  LIMIT ?,?
				 */
				


		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			
			list.add(c);
		}
		
		//4.
		return list;
	}
}
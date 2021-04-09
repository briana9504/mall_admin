package gdu.mall.dao;
import gdu.mall.vo.Manager;
import java.util.*;
import java.sql.*;
import gdu.mall.util.*;
public class ManagerDao {
	//level0 리스트
	public static ArrayList<Manager> selectManagerListByZero() throws Exception{
		ArrayList<Manager> list = new ArrayList<>();
		String sql ="SELECT manager_id managerID, manager_date managerDate FROM manager WHERE manager_level = 0 ORDER BY manager_date DESC";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs= stmt.executeQuery();
		 
		 while(rs.next()) {
			 Manager m = new Manager(); // 잠깐 쓰일때 알파벳이나 temp를 쓴다.
			 m.setManagerId(rs.getString("managerID"));
			 m.setManagerDate(rs.getString("managerDate"));
			 
			 list.add(m);
		 }
		 
		 return list;
		
	}
	//managerList 행의 총수 - 매니저아이디 검색에 따라서
	public static int totalCount(String searchWord) throws Exception{

		String sql = "";
		int totalRow = 0;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		if(searchWord.equals("")) {
			sql = "SELECT COUNT(*) cnt From manager";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT COUNT(*) cnt From manager WHERE manager_id like ?";
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
	
	//수정 매서드 - 매니저 레벨수정
	public static int updateManagerLevel(int managerNo, int managerLevel) throws Exception{
		
		//1.sql
		String sql="UPDATE manager SET manager_level=? WHERE manager_no=?";
		//2.리턴값 초기화
		int rowCnt = 0;
		//3.처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerLevel);
		stmt.setInt(2, managerNo);
		System.out.println("stmt updateManagerLevel: "+ stmt);
		
		rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	//삭제 매서드 - 매니저 삭제
	public static int deleteManager(int managerNo) throws Exception{
		//1.sql
		String sql="DELETE FROM manager WHERE manager_no=?";
		//2.리턴값 초기화
		int rowCnt = 0;
		//3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo);
		System.out.println("stmt deleteManager: "+ stmt);
		
		rowCnt = stmt.executeUpdate();
		
		return rowCnt;
	}
	
	
	//목록 메서드 - managerList 목록
	public static ArrayList<Manager> selectManagerList(int beginRow, int rowPerPage, String searchWord) throws Exception{
		//리턴값 초기화
		 ArrayList<Manager> list = new ArrayList<>();	 
		//처리
		 Connection conn = DBUtil.getConnection();
		 PreparedStatement stmt = null;
		 String sql="";
		 
		 if(searchWord.equals("")) {//검색어가 없으면
			sql = "SELECT manager_no managerNo, manager_id managerID, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager ORDER BY manager_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println("stmt managerList: "+ stmt);
		 } else {//검색어가 있으면
			sql = "SELECT manager_no managerNo, manager_id managerID, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager WHERE manager_id like ? ORDER BY manager_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.println("stmt managerList: "+ stmt);
		 }
		 
		 
		 ResultSet rs = stmt.executeQuery();
		 while(rs.next()) {
			 Manager m = new Manager(); // 잠깐 쓰일때 알파벳이나 temp를 쓴다.
			 m.setManagerNo(rs.getInt("managerNo"));
			 m.setManagerId(rs.getString("managerID"));
			 m.setManagerName(rs.getString("managerName"));
			 m.setManagerDate(rs.getString("managerDate"));
			 m.setManagerLevel(rs.getInt("managerLevel"));
			 
			 list.add(m);
		 }
		 
		 //ArrayList에 쿼리 추가
		 
		 
		//4. 리턴
		 return list;
	}
	
	// 입력 메서드 - managerId 생성
	public static int insertManager(String managerId, String managerPw, String managerName) throws Exception {
		//1. sql문
		String sql ="INSERT INTO manager(manager_id, manager_pw, manager_name, manager_date, manager_level) VALUES(?,?,?,now(),0)";
		//2. 리턴타입 초기화
		int rowCnt = 0;// 입력성공시 1, 입력실패시 0	
		//3. DB 핸들링...
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		stmt.setString(3, managerName);
		System.out.println("stmt insertManager:" + stmt);
		rowCnt = stmt.executeUpdate();		
		
		//4. 리턴
		return rowCnt;
	}
	
	// id 사용가능여부 - managerId 생성 겹치는지
	public static String selectManagerId(String managerId) throws Exception {
		// 1. sql문
		String sql = "SELECT manager_id FROM manager WHERE manager_id = ?";
		// 2. 리턴타입 초기화
		String returnManagerId = null;
	
		// 3. DB처리		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		ResultSet rs = stmt.executeQuery();	
		System.out.println("stmt idOverlap:"+ stmt);
		
		if(rs.next()) {
			returnManagerId = rs.getString("manager_id");
		}
		// 4. 리턴
		return returnManagerId;
	}
	
	// 로그인 메서드 - managerLogin
	public static Manager login(String managerId, String managerPw) throws Exception {
		//1. sql
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? AND manager_level>0";
		//2. 리턴타입 초기화
		Manager manager = null;
		//3. DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		System.out.println("stmt managerLogin:"+stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
		return manager;
	}
	
	
}

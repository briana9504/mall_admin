package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.util.*;
import java.sql.*;

public class CategoryDao {
	//카테고리 네임 리스트
	public static ArrayList<String> categoryNameList() throws Exception{
		//1.sql
		String sql = "SELECT category_name categoryName FROM category ORDER BY category_weight desc";
		//2.초기화
		ArrayList<String> list = new ArrayList<>();
		//3.DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.printf("stmt: %s <--EbookDao.categoryNameList \n",stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			String cn =  rs.getString("categoryName");

			list.add(cn);
		}
		
		//4.return값
		return list;
	}
	//delete category
	public static void deleteCategory(String categoryName) throws Exception{
		//1.sql
		String sql = "DELETE FROM category WHERE category_name=?";
		//2.DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		
		System.out.printf("stmt: %s <--CategoryDao.deleteCategory\n",stmt);
		
		stmt.executeUpdate();
	}
	//categoryWeight update
	public static void updateCategoryWeight(String categoryName, int categoryWeight) throws Exception{
		//1.sql
		String sql = "UPDATE category SET category_weight=? WHERE category_name=?";
		//2.DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryWeight);
		stmt.setString(2, categoryName);
		
		System.out.printf("stmt: %s <--CategoryDao.updateCategoryWeight \n",stmt);
		
		stmt.executeUpdate();

	}
	//CategoryName 생성
	public static void insertCategory(String categoryName) throws Exception{
		//1.sql
		String sql = "INSERT INTO category(category_name,category_weight,category_date) VALUES(?,0,now()) ";
		//2.DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		
		System.out.printf("stmt: %s <--CategoryDao.insertCategory \n",stmt);
		
		stmt.executeUpdate();
		
	}
	//CategoryName 중복 확인
	public static String checkCategoryName(String categoryName) throws Exception{
		//1.sql
		String sql = "SELECT category_name categoryName from category WHERE category_name=?";
		//2.초기화
		String returnCategoryName = null;
		//3.DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		
		System.out.printf("stmt: %s <--CategoryDao.overlapCategory \n",stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnCategoryName = rs.getString("categoryName");
		}
		return returnCategoryName;
	}
	
	//CategoryList 생성
	public static ArrayList<Category> categoryList() throws Exception{
		//1.sql
		String sql = "SELECT category_name categoryName, category_weight categoryWeight from category ORDER BY category_weight desc";
		//2.초기화
		ArrayList<Category> list = new ArrayList<>();
		//3.DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.printf("stmt: %s <--CategoryDao.categoryList \n",stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryWeight(rs.getInt("categoryWeight"));
			
			list.add(c);
		}
		
		//4.return값
		return list;
	}

}

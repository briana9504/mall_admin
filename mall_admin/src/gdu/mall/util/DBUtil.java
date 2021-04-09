package gdu.mall.util;

import java.sql.Connection;
import java.sql.DriverManager;
//반복되는 로직의 문제점? 메소드 안에 바꿔야되는값이 생기면 코드안에 모든 반복되는 것들을 바꿔야한다.
	//그러므로 동일한 로직은 따로 메소드로 만들어줘야 한다.
	//*중복된 부분의 사후관리, 유지보수를 위해서 밖으로 빼서 메서드를 만든다.
	
	//DB 연결 메서드 - 입력값은 없음! - mySQL 연결

public class DBUtil {
	public static Connection getConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall","root","java1004");
		return conn;
	}

}

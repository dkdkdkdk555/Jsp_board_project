package user;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn; //데이터베이스에 접근하게 해주는 객체
	private PreparedStatement pstmt; //sql문을 대신 실행시켜 주는 객체
	private ResultSet rs; //sql실행결과를 테이블형태로 pstmt로 부터 리턴받아 그걸 탐색하는 객체
	
	public UserDAO() { //userDAO를 생성했을때 자동으로 DB커넥션이 이루어지도록 한다.
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false"; //내 컴퓨터의 주소.. 3306포트는 컴에 설치된 mySQL 서버 자체를 가리키고 BBS라는 우리가 만든 DB에 접속할 수 있게 해준다.
			String dbID = "root"; //'root'계정에 접속할 수 있게
			String dbPassword = "66cjbv2022"; //root계정의 비밀번호
			Class.forName("com.mysql.cj.jdbc.Driver"); //mySql 드라이버를 찾을 수 있도록 매개로 넣어줌 / 드라이버는 mySql에 접속할 수 있도록 매개체 역할을 해주는 라이브러리(별도의 추가 필요)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//로그인 처리 메소드
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword from user where userID=?";
		try {
			pstmt = conn.prepareStatement(SQL); /*login()을 사용하기 위해 먼저 UserDAO생성자로 객체를 생성해 주는데 여기서 이미 conn,객체참조변수에는  드라이버가 장착되기 때문에
			별도의 Connection 객체를 얻는 코딩을 하지 않아도 된다.*/ 
			pstmt.setString(1,  userID); //첫번째 물음표 자리에 매개로 받은 userID를 바인딩해준다.
			rs = pstmt.executeQuery(); //select문을 실행해주고 그 결과를 ResultSet 객체로 반환한다.
			if(rs.next()) { //결과를 조사한다.
				if(rs.getString(1).equals(userPassword)) //getString(int columnindex) => 첫번째 칼럼인덱스(first column is the one) 가 매개로 주어진 String userPassword 와 같다면
					return 1; //로그인 성공
				else
					return 0; //비밀번호 불일치
			}
			return -1; //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	//회원가입 메소드
	public int join(User user) {
		String sql = "insert into user values(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}

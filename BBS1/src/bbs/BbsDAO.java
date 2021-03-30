package bbs;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn; //데이터베이스에 접근하게 해주는 객체
	//BbsDAO같은경우는 여러개의 함수가 사용되기 때문에 각각의 함수끼리 데이터베이스 접속에 있어서 pstmt는 각 메소드 안에 넣어준다.
	private ResultSet rs; //sql실행결과를 테이블형태로 pstmt로 부터 리턴받아 그걸 탐색하는 객체
	
	public BbsDAO() { //userDAO를 생성했을때 자동으로 DB커넥션이 이루어지도록 한다.
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
	
	//글작성시 현재 서버의 시간을 넣어주는 메소드
	public String getDate() {
		String sql = "select now()"; //현재시간 가져오는 mysql문장
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	public int getNext() {
		String sql = "select bbsID from bbs order by bbsID desc";//가장마지막에 쓰인 게시글번호 셀렉트
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; //마지막에 쓰인글(rs.getInt(1)인데 desc니까 )을 가져와서 그 글의 번호에 1을 더한값이 그 다음 글의 번호.
			}
			return 1; //첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String sql = "insert into BBS values(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate(); // executeUpdate는 성공할시 1을 리턴
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	//페이징 하기 위해 한페이지당 최대 10개의 게시글을 가져오는 메소드
	public ArrayList<Bbs> getList(int pageNumber) {
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10); //게시글이 5개라고 가정하면 getNext()는 6, pageNumber는1(한페이지에 게시글10개)
			//니까 ? 에는 getNext()보다 작은 값이 담길 수 밖에 없다.
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCount(rs.getInt("count"));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//(페이징처리위한메소드) 게시글이 10개밖에 없거나 해당페이지가 게시글이 10개 이하면 다음페이지가 없다고 알려주는 메소드
	public boolean nextPage(int pageNumber) {
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true; //결과가 하나라도 존재한다면 true로 다음페이지로 넘어갈 수 있다고 알려줌
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; //그렇지 않다면 false
	}
	
	public Bbs getBbs(int bbsID) {
		String sql = "select * from bbs where bbsID = ?"; //해당 게시번호의 게시글을 가져옴
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCount(rs.getInt("count"));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; //해당 글이 존재하지 않는경우
	}
	
	//게시판글 삭제하기 
	public boolean deleteBbs(int bbsID) {
		PreparedStatement pstmt = null;
		int flag = 0;
		String sql = "delete from bbs where bbsID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn!=null) conn.close();
				if(pstmt!=null) pstmt.close();
			} catch (Exception e) {}
		}
		if(flag>0) {
			return true;
		} else {
			return false;
		}
	}
	
	//게시판 글  수정하기
	public boolean bbsUpdate(Bbs b) {
		PreparedStatement pstmt = null;
		int flag = 0;
		Bbs bbs = b;
		String sql = "update bbs set bbsTitle= ?, bbsContent = ? where bbsID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbs.getBbsTitle());
			pstmt.setString(2, bbs.getBbsContent());
			pstmt.setInt(3, bbs.getBbsID());
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn!=null) conn.close();
				if(pstmt!=null) pstmt.close();
			} catch (Exception e) {}
		}
		if(flag>0) {
			return true;
		} else {
			return false;
		}
	}
	
	//게시글 클릭시 조회수를 올리는 메소드
	public boolean countUp(int i) {
		PreparedStatement pstmt = null;
		int flag = 0;
		String sql = "update bbs set count = count + 1 where bbsID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, i);
			flag = pstmt.executeUpdate();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(flag>0) {
			return true;
		} else {
			return false;
		}
	}
	
	//자신이 쓴 글이면 올린 조회수를 무효화 시키는 메소드
		public boolean countCancel(int i) {
			PreparedStatement pstmt = null;
			int flag = 0;
			String sql = "update bbs set count = count - 1 where bbsID = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, i);
				flag = pstmt.executeUpdate();	
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(flag>0) {
				return true;
			} else {
				return false;
			}
		}
}

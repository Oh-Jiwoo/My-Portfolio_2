package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class memberDAO {

	private Connection getConnection() throws Exception{
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		
		return con;
	}
	public int userCheck(String id, String passwd){
		int check = -1; 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select * from member1 where id=?";
		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 
				
				
				if(passwd.equals(rs.getString("passwd"))){
					
					check = 1; 
					
				}else{
					check=0;
				}
			}else{
				check = -1;
			}
			
		} catch (Exception e) {
			System.out.println("userCheck메소드 내부에서 오류 : "+ e);
		} finally {
	
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
				} catch (SQLException e) {
					
					e.printStackTrace();
				}
		}
		return check;
		
	}
	
	public int idCheck(String id){
		
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			
			con = getConnection();
			
			sql = "select * from member1 where id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				check = 1;
			}else{
				check = 0;
			}
			
			
		} catch (Exception e) {
			System.out.println("idCheck()메소드에서 오류 : "+e);
		}finally {

			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}//finally

		return check;	
	}
	
	
	public void insertMember(memberBean memberBean){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql ="";
		
		try {
			
			con = getConnection();
			
			sql = "insert into member1 (id,passwd,name,birth,gender,email,postcode,address,address2,mtel)"
				+" values(?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			
			pstmt.setString(1, memberBean.getId());
			pstmt.setString(2, memberBean.getPasswd());
			pstmt.setString(3, memberBean.getName());
			pstmt.setString(4, memberBean.getBirth());
			pstmt.setString(5, memberBean.getGender());
			pstmt.setString(6, memberBean.getEmail());
			pstmt.setString(7, memberBean.getPostcode());
			pstmt.setString(8, memberBean.getAddress());
			pstmt.setString(9, memberBean.getAddress2());
			pstmt.setString(10, memberBean.getMtel());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertMember메소드 내부에서 오류 : "+e);
		}finally {
		
			try {
				if(pstmt != null){ 
					pstmt.close();
				}
				if(con != null){
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		} //finally 끝
		
	} //insertMember 메소드 끝
	
	public memberBean getMember(String id){
		
		memberBean bean = new memberBean();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select * from member1 where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bean.setId(id);
				bean.setPasswd(rs.getString("passwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setPostcode(rs.getString("postcode"));
				bean.setAddress(rs.getString("address"));
				bean.setAddress2(rs.getString("address2"));
				bean.setEmail(rs.getString("email"));
				bean.setMtel(rs.getString("mtel"));
			}
			
		} catch (Exception e) {
			System.out.println("getMember메소드 내부에서 오류"+e);
		} finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		return bean;
	}
	
	public void updateMember(memberBean bean){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql ="";
		
		try {
			con = getConnection();
			sql = "update member1 set name=?, gender=?, email=?, postcode=?, address=?, address2=?, mtel=? where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getGender());
			pstmt.setString(3, bean.getEmail());
			pstmt.setString(4, bean.getPostcode());
			pstmt.setString(5, bean.getAddress());
			pstmt.setString(6, bean.getAddress2());
			pstmt.setString(7, bean.getMtel());
			pstmt.setString(8, bean.getId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateMember메소드 내부에서 오류"+e);
		} finally {
			try {
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}
	
	
} //MemberDAO클래스 끝
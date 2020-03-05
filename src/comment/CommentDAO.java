package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	private Connection getConnection() throws Exception {

		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/jspbeginner");
		con = ds.getConnection();

		return con;
	}

	public void insertComment(CommentBean mBean, int b_num) {

		int num = 0;

		try {
			con = getConnection();

			sql = "insert into comment(num, id, ment, date)" + "value(?,?,?,?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_num);
			pstmt.setString(2, mBean.getId());
			pstmt.setString(3, mBean.getMent());
			pstmt.setTimestamp(4, mBean.getDate());

			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("댓글insert()오류 " + e);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
		}

	} // insertComment 끝

	public CommentBean getComment(int idx) {
		CommentBean commentbean = null;

		try {
			con = getConnection();
			sql = "select * from comment where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				commentbean = new CommentBean();
				commentbean.setId(rs.getString("id"));
				commentbean.setMent(rs.getString("ment"));
				commentbean.setNum(rs.getInt("num"));
				commentbean.setDate(rs.getTimestamp("date"));
			}

		} catch (Exception e) {
			System.out.println("답글getComment에서 오류" + e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
		}
		return commentbean;
	} // getComment끝

	public List<CommentBean> getCommentList(int num) {

		List<CommentBean> commentList = new ArrayList<CommentBean>();

		try {
			con = getConnection();
			sql = "select * from comment where num=? order by num asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CommentBean mbean = new CommentBean();
				mbean = new CommentBean();
				mbean.setIdx(rs.getInt("idx"));
				mbean.setNum(rs.getInt("num"));
				mbean.setId(rs.getString("id"));
				mbean.setMent(rs.getString("ment"));
				mbean.setDate(rs.getTimestamp("date"));

				commentList.add(mbean);
			} // while 끝

		} catch (Exception e) {
			System.out.println("댓글getComment에서 오류" + e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
		}

		return commentList;

	} // getCommentList 끝

	public int getCommentCount(int num) {

		int count = 0;

		try {
			con = getConnection();
			sql = "select count(*) from comment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			System.out.println("댓글getCommentCount에서 오류 : " + e);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception err) {
					err.printStackTrace();
				}
		}

		return count;
	} // getCommentCount 끝

 
	public int deleteComment(int num, String id, int idx) { 
		 
		  int check = 0;
	  try { 
		 con = getConnection(); 
		 sql = "select id from comment where num=?";
		 pstmt = con.prepareStatement(sql); 
		 pstmt.setInt(1, num); 
		 rs = pstmt.executeQuery();

		 if(rs.next()) { 
			 
			 if(id.equals(rs.getString("id"))) { 
	
				 sql="delete from comment where idx=?"; 
				 pstmt = con.prepareStatement(sql);
				 pstmt.setInt(1, idx); 
				 pstmt.executeUpdate(); 
		
				 check = 1;
		
			 } else {
				 return check; 
			 } 
		 } 
	  } catch (Exception e) { 
		  System.out.println("댓글deleteComment오류 : "+e); 
	  } finally {
		  if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
		  if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();} 
		  if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();} 
	  } 
	  	return check;
	  
	  } //deleteComment 끝
	 
	 

}

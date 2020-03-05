package collection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CollectionDAO {
	Connection con = null;
	PreparedStatement pstmt  = null;
	ResultSet rs = null;		
	String sql = "";	
	
	private Connection getConnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		
		return con;
	} 
	
	//수정할 글정보(CollectionBean)객체를 매개변수로 전달받아 DB에 존재하는 비밀번호와
		//글수정 화면에서 입력한 비밀번호가 일치하면 글정보 UPDATE
		public int updateCollection(CollectionBean cBean){
			int check = 0;
			
			try {
				con = getConnection();
				sql = "select passwd from collection where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cBean.getNum());
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(cBean.getPasswd().equals(rs.getString("passwd"))){
						check = 1;
						sql = "update collection set name=?, subject=?, content=? where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, cBean.getName());
						pstmt.setString(2, cBean.getSubject());
						pstmt.setString(3, cBean.getContent());
						pstmt.setInt(4, cBean.getNum());
						
						pstmt.executeUpdate();
						
					}else{
						check = 0;
					}
				}
				
			} catch (Exception e) {
				System.out.println("updateBorad메소드 오류 : "+e);
			} finally {
				
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			return check;
			
		}
		
		//삭제할 글번호와 삭제할 글의 비밀번호를 매개변수로 전달 받아 글을 DELETE삭제 시키는 메소드
		public int deleteCollection(int num, String passwd){
			
			int check = 0; //삭제 성공, 삭제 실패 판단값 1 또는 0 저장할 변수
			
			try {
				con = getConnection();
				sql="select passwd from collection where num=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()){ //검색한 글이 존재하면
					if(passwd.equals(rs.getString("passwd"))){
						check = 1;
						//매개변수로 전달받은 글번호에 해당하는 글삭제
						sql = "delete from collection where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
		
						pstmt.executeUpdate();
					}else{ //비밀번호 틀림
						check = 0;
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			return check; //1또는 0리턴
			
		}
		
		//글번호를 매개변수로 전달받아 글번호에 해당하는하나의 글 검색해서 반환
		public CollectionBean getCollecion(int num){ //conten.jsp에서 호출한 메소드
			CollectionBean collectionbean = null;
			
			try {
				con = getConnection();
				sql="select * from collection where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){ //검색되 글이 존재하면 
					collectionbean = new CollectionBean(); //검색한 정보를 rs에서 꺼내와서 저장할 용도
					//setter메소드를 활용해서 변수에 검색한 값들을 저장
					collectionbean.setContent(rs.getString("content"));
					collectionbean.setDate(rs.getTimestamp("date"));
					collectionbean.setFile(rs.getString("file"));
					collectionbean.setName(rs.getString("name"));
					collectionbean.setNum(rs.getInt("num"));
					collectionbean.setPasswd(rs.getString("passwd"));
					collectionbean.setReadcount(rs.getInt("readcount"));
					collectionbean.setSubject(rs.getString("subject"));
				}//if끝
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return collectionbean; 
			
		} //메소드 끝
		
		
		//글번호를 매개변수로 전달받아 글번호에 해당되는 글의 조회수 1증가시키는 메소드
		public void updateReadCount(int num){ //content.jsp에서 호출하는 메소드
			
			//커넥션풀로부터 커넥션객체 얻기(DB와 미리 연결을 맺은 Connection객체 얻기)
			try {
				con = getConnection();
				
				sql = "update collection set readcount=readcount+1 where num=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
		}
		
		//각페이지 마다 맨위에 첫번째로 보여질 시작글번호, 한페이지당 보여줄 글개수를 매개변수로 전달 받아.
		//SELECT검색한 결과를 ArrayList에 저장후 리턴 하는 메소드 
		public List<CollectionBean> getCollectionList(int startRow,int pageSize){
			
			List<CollectionBean> collectionList = new ArrayList<CollectionBean>();
			
			try{
				con = getConnection();
				sql = "select * from collection limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
			
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					CollectionBean cBean = new CollectionBean();
					
					cBean.setContent(rs.getString("content"));
					cBean.setDate(rs.getTimestamp("date"));
					cBean.setFile(rs.getString("file"));
					cBean.setName(rs.getString("name"));
					cBean.setNum(rs.getInt("num"));
					cBean.setPasswd(rs.getString("passwd"));
					cBean.setReadcount(rs.getInt("readcount"));
					cBean.setSubject(rs.getString("subject"));
						
					//CollectionBean객체 => ArrayList배열에 추가
					collectionList.add(cBean);

				}//while문			
				
			}catch(Exception err){
				System.out.println("getCollectionList메소드 내부에서 오류 : " + err);
			}finally {
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return collectionList;//ArrayList반환
		}
		
		
		//게시판에 저장되어 있는 전체 글 개수 검색 메소드
		public int getCollectionCount(){
			
			int count = 0;//검색한 전체 글 갯수를 저장할 변수 
			
			try {
				con = getConnection();
				sql = "select count(*) from collection";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);//검색한 글의 개수 
				}
			
			} catch (Exception e) {
				System.out.println("getcollecionCount()메소드 오류 : " + e);
			} finally {
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return count;
		}
		
		
		//게시판 새글 추가(주글)
		//-> cwritePro.jsp에서 insertCollection()메소드 호출시.. 
		//   전달한 CollectionBean객체를 이용하여 insert SQL문을 만들자.
		public void insertCollection(CollectionBean cBean){		
			
			int num = 0; //추가할 글번호 저장 용도	
			try{
				con = getConnection();
				//새글 추가시..글번호 구하기
				//-> collection테이블에 저장되어 있는 가장 큰글번호 얻기
				//->글이 없을 경우 : 글번호 1 로 지정
				//->글이 있을 경우 : 최근 글번호(번호가 가장큰값) + 1 로 지정
				sql = "select max(num) from collection";//가장 큰글번호 검색
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){//검색한 데이터가 존재 하면?
					num = rs.getInt(1) + 1; //글이 있을 경우 최대글번호 + 1
				}else{//검색이 되지 않으면?
					num = 1; //글이 없을 경우 
				}
				sql = "insert into collection "
					+ "(num,name,passwd,subject,"
					+ "content,file,"
					+ "readcount,date)"
					+ "values(?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);//추가할 새글번호
				pstmt.setString(2, cBean.getName());//새글을 추가한 작성자 이름
				pstmt.setString(3, cBean.getPasswd());//추가할 새글의 비밀번호
				pstmt.setString(4, cBean.getSubject());//추가할 새글의 글제목
				pstmt.setString(5, cBean.getContent());//추가할 새글의 글내용
				pstmt.setString(6, cBean.getFile());//추가할 새글 데이터중 업로드할 파일명
				pstmt.setInt(7, 0);//추가할 글의 조회수 readcount 0
				pstmt.setTimestamp(8, cBean.getDate());//글 작성 날짜
				
				pstmt.executeUpdate();
				
			}catch(Exception e){
				System.out.println("inserCollection메소드 내부에서 오류:" + e);
			}finally {
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}		
		}//insertCollection메소드 닫는 부분
		
	
	
	
}

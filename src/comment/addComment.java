package comment;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addComment")
public class addComment extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/html;charset=utf-8");
		
		String c_id = request.getParameter("c_id");
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		String c_ment = request.getParameter("c_ment");
		CommentBean mBean = new CommentBean();
		mBean.setId(c_id);
		mBean.setNum(b_num);
		mBean.setMent(c_ment);
		mBean.setDate(new Timestamp(System.currentTimeMillis()));
		
		CommentDAO mdao = new CommentDAO();
		mdao.insertComment(mBean,b_num);
		
		
	}
	
	
	
}

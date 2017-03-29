package cmm529.cw.findafriend.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import cmm529.coursework.friend.model.User;
import cmm529.cw.findafriend.dao.UserDao;

@Path("")
public class WelcomeController {

	private @Inject UserDao userDao;
	
	@GET
	public void getHome(@Context HttpServletRequest request, @Context HttpServletResponse response)
			throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
	
	}
	@Path("login")
	@POST
	public void login(@FormParam("userId") String userId, @Context HttpServletRequest request, @Context HttpServletResponse response)
			throws ServletException, IOException {
		
		if(userDao.findById(userId)==null){
			request.setAttribute("error", "Username was not found.");
			request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		}else{
			HttpSession session = request.getSession();
			session.setAttribute("user", userId);
			request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		}
	
	
	
	
	}
	
	@Path("signup")
	@POST
	public void signup(@FormParam("userId") String userId, @Context HttpServletRequest request, @Context HttpServletResponse response)
			throws ServletException, IOException {
		
		if(userDao.findById(userId)!=null){
			request.setAttribute("signUpError", "Username is already taken.");
			request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		}else{
			
			User user = new User();
			user.setId(userId);
			userDao.save(user);
			
			HttpSession session = request.getSession();
			session.setAttribute("user", userId);
			request.setAttribute("signUpSuccess", "Congratulations! You have created an account.");
			request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		}
	
	
	
	
	}
	
	
	
}
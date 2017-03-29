package cmm529.cw.findafriend.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;

import org.glassfish.jersey.server.mvc.Viewable;

import cmm529.cw.findafriend.NumberGen;
import cmm529.cw.findafriend.dao.UserDao;

@Path("/message")
public class Controller {

	private @Inject NumberGen num;
	
	private @Inject UserDao userDao;

	@Path("/string")
	@GET
	public String getstring(@Context HttpServletRequest request, @Context HttpServletResponse response)
			throws ServletException, IOException {

		// request.setAttribute("test", num.getNum());
		// request.getRequestDispatcher("WEB-INF/test.jsp").forward(request,
		// response);
		return "Injection!! " + userDao.findById("1");
	}

	@GET
	public void getMsg(@Context HttpServletRequest request, @Context HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("test", num.getNum());
		request.getRequestDispatcher("WEB-INF/test.jsp").forward(request, response);
		// return "Injection!! " + num.getNum();
	}

	@Path("/jsp")
	@GET
	public Viewable getJsp() {
		return new Viewable("WEB-INF/test.jsp");
	}

}

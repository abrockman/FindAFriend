package cmm529.cw.findafriend.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import cmm529.coursework.friend.model.Location;
import cmm529.coursework.friend.model.User;
import cmm529.cw.findafriend.dao.UserDao;
import cmm529.cw.findafriend.service.UserService;

@Path("")
public class WelcomeController {

	private @Inject UserDao userDao;

	private @Inject UserService userService;

	@GET
	public void getHome(@Context HttpServletRequest request, @Context HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);

	}

	@Path("login")
	@POST
	public void login(@FormParam("userId") String userId, @Context HttpServletRequest request,
			@Context HttpServletResponse response) throws ServletException, IOException {

		if (userDao.findById(userId) == null) {
			request.setAttribute("error", "Username was not found.");
			request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("user", userId);
			request.getSession().setAttribute("userLoc", userDao.findById(userId).getLocation());
			request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		}

	}

	@Path("signup")
	@POST
	public void signup(@FormParam("userId") String userId, @Context HttpServletRequest request,
			@Context HttpServletResponse response) throws ServletException, IOException {

		if (userDao.findById(userId) != null) {
			request.setAttribute("signUpError", "Username is already taken.");
			request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		} else {

			User user = new User();
			user.setId(userId);
			userDao.save(user);

			HttpSession session = request.getSession();
			session.setAttribute("user", userId);
			request.setAttribute("signUpSuccess", "Congratulations! You have created an account.");
			request.getSession().setAttribute("userLoc", userDao.findById(userId).getLocation());
			request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		}

	}

	@Path("updatelocation")
	@POST
	public void submitLocation(@Context HttpServletRequest request, @Context HttpServletResponse response,
			@FormParam("userId") String userId, @FormParam("lat") double lat, @FormParam("lon") double lon)
			throws IOException {
		System.out.println(userId + ", " + lat + ", " + lon);
		User user = userService.findUserById(userId);
		if (user != null) {
			userService.updateLocation(user, new Location(lon, lat));
		} else {
			// invalid user id
		}
		response.sendRedirect("updatelocation");
		// Submit and forward to GET
	}

	@Path("updatelocation")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public User updateLocation(@Context HttpServletRequest request, @Context HttpServletResponse response) {
		String userId = (String) request.getSession().getAttribute("user");
		User user = userService.findUserById(userId);
		request.getSession().setAttribute("userLoc", user.getLocation());
		return user;
	}

}

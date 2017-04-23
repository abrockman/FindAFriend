package cmm529.cw.findafriend.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import cmm529.coursework.friend.model.Subscription;
import cmm529.coursework.friend.model.SubscriptionRequest;
import cmm529.coursework.friend.model.User;
import cmm529.cw.findafriend.dao.UserDao;
import cmm529.cw.findafriend.service.SubscriptionService;
import cmm529.cw.findafriend.service.UserService;

@Path("subscriptions")
public class SubscriptionController {

	private @Inject SubscriptionService subscriptionService;

	private @Inject UserService userService;

	// Send request
	@Path("subscribe")
	@POST
	public void sendSubscriptionRequest(@FormParam("userId") String subscriber,
			@FormParam("subscribeTo") String subscribeTo, @Context HttpServletRequest request,
			@Context HttpServletResponse response) {
		if (subscriber != null && subscribeTo != null) {
			if (userService.findUserById(subscribeTo) != null) {
				subscriptionService.createNewSubscriptionRequest(subscriber, subscribeTo);
				// return all outstanding requests
				//request.setAttribute("subscriber", subscriber);
				request.setAttribute("Success", "Success");
				System.out.println("subscribe success");
				
			} else {
				// TODO User does not exist
			}
		} else {
			// TODO Invalid parameters
		}

	}

	@Path("subscribe")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Collection<SubscriptionRequest> outstandingSubscriptionRequests(@QueryParam("userId") String userId,
			@Context HttpServletRequest request, @Context HttpServletResponse response) {
		Collection<SubscriptionRequest> subReqs = null;
		if (userId != null && userService.findUserById(userId) != null) {
			subReqs = subscriptionService.findAllOutstanding(userId);
		} else {
			// TODO Invalid user
		}

		return subReqs;

	}

	// Get request
	@Path("pending-approval/{userId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Collection<SubscriptionRequest> getPendingApprovalRequests(@PathParam("userId") String userId,
			@Context HttpServletRequest request, @Context HttpServletResponse response) {
		Collection<SubscriptionRequest> subReqs = null;

		if (userId != null && userService.findUserById(userId) != null) {
			subReqs = subscriptionService.findAllPendingApproval(userId);
		} else {
			// TODO Invalid user
		}

		return subReqs;
	}

	// Delete Subscription
	@Path("delete-subscription")
	@GET
	public void deleteSubscription(@QueryParam("subscriberId") String subscriberId,
			@QueryParam("subscribeTo") String subscribeTo) {
		
		if (subscriberId != null && subscribeTo != null) {
			subscriptionService.deleteSubscription(subscriberId, subscribeTo);
			
		}else{
			//TODO user error
		}
		
	}

	// Search for all requests
	public void getAllRequests() {

	}

	// Approve Request
	@Path("accept-request")
	@POST
	public void approveRequest(@FormParam("subscriberId") String subscriberId,
			@FormParam("subscribeTo") String subscribeTo) {
		// find request entry
		System.out.println(subscriberId + ", " + subscribeTo);
		if (subscriberId != null && subscribeTo != null) {

			SubscriptionRequest subReq = subscriptionService.getSubscriptionRequest(subscriberId, subscribeTo);
			if (subReq != null) {
				subscriptionService.approveRequest(subReq);
			} else {
				// TODO No such subscription request
			}
		} else {
			// TODO invalid parameters
		}
		// accept request with service
	}

	// Decline Request
	@Path("decline-request")
	@POST
	public void declineRequest(@FormParam("subscriberId") String subscriberId,
			@FormParam("subscribeTo") String subscribeTo) {
		// find request entry
		System.out.println(subscriberId + ", " + subscribeTo);
		if (subscriberId != null && subscribeTo != null) {

			SubscriptionRequest subReq = subscriptionService.getSubscriptionRequest(subscriberId, subscribeTo);
			if (subReq != null) {
				subscriptionService.declineRequest(subReq);
			} else {
				// TODO No such subscription request
			}
		} else {
			// TODO invalid parameters
		}
		// accept request with service
	}

	// get users subscriptions
	@Path("subscription/{userId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Subscription getSubscription(@PathParam("userId") String userId, HttpServletResponse response) {

		if (userId != null || userService.findUserById(userId) != null) {
			return subscriptionService.getSubscription(userId);
		} else {
			// TODO No user param
			response.setStatus(404);
			return null;
		}
	}

	@Path("subscription-locations")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Collection<User> subscriptionLocations(@QueryParam("userId") String userId) {
		Subscription requester = subscriptionService.getSubscription(userId);
		Collection<User> allUsers = new ArrayList<>();
		for (String user : requester.getSubscribeTo()) {
			allUsers.add(userService.findUserById(user));
		}
		return allUsers;
	}
}

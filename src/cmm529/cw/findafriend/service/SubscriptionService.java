package cmm529.cw.findafriend.service;

import java.util.List;

import cmm529.coursework.friend.model.Subscription;
import cmm529.coursework.friend.model.SubscriptionRequest;

public interface SubscriptionService {
	
	public void createNewSubscriptionRequest(String subscriberId, String subscribeTo);
	
	public List<SubscriptionRequest> findAllOutstanding(String subsciberId);

	public List<SubscriptionRequest> findAllPendingApproval(String subscibeToId);
	
	public void approveRequest(SubscriptionRequest subReq);
	
	public void declineRequest(SubscriptionRequest subReq);
	
	public Subscription getSubscription(String subscriberId);
}

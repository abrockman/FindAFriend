package cmm529.cw.findafriend.dao;

import java.util.List;

import cmm529.coursework.friend.model.SubscriptionRequest;

public interface SubscriptionRequestDao {
	
	
	public void deleteSubscriptionRequest(SubscriptionRequest subReq);
	
	public void save(SubscriptionRequest subReq);
	
	public List<SubscriptionRequest> findSubscriptionReqBySender(String subscriberId);
	
	public List<SubscriptionRequest> findSubscriptionReqByReciever(String subscribeToId);

	public SubscriptionRequest findSubsciptionRequest(String subscriberId, String subscripeToId);
}

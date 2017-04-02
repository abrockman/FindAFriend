package cmm529.cw.findafriend.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import cmm529.coursework.friend.model.Subscription;
import cmm529.coursework.friend.model.SubscriptionRequest;
import cmm529.cw.findafriend.dao.SubscriptionDao;
import cmm529.cw.findafriend.dao.SubscriptionRequestDao;

public class SubscriptionServiceImpl implements SubscriptionService {

	private @Inject SubscriptionDao subscriptionDao;
	private @Inject SubscriptionRequestDao subscriptionRequestDao;
	
	@Override
	public void createNewSubscriptionRequest(String subscriberId, String subscribeTo) {
		SubscriptionRequest subReq = new SubscriptionRequest();
		subReq.setSubscriberId(subscriberId);
		subReq.setSubscribeTo(subscribeTo);
		subReq.setTimeStamp(new Date().getTime());
		subscriptionRequestDao.save(subReq);

	}

	@Override
	public List<SubscriptionRequest> findAllOutstanding(String subscriberId) {
		return subscriptionRequestDao.findSubscriptionReqBySender(subscriberId);
	}

	@Override
	public List<SubscriptionRequest> findAllPendingApproval(String subscribeToId) {
		return subscriptionRequestDao.findSubscriptionReqByReciever(subscribeToId);
	}

	@Override
	public void approveRequest(SubscriptionRequest subReq) {
		Subscription sub = subscriptionDao.findById(subReq.getSubscriberId());
		sub.setSubscriberId(subReq.getSubscriberId());
		sub.getSubscribeTo().add(subReq.getSubscribeTo());
		subscriptionDao.save(sub);

	}

	@Override
	public void declineRequest(SubscriptionRequest subReq) {
		subscriptionRequestDao.deleteSubscriptionRequest(subReq);
	}

	@Override
	public Subscription getSubscription(String subscriberId) {
		return subscriptionDao.findById(subscriberId);
	}
	
	public SubscriptionRequest getSubscriptionRequest(String subscriberId, String subscribeToId){
		return subscriptionRequestDao.findSubsciptionRequest(subscriberId, subscribeToId);
	}
	
	
	
	

}

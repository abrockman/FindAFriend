package cmm529.cw.findafriend.dao;

import java.util.List;

import cmm529.coursework.friend.model.SubscriptionRequest;

public class SubscriptionRequestDaoImpl extends AbstractDynamoDao<SubscriptionRequest> implements SubscriptionRequestDao {

	@Override
	public void deleteSubscriptionRequest(SubscriptionRequest subReq) {
		delete(subReq);

	}

	@Override
	public void save(SubscriptionRequest subReq) {
		persist(subReq);

	}

	@Override
	public List<SubscriptionRequest> findSubscriptionReqBySender(String subscriberId) {
		return searchFor("subscriber", subscriberId);
	}

	@Override
	public List<SubscriptionRequest> findSubscriptionReqByReciever(String subscribeToId) {
		return searchFor("subscribeTo", subscribeToId);
	}

}

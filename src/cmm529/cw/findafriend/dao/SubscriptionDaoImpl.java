package cmm529.cw.findafriend.dao;

import cmm529.coursework.friend.model.Subscription;

public class SubscriptionDaoImpl extends AbstractDynamoDao<Subscription> implements SubscriptionDao {

	@Override
	public Subscription findById(String subscribeToId) {
		return super.findById(subscribeToId);
	}

	@Override
	public void delete(Subscription subscription) {
		super.delete(subscription);
	}

	@Override
	public void save(Subscription subscription) {
		persist(subscription);
	}

}

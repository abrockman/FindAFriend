package cmm529.cw.findafriend.dao;

import cmm529.coursework.friend.model.Subscription;

public interface SubscriptionDao {

	public Subscription findById(String subscribeToId);
	
	public void delete(Subscription subscription);
	
	public void save(Subscription subscription);
	
}

package cmm529.cw.findafriend.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBQueryExpression;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBScanExpression;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;

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

	@Override
	public SubscriptionRequest findSubsciptionRequest(String subscriberId, String subscripeToId) {
		
		Map<String, AttributeValue> map = new HashMap<>();
		map.put(":val1", new AttributeValue().withS(subscriberId));
		map.put(":val2", new AttributeValue().withS(subscripeToId));
		DynamoDBQueryExpression<SubscriptionRequest> scanCrit = new DynamoDBQueryExpression<SubscriptionRequest>()
				.withKeyConditionExpression("subscriber = :val1 and subscribeTo = :val2")
				.withExpressionAttributeValues(map);
		List<SubscriptionRequest> list = super.getMapper().query(SubscriptionRequest.class, scanCrit);
		if(list.size()>0){
			return list.get(0);
		}
		return null;
	}
	
	

}

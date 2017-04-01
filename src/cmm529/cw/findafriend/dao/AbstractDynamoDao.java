package cmm529.cw.findafriend.dao;

import java.lang.reflect.ParameterizedType;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBScanExpression;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;

public abstract class AbstractDynamoDao<T> {

	private final Class<T> persistentClass;
	private final AmazonDynamoDB dynamoDB;
	private final DynamoDBMapper mapper;

	@SuppressWarnings("unchecked")
	public AbstractDynamoDao() {
		this.persistentClass = (Class<T>) ((ParameterizedType) this.getClass().getGenericSuperclass())
				.getActualTypeArguments()[0];
		this.dynamoDB = AmazonDynamoDBClientBuilder.standard().withRegion(Regions.US_WEST_2).build();
		mapper = new DynamoDBMapper(dynamoDB);
	}

	public T findById(String id) {
		return mapper.load(persistentClass, id);
	}

	public List<T> findAll() {
		return mapper.scan(persistentClass, new DynamoDBScanExpression());
	}

	public void persist(T entity) {
		mapper.save(entity);
	}

	public void delete(T entity) {
		if(entity != null){
			mapper.delete(entity);
		}
	}

	public List<T> searchFor(String attributeName, String attributeValue) {
		Map<String, AttributeValue> map = new HashMap<>();
		map.put(":val1", new AttributeValue().withS(attributeValue));
		DynamoDBScanExpression scanCrit = new DynamoDBScanExpression().withFilterExpression(attributeName + ":val1")
				.withExpressionAttributeValues(map);
		return mapper.scan(persistentClass, scanCrit);
	}

}

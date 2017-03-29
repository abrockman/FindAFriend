package cmm529.cw.findafriend.dao;

import java.util.List;

import org.jvnet.hk2.annotations.Service;

import cmm529.coursework.friend.model.User;

@Service
public class UserDaoImpl extends AbstractDynamoDao<User> implements UserDao {

	public UserDaoImpl() {
		super();
	}
	
	@Override
	public List<User> findAll() {
		return super.findAll();
	}

	@Override
	public User findById(String id) {
		return super.findById(id);
	}

	@Override
	public void save(User user) {
		persist(user);

	}

	@Override
	public void delete(User user) {
		// TODO Implement

	}
	
	public static void main(String[] args) {
		UserDaoImpl user = new UserDaoImpl();
	System.out.println(user.findAll().size());
	}

}

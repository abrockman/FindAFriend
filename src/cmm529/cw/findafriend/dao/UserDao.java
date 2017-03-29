package cmm529.cw.findafriend.dao;

import java.util.List;

import org.jvnet.hk2.annotations.Contract;

import cmm529.coursework.friend.model.User;

@Contract
public interface UserDao {

	public List<User> findAll();

	public User findById(String id);

	public void save(User user);

	public void delete(User user);

}

package cmm529.cw.findafriend.service;

import org.jvnet.hk2.annotations.Contract;

import cmm529.coursework.friend.model.Location;
import cmm529.coursework.friend.model.User;

@Contract
public interface UserService {

	
	public void save(User user);
	
	public void updateLocation(User user, Location location);
	
	public User findUserById(String id);
	
	
}

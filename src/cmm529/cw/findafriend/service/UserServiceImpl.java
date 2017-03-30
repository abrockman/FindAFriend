package cmm529.cw.findafriend.service;

import java.util.Date;

import javax.inject.Inject;

import org.jvnet.hk2.annotations.Service;

import cmm529.coursework.friend.model.Location;
import cmm529.coursework.friend.model.User;
import cmm529.cw.findafriend.dao.UserDao;

@Service
public class UserServiceImpl implements UserService {

	private @Inject UserDao userDao;
	
	@Override
	public void save(User user) {
		userDao.save(user);

	}

	@Override
	public void updateLocation(User user, Location location) {
		user.setLocation(location);
		user.setLastUpdated(new Date().getTime());
		userDao.save(user);
		System.out.println("USER OBJ: " + user.getId() + ", " + user.getLastUpdated() + ", " + user.getLocation());

	}
	
	public User findUserById(String id){
		return userDao.findById(id);
		
	}

}

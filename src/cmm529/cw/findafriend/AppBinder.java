package cmm529.cw.findafriend;

import org.glassfish.hk2.utilities.binding.AbstractBinder;

import cmm529.cw.findafriend.dao.UserDao;
import cmm529.cw.findafriend.dao.UserDaoImpl;
import cmm529.cw.findafriend.service.UserService;
import cmm529.cw.findafriend.service.UserServiceImpl;

public class AppBinder extends AbstractBinder  {

	@Override
	protected void configure() {
		bind(NumberGenImpl.class).to(NumberGen.class);
		bind(UserDaoImpl.class).to(UserDao.class);
		bind(UserServiceImpl.class).to(UserService.class);
		
	}

}

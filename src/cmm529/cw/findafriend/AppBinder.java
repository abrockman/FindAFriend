package cmm529.cw.findafriend;

import org.glassfish.hk2.utilities.binding.AbstractBinder;

import cmm529.cw.findafriend.dao.SubscriptionDao;
import cmm529.cw.findafriend.dao.SubscriptionDaoImpl;
import cmm529.cw.findafriend.dao.SubscriptionRequestDao;
import cmm529.cw.findafriend.dao.SubscriptionRequestDaoImpl;
import cmm529.cw.findafriend.dao.UserDao;
import cmm529.cw.findafriend.dao.UserDaoImpl;
import cmm529.cw.findafriend.service.SubscriptionService;
import cmm529.cw.findafriend.service.SubscriptionServiceImpl;
import cmm529.cw.findafriend.service.UserService;
import cmm529.cw.findafriend.service.UserServiceImpl;

public class AppBinder extends AbstractBinder  {

	@Override
	protected void configure() {
		bind(NumberGenImpl.class).to(NumberGen.class);
		bind(UserDaoImpl.class).to(UserDao.class);
		bind(UserServiceImpl.class).to(UserService.class);
		bind(SubscriptionRequestDaoImpl.class).to(SubscriptionRequestDao.class);
		bind(SubscriptionDaoImpl.class).to(SubscriptionDao.class);
		bind(SubscriptionServiceImpl.class).to(SubscriptionService.class);
		
	}

}

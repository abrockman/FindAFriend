package cmm529.cw.findafriend;

import org.jvnet.hk2.annotations.Service;

@Service
public class NumberGenImpl implements NumberGen {

	public NumberGenImpl() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public double getNum() {
		return Math.random();
	}

}

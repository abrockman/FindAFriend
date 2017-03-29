package cmm529.cw.findafriend;

import javax.ws.rs.core.Feature;
import javax.ws.rs.core.FeatureContext;

public class FeatureImpl implements Feature {

	@Override
	public boolean configure(FeatureContext arg0) {
		arg0.register(new AppBinder());
		return true;
	}

}

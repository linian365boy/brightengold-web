package com.brightengold.util;

import org.apache.tiles.factory.AbstractTilesContainerFactory;
import org.apache.tiles.request.ApplicationContext;
import org.apache.tiles.startup.AbstractTilesInitializer;

public class BgTilesInitializer extends AbstractTilesInitializer {
	@Override
	protected AbstractTilesContainerFactory createContainerFactory(
			ApplicationContext context) {
		// TODO Auto-generated method stub
		return new BgTilesContainerFactory();
	}
}

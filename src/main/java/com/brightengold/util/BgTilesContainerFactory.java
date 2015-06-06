package com.brightengold.util;

import org.apache.tiles.TilesContainer;
import org.apache.tiles.evaluator.AttributeEvaluatorFactory;
import org.apache.tiles.factory.BasicTilesContainerFactory;
import org.apache.tiles.request.ApplicationContext;
import org.apache.tiles.request.render.BasicRendererFactory;

public class BgTilesContainerFactory extends BasicTilesContainerFactory {
	@Override
	protected void registerAttributeRenderers(
			BasicRendererFactory rendererFactory,
			ApplicationContext applicationContext, TilesContainer container,
			AttributeEvaluatorFactory attributeEvaluatorFactory) {  
		   super.registerAttributeRenderers(rendererFactory, applicationContext,
		            container, attributeEvaluatorFactory);
	}
}

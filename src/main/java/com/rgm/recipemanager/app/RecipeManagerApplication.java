package com.rgm.recipemanager.app;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.servlet.GuiceServletContextListener;
import com.google.inject.servlet.ServletModule;

public class RecipeManagerApplication extends GuiceServletContextListener
{

	@Override
	protected Injector getInjector()
	{
		return Guice.createInjector(new ServletModule() {
			@Override
		    protected void configureServlets() 
			{
				super.configureServlets();
				
				serve("/modify/*").with(ModifyRecipeServlet.class);
		    }
		});
	}
}

package com.rgm.recipemanager.app;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Scopes;
import com.google.inject.persist.PersistFilter;
import com.google.inject.persist.jpa.JpaPersistModule;
import com.google.inject.servlet.GuiceServletContextListener;
import com.google.inject.servlet.ServletModule;
import com.rgm.recipemanager.domain.Recipe;

public class RecipeManagerServletContextListener extends GuiceServletContextListener
{

	@Override
	protected Injector getInjector()
	{
		return Guice.createInjector(new ServletModule() {
			@Override
		    protected void configureServlets() 
			{				
				install(new JpaPersistModule("imported-recipes"));
				filter("/*").through(PersistFilter.class);
				
				bind(ModifyRecipeServlet.class).in(Scopes.SINGLETON);
				bind(Recipe.class);
				
				serve("/modify/*").with(ModifyRecipeServlet.class);
		    }
		});
	}
}

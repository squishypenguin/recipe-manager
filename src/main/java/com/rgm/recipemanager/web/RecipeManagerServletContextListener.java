package com.rgm.recipemanager.web;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Scopes;
import com.google.inject.matcher.Matchers;
import com.google.inject.persist.PersistFilter;
import com.google.inject.persist.jpa.JpaPersistModule;
import com.google.inject.servlet.GuiceServletContextListener;
import com.google.inject.servlet.ServletModule;
import com.rgm.recipemanager.domain.Recipe;
import com.rgm.recipemanager.service.Slf4jTypeListener;

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
				
				//bindListener(Matchers.any(), new Slf4jTypeListener());
				bind(ViewServlet.class).in(Scopes.SINGLETON);
				bind(Recipe.class);
				
				serve("/modify/*").with(ViewServlet.class);
				serve("/ingredientSearch").with(ViewServlet.class);
				serve("/viewRecipe").with(ViewServlet.class);
				serve("/addRecipe").with(ViewServlet.class);
		    }
		});
	}
}

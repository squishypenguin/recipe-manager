package com.rgm.recipemanager.web;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.inject.Inject;
import com.google.inject.Injector;
import com.google.inject.Singleton;
import com.rgm.recipemanager.dao.RecipeRepository;
import com.rgm.recipemanager.domain.Recipe;

@Singleton
public class ViewServlet extends HttpServlet
{
	private static final long serialVersionUID = -3629584595013082227L;
	@Inject Injector injector;
	@Inject RecipeRepository recipeRepository;
	@Inject private Logger logger;
	
	// yes... this needs to be handled more appropriately - or just scrap guice and go to spring
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String page;
		switch (request.getRequestURI())
		{
			case "/ingredientSearch":
				page = "/WEB-INF/pages/ingredientSearch.jsp";
				break;
			case "/viewRecipe":
				page = "/WEB-INF/pages/viewRecipe.jsp";
				break;
			case "/addRecipe":
				page = "/WEB-INF/pages/addRecipe.jsp";
				break;
			default:
				page = "/";
		}
		request.getRequestDispatcher(page).include(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		final Recipe recipe = injector.getInstance(Recipe.class);
		recipe.processRequest();
		
		// TODO trigger a solr reindex to get this data
		// TODO need a way to regenerate the tags
		switch (request.getRequestURI())
		{
			case "/addRecipe":
				logger.info("Directing to create recipe");
				recipeRepository.createRecipe(recipe);
				break;
			default:
				logger.info("Directing to update recipe: " + recipe.getUrl());
				recipeRepository.updateRecipe(recipe);
		}
		response.sendRedirect("/");
	}
}

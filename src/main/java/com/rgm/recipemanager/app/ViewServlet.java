package com.rgm.recipemanager.app;

import java.io.IOException;

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
	
	// yes... this needs to be handled more appropriately
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
				recipeRepository.getRecipe(Long.valueOf(request.getParameter("id")));
				page = "/WEB-INF/pages/viewRecipe.jsp";
				break;
			case "/createRecipe":
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
		
		switch (request.getRequestURI())
		{
			case "/addRecipe":
				recipeRepository.createRecipe(recipe);
				break;
			default:
				recipeRepository.updateRecipe(recipe);
		}
		response.sendRedirect("/");
	}
}

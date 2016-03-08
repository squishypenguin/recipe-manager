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
public class ModifyRecipeServlet extends HttpServlet
{
	private static final long serialVersionUID = -3629584595013082227L;
	@Inject Injector injector;
	@Inject RecipeRepository recipeRepository;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getOutputStream().print("you got me");
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		final Recipe recipe = injector.getInstance(Recipe.class);
		recipe.processRequest();
		
		recipeRepository.updateRecipe(recipe);
		response.getOutputStream().print("posted me up");		
	}
}

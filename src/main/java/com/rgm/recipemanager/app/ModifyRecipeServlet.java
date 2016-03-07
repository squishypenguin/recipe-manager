package com.rgm.recipemanager.app;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import com.rgm.recipemanager.service.RecipeService;

@Singleton
public class ModifyRecipeServlet extends HttpServlet
{
	private static final long serialVersionUID = -3629584595013082227L;

	@Inject RecipeService recipeService;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getOutputStream().print("you got me");
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getOutputStream().print("post me up");
	}
}

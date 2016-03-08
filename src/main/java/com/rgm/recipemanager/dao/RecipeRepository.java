package com.rgm.recipemanager.dao;

import javax.persistence.EntityManager;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;
import com.rgm.recipemanager.domain.Recipe;

@Singleton
public class RecipeRepository
{
	@Inject private Provider<EntityManager> entityManagerProvider;	
		
	public void updateRecipe(Recipe recipe)
	{
		final EntityManager entityManager = entityManagerProvider.get();
		entityManager.getTransaction().begin();
		entityManager.merge(recipe);
		entityManager.getTransaction().commit();
	}
	
	public void createRecipe(Recipe recipe)
	{
		final EntityManager entityManager = entityManagerProvider.get();
		entityManager.getTransaction().begin();
		entityManager.persist(recipe);
		entityManager.getTransaction().commit();
	}
}

package com.rgm.recipemanager.dao;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;
import com.rgm.recipemanager.domain.Recipe;

// get the @Transactional working so this looks prettier
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

	// create procs
	public Recipe getRecipe(Long recipeId)
	{
		final EntityManager entityManager = entityManagerProvider.get();
		final Query query = entityManager.createQuery("select id,name,CONVERT(attributes_blob USING utf8) as attributes,CONVERT(ingredients_blob USING utf8) as ingredients,CONVERT(directions_blob USING utf8) as directions,notes,url from imported_recipe where id=" + recipeId);
		
		entityManager.getTransaction().begin();
		final Recipe recipe = (Recipe)query.getSingleResult();
		entityManager.getTransaction().commit();
		
		return recipe;
	}
}

package com.rgm.recipemanager.domain;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.StringUtils;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

import com.google.common.collect.Lists;
import com.google.inject.Inject;
import com.google.inject.servlet.RequestParameters;
import com.google.inject.servlet.RequestScoped;
import com.rgm.recipeimporter.IngredientTagsBuilder;

// mixing causes here and duplicated with importer - consolidate and reuse
@Entity @Table(name="imported_recipe")
@NoArgsConstructor
@RequestScoped
public @Data class Recipe
{
	@Inject @RequestParameters @Transient
	private Map<String, String[]> parameters;
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Lob @Basic(fetch=FetchType.LAZY)
	@Column(name="attributes_blob")
	private String attributes;
	
	@Lob @NonNull @Basic(fetch=FetchType.LAZY)
	@Column(name="ingredients_blob")
	private String ingredients;
	
	@Lob @NonNull @Basic(fetch=FetchType.LAZY)
	@Column(name="directions_blob")
	private String directions;
	
	@NonNull @Column(name="name")
	private String name;
	
	@NonNull @Column(name="url")
	private String url;
	
	@Column(name="url_domain")
	private String urlDomain;
	
	@Column(name="notes")
	private String notes;
	
	@NonNull @Column(name="ingredients_tags")
	private String ingredientsTags;
	
	public void processRequest()
	{
		final String[] paramId = parameters.get("id");
		if (paramId != null)
		{
			setId(Long.valueOf(paramId[0]));
		}
		setName((String)parameters.get("name")[0]);
		
		final String attributes = (String)parameters.get("attributes")[0];
		setAttributes(StringUtils.join(StringUtils.split(attributes, "\n"), "|"));
		
		final String directions = (String)parameters.get("directions")[0];
		setDirections(StringUtils.join(StringUtils.split(directions, "\n"), "|"));
		
		final String notes = (String)parameters.get("notes")[0];
		setNotes(StringUtils.join(StringUtils.split(notes, "\n"), "|"));

		final String url = (String)parameters.get("url")[0];
		setUrl(url);
		try
		{
			setUrlDomain(new URL(url).getHost());
		} 
		catch (MalformedURLException e)
		{
			e.printStackTrace();
		}

		final String ingredientsBlob = (String)parameters.get("ingredients")[0];
		final String[] lines = StringUtils.split(ingredientsBlob, "\n");
		setIngredients(StringUtils.join(lines, "|"));
		
		final Set<String> ingredientsTags = new IngredientTagsBuilder().withIngredientsList(Lists.newArrayList(lines)).build();
		setIngredientsTags(StringUtils.join(ingredientsTags, "|"));
	}
}

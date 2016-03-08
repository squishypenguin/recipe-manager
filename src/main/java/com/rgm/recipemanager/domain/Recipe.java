package com.rgm.recipemanager.domain;

import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

import com.google.inject.Inject;
import com.google.inject.servlet.RequestParameters;
import com.google.inject.servlet.RequestScoped;

// mixing causes here
@Entity @Table(name="imported_recipe")
@NoArgsConstructor
@RequestScoped
public @Data class Recipe
{
	@Inject @RequestParameters @Transient
	private Map<String, String[]> parameters;
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Lob @Column(name="attributes_blob")
	private String attributes;
	
	@Lob @NonNull @Column(name="ingredients_blob")
	private String ingredients;
	
	@Lob @NonNull @Column(name="directions_blob")
	private String directions;
	
	@NonNull @Column(name="name")
	private String name;
	
	@NonNull @Column(name="url")
	private String url;
	
	@Column(name="notes")
	private String notes;
	
	public void processRequest()
	{
		setId(Long.valueOf(parameters.get("id")[0]));
		setName((String)parameters.get("name")[0]);
		setUrl((String)parameters.get("url")[0]);
		setAttributes((String)parameters.get("attributes")[0]);
		setIngredients((String)parameters.get("ingredients")[0]);
		setDirections((String)parameters.get("directions")[0]);
		setNotes((String)parameters.get("notes")[0]);
	}
}

package com.rgm.recipemanager.service;

import java.lang.reflect.Field;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.inject.MembersInjector;

public class Slf4jMembersInjector<T> implements MembersInjector<T>
{
	private final Field field;
	private final Logger logger;
	
	public Slf4jMembersInjector(Field aField) 
	{
    	field = aField;
    	logger = LoggerFactory.getLogger(field.getDeclaringClass());
    	field.setAccessible(true);
    }
	
	@Override
	public void injectMembers(T instance)
	{
		try 
		{
			field.set(instance, logger);
		} 
		catch (IllegalAccessException e) 
		{
			throw new RuntimeException(e);
		}
	}
}

package com.rgm.recipemanager.service;

import java.lang.reflect.Field;

import org.apache.logging.log4j.Logger;

import com.google.inject.spi.TypeEncounter;
import com.google.inject.spi.TypeListener;

public class Slf4jTypeListener implements TypeListener
{
	@Override
	public <I> void hear(com.google.inject.TypeLiteral<I> aTypeLiteral, TypeEncounter<I> aTypeEncounter)
	{
		for (Field field : aTypeLiteral.getRawType().getDeclaredFields()) 
		{
			if ((field.getType() == Logger.class) && field.isAnnotationPresent(InjectLogger.class)) 
			{
	        	aTypeEncounter.register(new Slf4jMembersInjector<I>(field));
			}
		}
	}
}

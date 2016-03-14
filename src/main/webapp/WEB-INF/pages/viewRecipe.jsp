<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>View a Recipe</title>
</head>
<body>
	<form action="/modify/" method="post">
		<input type="hidden" id="idField" name="id" />
		<table>
			<tr><td>Name</td><td><input type="text" size="100" id="nameField" name="name" /></td></tr>
			<tr><td>URL</td><td><input type="text" size="100" id="urlField" name="url" /></td></tr>
			<tr><td>Attributes</td><td><textarea id="attributesField" rows="4" cols="80" name="attributes"></textarea></td></tr>
			<tr><td>Ingredients</td><td><textarea id="ingredientsField" rows="4" cols="80" name="ingredients"></textarea></td></tr>
			<tr><td>Directions</td><td><textarea id="directionsField" rows="6" cols="80" name="directions"></textarea></td></tr>
			<tr><td>Notes</td><td><textarea id="notesField" rows="2" cols="80" name="notes"></textarea></td></tr>
		</table>
		<input type="submit" title="Save" />
	</form>
</body>
</html>
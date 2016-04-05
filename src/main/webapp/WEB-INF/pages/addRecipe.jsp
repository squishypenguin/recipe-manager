<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Add a recipe</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	</head>
	<body>
		<div class="container">
			<form action="/addRecipe" method="post">
				<div class="form-group"><label for="nameField">Name</label><input type="text" size="100" id="nameField" name="name" class="form-control" /></div>
				<div class="form-group"><label for="urlField">URL</label><input type="text" size="100" id="urlField" name="url" class="form-control" /></div>
				<div class="form-group"><label for="attributesField">Attributes</label><textarea id="attributesField" rows="6" name="attributes" class="form-control"></textarea></div>
				<div class="form-group"><label for="ingredientsField">Ingredients</label><textarea id="ingredientsField" rows="8" name="ingredients" class="form-control"></textarea></div>
				<div class="form-group"><label for="directionsField">Directions</label><textarea id="directionsField" rows="8" name="directions" class="form-control"></textarea></div>
				<div class="form-group"><label for="notesField">Notes</label><textarea id="notesField" rows="2" name="notes" class="form-control"></textarea></div>
				<button type="submit" class="btn btn-default">Save</button>
			</form>
		</div>
	</body>
</html>
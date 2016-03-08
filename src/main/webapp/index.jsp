<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Recipe Search</title>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function() {
		$("#searchResults").hide();
		
		$('#searchButton').click(function(event) {
		   event.preventDefault();

			var solrBaseQuery = "http://localhost:8983/solr/recipes/select?q=";

			var searchTerm = $("#urlSearchField").val();
			searchTerm = encodeURIComponent(searchTerm);
			searchTerm = searchTerm.replace(/\./g,'%2E');
			searchTerm = searchTerm.replace(/-/g,'%2D');
			var queryString = "url:%22"+searchTerm+"%22";

			var queryurl = solrBaseQuery+queryString+"&wt=json&rows=1";
			$.ajax({
				'url': queryurl,
				'crossDomain': 'true',
				'success': function(data) { 
					$("#query").val(searchTerm);
					$("#idField").val(data.response.docs[0].id);
					$("#nameField").val(data.response.docs[0].name);
					$("#urlField").val(data.response.docs[0].url);
					$("#attributesField").val(data.response.docs[0].attributes);
					$("#ingredientsField").val(data.response.docs[0].ingredients);
					$("#directionsField").val(data.response.docs[0].directions);
					$("#notesField").val(data.response.docs[0].notes);
					$("#searchResults").show();
				},
				'dataType': 'jsonp',
				'jsonp': 'json.wrf',
				encodeData:false
			});
		});
	});
	</script>
</head>
<body>
	<label for="urlSearchField">Search by URL:</label><input type="text" size="100" id="urlSearchField" /><p/>
	<button id="searchButton">Search</button>
	<p>OR</p>
	<a href="ingredientSearch.jsp">Search by Ingredient</a>
	<hr />
	<div id="searchResults">
		<div>Search Results for:<span id="query"></span></div>
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
	</div>
</body>
</html>
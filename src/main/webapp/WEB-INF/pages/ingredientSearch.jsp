<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Search by Ingredient</title>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	
		<script type="text/javascript">
			$(document).ready(function() {
				$("#searchResults").hide();
				
				$('#searchButton').click(function(event) {
				   event.preventDefault();
		
					var solrBaseQuery = "http://localhost:8983/solr/recipes/select?facet=true&facet.field=ingredients&facet.query=";
					var searchTerm = $("#ingredientSearchField").val();
		
					var queryurl = solrBaseQuery+queryString+"&wt=json&rows=20";
					$.ajax({
						'url': queryurl,
						'crossDomain': 'true',
						'success': function(data) { 
							$("#query").val(searchTerm);
							$("#nameField").val(data.response.docs[0].name);
							$("#urlField").val(data.response.docs[0].url);
							$("#attributesField").val(data.response.docs[0].attributes);
							$("#ingredientsField").val(data.response.docs[0].ingredients);
							$("#directionsField").val(data.response.docs[0].directions);
							$("#notesField").val(data.response.docs[0].notes);
							$("#searchResults").show();
						},
						'dataType': 'jsonp',
						'jsonp': 'json.wrf'
					});
				});
			});
		</script>
	</head>
	<body>
		<label for="ingredientSearchField">Search by Ingredient:</label><input type="text" size="70" id="ingredientSearchField" /><p/>
		<button id="ingredientSearchButton">Search</button>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>View a Recipe</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

	<script type="text/javascript">
		var id = window.location.search.substring(1);

		var solrBaseQuery = "http://localhost:8983/solr/recipes/select?q=id:"+id.split('=')[1]+"&wt=json&fl=id,name,url,attributes,ingredients,directions,notes";

		$(document).ready(function() {
			$.ajax({
				'url': solrBaseQuery,
				'crossDomain': 'true',
				'success': function(data) { 
					$.each(data.response.docs, function (index, value) {
						$("#recipeName").text(value.name);
						$("#url").text(value.url);
						
						var atts = "<ul class='list-unstyled'>";
						$.each(value.attributes, function (index, value) {
							atts += "<li>"+value+"</li>";
						});
						atts += "</ul>";
						$("#attributes").append(atts);
						
						var ingreds = "<ul>";
						$.each(value.ingredients, function (index, value) {
							ingreds += "<li>"+value+"</li>";
						});
						ingreds += "</ul>";
						$("#ingredients").append(ingreds);
						
						var dirs = "";
						$.each(value.directions, function (index, value) {
							dirs += "<p>"+value+"</p>";
						});
						$("#directions").append(dirs);
						$("#notes").text(value.notes);
					});
				},
				'dataType': 'jsonp',
				'jsonp': 'json.wrf'
			});
			
			$('.fa-pencil').click(function(event) {
				event.preventDefault();
				alert($(this).parent().attr("id"));
				var containerDivId = $(this).parent().attr("id");
				if (containerDivId === "ingredientsContainer") { // or do as a popup?
					var existingIngredText = $("#ingredients").text();
					var ingredTextarea = '<textarea id="ingredientsField" rows="8" name="ingredients">'+existingIngredText+'</textarea>';
					$("#ingredients").empty();
					$("#ingredients").append(ingredTextarea);
				} else if (containerDivId === "directionsContainer") {
					
				}
			});
		});
	</script>
</head>
<body>
	<div class="container-fluid">
		<ul class="list-inline">
  			<li><a href="/addRecipe">Add</a></li>
  			<li><a href="/ingredientSearch">Search</a></li>
		</ul>
	</div>
	<div class="container-fluid">
	 	<div id="nameContainer"><h1 id="recipeName"></h1></div>
	 	<div id="url"></div>
	 	<p id="attributes"></p>
	 	<div id="ingredientsContainer"><strong>Ingredients</strong> <i class="fa fa-pencil"></i><div id="ingredients"></div></div>
	 	<div id="directionsContainer"><strong>Directions</strong> <i class="fa fa-pencil"></i><div id="directions"></div></div>
	 	<div id="notes"></div>
	 </div>
</body>
</html>
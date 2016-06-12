<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Search by Ingredient</title>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	
		<script type="text/javascript">
			var solrBaseQuery = "http://localhost:8983/solr/recipes/select?facet=true&facet.field=ingredients_facet";

			$(document).ready(function() {
				$("#resultsPane").hide();
				
				$("#facets").css('cursor', 'pointer');
				
				$("div").on("click","span.facetfield",function() {
					var value = $(this).val();
					doSearch($(this).text());
				});
				
				// this is a mess
				function doSearch(facet) {
					$("#facets").empty();
					$("#searchResults").empty();
					$("#resultsCount").val("");
					$("#facetContainer").empty();
					
					var searchTerm = "&q=ingredients_facet:" + $("#ingredientSearchField").val() + "&facet.query=ingredients_facet:" + $("#ingredientSearchField").val();
					if (searchTerm.indexOf(' ') >= 0) {
						searchTerm = "&q=ingredients_facet:%22"+searchTerm+"%22" + "&facet.query=ingredients_facet:%22"+searchTerm+"%22";	
					}
					
					if (facet != null) {
						if (facet.indexOf(' ') >= 0) {
							facet = "%22"+facet+"%22";
						}
						var facetTerm = "&facet.query=ingredients_facet:"+facet;
						searchTerm = searchTerm + facetTerm;
					}
					var queryurl = solrBaseQuery+searchTerm+"&wt=json&rows=20&fl=id,name,url&json.nl=arrarr&facet.mincount=1&facet.limit=12";
					//alert(queryurl);
					$.ajax({
						'url': queryurl,
						'crossDomain': 'true',
						'success': function(data) { 
							$("#resultsCount").text("There were " + data.response.numFound + " recipes found.");
							$("#query").val(searchTerm);

							$.each(data.response.docs, function(index, value) {
								var idField = "<input type=\"hidden\" name=\"idField"+index+"\""+value.id+"\"/>";
								var nameField = "<div style=\"font-weight:bold\"><a href=\"/viewRecipe?id="+value.id+"\">"+value.name+"</a></div>";
								var urlField = "<div>"+value.url+"</div>";
								var container = "<div style=\"margin-bottom:5px\">"+idField+nameField+urlField+"</div>";
								$("#searchResults").append(container);
							});
							
							// {"ingredients_facet:spinach":8,"ingredients_facet:\"cherry tomatoes\"":2}
							var queries = [];
							$.each(data.facet_counts.facet_queries, function(key, value) {
								queries.push(key.split(":")[1]);
								console.log("adding: " + key.split(":")[1]);
							});
							
							$.each(data.facet_counts.facet_fields.ingredients_facet, function(index, value) {
								if (value[0] != '') {
									var facetField = "<div><span class=\"facetfield\">";
									if (queries.indexOf(value[0]) >= 0) {
										facetField = facetField + "<span class=\"selected\"><strong>"+value[0]+"</strong></span>";
									} else {
										facetField = facetField + value[0];
									}
									facetField = facetField +"</span> <span>("+value[1]+")</span></div>";
									$("#facets").append(facetField);
									console.log(facetField);
								}
							});
							
							$("#resultsPane").show();
						},
						'dataType': 'jsonp',
						'jsonp': 'json.wrf'
					});
				}
				
				$('#ingredientSearchButton').click(function(event) {
				   	event.preventDefault();
				   	$("#facets").empty();
				   	$("#searchResults").empty();
				   	$("#resultsCount").val("");
				   	$("#facetContainer").empty();
					doSearch(null);
				});
			});
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<form method="get">
				<div class="form-group">
					<label for="ingredientSearchField">Search by Ingredient:</label><input type="text" size="70" id="ingredientSearchField" class="form-control" />
					<button id="ingredientSearchButton" class="btn btn-default">Search</button>
				</div>
			</form>
			<hr/>
			<input type="hidden" id="queries" />
			<div id="resultsCount" style="margin:0 0 10 10; font-weight:bold;"></div>
			<div id="resultsPane" class="row">
				<div class="col-md-2"><div id="facetContainer"></div><span><strong>Filter by</strong></span><br/><div id="facets"></div></div>
				<div class="col-md-10"><div id="searchResults" style="vertical-align:text-top;text-align:top;"></div></div>
			</div>
		</div>
	</body>
</html>
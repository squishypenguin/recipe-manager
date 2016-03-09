<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Search by Ingredient</title>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	
		<script type="text/javascript">
			$(document).ready(function() {
				$("#resultsPane").hide();
				
				$(".facet").on("click",function() {
					alert($(this).val());
				});
				
				$('#ingredientSearchButton').click(function(event) {
				   event.preventDefault();
		
					var solrBaseQuery = "http://localhost:8983/solr/recipes/select?facet=true&facet.field=ingredients_facet&q=ingredients_facet:";
					var searchTerm = $("#ingredientSearchField").val();
					if (searchTerm.indexOf(' ') >= 0) {
						searchTerm = "%22"+searchTerm+"%22";	
					}
					
					var queryurl = solrBaseQuery+searchTerm+"&wt=json&rows=20&fl=id,name,url&json.nl=arrarr&facet.mincount=1&facet.limit=12";
					$.ajax({
						'url': queryurl,
						'crossDomain': 'true',
						'success': function(data) { 
							$("#resultsCount").val(data.response.numFound);
							$("#query").val(searchTerm);

							$.each(data.response.docs, function (index, value) {
								var idField = "<input type=\"hidden\" name=\"idField"+index+"\""+value.id+"\"/>";
								var nameField = "<div style=\"font-weight:bold\"><a href=\"/viewRecipe?id="+value.id+"\">"+value.name+"</a></div>";
								var urlField = "<div>"+value.url+"</div>";
								var container = "<div>"+idField+nameField+urlField+"</div>";
								$("#searchResults").append(container);
							});
							
							$.each(data.facet_counts.facet_fields.ingredients_facet, function (index, value) {
								var facetField = "<div><span class=\"facet\">"+value[0]+"</span> <span>("+value[1]+")</span></div>";
								$("#facets").append(facetField);
							});
							
							$("#resultsPane").show();
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
		<hr/>
		<div id="resultsCount"></div>
		<table id="resultsPane">
			<tr><td><span>Filter by</span><br/><div id="facets"></div></td><td style="vertical-align:text-top;"><div id="searchResults" style="vertical-align:text-top;text-align:top;"></div></td></tr>
		</table>
	</body>
</html>
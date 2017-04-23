
<div class = "sidebar">
<!-- Tabbed model -->

	<div id="select-buttons">
	
		<div class="btn-row">
			<button class= "btn btn-primary btn-block" type="button" data-toggle="modal" data-target="#manModal">Management</button>
		</div>
	
		<div class="btn-row">			
				<div class = "btn-group">
				<div onClick= "selectAllItems()" class = "btn btn-primary">Select All</div>
				<div onClick = "deselectAllItems()" class = "btn btn-primary">Deselect All</div>
			</div>
			
		</div>
	</div>

<script>

$(function(){
	
	//Get request calling update table.
	var currentSubscriptionsURL = "subscriptions/subscription/${sessionScope.user}";
	$.get(currentSubscriptionsURL, function (data,status) {
		populateSideBarList(data);
	});
	
	var populateSideBarList = function (data){
		
		var subList = $('#subscriptionsList');
		
		data.subscribeTo.forEach(function(d){
			var userSym = "<div class='user-logo'><span class='glyphicon glyphicon-user' aria-hidden='true'></span></div>";
			var userName =  "<div class='user-item'>" + d + "</div>";
			var focusSym = "<div class='focus-icon'><span class='glyphicon glyphicon-eye-open' aria-hidden='true'></span></div>";
			subList.append("<li id='" + d + "'><div class='list-el'>" + userSym + userName + "</div> </li>");
		});
	}
	
	$("#subscriptionsList .focus-icon").on("click","div", function() {
	   console.log("div click");
	});
	
	$("#subscriptionsList").on("click","li", function() {
	    var id=$(this).attr('id');
	    $(this).toggleClass( "sub-selected" );
	    if($(this).hasClass("sub-selected")){
	    	subscriptionMap[id].setMap(map);
	    }else{
	    	subscriptionMap[id].setMap(null);
	    }
	});
	
	$("#subscriptionsList").on("dblclick","li", function() {
	    var id=$(this).attr('id');
	    subscriptionMap[id].setMap(map);
	    $(this).addClass("sub-selected");
	    panToUser(id);
	    //CALL FOCUS FUNCTION
	    
	});
	
	
	
	
	
});
	//Deselect all items
	var deselectAllItems = function(){
		$("#subscriptionsList li").each(function(idx, li){
			$(li).removeClass("sub-selected");
			subscriptionMap[$(li).attr("id")].setMap(null);
		});
	}

	//Select all items 
	var selectAllItems = function(){
		$("#subscriptionsList li").each(function(idx, li){
			$(li).addClass("sub-selected");
			subscriptionMap[$(li).attr("id")].setMap(map);
		});
	}


</script>

<ul id = "subscriptionsList">



</ul>

</div>
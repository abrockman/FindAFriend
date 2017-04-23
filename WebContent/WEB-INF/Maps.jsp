<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			
			
			<div class = "mapContainer">
			<!-- <h2 id ="current"></h2>-->
			<div class = "btn-row">
            	<button type="button" class="btn btn-primary btn-block" onClick="submitLocation()">Submit Location</button>
            </div>
            <div id="googleMap" style="width:100%;height:500px;"></div>

			<script>
			//Default position
				var currentLat = 0;
				var currentLon = 0;
			</script>


			<c:if test = "${not empty userLoc.latitude}">
				<script>
					var currentLat = ${userLoc.latitude};
					var currentLon = ${userLoc.longitude};
				</script>
			</c:if>


            <script>
            
            	 var jsonUserObj = function (result) {
                 	currentLat = result.lat;
                 	currentLon = result.lon;
                 }
            	 
            	 </script>
            	 
            	 <script>
            	
            	var map;
            	var myMarker;
            	
                function myMap() {
                	
					//Center on user marker
                     map = new google.maps.Map(document.getElementById("googleMap"), {
                        zoom: 5,center: new google.maps.LatLng(currentLat, currentLon),
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    });
					
					//User location marker
                    myMarker = new google.maps.Marker({
                        position: new google.maps.LatLng(currentLat, currentLon),
                        draggable: true
                    });

					//Get data when drag ends
                    google.maps.event.addListener(myMarker, 'dragend', function (evt) {
                      currentLat = evt.latLng.lat().toFixed(3);
                      currentLon = evt.latLng.lng().toFixed(3);
                    });


                    map.setCenter(myMarker.position);
                    myMarker.setMap(map);
                }
                
                //Main marking
                var setMainMarker = function(currentLat, currentLon){
                	
                	//Draggable for user location input
                	myMarker = new google.maps.Marker({
                        position: new google.maps.LatLng(currentLat, currentLon),
                        draggable: true
                    });
                	
                	//Add marker to map
                	myMarker.setMap(map);
                	
                }
				
				
				
					
				
				
				//Map userId -> markerObject
				var subscriptionMap = {};
				//Map userId -> last updated - used in model.
				var userDateMap = {};
				//JSON object storing all subscribed user locations.
				var allUsers;
				
				//Create all markers
				var extractLocations = function (data){
					allUsers = data;
					//For each subscription
					data.forEach(function(d){
						
						//Contect for the info windoq
						var content = "<h4>" + d.id + "</h4>" + "<p>Last check-in: " + new Date(d.lastUpdated).toLocaleDateString() + "</p>";
						
						//Info window
						var infowindow = new google.maps.InfoWindow({
					          content: content
					        });
						
						//Green marker
						var userMarker = new google.maps.Marker({
		                        	position: new google.maps.LatLng(d.location.latitude, d.location.longitude),
		                        	draggable: false,
		                        	icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
	                    			});
						
						//Activate info window on marker click
						userMarker.addListener('click', function(){
							infowindow.open(map,userMarker);
						})
						
						//Add marker to map
						subscriptionMap[d.id]=userMarker;
						//add to map
						console.log(d.id + ", " + d.lastUpdated);
						userDateMap[d.id] = d.lastUpdated;
					});
					
				}
				
				//PanTo function - used in double click
				var panToUser = function(username){
					map.panTo(subscriptionMap[username].getPosition());
					map.setZoom(14);
				}
				
				//GET for all user locations
				var updateLocations = function(){
					$.get("subscriptions/subscription-locations",
							{"userId": "${sessionScope.user}"},
							function(data, status){
								extractLocations(data);
							   	 });	
				}
				$(function(){

					updateLocations();
				});
				
                
				//Submit location POST functionality
                var submitLocation = function(){
                	$.ajax({
                	    type: 'POST',
                	    url: '/FindAFriend/updatelocation',
                	    data: { 
                	        'userId': user, 
                	        'lat': currentLat,
                	        'lon':currentLon 
                	    },
                	    success: function(result){
                	    	jsonUserObj(result);
                	       
                	    }
                	});
                	
                }
                
            </script>

            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAsirY24ohCpJEsaTHsyL4IDSoCw96Nh7o&callback=myMap"></script>

			</div>

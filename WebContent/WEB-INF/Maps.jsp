<h1>Google Maps</h1>
			<h2 id = "current"></h2>
            <div id="googleMap" style="width:100%;height:400px;"></div>

            <script>
            
            
            	
            	var currentLat = ${userLoc.latitude};
            	var currentLon = ${userLoc.longitude};
            	
            	$.get("/FindAFriend/updatelocation", function(data, status){
                   	jsonUserObj(data);
                   	});
            	
            	 var jsonUserObj = function (result) {
                 	currentLat = result.lat;
                 	currentLon = result.lon;
                 	console.log("SET VALS");
                 	//setMainMarker(result.lat, result.lon);
                 }
            	 
            	 </script>
            	 
            	 <script defer = "defer">
            	
            	var map;
            	var myMarker;
            	
                function myMap() {
                	console.log("MAP TIME")
					/*INSERT CURRENT LOCATION HERE*/
                     map = new google.maps.Map(document.getElementById("googleMap"), {
                        zoom: 1,center: new google.maps.LatLng(currentLat, currentLon),
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    });
					
					/*INSERT CURRENT LOCATION HERE*/
                    myMarker = new google.maps.Marker({
                        position: new google.maps.LatLng(currentLat, currentLon),
                        draggable: true
                    });
					/*PULL DATA ON CLICK FROM HERE*/
                    google.maps.event.addListener(myMarker, 'dragend', function (evt) {
                      currentLat = evt.latLng.lat().toFixed(3);
                      currentLon = evt.latLng.lng().toFixed(3);
                    	document.getElementById('current').innerHTML = 'Current Lat: ' + evt.latLng.lat().toFixed(3) + ' Current Lng: ' + evt.latLng.lng().toFixed(3);
                    });


                    map.setCenter(myMarker.position);
                    myMarker.setMap(map);
                }
                
                var setMainMarker = function(currentLat, currentLon){
                	
                	myMarker = new google.maps.Marker({
                        position: new google.maps.LatLng(currentLat, currentLon),
                        draggable: true
                    });
                	
                	myMarker.setMap(map);
                	
                }

                var submitLocation = function(){
                	$.ajax({
                	    type: 'POST',
                	    url: '/FindAFriend/updatelocation',
                	    data: { 
                	        'userId': user, 
                	        'lat': currentLat,
                	        	'lon':currentLon // <-- the $ sign in the parameter name seems unusual, I would avoid it
                	    },
                	    success: function(result){
                	    	jsonUserObj(result);
                	       
                	    }
                	});
                	
                }
                
            </script>

            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAsirY24ohCpJEsaTHsyL4IDSoCw96Nh7o&callback=myMap"></script>

			<button type="button" onClick="submitLocation()">submit location</button>

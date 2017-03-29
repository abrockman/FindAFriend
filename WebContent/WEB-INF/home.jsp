<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
            <c:url var="jQuery" value="/Resources/jQuery/jquery-3.2.0.min.js" />
            <c:url var="bootstrapCss"
                   value="/Resources/bootstrap/css/bootstrap.min.css" />
            <c:url var="bootstrapJs"
                   value="/Resources/bootstrap/js/bootstrap.min.js" />


            <script src="${jQuery}"></script>
            <link rel="stylesheet" href="${bootstrapCss}">
            <script src="${bootstrapJs}"></script>

            <title>Find A Friend</title>
        </head>
        <body>

            <jsp:include page="NavBar.jsp"></jsp:include>


            <!-- AIzaSyAsirY24ohCpJEsaTHsyL4IDSoCw96Nh7o -->

            <h1>My First Google Map</h1>
<h2 id = "current"></h2>
            <div id="googleMap" style="width:100%;height:400px;"></div>

            <script>
                function myMap() {
					/*INSERT CURRENT LOCATION HERE*/
                    var map = new google.maps.Map(document.getElementById("googleMap"), {
                        zoom: 1,center: new google.maps.LatLng(35.137879, -82.836914),
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    });
					
					/*INSERT CURRENT LOCATION HERE*/
                    var myMarker = new google.maps.Marker({
                        position: new google.maps.LatLng(47.651968, 9.478485),
                        draggable: true
                    });
					
					/*PULL DATA ON CLICK FROM HERE*/
                    google.maps.event.addListener(myMarker, 'dragend', function (evt) {
                        document.getElementById('current').innerHTML = 'Current Lat: ' + evt.latLng.lat().toFixed(3) + ' Current Lng: ' + evt.latLng.lng().toFixed(3);
                    });


                    map.setCenter(myMarker.position);
                    myMarker.setMap(map);
                }
            </script>

            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAsirY24ohCpJEsaTHsyL4IDSoCw96Nh7o&callback=myMap"></script>



            <!-- Modal Window for Sign in -->
            <script type="text/javascript">
                $(function(){
                    var user = ${sessionScope.user} + "";
                    console.log(user);
                    if(user == ""){
                        $('#myModal').modal('show');
                    }
                }
                 );



            </script>


            <h1>${sessionScope.user}</h1>
            <h2>${signUpSuccess}</h2>


            <div id="myModal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <div class="modal-title">Welcome to Find A Friend! Please sign in or register to locate a friend</div>
                        </div>
                        <div class="modal-body">
                            <h4>Sign In</h4>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <form action = "login" method="post">
                                <label> Username</label>
                                <input name = "userId" type="text">
                                <input type = "submit" value="login">
                            </form>

                            <h4>Sign Up</h4>
                            <c:if test="${not empty signUpError}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <form action="signup" method= "post">

                                <label> Select a Username</label>
                                <input name = "userId" type = "text">
                                <input type = "submit" value = "Sign Up">
                            </form>

                        </div>
                    </div>
                </div>
            </div>

        </body>
    </html>
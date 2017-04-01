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
           
           	<!-- Assess user visitor for a user session. Display modal if not signed in. -->
            <c:choose >
                <c:when test="${not empty sessionScope.user }">
                	<script>
           				var user = "${sessionScope.user}";
          			</script>
                	<jsp:include page="Maps.jsp"></jsp:include>
                </c:when>
               
                <c:otherwise>
                    <script type="text/javascript">
                       // var user = ${sessionScope.user} + "";
                        $(function(){
                           
                                $('#myModal').modal('show'); 

                        }
                         );
                    </script>
                </c:otherwise>
            </c:choose>

            <h1>${sessionScope.user}</h1>
            <h2>${signUpSuccess}</h2>

			<!-- Login / Sign Up Modal -->
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
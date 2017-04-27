<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- DataTables Plugin -->
<c:url value="/Resources/DataTables/datatables.min.js"
	var="dataTablesJs" />
<c:url value="/Resources/DataTables/datatables.min.css"
	var="dataTablesCss" />

<script
	src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<link href="${dataTablesCss}" rel="stylesheet" />
<script src="${dataTablesJs}"></script>

<script
	src="//cdn.datatables.net/plug-ins/1.10.13/dataRender/datetime.js"></script>

<script type="text/javascript">
					
					var outstandingTable;
					var awaitingApproval;
					var currentSubscriptions;
					
					$(function(){
						//Define Outstanding Requests Table
						outstandingTable = $('#outstandingRequests').DataTable(
											{"rowId":'subscribeTo',
											"columns":[	{data:'timeStamp'},
														{data:'subscribeTo'}]
								  
									
								});
						
						
						//Define Awaiting Approval Table
						awaitingApproval = $('#awaitingApproval').DataTable({
											"rowId":"subscriberId",
											"columns":[	{data:"timeStamp"},
														{data:"subscriberId"},
														{data:"accept"},
														{data:"decline"}],
											"columnDefs": [
												{
									            "targets": -2,
									            "data": null,
									            "defaultContent": "<button class='accept btn btn-primary'>Accept</button>"},
									            {
									            "targets": -1,
									            "data": null,
									            "defaultContent": "<button class='decline btn btn-alert'>Decline</button>"}]
									     
						});
						
						//Define Current Subscriptions Table
						currentSubscriptions = $('#currentSubscriptions').DataTable({
							
											"rowId":"subscribeTo",
											"columns":[	{data:"subscribeTo"},
														{data:"delete"}],
														"columnDefs": [
															{
												            "targets": -1,
												            "data": null,
												            "defaultContent": "<span class='glyphicon glyphicon-remove' aria-hidden='true'></span>"
												            }]
								});
						/**/
						
						//GET functionality for deleting subscription
						$('#currentSubscriptions tbody').on('click', 'span', function () {
					        var deleteUrl = "subscriptions/delete-subscription";
							var data = currentSubscriptions.row($(this).parents('tr')).id();
							console.log(data);
							$.get(deleteUrl, 	{	
												"subscriberId":user,
												"subscribeTo":data
												},
							
									function(data, status){
										updateCurrentSubscriptionsTable(user);
								}
							);
							
					    } );
						
						//POST functionality for awaiting approval table - accept/decline buttons.
						$('#awaitingApproval tbody').on('click', 'button', function () {
					        var urlPost = "subscriptions/";
							var data = awaitingApproval.row($(this).parents('tr')).id();
							
							//Assess whether the accept button was pressed
					        if($(this).hasClass('accept')){
					        	urlPost += "accept-request";
					        }
							//Assess whether the decline button was pressed
					        if($(this).hasClass('decline')){
					        	urlPost += "decline-request";
					        }
					        
							$.ajax({
					        	  type: "POST",
					        	  url: urlPost,
					        	  data: {
					        		  "subscriberId":data,
					        		  "subscribeTo":"${sessionScope.user}"
					        	  },
					        	  success: function(){ updateAwaitingApprovalTable(user);}
					        	});
							
					    } );
						
						//Update all the tables
						updateOutstandingTable(user);
						updateAwaitingApprovalTable(user);
						updateCurrentSubscriptionsTable(user);
						});
					
					//Update current subscriptions
					var updateCurrentSubscriptionsTable = function(userId) {
						// Get request calling update table.
						var currentSubscriptionsURL = "subscriptions/subscription/" + userId;
						$.get(currentSubscriptionsURL, function(data, status) {
							populateCurrentSubscriptionsTable(data);
						});

					}
					// Populate current subscriptions table
					var populateCurrentSubscriptionsTable = function(data) {
						currentSubscriptions.clear().draw();

						data.subscribeTo.forEach(function(d) {
							console.log(d + ", " + userDateMap[d]);
							currentSubscriptions.rows.add([ {
								"subscribeTo" : d
							} ]).draw();

						});
					}
					// Define awaiting approvate update
					var updateAwaitingApprovalTable = function(userId) {
						var pendingApprovalURL = "subscriptions/pending-approval/"
								+ userId;
						$.get(pendingApprovalURL, function(data, status) {
							populateAwaitingApprovalTable(data);
						});
					}

					// Function for populating awaiting approval table.
					var populateAwaitingApprovalTable = function(data) {
						// TODO Temp vals
						var yep = "Accept";
						var nope = "Decline";
						awaitingApproval.clear().draw();
						data.forEach(function(d) {
							console.log(d);
							if (awaitingApproval.rows('[id=' + d.subscriberId + ']').any()) {
							} else {

								awaitingApproval.rows.add([ {
									"timeStamp" : new Date(d.timeStamp).toLocaleDateString(),
									"subscriberId" : d.subscriberId
								} ]).draw();
							}
						});
					}

					// Define Update for outstanding requests table
					var updateOutstandingTable = function(userId) {
						$.get("subscriptions/subscribe", {
							"userId" : userId
						}, function(data, status) {
							populateTable(data);
						});
					}

					// Function for populating outstanding request tables
					var populateTable = function(data) {
						outstandingTable.clear().draw();
						data.forEach(function(d) {
							console.log("OUTSTANDING:" + d.timeStamp + ", " + d.subscribeTo);
							if (outstandingTable.rows('[id=' + d.subscribeTo + ']').any()) {
							} else {
								outstandingTable.rows.add([ {
									"timeStamp" : new Date(d.timeStamp).toLocaleDateString(),
									"subscribeTo" : d.subscribeTo
								} ]).draw();
							}
						});

					}
					
					//New request form Submition
				    //Attach a submit handler to the form
				    $("#newrequest").submit(function(event) {
				      event.preventDefault();
				      var $form = $( this ),
				      
				      url = $form.attr( 'action' ),
				      subscribeTo = $('#subscribeTo').val();

				      //Send the data using post with user id name and subscribeTo
				     /* var posting = $.post( url, { 	userId: $('#userId').val(), 
				    	  							subscribeTo: $('#subscribeTo').val() 
				    	  							},
				    	  							function ( data ) {
				      									updateOutstandingTable(user);
				      								}
				    	  						);*/
				      $.ajax({
			        	  type: "POST",
			        	  url: url,
			        	  data:{"userId": user, 
	  							"subscribeTo": subscribeTo}
			        	}).done(function(data, textStatus, jqXHR){ 
					        		  console.log("post success");
					        		  updateOutstandingTable(user);
			       		}).fail(function(jqXHR, textStatus, errorThrown){ //replaces .error
				        			  console.log("error");
				        			  console.dir(arguments);
			        	}).always(function(/*data|jqXHR, textStatus, jqXHR|errorThrown*/){ //replaces .complete
				        			  console.log("always");
				        			  console.dir(arguments);
			        	});
				    	  						
				     
				    });
				

					
					
					</script>


<div id="manModal" class="modal fade" role="dialog"
	data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg">
		<!-- Modal content-->
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Subscription Management</h3>
			</div>


			<ul class="nav nav-tabs" id="tabContent">
				<li class="active"><a href="#sendRequest" data-toggle="tab">Send
						Request</a></li>
				<li><a href="#pendingApproval" data-toggle="tab">Pending
						Approval</a></li>
				<li><a href="#subscriptions" data-toggle="tab">Subscriptions</a></li>
			</ul>

			<div class="tab-content">

				<!-- Send subscription resquest -->
				<div class="tab-pane active" id="sendRequest">

					<div class="myModel-content">
						<form id="newrequest" action="subscriptions/subscribe"
							method="post" class="form-inline">
							<input type="hidden" id="userId" name="userId"
								value="${sessionScope.user}">
							
								<label for="subscribeTo" class="sr-only">Subscribe To</label> 
								<input placeholder="Subscribe To" class="form-control" type="text" id="subscribeTo" name="subscribeTo">
							
							<input type="submit" value="Send Request" class="btn btn-primary">

						</form>

						
						<div class="table">
							<h4>Outstanding Requests</h4>
							<table id="outstandingRequests" class="display" cellspacing="0"
								width="100%">
								<thead>
									<tr>
										<th>Date</th>
										<th>Recipient</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
					</div>

				</div>

				<!-- View Pending Approval subscription requests -->
				<div class="tab-pane" id="pendingApproval">
					<div class="myModel-content">
						<div class="table">
							<h4>Requests Awaiting Approval</h4>
	
							<table id="awaitingApproval" class="display" cellspacing="0"
								width="100%">
								<thead>
									<tr>
										<th>Date</th>
										<th>Request From</th>
										<th>Accept</th>
										<th>Decline</th>
									</tr>
								</thead>
								<tbody>
	
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- All current suSbscriped to -->
				<div class="tab-pane" id="subscriptions">
				<div class="myModel-content">

					<table id="currentSubscriptions" class="display" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>Subscription To</th>
								<th>Delete</th>
							</tr>
						</thead>
						
						<tbody>
						</tbody>
						
					</table>
				</div>
				</div>
			</div>

		</div>
	</div>
</div>

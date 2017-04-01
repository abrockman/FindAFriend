<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- DataTables Plugin -->
<c:url value="/Resources/DataTables/datatables.min.js"
	var="dataTablesJs" />
<c:url value="/Resources/DataTables/datatables.min.css"
	var="dataTablesCss" />
<link href="${dataTablesCss}" rel="stylesheet" />
<script src="${dataTablesJs}"></script>

<!-- Tabbed model -->
<button type="button" data-toggle="modal" data-target="#manModal">Management</button>

<div id="manModal" class="modal fade" role="dialog"
	data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog">
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

					<form id="newrequest" action="subscriptions/subscribe" method="post">
						<input type="hidden" id="userId" name="userId" value="${sessionScope.user}">
						<label>Subscribe To</label> <input type="text" id = "subscribeTo" name="subscribeTo">
						<input type="submit" value="Send Request">
					</form>

					<script type="text/javascript">
					
					var outstandingTable;
					
					$(function(){
						outstandingTable = $('#outstandingRequests').DataTable();
						updateOutstandingTable();
						});
					
					 var populateTable = function(data){
						 
						 console.log("Number of outstanding requests: " + data.length);
						 for(i=0;i<data.length;i++){
							 
						var flag = 0;
						$("#outstandingRequests").find("tr").each(function () { //iterate through rows
							 var td1 = $(this).find("td:eq(1)").text(); //get value of first td in row
							 console.log(data[i].subscribeTo + ", " + td1);
							 if (data[i].subscibeTo === td1) { //compare if test = td1 AND sample = td2
								 console.log("EQUALS!")
								 flag = 1; //raise flag if yes
							      }
							});
							 
						if(flag == 0){
						 outstandingTable.row.add( [
							 data[i].timeStamp,
							 data[i].subscribeTo
					        ] ).draw( false );
						}
					 	}
					 }
	
					var updateOutstandingTable = function(){
						$.get("subscriptions/subscribe", {"userId": "${sessionScope.user}"},function(data, status){
							console.log("Get Outstanding requests")
							 populateTable(data);
						    });	
					}
					
					
					//Form Submition
				    /* attach a submit handler to the form */
				    $("#newrequest").submit(function(event) {
				      event.preventDefault();
				      var $form = $( this ),
				      
				      url = $form.attr( 'action' );

				      /* Send the data using post with element id name and name2*/
				      var posting = $.post( url, { userId: $('#userId').val(), subscribeTo: $('#subscribeTo').val() } );

				      /* Alerts the results */
				      posting.done(function( data ) {
				        updateOutstandingTable();
				      });
				    });
				

					
					
					</script>
					
					<table id="outstandingRequests">
					<thead>
					<tr>
					<th>Request Date</th>
					<th>Request Recipient</th>
					</tr>
					</thead>
					<tbody>
					</tbody>
					</table>
				</div>

				<!-- View Pending Approval subscription requests -->
				<div class="tab-pane" id="pendingApproval">content 0</div>

				<!-- All current suSbscriped to -->
				<div class="tab-pane" id="subscriptions">content 1</div>
			</div>

		</div>
	</div>
</div>

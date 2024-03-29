<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flights</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/flightForm.css">
<script src="${pageContext.request.contextPath}/js/formPage.js"></script>
<script>
	$(".sortHeader").click(function() {
		if ($(this).hasClass("active")) {
			
		}
	})
</script>
</head>
<body>
<%@ include file="navBar.jsp" %>
<div class="container">
	<%@ include file="sideNav.jsp" %>
	<div class="mainContainer">
		<div class="main flightForm">
			<%@ include file="breadcrumbs.jsp" %>
			<h1>Flights</h1>
			<form:errors path="flight.*" cssStyle="color:red;" />
			<form:form action="saveFlight" method="POST" modelAttribute="flight">
				<div class="formSection">
					<form:input type="number" path="flightId" value="${flight.getFlightId()}" placeholder="flight id" hidden="true"/>
				</div>
				<div class="formSection labeledInputSection">
					<form:label path="flightNumber"><img src="${pageContext.request.contextPath}/img/list-ol-solid.svg" />
						<form:input path="flightNumber" value="${flight.getFlightNumber()}" placeholder="Flight number" />
					</form:label>
				</div>
				<form:select path="airlines">
					<form:option value="" disabled="true" selected="true">--- Select Airline ---</form:option>
					<core:forEach items="${allAirlines}" var="airline">
						<form:option value="${airline}" label="${airline.getAirlinesCode()} - ${airline.getAirlinesName()}" />
					</core:forEach>
				</form:select>
				<div class="formSection labeledInputSection">
					<form:label path="capacity"><img src="${pageContext.request.contextPath}/img/arrow-up-1-9-solid.svg" />
						<form:input type="number" path="capacity" value="${flight.getCapacity()}" placeholder="Capacity" />
					</form:label>
				</div>
				<div class="formSection labeledInputSection">
					<form:label path="ticketPrice"><img src="${pageContext.request.contextPath}/img/dollar-sign-solid.svg" />
						<form:input type="number" path="ticketPrice" step=".01" min="1.00" value="${flight.getTicketPrice()}" placeholder="Ticket price" />
					</form:label>
				</div>
				<br>
				<br>
				<div class="formSection labeledInputSection">
					<%-- <form:label path="departureCity"><img src="${pageContext.request.contextPath}/img/plane-departure-solid.svg" />
						<form:input path="departureCity" value="${airline.getDepartureCity()}" placeholder="Departure city" />
					</form:label> --%>
					<form:label path="departureCity"><img src="${pageContext.request.contextPath}/img/plane-departure-solid.svg" />
						<%-- <form:select path="departureCity">
							<form:option value="" disabled="true" selected="true">--- Departure city ---</form:option>
							<core:forEach items="${cities}" var="city">
								<form:option value="${city}" label="${city}" />
							</core:forEach>
						</form:select> --%>
						<form:select path="departureCity">
							<form:option value="" disabled="true" selected="true">--- Departure city ---</form:option>
							<core:forEach items="${cities}" var="city">
								<form:option value="${city}" label="${city}" />
							</core:forEach>
						</form:select>
					</form:label>
				</div>
				<form:input type="date" path="departureDate" value="${airline.getDepartureDate()}" />
				<form:input type="time" path="departureTime" value="${airline.getDepartureTime()}" />
				<br>
				<br>
				<div class="formSection labeledInputSection">
					<%-- <form:label path="arrivalCity"><img src="${pageContext.request.contextPath}/img/plane-arrival-solid.svg" />
						<form:input path="arrivalCity" value="${airline.getArrivalCity()}" placeholder="Arrival city" />
					</form:label> --%>
					<form:label path="arrivalCity"><img src="${pageContext.request.contextPath}/img/plane-arrival-solid.svg" />
						<form:select path="arrivalCity">
							<form:option value="" disabled="true" selected="true">--- Arrival city ---</form:option>
							<core:forEach items="${cities}" var="city">
								<form:option value="${city}" label="${city}" />
							</core:forEach>
						</form:select>
					</form:label>
				</div>
				<form:input type="date" path="arrivalDate" value="${airline.getArrivalDate()}" />
				<form:input type="time" path="arrivalTime" value="${airline.getArrivalTime()}" />
				<br>
				<br>
				<core:if test="${!isUpdate}">
					<input type="submit" value="Submit" />
				</core:if>
				<core:if test="${isUpdate}">
					<input type="submit" value="Update" class="btnUpdate" />
					<a href="deleteFlight?flightId=${flight.getFlightId()}"><button type="button" class="btnDefault btnDelete">Delete</button></a>
					<a href="/flightForm"><button type="button" class="btnDefault btnCancel">Cancel</button></a>
				</core:if>
			</form:form>
			
			<div class="listBodyContainer">
				<!-- <div class="listHeaderContainer">
					<table class="dbList">
						<thead>
							<tr>
								<th>Flight id</th>
								<th>Flight number</th>
								<th>Airlines</th>
								<th>Departure city</th>
								<th>Departure date</th>
								<th>Departure time</th>
								<th>Arrival city</th>
								<th>Arrival date</th>
								<th>Arrival time</th>
								<th>Capacity</th>
								<th>Seats booked</th>
								<th>Ticket price</th>
								<th></th>
							</tr>
						</thead>
					</table>
				</div> -->
				<table class="dbList dbListData">
				<thead>
					<tr>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=flightId" class="sortHeader ${sortedBy == 'flightId' ? 'active' : ''}">Flight id</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=flightNumber" class="sortHeader ${sortedBy == 'flightNumber' ? 'active' : ''}">Flight number</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=airlines.airlinesName" class="sortHeader ${sortedBy == 'airlines.airlinesName' ? 'active' : ''}">Airlines</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=departureCity" class="sortHeader ${sortedBy == 'departureCity' ? 'active' : ''}">Departure city</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=departureDate" class="sortHeader ${sortedBy == 'departureDate' ? 'active' : ''}">Departure date</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=departureTime" class="sortHeader ${sortedBy == 'departureTime' ? 'active' : ''}">Departure time</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=arrivalCity" class="sortHeader ${sortedBy == 'arrivalCity' ? 'active' : ''}">Arrival city</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=arrivalDate" class="sortHeader ${sortedBy == 'arrivalDate' ? 'active' : ''}">Arrival date</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=arrivalTime" class="sortHeader ${sortedBy == 'arrivalTime' ? 'active' : ''}">Arrival time</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=capacity" class="sortHeader ${sortedBy == 'capacity' ? 'active' : ''}">Capacity</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=seatsBooked" class="sortHeader ${sortedBy == 'seatsBooked' ? 'active' : ''}">Seats booked</a></th>
						<th><a href="flightForm?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=ticketPrice" class="sortHeader ${sortedBy == 'ticketPrice' ? 'active' : ''}">Ticket price</a></th>
						<th></th>
					</tr>
				</thead>
					<tbody>
						<core:forEach items="${flights}" var="flight">
							<tr>
								<td>${flight.getFlightId()}</td>
								<td>${flight.getFlightNumber()}</td>
								<td>${flight.getAirlines().getAirlinesName()}</td>
								<td>${flight.getDepartureCity()}</td>
								<td>${flight.getDepartureDate()}</td>
								<td>${flight.getDepartureTime()}</td>
								<td>${flight.getArrivalCity()}</td>
								<td>${flight.getArrivalDate()}</td>
								<td>${flight.getArrivalTime()}</td>
								<td>${flight.getCapacity()}</td>
								<td>${flight.getSeatsBooked()}</td>
								<td>
									$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${flight.getTicketPrice()}"/>
								</td>
								<td><a href="updateFlight?flightId=${flight.getFlightId()}"><img src="${pageContext.request.contextPath}/img/pen-to-square-solid.svg" /></a></td>
							</tr>
						</core:forEach>
					</tbody>
				</table>
			</div>
			<div class="pageList">
				<core:set var="noOfPages" value="${totalPages}"></core:set>
				<core:set var="sortedBy" value="${sortedBy}"></core:set>
				<core:set var="pageSize" value="${pageSize}"></core:set>
				<core:set var="pageNo" value="${pageNo}"></core:set>
				<%
				for (int i = 0; i < (int)pageContext.getAttribute("noOfPages"); i++) {
					//pageContext, out, request, response are some of jsp implicit objects
					if (i > 0) {
						out.println("&middot;");
					}
					if ((int)pageContext.getAttribute("pageNo") == i) {
						out.println("<p>" + (i+1) + "</p>");
					} else {
						out.println("<a class=\"page\" href=\"flightForm?pageNo="+i+"&pageSize="+request.getAttribute("pageSize")+"&sortedBy="+request.getAttribute("sortedBy")+"\">"+(i+1)+"</a>");						
					}
				}
				%>
			</div>
		</div>
		<%@ include file="footer.jsp" %>
	</div>
</div>
</body>
</html>
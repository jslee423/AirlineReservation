<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Roles</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/roles.css">
<script src="${pageContext.request.contextPath}/js/formPage.js"></script>
<script>

</script>
</head>
<body>
<%@ include file="navBar.jsp" %>
<div class="container">
	<%@ include file="sideNav.jsp" %>
	<div class="mainContainer">
		<div class="main roles">
			<%@ include file="breadcrumbs.jsp" %>
			<h1>Roles</h1>
			<form:errors path="role.*" cssStyle="color:red;" />		
			<form:form action="saveRole" method="POST" modelAttribute="role">
				<div class="formSection">
					<form:input type="number" path="roleId" value="${role.getRoleId()}" placeholder="role id" hidden="true"/>
				</div>
				<div class="formSection labeledInputSection">
					<form:label path="roleName"><img src="${pageContext.request.contextPath}/img/signature-solid.svg" />
						<form:input path="roleName" value="${role.getRoleName()}" placeholder="Role name" />
					</form:label>
				</div>
				<core:if test="${!isUpdate}">
					<input type="submit" value="Submit" />
				</core:if>
				<core:if test="${isUpdate}">
					<input type="submit" value="Update" class="btnUpdate" />
					<a href="deleteRole?roleId=${role.getRoleId()}"><button type="button" class="btnDefault btnDelete">Delete</button></a>
					<a href="/roles"><button type="button" class="btnDefault btnCancel">Cancel</button></a>
				</core:if>
			</form:form>
			<div class="listBodyContainer">
				<!-- <div class="listHeaderContainer">
					<table class="dbList">
						<thead>
							<tr>
								<th>Role id</th>
								<th>Role name</th>
								<th></th>
							</tr>
						</thead>
					</table>
				</div> -->
				<table class="dbList dbListData">
				<thead>
					<tr>
						<th><a href="roles?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=roleId" class="sortHeader ${sortedBy == 'roleId' ? 'active' : ''}">Role id</a></th>
						<th><a href="roles?pageNo=${pageNo}&pageSize=${pageSize}&sortedBy=roleName" class="sortHeader ${sortedBy == 'roleName' ? 'active' : ''}">Role name</a></th>
						<th></th>
					</tr>
				</thead>
					<tbody>
						<core:forEach items="${roles}" var="role">
							<tr>
								<td>${role.getRoleId()}</td>
								<td>${role.getRoleName()}</td>
								<td><a href="updateRole?roleId=${role.getRoleId()}"><img src="${pageContext.request.contextPath}/img/pen-to-square-solid.svg" /></a></td>
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
						out.println("<a class=\"page\" href=\"reservations?pageNo="+i+"&pageSize="+request.getAttribute("pageSize")+"&sortedBy="+request.getAttribute("sortedBy")+"\">"+(i+1)+"</a>");						
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
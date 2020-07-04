<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="container log-row">
    </br>
    <p style="font-size: 50px;color: white;text-align: center">Błąd 404</p>
    </br>
    </br>
    <p style="font-size: 20px;color: white; text-align: center">Żądana strona nie istnieje</p>
    </br>
    </br>
    </br>
    <a class="btn btn-info" style="margin: 0 auto;display: block; width: 150px;" href="<c:url value="/admin/dashboard/"/> ">
        Wróć do CMS
    </a>
    <br/>
    <c:if test="${not empty sessionScope.message}">
        <span style="color:green"><c:out value="${sessionScope.message}"/></span>
        <c:remove var="message" scope="session"/>
    </c:if>
</div>

<style>
    p {
        margin: 20px 0 10px;
    }

</style>
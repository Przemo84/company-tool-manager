<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" uri="/WEB-INF/taglibs/customTags.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="page-header">
    <div class="pull-left">
        <h1><fmt:message key="menu.action.tools.history"/>:
            <br><br>
            <i style="color:#942a25; margin-top: 20px ">Nordgeo ID: ${tool.companyId} , nazwa: ${tool.model}</i>
        </h1>
    </div>
</div>

<div class="breadcrumbs">
    <ul>
        <li>
            <a href="<c:url value="${baseUrl}"/>"><fmt:message key="home"/></a>
            <i class="icon-angle-right"></i>
        </li>
        <li>
            <a href="<c:url value="${moduleBaseUrl}/${tool.id}"/>"><fmt:message key="menu.action.tools.history"/></a>
        </li>
    </ul>
    <div class="close-bread">
        <a href="#"><i class="icon-remove"></i></a>
    </div>
</div>


<div class="row-fluid">
    <div class="span12">
        <div class="box">
            <div class="box-content nopadding">
                <div class="dataTables_wrapper">
                    <div class="dataTables_length">
                    </div>
                        <table class="table table-hover table-nomargin table-striped table-bordered"
                               style="clear: both;">
                            <thead>
                            <tr>
                                <th style="text-align: center;">
                                    <tag:th param="action">
                                        <fmt:message key="tool-status.action"/>
                                    </tag:th>
                                </th>
                                <th style="text-align: center;" colspan="2">
                                    <tag:th param="createDate">
                                        <fmt:message key="tool-status.action.date"/>
                                    </tag:th>
                                </th>
                                <th style="text-align: center;">
                                    <tag:th param="user">
                                        <fmt:message key="tool-status.author"/>
                                    </tag:th>
                                </th>
                                <th style="text-align: center;">
                                    <tag:th param="description">
                                        <fmt:message key="tool-status.description"/>
                                    </tag:th>
                                </th>

                                <th style="text-align: center;">
                                    <tag:th param="needRepair">
                                        <fmt:message key="tool-status.need.repair"/>
                                    </tag:th>
                                </th>

                                <th style="text-align: center;">
                                    <tag:th param="shape">
                                        <fmt:message key="tool-status.shape"/>
                                    </tag:th>
                                </th>
                            </tr>
                            </thead>

                            <tbody id="myTable">
                            <c:forEach var="item" items="${page.iterator()}">
                                <tr>
                                    <td style="text-align: center;">
                                        <c:if test="${item.action eq 'TAKE_IN'}">
                                            <i style="color: red" class="fas fa-cloud-download-alt"></i><fmt:message
                                                key="${item.action}"/>
                                        </c:if>
                                        <c:if test="${item.action eq 'TAKE_OUT'}">
                                            <i style="color: green" class="fas fa-cloud-upload-alt"></i><fmt:message
                                                key="${item.action}"/>
                                        </c:if>
                                    </td>
                                    <td style="text-align: center;" colspan="2">
                                        <fmt:formatDate value="${item.createDate}" type="date" pattern="dd-MM-yyyy HH:MM:ss"/>
                                    </td>
                                    <td style="text-align: center;">${item.user.fullName}</td>
                                    <td style="text-align: center;">${item.description}</td>
                                    <td style="text-align: center;">
                                        <c:if test="${item.needRepair eq false}">
                                            <i style="color: green" class="fas fa-thumbs-up"></i>
                                        </c:if>
                                        <c:if test="${item.needRepair eq true}">
                                            <i style="color: red" class="fas fa-exclamation-circle"></i>
                                        </c:if>
                                    </td>

                                    <c:if test="${item.shape eq 'VERY_GOOD'}">
                                        <td style="text-align: center; background-color: green">
                                            <strong><fmt:message key="${item.shape}"/></strong>
                                        </td>
                                    </c:if>

                                    <c:if test="${item.shape eq 'GOOD'}">
                                        <td style="text-align: center; background-color: yellowgreen">
                                            <strong><fmt:message key="${item.shape}"/></strong>
                                        </td>
                                    </c:if>
                                    <c:if test="${item.shape eq 'AVERAGE'}">
                                        <td style="text-align: center; background-color: yellow">
                                            <strong><fmt:message key="${item.shape}"/></strong>
                                        </td>
                                    </c:if>
                                    <c:if test="${item.shape eq 'BAD'}">
                                        <td style="text-align: center; background-color: orangered">
                                            <strong><fmt:message key="${item.shape}"/></strong>
                                        </td>
                                    </c:if>
                                    <c:if test="${item.shape eq 'VERY_BAD'}">
                                        <td style="text-align: center; background-color: red">
                                            <strong><fmt:message key="${item.shape}"/></strong>
                                        </td>
                                    </c:if>

                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th colspan="8" style="height:40px;"></th>
                            </tr>
                            </tfoot>
                        </table>
                </div>
            </div>
        </div>
        <div class="pagination pagination-small">
            <tag:paginate pageData="${page}" next="&#62;" previous="&#60;"/>
        </div>
    </div>
</div>
<script>
    var checkboxes = $('#executable-users-list-form td input[type="checkbox"]');
    var checkboxAll = $('#executable-users-list-form  th input[type="checkbox"]');

    checkboxes.change(function () {
        $('#executeBtn').prop("disabled", !this.checked);
    }).change();

    checkboxAll.change(function () {
        $('#executeBtn').prop("disabled", !this.checked);
    }).change();

    $(document).ready(function () {
        $("#myInput").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });

</script>
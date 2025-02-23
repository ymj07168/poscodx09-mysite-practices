<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath }/assets/css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<c:set var="gNo" value="${boardView.groupNo }"/>
		<c:set var="oNo" value="${boardView.orderNo }"/>
		<c:set var="depth" value="${boardView.depth }"/>
		<div id="content">
			<div id="board" class="board-form">
				<table class="tbl-ex">
					<tr>
						<th colspan="2">글보기</th>
					</tr>
					<tr>
						<td class="label">제목</td>
						<td>${boardView.title }</td>
					</tr>
					<tr>
						<td class="label">내용</td>
						<td>
							<div class="view-content">
								${boardView.content }
							</div>
						</td>
					</tr>
				</table>
				<div class="bottom">
					<a href="${pageContext.request.contextPath}/board/list/${page}">글목록</a>
					<sec:authorize access="isAuthenticated()">
                        <sec:authentication property="principal" var="authUser"/>
							<c:if test="${not empty authUser && authUser.getId() == boardView.userId}" >
								<a href="${pageContext.request.contextPath}/board/update/${page }/${pId}">글수정</a>
							</c:if>
							<c:if test='${not empty authUser }'>
							<a href="${pageContext.request.contextPath}/board/write/${page }/${pId}">답글</a>
							</c:if>
					</sec:authorize>
				</div>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"/>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${list}" var = "i">
<table align="center">
<tr>
<th><h2>당신의 비밀번호는</h2></th>
</tr>

<tr>
<td>${i.seller_password }입니다.</td>
</tr>

<tr>
<td><a href="seller_login" >로그인 하러 가기</a>
</td>
</tr>
</table>
</c:forEach>
</body>
</html>
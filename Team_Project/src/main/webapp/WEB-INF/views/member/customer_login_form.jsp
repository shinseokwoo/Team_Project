<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="customer_login_check" id="customer_login_form">
		<table border="2" align="center">
		<caption>사용자 로그인</caption>
			<tr>
				<th>아이디</th>
				<td> <input type="text" name="login_id"> </td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td> <input type="text" name="login_pw"> </td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="로그인" onclick="logincheck()">
					<input type="button" value="회원가입" onclick="location.href='customer_join';">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
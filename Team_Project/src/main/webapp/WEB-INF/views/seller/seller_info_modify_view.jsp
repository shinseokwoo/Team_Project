<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.modify_btn{
	margin-top: 50px;
	margin-bottom: 50px;
	height: 52px;
    width: 100px;
    padding: 0 10px 0 10px;
    color: #ffffff;
    font-size: 16px;
    border: 1px solid #323437;
    background: #323437;
    text-align: center;
    font-weight: bold;
    line-height: 1.5;
    &:hover {
    background: rgb(77,77,77);
    color: #fff;}
}	
.reset_btn{
	height: 52px;
    width: 100px;
    padding: 0 10px 0 10px;
    color: #ffffff;
    font-size: 16px;
    border: 1px solid #323437;
    background: #323437;
    text-align: center;
    font-weight: bold;
    line-height: 1.5;
    &:hover {
    background: rgb(77,77,77);
    color: #fff;}
    margin-left: 20px;
}
.page_name {
	color: #777;
	align-content: center;
	margin-left: 400px;
	margin-right: 400px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function validateForm() {
		var password = document.getElementsByName("seller_password")[0].value;
		var phoneNumber = document.getElementsByName("seller_phone_number")[0].value;
		var companyNumber = document.getElementsByName("seller_company_number")[0].value;

		// 비밀번호 유효성 검사 (6-15자 영문 대소문자와 숫자)
		var passwordPattern = /^[a-zA-Z0-9]{6,15}$/;
		if (!passwordPattern.test(password)) {
			alert("비밀번호는 6-15자 사이의 영문 대소문자와 숫자로만 입력하세요.");
			return false;
		}

		// 전화번호 유효성 검사 (11자리 숫자)
		var phoneNumberPattern = /^\d{11}$/;
		var sanitizedPhoneNumber = phoneNumber.replace(/-/g, '').replace(/\s/g,
				'');
		if (!phoneNumberPattern.test(sanitizedPhoneNumber)) {
			alert("전화번호는 11자리 숫자로 입력하세요.");
			return false;
		}

		// 사업자 번호 유효성 검사 (10자리 숫자)
		var companyNumberPattern = /^\d{10}$/;
		if (!companyNumberPattern.test(companyNumber)) {
			alert("사업자 번호는 10자리 숫자로 입력하세요.");
			return false;
		}

		return true; // 모든 유효성 검사를 통과하면 true 반환
	}
</script>
</head>
<body>
	<hr>
	<form action="seller_info_modify_update" method="post"
		onsubmit="return validateForm();">
		<c:forEach items="${list }" var="i">
			<table align="center" width="350px">
						<div class="page_name">
							<H2>판매자 정보수정</H2><hr></div>
				<tr>
					<th>아이디</th>
					<td><hr>${i.seller_id }<hr></td>
				</tr>
				<input type="hidden" name="seller_number"
					value="${i.seller_number }">
				<tr>
					<th>비밀번호</th>
					<td><hr>
						<input type="text" name="seller_password"
						value="${i.seller_password }">
					<hr></td>
				</tr>

				<tr>
					<th>이름</th>
					<td><hr>${i.seller_name }<hr></td>
				</tr>

				<tr>
					<th>전화번호</th>
					<td><hr>
						<input type="text" name="seller_phone_number"
						value="${i.seller_phone_number }">
					<hr></td>
				</tr>

				<tr>
					<th>이메일</th>
					<td><hr>${i.seller_email }<hr></td>
				</tr>

				<tr>
					<th>사업자 번호</th>
					<td><hr>
						<input type="text" name="seller_company_number"
						value="${i.seller_company_number }" maxlength="10">
					<hr></td>
				</tr>

				<tr>
					<th>사업장 주소</th>
					<td><hr>
						<input type="text" id="seller_company_address"
						name="seller_company_address" value="${i.seller_company_address }">
					<hr></td>
				</tr>

				<tr>
					<td colspan="2" align="center">
					<input type="submit" class="modify_btn" value="수정">
					<input type="button" class="reset_btn" value="취소" onclick="back_page()"></td>
				</tr>
			</table>
		</c:forEach>
	</form>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		window.onload = function() {
			document
					.getElementById("seller_company_address")
					.addEventListener(
							"click",
							function() { //주소입력칸을 클릭하면
								//카카오 지도 발생
								new daum.Postcode(
										{
											oncomplete : function(data) { //선택시 입력값 세팅
												document
														.getElementById("seller_company_address").value = data.address; // 주소 넣기
											}
										}).open();
							});
		}
		function back_page(){
			history.back();
		}
		
		
	</script>
</body>
</html>
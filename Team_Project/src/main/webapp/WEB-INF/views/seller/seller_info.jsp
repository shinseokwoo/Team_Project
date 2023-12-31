<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
a {
	text-decoration: none !important;
	color: black;
}

a:hover {
	color: black;
}

/* 드롭다운 스타일 */
.dropdown-container {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 350px;
	height: 200px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-content {
	padding: 16px;
	text-decoration: none;
	display: block;
	align-items: center; /* 수평 정렬 */
	justify-content: center; /* 수직 정렬 */
}

.dropdown-input {
	width: 100%;
	padding: 8px;
	margin: 8px 0;
}

.modify_btn {
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
.out_btn {
	height: 52px;
	width: 120px;
	padding: 0 10px 0 10px;
	color: #ffffff;
	font-size: 16px;
	border: 1px solid #323437;
	background: #323437;
	text-align: center;
	font-weight: bold;
	line-height: 1.5;
	margin-left: 10px; 
	&:hover {
    background: rgb(77,77,77);
    color: #fff;}
}
.page_name {
	color: #777;
	align-content: center;
	margin-left: 400px;
	margin-right: 400px;
}
</style>
<script>
	function toggleDropdown() {
		var dropdown = document.getElementById("passwordDropdown");
		if (dropdown.style.display === "block") {
			dropdown.style.display = "none";
		} else {
			dropdown.style.display = "block";
		}
	}

	function confirmPassword() {
		// 비밀번호 확인 로직을 구현합니다.
		// 이 함수에서 확인 버튼의 동작을 정의하세요.
		var seller_password = $(".dropdown-input").val();
		var seller_number = $(".seller_number").val();
		if (confirm("정말 탈퇴하시겠습니까?") == true) {
			$.ajax({
				type : "post",
				url : "seller_info_exit",
				data : {
					"seller_password" : seller_password,
					"seller_number" : seller_number
				},
				success : function(data) {
					if (data == "ok") {
						alert("회원 탈퇴가 완료되었습니다.");
						window.location = "seller_page";
					} else {
						alert("비밀번호가 다릅니다.");
						window.location = "redirect:seller_info";
					}
				},
				error : function() {
					alert("오류 발생");
				}
			});
		} else {
			return false;
		}
		closeDropdown();
	}

	function seller_page() {
		location.href = "seller_page";
	}

	function closeDropdown() {
		var dropdown = document.getElementById("passwordDropdown");
		dropdown.style.display = "none";
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- <body> -->
	<hr>
	<c:forEach items="${list }" var="i">
		<table align="center">
			<div class="page_name">
				<H2>마이페이지<hr></H2>
			</div>
			<tr>
				<th>아이디</th>
				<td><hr>${i.seller_id }<hr></td>
			</tr>

			<tr>
				<th>이름</th>
				<td><hr>${i.seller_name }<hr></td>
			</tr>

			<tr>
				<th>전화번호</th>
				<td><hr>${i.seller_phone_number }<hr></td>
			</tr>

			<tr>
				<th>이메일</th>
				<td><hr>${i.seller_email }<hr></td>
			</tr>

			<tr>
				<th>사업자 번호</th>
				<td><hr>${i.seller_company_number }<hr></td>
			</tr>

			<tr>
				<th>사업장 주소</th>
				<td><hr>${i.seller_company_address }<hr></td>
			</tr>

			<tr>
				<th>보유 포인트</th>
				<td><hr>
					<fmt:formatNumber value="${i.seller_buy_point }" pattern="#,###" />
					<hr></td>
			</tr>

			<tr>
				<td><input type="button" class="modify_btn" value="정보수정"
					onclick="location.href='seller_info_modify?seller_number=${i.seller_number }'"></td>
				<td>
					<!-- 드롭다운 토글 버튼 --> <input type="button" class="out_btn"
					onclick="toggleDropdown()" value="회원 탈퇴하기"> <!-- 비밀번호 입력 드롭다운 -->
					<div id="passwordDropdown" class="dropdown-container">
						<input class="dropdown-input" type="password"
							placeholder="비밀번호 입력" name="seller_password"> <input
							class="seller_number" type="hidden" name="seller_number"
							value="${i.seller_number }">
						<button onclick="confirmPassword()">확인</button>
						<button onclick="closeDropdown()">취소</button>
					</div>
				</td>
			</tr>

		</table>
	</c:forEach>
</body>
</html>
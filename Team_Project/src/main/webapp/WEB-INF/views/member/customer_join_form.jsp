<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.customer_join_save_btn{
	height: 52px;
    padding: 0 10px 0 10px;
    color: #ffffff;
    font-size: 16px;
    border: 1px solid #323437;
    background: #323437;
    text-align: center;
    font-weight: bold;
    line-height: 1.5;
    width: 340px;
}
.customer_join_reset_btn{
	height: 52px;
    padding: 0 10px 0 10px;
    color: #ffffff;
    font-size: 16px;
    border: 1px solid #323437;
    background: #323437;
    text-align: center;
    font-weight: bold;
    line-height: 1.5;
    width: 340px;
}
.find_wall {
    margin-bottom: 0;
    flex-direction: unset;
    display: flex;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    padding-bottom: 0px;
    margin-top: 10px;
    -webkit-box-align: center;
    align-items: center;
    font-size: 13px;
    justify-content: center;
}
</style>
</head>
<script type="text/javascript">

function check(){
	var customerjoinform = document.getElementById("customer_join_form");
	
	// 체크해야 하는 질문 목록
	var requiredQuestions = [
		"member_id",
		"join_pw1",
		"join_pw2",
		"member_name",
		"member_personal_number",
		"member_phone_number",
		"member_address",
		"member_email",
		"member_birthday"
	]
	
	  // 각 질문을 순회하면서 체크
    for (var i = 0; i < requiredQuestions.length; i++) {
        var question = requiredQuestions[i];
        var inputElement = customerjoinform.elements[question];
        var inputValue = inputElement.value.trim(); // 입력값 공백 제거

        if (inputValue === "") {
            alert("필수 입력란이 비어 있습니다");
            // 필수 입력란이 비어 있을 때 작업을 중지하거나 추가 조치를 취할 수 있습니다.
            return;
        }
    }
    // 모든 필수 입력란이 값이 채워져 있을 때 가입 프로세스를 진행
    customerjoinform.submit(); // 또는 원하는 작업 수행
}

function checkPassword() {
    var p1 = document.getElementById('join_pw1').value;
    var p2 = document.getElementById('join_pw2').value;
    var pwCheckDiv = document.getElementById('pw_check');
   
    pwCheckDiv.innerHTML = "";
    
	if (p2.trim() === "") {
        return; // 입력란이 비어있으면 아무것도 하지 않음
    }
	
    if (p1 != p2) {
        pwCheckDiv.innerHTML = "비밀번호가 일치하지 않습니다.";
        pwCheckDiv.style.color = "red"; // 파란색으로 변경
    } else {
        pwCheckDiv.innerHTML = "비밀번호가 일치합니다.";
        pwCheckDiv.style.color = "blue"; // 파란색으로 변경
    }
}

function checkemail() {
    var email = document.getElementById('member_email').value;
    var emailCheckDiv = document.getElementById('email_check');

	// 이메일 입력란이 변경될 때 메시지를 리셋
    emailCheckDiv.innerHTML = "";
    
	if (email.trim() === "") {
        return; // 입력란이 비어있으면 아무것도 하지 않음
    }

    $.ajax({
        type: "post",
        url: "emailcheck",
        async: true,
        data: {"email" : email},
        success: function(data) {
            if (data === "ok") {
                emailCheckDiv.innerHTML = "이메일 사용이 가능합니다.";
                emailCheckDiv.style.color = "blue"; // 파란색으로 변경
            } else if (data === "no") {
                emailCheckDiv.innerHTML = "이메일 사용이 불가능합니다.";
                emailCheckDiv.style.color = "red"; // 빨간색으로 변경
            }
        },
        error: function(xhr, textStatus, errorThrown) {
            alert("오류 발생");
        }
    });
}

function checkid() {
    var id = document.getElementById('member_id').value;
    var idCheckDiv = document.getElementById('id_check');

	// 이메일 입력란이 변경될 때 메시지를 리셋
    idCheckDiv.innerHTML = "";
    
	if (id.trim() === "") {
        return; // 입력란이 비어있으면 아무것도 하지 않음
    }

    $.ajax({
        type: "post",
        url: "idcheck",
        async: true,
        data: {"id" : id},
        success: function(data) {
            if (data === "ok") {
                idCheckDiv.innerHTML = "아이디 사용이 가능합니다.";
                idCheckDiv.style.color = "blue"; // 파란색으로 변경
            } else if (data === "no") {
                idCheckDiv.innerHTML = "아이디 사용이 불가능합니다.";
                idCheckDiv.style.color = "red"; // 빨간색으로 변경
            }
        },
        error: function(xhr, textStatus, errorThrown) {
            alert("오류 발생");
        }
    });
}

</script>
<body>
<hr>
	<form action="customer_join_save" method="get" id="customer_join_form">
		<table align="center" width="600px">
		<caption>회원가입</caption>
			<tr>
				<th>아이디</th>
				<td><hr> <input type="text" id="member_id" name="member_id" oninput="checkid()" style="width: 300px;" > </td>
			</tr>
			<tr>
				<td colspan="2"> <div id="id_check"></div> </td>				
			</tr>
			<tr>
				<th>패스워드</th>
				<td><hr> <input type="password" id="join_pw1" style="width: 300px;"> </td>
			</tr>
			<tr>
	        	<th>패스워드 확인</th>
	       		<td><hr> <input id="join_pw2" type="password" oninput="checkPassword()" name="member_password" style="width: 300px;"> </td>
	        </tr>
	        <tr>
	       		<td colspan="2"><div id="pw_check" ></div></td>
	        </tr>
			<tr>
				<th>이름</th>
				<td><hr> <input type="text" id="name" name="member_name" style="width: 300px;"> </td>
			</tr>
			<tr>
				<th>주민번호</th>
				<td><hr> <input type="text" id="member_personal_number" name="member_personal_number" placeholder=" - 빼고 입력해주세요" style="width: 300px;"> </td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><hr> <input type="text" id="member_phone_number" name="member_phone_number" style="width: 300px;"> </td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
				<hr> 
					<input type="text" id="member_address" name="member_address" style="width: 300px;"> 
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><hr> <input type="email" id="member_email" name="member_email" oninput="checkemail()" style="width: 300px;"> </td>
			</tr>
			<tr>
				<td colspan="2"><div id="email_check"></div></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><hr> <input type="date" id="member_birthday" name="member_birthday" style="width: 300px;"> </td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<hr>
					<input type="button" class="customer_join_save_btn" value="회원가입" onclick="check()">
				<div class="find_wall"></div>
					<input type="reset" class="customer_join_reset_btn" value="취소" onclick="location.href='user_page';">
				</td>
			</tr>
		</table>
			<div class="find_wall"></div>
	</form>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		window.onload = function(){
		    document.getElementById("member_address").addEventListener("click", function(){ //주소입력칸을 클릭하면
		        //카카오 지도 발생
		        new daum.Postcode({
		            oncomplete: function(data) { //선택시 입력값 세팅
		                document.getElementById("member_address").value = data.address; // 주소 넣기
		            }
		        }).open();
		    });
		}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function addToCart(product_number, member_number) {
    // Ajax 요청을 보내고 서버에서 처리합니다.
    $.ajax({
        type: 'POST',  // 또는 'GET'에 따라 상황에 맞게 설정
        url: 'user_product_cart_check', // 서버의 처리 URL로 변경해야 합니다.
        data: {
            product_number: product_number,
            member_number: member_number
        },
        success: function(response) {
            if (response === 'already') {
                alert('이미 등록된 상품입니다.');
            } else if (response === 'success') {
                alert('상품이 장바구니에 추가되었습니다.');
                var newLocation = 'user_product_cart?product_number=' + product_number + '&member_number=' + member_number;
                window.location.href = newLocation;
            } else {
                alert('알 수 없는 오류가 발생했습니다.');
            }
        },
        error: function() {
            alert('로그인이 필요한 기능입니다.');
        }
    });
}
///


function checkLoginAndRedirect(product_number, member_number, product_sell_amount) {
    // 로그인 상태를 확인하고, 리디렉션을 처리하는 함수
    isUserLoggedIn(function(loggedIn) {
        if (loggedIn) {
            // 로그인된 경우
            checkAndRedirect(product_number, member_number, product_sell_amount);
        } else {
            // 로그인되지 않은 경우
            alert('로그인이 필요한 기능입니다.');
        }
    });
}

function isUserLoggedIn(callback) {
    // Ajax 요청을 보내어 서버에서 세션에서 로그인 상태 확인
    $.ajax({
        type: 'GET',
        url: 'checkLoginStatus',
        success: function(response) {
            if (response === 'loggedIn') {
                // 사용자가 로그인한 상태
                callback(true);
            } else {
                // 사용자가 로그인하지 않은 상태
                callback(false);
            }
        },
        error: function() {
            // 에러 처리 로직
            return false; // 에러 시에도 로그인되지 않은 상태로 처리
        }
    });
}

function checkAndRedirect(productNumber, memberNumber, productSellAmount) {
    if (productSellAmount > 0) {
        // 여기에서 상품 수량이 0보다 큰 경우에만 구매 페이지로 리디렉션
        window.location.href = 'user_product_order?product_number=' + productNumber + '&member_number=' + memberNumber;
    } else {
        alert('품절된 상품입니다.');
    }
}


</script>
<style type="text/css">
body {
	margin-top: -1px;
	border-top: 1px solid #cccccc;
	padding-top: 75px !important;
	align: center;
}

.content_box {
	padding-top: 75px !important;
	width: 100%;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
}

.sub_image_item_info {
	position: relative;
	width: 760px;
	border: 0;
	height: 600px;
	text-align: center;
	vertical-align: middle;
	display: flex;
	border-bottom: 1px solid #dbdbdb;
}

.sub_image {
	max-width: 100%;
	max-height: 100%;
	border: 0 none;
	vertical-align: top;
	width: 527px;
	height: auto;
	overflow-clip-margin: content-box;
	overflow: clip;
	color: #333;
	cursor: pointer;
}

.item_info_box {
	width: 440px;
	box-sizing: border-box;
	padding-left: 20px;
	float: right;
	position: relative;
	margin: 0;
	padding: 0;
}

.item_product_name {
	position: relative;
	padding: 0 0 10px 0;
	border-bottom: 1px solid #dbdbdb;
}

.item_product_info {
	border-bottom: 0;
	margin: 10px 0 0 0;
	padding: 0;
}

.item_product_price {
	float: left;
	width: 100%;
	min-height: 24px;
	padding: 7px 0 6px 0;
	display: block;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
}

.item_product_maker {
	float: left;
	width: 100%;
	min-height: 24px;
	padding: 7px 0 6px 0;
	display: block;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
}

.item_product_country {
	float: left;
	width: 100%;
	min-height: 24px;
	padding: 7px 0 6px 0;
	display: block;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
}

.item_product_amount {
	float: left;
	width: 100%;
	min-height: 24px;
	padding: 7px 0 6px 0;
	display: block;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
}

.item_choise_button {
	border-top: 1px solid #000;
	clear: both;
	width: 100%;
	padding: 20px 0 0 0;
	text-align: right;
}

.cart {
	width: 205px;
	margin-right: 3px;
	margin: 0;
	display: inline-block;
	height: 52px;
	padding: 0 10px 0 10px;
	color: #3e3d3c;
	font-size: 16px;
	border: 1px solid #cccccc;
	background: #ffffff;
	text-align: center;
	font-weight: bold;
	line-height: 1.5;
	font-family: Malgun Gothic, "맑은 고딕", AppleGothic, Dotum, "돋움",
		sans-serif;
}

.like {
	width: 205px;
	margin-right: 3px;
	margin: 0;
	display: inline-block;
	height: 52px;
	padding: 0 10px 0 10px;
	color: #3e3d3c;
	font-size: 16px;
	border: 1px solid #cccccc;
	background: #ffffff;
	text-align: center;
	font-weight: bold;
	line-height: 1.5;
	font-family: Malgun Gothic, "맑은 고딕", AppleGothic, Dotum, "돋움",
		sans-serif;
	cursor: pointer;
}

.buy {
	width: 205px;
	height: 52px;
	margin: 10px 0 0;
	padding: 0 10px 0 10px;
	color: #ffffff;
	font-size: 16px;
	border: 1px solid #323437;
	background: #323437;
	text-align: center;
	font-weight: bold;
	line-height: 1.5;
	font-family: Malgun Gothic, "맑은 고딕", AppleGothic, Dotum, "돋움",
		sans-serif;
	cursor: pointer;
}

.intro_image {
	border-top: 1px solid #000;
	width: 100%;
	max-width: 100%;
	margin: 0 auto;
	border: 0 none;
	vertical-align: top;
	overflow-clip-margin: content-box;
	overflow: clip;
	font-size: 12px;
	line-height: 1.5;
	display: flex;
	justify-content: space-between;
	flex-direction: column
}

.intro_image img {
	display: block;
	margin: 0 auto;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach items="${list }" var="pnum">
		<div class="content_box">
			<div class="sub_image_item_info">
				<div class="sub_image">
					<img src="product_sum_image/${pnum.product_sum_image }"
						width="440px" height="auto">
				</div>
				<div class="item_info_box">
					<div class="item_product_name">${pnum.product_name }</div>
					<div class="item_product_info">
						<dl class="item_product_price">
							<dt>판매가</dt>
							<dd>
								<strong><strong>${pnum.product_price }</strong></strong>원
							</dd>
						</dl>
						<dl class="item_product_maker">
							<dt>메이커</dt>
							<dd>
								<strong><strong>${pnum.product_maker }</strong></strong>
							</dd>
						</dl>
						<dl class="item_product_country">
							<dt>made in</dt>
							<dd>
								<strong><strong>${pnum.product_country }</strong></strong>
							</dd>
						</dl>
						<c:choose>
							<c:when test="${pnum.product_sell_amount > 0 }">
								<dl class="item_product_amount">
									<dt>재고</dt>
									<dd>
										<strong>${pnum.product_sell_amount }</strong>
									</dd>
								</dl>
							</c:when>
							<c:otherwise>
								<dl class="item_product_amount">
									<dt>재고</dt>
									<dd>
										<strong>품절</strong>
									</dd>
								</dl>
							</c:otherwise>
						</c:choose>

					</div>
					<div class="item_choise_button">
						<input type="button" class="cart" value="장바구니"
							onclick="addToCart(${pnum.product_number}, ${memberDTO.member_number})">
						<c:choose>
							<c:when test="${memberDTO.member_number != null }">
								<input type="button" class="buy" value="바로구매"
									onclick="checkLoginAndRedirect(${pnum.product_number}, ${memberDTO.member_number}, ${pnum.product_sell_amount })">
							</c:when>
							<c:otherwise>
								<input type="button" class="buy" value="로그인 후 구매 가능"
									onclick="location.href='customer_login'">
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<div class="intro_image">
			<img src="product_intro_image/${pnum.product_detail_image1 }">
			<img src="product_intro_image/${pnum.product_detail_image2 }">
			<img src="product_intro_image/${pnum.product_detail_image3 }">
		</div>
	</c:forEach>
</body>
</html>
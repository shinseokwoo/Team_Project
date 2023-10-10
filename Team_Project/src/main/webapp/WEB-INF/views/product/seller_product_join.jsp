<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
a{
	text-decoration: none !important;
	color:black;
	}
	a:hover{
	color:black;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="seller_product_join_save" method="post" enctype="multipart/form-data">
<table align="center">
<h3>상품 등록</h3>

<input type="hidden" value="${seller_id }" name="seller_id">

<tr>
<th>상품명</th>
<td><input type="text" name="product_name"></td>
</tr>

<tr>
<th>원산지</th>
<td><input type="text" name="product_country"></td>
</tr>

<tr>
<th>메이커</th>
<td><input type="text" name="product_maker"></td>
</tr>

<tr>
<th>가격</th>
<td><input type="text" name="product_price"></td>
</tr>

<tr>
<th>상품재고</th>
<td><input type="number" name="product_sell_amount"></td>
</tr>

<tr>
<th>썸네일이미지</th>
<td><input type="file" name="product_sum_image"></td>
</tr>
<tr>
<th>상세이미지1</th>
<td><input type="file" name="product_detail_image1"></td>
</tr>
<tr>
<th>상세이미지2</th>
<td><input type="file" name="product_detail_image2"></td>
</tr>
<tr>
<th>상세이미지3</th>
<td><input type="file" name="product_detail_image3"></td>
</tr>


<tr>
<td colspan="2"><input type="submit" value="등록">
<button><a href="seller_page">취소</a></button>
</td>
</tr>


</table>
</form>
</body>
</html>
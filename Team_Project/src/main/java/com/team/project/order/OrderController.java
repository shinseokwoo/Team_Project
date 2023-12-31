package com.team.project.order;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team.project.member.MemberDTO;
import com.team.project.member.MemberService;
import com.team.project.product.ProductDTO;
import com.team.project.product.ProductService;
import com.team.project.seller.SellerService;

@Controller
public class OrderController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping(value = "/user_product_order")
	public String user_product_order(HttpServletRequest request, Model mo) {
		
		int product_number=Integer.parseInt(request.getParameter("product_number"));
		int member_number=Integer.parseInt(request.getParameter("member_number"));

		ProductService ps = sqlSession.getMapper(ProductService.class);
		ArrayList<ProductDTO> plist = ps.user_product_order(product_number);
		
		MemberService ms = sqlSession.getMapper(MemberService.class);
		ArrayList<MemberDTO> mlist = ms.user_product_order(member_number);
		
		mo.addAttribute("mlist", mlist);
		mo.addAttribute("plist", plist);
		
		return "user_product_order";
	}	
	
	@RequestMapping(value = "/order_buy_final")
	public String order_buy_final(HttpServletRequest request) {
		int member_point = Integer.parseInt(request.getParameter("member_point"));
		int member_number = Integer.parseInt(request.getParameter("member_number"));
		int product_number=Integer.parseInt(request.getParameter("product_number"));
		int product_price=Integer.parseInt(request.getParameter("product_price"));
		String seller_id=request.getParameter("seller_id");
		System.out.println(seller_id);
		System.out.println(member_point);
		System.out.println(member_number);
		MemberService ms = sqlSession.getMapper(MemberService.class);
		SellerService ss = sqlSession.getMapper(SellerService.class);
		ms.order_buy_final(member_point,member_number);
		ms.order_buy_point_up(product_price,member_number);
		String member_address = ms.customer_member_address(member_number);
		ProductService ps = sqlSession.getMapper(ProductService.class);
		ps.order_buy_amount_updown(product_number);
		String seller_number = ss.product_seller_number(seller_id);
		System.out.println(seller_number);
		String seller_name = ss.product_seller_name(seller_id);
		System.out.println(seller_name);
		String member_name = ms.customer_member_name(member_number);
		OrderDTO dto = new OrderDTO();
		dto.setSeller_number(Integer.parseInt(seller_number));
		dto.setSeller_name(seller_name);
		dto.setMember_number(member_number);
		dto.setMember_name(member_name);
		dto.setProduct_number(product_number);
		dto.setProduct_name(ps.product_product_name(String.valueOf(product_number)));
		dto.setProduct_sell_amount(1);
		dto.setProduct_price(product_price);
		dto.setProduct_total_price(product_price);
		String delivery_status="주문 접수 중";
		dto.setDelivery_status(delivery_status);
		dto.setMember_address(member_address);
		OrderService os = sqlSession.getMapper(OrderService.class);
		os.insert_order_history(dto);
		return "redirect:/user_product_out";
	}
	
	@RequestMapping(value = "/customer_order_view")
	public String customer_order_view(HttpServletRequest request,Model mo)
	{
		HttpSession hs = request.getSession();
		if(hs.getAttribute("memberDTO") != null)
		{
		MemberDTO dto = (MemberDTO) hs.getAttribute("memberDTO");
		int member_number = dto.getMember_number();
		OrderService os = sqlSession.getMapper(OrderService.class);
		ArrayList<OrderDTO> list = os.customer_order_view(member_number);
		mo.addAttribute("list", list);
		return "customer_order_view";
		}
		else
		{
			mo.addAttribute("msg","로그인 세션이 만료 되었습니다.");
			return "customer_login_form";
		}
	}
	@ResponseBody
	@RequestMapping(value = "/delivery_status_update",method=RequestMethod.POST)
	public String delivery_status_update(HttpServletRequest request,Model mo)
	{
		int sell_list_number = Integer.parseInt(request.getParameter("sellListNumber"));
		String delivery_status = request.getParameter("newDeliveryStatus");
		System.out.println("주문번호"+sell_list_number+"배송 정보"+delivery_status);
		OrderService os = sqlSession.getMapper(OrderService.class);
		os.delivery_status_update(sell_list_number,delivery_status);
		mo.addAttribute("delivery_status",delivery_status );
		return "response";
	}
	@ResponseBody
	@RequestMapping(value = "/refund_product",method=RequestMethod.POST)
	public String refund_product(HttpServletRequest request)
	{
		int sell_list_number = Integer.parseInt(request.getParameter("sell_list_number"));
		String delivery_status = "환불 요청 중";
		
		OrderService os = sqlSession.getMapper(OrderService.class);
		os.delivery_status_update(sell_list_number, delivery_status);
		String result="ok";
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/accept_refund",method=RequestMethod.POST)
	public String accept_refund(HttpServletRequest request)
	{
		int sell_list_number = Integer.parseInt(request.getParameter("sell_list_number"));
		OrderService os = sqlSession.getMapper(OrderService.class);
		OrderDTO dto = os.reject_refund_product_data(sell_list_number);
		//환불 요청 수락 시 판매자 포인트 차감과 구매자 포인트 환불 진행을 위한 데이터 검색
		int product_sell_amount = dto.product_sell_amount;
		int product_price = dto.product_price;
		int product_price_all = product_sell_amount * product_price;
		int member_number = dto.member_number;
		int seller_number = dto.seller_number;
		int product_number = dto.product_number;
		SellerService ss = sqlSession.getMapper(SellerService.class);
		ss.seller_refund(seller_number,product_price_all);
		
		MemberService ms = sqlSession.getMapper(MemberService.class);
		//구매자 포인트 환불
		ms.member_refund(member_number,product_price_all);
		ProductService ps = sqlSession.getMapper(ProductService.class);
		//상품 재고 롤백
		ps.sell_amount_rollback(product_number,product_sell_amount);
		
		os.accept_refund(sell_list_number);//환불 요청 수락시 DB에서 데이터 제거
		
		return "success";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/reject_refund",method=RequestMethod.POST)
	public String reject_refund(HttpServletRequest request)
	{
		int sell_list_number = Integer.parseInt(request.getParameter("sell_list_number"));
		String delivery_status = "주문 접수 중";
		OrderService os = sqlSession.getMapper(OrderService.class);
		os.reject_refund(sell_list_number,delivery_status);
		return "success";
	}
	
}

package com.team.project.inquiry;

import java.util.ArrayList;

public interface InquiryService {
	
	public void customer_inquiry_input_save(InquiryDTO dto);
	public ArrayList<InquiryDTO> customer_inquiry_view(String inquiry_writer_type);
	public ArrayList<InquiryDTO> inquiry_board_list();
	public InquiryDTO inquiry_answer(int inquiry_number);
	public void admin_inquiry_answer_save(int inquiry_number,String inquiry_answer,String inquiry_status);
	public void admin_inquiry_answer_modify_save(int inquiry_number, String inquiry_answer);
	public ArrayList<InquiryDTO> seller_inquiry_view(String inquiry_writer_type);
}
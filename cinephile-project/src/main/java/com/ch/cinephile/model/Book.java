package com.ch.cinephile.model;

import java.sql.Date;

import lombok.Data;
@Data
public class Book {
	private int book_num;
	private String c_id;
	private int mv_num;
	private String book_numSeat;
	private String book_loc;
	private Date book_date;
	private String book_humantype;
	private int book_price;
	private String mv_name;
	private String book_del;
	//예매확인 영화이미지용
	private String img;
}
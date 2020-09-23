package com.ch.cinephile.model;

import java.sql.Date;
import lombok.Data;

@Data 
public class Board {
	   private int b_num;
	   private String b_subject;
	   private String b_content;
	   private int b_readcount ;
	   private Date b_regdate;
	   private String c_id;
	   private int b_good;
	   private String b_type;
	   private String b_category;
	   private String b_del;
	   // 페이징용
	   private int startRow;
	   private int endRow;
	   // 검색용
	   private String search;
	   private String keyword;

	}
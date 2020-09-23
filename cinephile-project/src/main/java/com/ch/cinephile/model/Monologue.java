package com.ch.cinephile.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Monologue {
	private int mo_num;
	private String c_id;
	private String mo_content;
	private int mo_good;
	private Date mo_regdate;
	private String  mo_del;
	   // 검색용
	   private String search;
	   private String keyword;
}

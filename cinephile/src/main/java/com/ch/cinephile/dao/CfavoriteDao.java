package com.ch.cinephile.dao;

import java.util.List;

import com.ch.cinephile.model.Cfavorite;

public interface CfavoriteDao {

	int selectZipnum(String id);

	Cfavorite ckChoice(int mv_num, int zipnum);

	int insert(int mv_num, int zipnum);

	List<Integer> getCustomer(int zipnum);

	void delete(int mv_num, int zipnum);

	List<Integer> selectZipnum(int zipnum);


	
	// 모든 영화 보기
	
	Integer mvgood(int mv_num);

	List ckChoiceAll(int zip_num);

}

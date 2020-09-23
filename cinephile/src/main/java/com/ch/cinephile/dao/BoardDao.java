package com.ch.cinephile.dao;
import java.util.Collection;
import java.util.List;

import com.ch.cinephile.model.Board;

public interface BoardDao {

	int getTotal(Board board);
	List<Board> list(Board board);
	int insert(Board board);
	Board select(int b_num);
	void updateReadCount(int b_num);
	int update(Board board);
	int delete(int b_num);
	int maxNum();
	void updateStep(Board board);
	
	// 통합검색
	Collection<Board> rbList(Board board);
	Collection<Board> ibList(Board board);
	Collection<Board> fbList(Board board);
	Collection<Board> nbList(Board board);
	List<Board> list2(String b_type);
	void goodUp(int b_num);
	void goodDown(int b_num);

}
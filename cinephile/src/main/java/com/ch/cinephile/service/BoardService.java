package com.ch.cinephile.service;
import java.util.Collection;
import java.util.List;

import com.ch.cinephile.model.Board;
public interface BoardService {
	int getTotal(Board board);
	int insert(Board board);
	void updateReadCount(int b_num);
	Board select(int b_num);
	int update(Board board);
	int delete(int b_num);
	int maxNum();
	void updateStep(Board board);
	List<Board> list(Board board);
	void goodUp(int b_num);
	void goodDown(int b_num);
	
	// 통합검색
	Collection<Board> rbList(Board board);
	Collection<Board> ibList(Board board);
	Collection<Board> fbList(Board board);
	Collection<Board> nbList(Board board);

}
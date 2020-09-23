package com.ch.cinephile.service;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ch.cinephile.dao.BoardDao;
import com.ch.cinephile.dao.ReplyBoardDao;
import com.ch.cinephile.model.Board;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao bd;
	@Autowired
	private ReplyBoardDao rbd;
	public int getTotal(Board board) {
		return bd.getTotal(board);
	}
	public List<Board> list(Board board) {
		return bd.list(board);
	}
	public List<Board> list2(String b_type) {
		return bd.list2(b_type);
	}
	public int insert(Board board) {
		return bd.insert(board);
	}
	public void updateReadCount(int b_num) {
		bd.updateReadCount(b_num);
	}
	public Board select(int b_num) {
		return bd.select(b_num);
	}
	public int update(Board board) {
		return bd.update(board);
	}
	public int delete(int b_num) {
		return bd.delete(b_num);
	}
	public int maxNum() {
		return bd.maxNum();
	}
	public void updateStep(Board board) {
		bd.updateStep(board);
	}
	public void goodUp(int b_num) {
		bd.goodUp(b_num);
	}
	public void goodDown(int b_num) {
		bd.goodDown(b_num);
	}
	
	// 통합검색
	public Collection<Board> rbList(Board board) {
		return bd.rbList(board);
	}
	public Collection<Board> ibList(Board board) {
		return bd.ibList(board);
	}
	public Collection<Board> fbList(Board board) {
		return bd.fbList(board);
	}
	public Collection<Board> nbList(Board board) {
		return bd.nbList(board);
	}
}


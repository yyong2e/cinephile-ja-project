package com.ch.cinephile.dao;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ch.cinephile.model.Board;

@Repository
public class BoardDaoImpl implements BoardDao{
	@Autowired
	private SqlSessionTemplate sst;
	public int getTotal(Board board) {
		return sst.selectOne("boardns.getTotal", board);
	}

	public List<Board> list(Board board) {
		return sst.selectList("boardns.list", board);
	}
	public List<Board> list2(String b_type) {
		return sst.selectList("boardns.list2",b_type);
	}

	public int insert(Board board) {
		return sst.insert("boardns.insert",board);
	}
	public Board select(int b_num) {
		return sst.selectOne("boardns.select", b_num);
	}
	public void updateReadCount(int b_num) {
		sst.update("boardns.updateReadCount",b_num);		
	}
	public int update(Board board) {
		return sst.update("boardns.update", board);
	}
	public int delete(int b_num) {
		return sst.delete("boardns.delete", b_num);
	}
	public int maxNum() {
		return sst.selectOne("boardns.maxNum");
	}
	public void updateStep(Board board) {
		sst.update("boardns.updateStep", board);
	}
	public void goodUp(int b_num) {
		sst.update("boardns.goodUp",b_num);
	}
	public void goodDown(int b_num) {
		sst.update("boardns.goodDown",b_num);
	}
	
	
	// 통합검색
	public Collection<Board> rbList(Board board) {
		return sst.selectList("boardns.rbList", board);
	}
	public Collection<Board> ibList(Board board) {
		return sst.selectList("boardns.ibList", board);
	}
	public Collection<Board> fbList(Board board) {
		return sst.selectList("boardns.fbList", board);
	}
	public Collection<Board> nbList(Board board) {
		return sst.selectList("boardns.nbList", board);
	}

}

package com.ch.cinephile.dao;

import java.util.Collection;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Mogoodck;
import com.ch.cinephile.model.Monologue;

@Repository
public class MonologueDaoImpl implements MonologueDao{
	@Autowired
	private SqlSessionTemplate sst;

	public void write(String c_id, String contents) {
		Monologue m=new Monologue();
		m.setC_id(c_id);
		m.setMo_content(contents);
		sst.insert("monologuens.write", m);
	}
	public List<Monologue> getForCid(String c_id) {
		return sst.selectList("monologuens.getForCid", c_id);
	}
	public List<Monologue> searchHot() {
		return sst.selectList("monologuens.searchHot");
	}
	@Override
	public void goodup(int mo_num) {
		sst.update("monologuens.goodup", mo_num);
		
	}
	@Override
	public void gooddown(int mo_num) {
		sst.update("monologuens.gooddown", mo_num);
	}
	public void delete(int mo_num) {
		sst.update("monologuens.delete", mo_num);
	}
	public int recentMono(String c_id) {
		return sst.selectOne("monologuens.recentMono", c_id);
	}
	
	// 통합검색
	public List<Monologue> moList(Monologue monologue) {
		return sst.selectList("monologuens.moList",monologue);
	}
}

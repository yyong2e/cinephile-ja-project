package com.ch.cinephile.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Bogoodck;

@Repository
public class BogoodckDaoImpl implements BogoodckDao{
	@Autowired
	private SqlSessionTemplate sst;

	public Bogoodck ckGood(Bogoodck bgood) {
		return sst.selectOne("bogoodckns.ckGood", bgood);
	}
	public void insert(Bogoodck bgood) {
		sst.insert("bogoodckns.insert",bgood);
	}
	public void delete(Bogoodck bgood) {
		sst.insert("bogoodckns.delete",bgood);
	}
}

package com.ch.cinephile.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Mogoodck;

@Repository
public class MogoodckDaoImpl implements MogoodckDao{
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public Mogoodck selectMonum(Mogoodck mgc) {
		return sst.selectOne("mogoodckns.selectMonum",mgc);
	}

	public void delete(Mogoodck mogoodck) {
		sst.delete("mogoodckns.delete", mogoodck);
	}

	public void insert(Mogoodck mogoodck) {
		sst.insert("mogoodckns.insert", mogoodck);
	}
}

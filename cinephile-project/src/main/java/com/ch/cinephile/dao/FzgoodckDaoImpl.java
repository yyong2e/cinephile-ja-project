package com.ch.cinephile.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Fzgoodck;

@Repository
public class FzgoodckDaoImpl implements FzgoodckDao{
	@Autowired
	private SqlSessionTemplate sst;
	@Override
	public void delete(Fzgoodck fzgoodck) {
		sst.delete("Fzgoodckns.delete", fzgoodck);
	}
	@Override
	public void insert(Fzgoodck fzgoodck) {
		sst.insert("Fzgoodckns.insert", fzgoodck);
	}
	public Fzgoodck searchId(Fzgoodck fg) {
		return sst.selectOne("Fzgoodckns.searchId", fg);
	}
}

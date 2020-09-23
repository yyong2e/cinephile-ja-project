package com.ch.cinephile.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Mvtaglink;

@Repository
public class MvtaglinkDaoImpl implements MvtaglinkDao{
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Mvtaglink> selectAllTag(int mv_num) {
		return sst.selectList("mvtaglinkns.selectAllTag", mv_num);
	}
	public void insert(Mvtaglink mvtag) {
		sst.insert("mvtaglinkns.insert",mvtag);
		
	}
	@Override
	public void deleteTagnum(int tag_num) {
		sst.delete("mvtaglinkns.deleteTagnum", tag_num);
	}
}

package com.ch.cinephile.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Motaglink;

@Repository
public class MotaglinkDaoImpl implements MotaglinkDao{
	@Autowired
	private SqlSessionTemplate sst;
	public void insert(Motaglink motaglink) {
		sst.insert("motaglinkns.insert", motaglink);
	}
	public List<Motaglink> selectTag(int mo_num) {
		return sst.selectList("motaglinkns.selectTag", mo_num);
	}
	public void deleteTagnum(int tag_num) {
		sst.delete("motaglinkns.deleteTagnum", tag_num);
	}
}

package com.ch.cinephile.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Tag;

@Repository
public class TagDaoImpl implements TagDao{
	@Autowired
	private SqlSessionTemplate sst;
	public Tag getTag(int tag_num) {
		return sst.selectOne("tagns.getTag", tag_num);
	}
	public List<Tag> selectAll(String con) {
		return sst.selectList("tagns.selectAll", con);
	}
	public List<String> getCons(String con) {
		return sst.selectList("tagns.getCons", con);
	}
	public Tag selectCon(String con) {
		return sst.selectOne("tagns.selectCon", con);
	}
	public void insert(String con) {
		sst.insert("tagns.insert", con);
	}
	public List<Tag> allTag() {
		return sst.selectList("tagns.allTag");
	}
	@Override
	public void delete(int tag_num) {
		sst.delete("tagns.delete",tag_num);
	}
}

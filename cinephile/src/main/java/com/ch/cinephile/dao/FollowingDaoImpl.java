package com.ch.cinephile.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Following;

@Repository
public class FollowingDaoImpl implements FollowingDao{
	@Autowired
	private SqlSessionTemplate sst;

	public Following followCk(Following following) {
		return sst.selectOne("followingns.followCk", following);
	}
	public void delete(Following following) {
		sst.delete("followingns.delete", following);
	}
	@Override
	public void insert(Following following) {
		sst.insert("followingns.insert", following);
	}
	@Override
	public List<Following> selectAll(String c_id) {
		return sst.selectList("followingns.selectAll", c_id);
	}
	public int followCnt(String c_id) {
		return sst.selectOne("followingns.followCnt", c_id);
	}
	public int followingCnt(String c_id) {
		return sst.selectOne("followingns.followingCnt", c_id);
	}
	public List<Following> selectAll2(String f_id) {
		return sst.selectList("followingns.selectAll2", f_id);
	}
}

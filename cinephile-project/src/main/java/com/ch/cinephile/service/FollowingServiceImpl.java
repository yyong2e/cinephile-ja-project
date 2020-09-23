package com.ch.cinephile.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.cinephile.dao.FollowingDao;
import com.ch.cinephile.model.Following;

@Service
public class FollowingServiceImpl implements FollowingService{
	@Autowired
	private FollowingDao fd;

	public Following followCk(Following following) {
		return fd.followCk(following);
	}
	public void delete(Following following) {
		fd.delete(following);
	}
	public void insert(Following following) {
		fd.insert(following);
	}
	@Override
	public List<Following> selectAll(String c_id) {
		return fd.selectAll(c_id);
	}
	public int followCnt(String c_id) {
		return fd.followCnt(c_id);
	}
	public int followingCnt(String c_id) {
		return fd.followingCnt(c_id);
	}
	public List<Following> selectAll2(String f_id) {
		return fd.selectAll2(f_id);
	}
}

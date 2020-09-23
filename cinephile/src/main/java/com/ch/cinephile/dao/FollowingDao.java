package com.ch.cinephile.dao;

import java.util.List;

import com.ch.cinephile.model.Following;

public interface FollowingDao {

	Following followCk(Following following);

	void delete(Following following);

	void insert(Following following);

	List<Following> selectAll(String c_id);

	int followCnt(String c_id);

	int followingCnt(String c_id);

	List<Following> selectAll2(String f_id);

}

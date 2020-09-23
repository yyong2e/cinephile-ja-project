package com.ch.cinephile.service;

import java.util.List;

import com.ch.cinephile.model.Following;

public interface FollowingService {

	Following followCk(Following following);

	void delete(Following following);

	void insert(Following following);

	List<Following> selectAll(String c_id);

	int followCnt(String c_id);

	int followingCnt(String c_id);

	List<Following> selectAll2(String f_id);

}

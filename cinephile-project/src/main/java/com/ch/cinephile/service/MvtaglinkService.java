package com.ch.cinephile.service;

import java.util.List;

import com.ch.cinephile.model.Mvtaglink;

public interface MvtaglinkService {

	List<Mvtaglink> selectAllTag(int mv_num);

	void insert(Mvtaglink mvtag);

	void deleteTagnum(int tag_num);

}

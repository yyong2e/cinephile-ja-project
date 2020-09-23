package com.ch.cinephile.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.cinephile.dao.MvtaglinkDao;
import com.ch.cinephile.model.Mvtaglink;

@Service
public class MvtaglinkServiceImpl implements MvtaglinkService{
	@Autowired
	private MvtaglinkDao md;

	@Override
	public List<Mvtaglink> selectAllTag(int mv_num) {
		return md.selectAllTag(mv_num);
	}

	// 무비태그링크 추가
	public void insert(Mvtaglink mvtag) {
		 md.insert(mvtag);
	}
	public void deleteTagnum(int tag_num) {
		md.deleteTagnum(tag_num);
	}
}

package com.ch.cinephile.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.cinephile.dao.MotaglinkDao;
import com.ch.cinephile.model.Motaglink;

@Service
public class MotaglinkServiceImpl implements MotaglinkService{
	@Autowired
	private MotaglinkDao md;

	public void insert(Motaglink motaglink) {
		md.insert(motaglink);
	}
	public List<Motaglink> selectTag(int mo_num) {
		return md.selectTag(mo_num);
	}
	public void deleteTagnum(int tag_num) {
		md.deleteTagnum(tag_num);
	}
}

package com.ch.cinephile.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.cinephile.dao.TagDao;
import com.ch.cinephile.model.Tag;

@Service
public class TagServiceImpl implements TagService{
	@Autowired
	private TagDao td;
	public Tag getTag(int tag_num) {
		return td.getTag(tag_num);
	}
	@Override
	public List<Tag> selectAll(String con) {
		return td.selectAll(con);
	}
	public List<String> getCons(String con) {
		return td.getCons(con);
	}
	public Tag selectCon(String str) {
		return td.selectCon(str);
	}
	public void insert(String str) {
		td.insert(str);
	}
	public List<Tag> allTag() {
		return td.allTag();
	}
	public void delete(int tag_num) {
		td.delete(tag_num);
	}
}

package com.ch.cinephile.service;

import java.util.List;

import com.ch.cinephile.model.Tag;

public interface TagService {

	Tag getTag(int tag_num);

	List<Tag> selectAll(String con);

	List<String> getCons(String con);

	Tag selectCon(String str);

	void insert(String str);

	List<Tag> allTag();

	void delete(int tag_num);

}

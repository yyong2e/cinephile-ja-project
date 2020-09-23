package com.ch.cinephile.dao;

import java.util.List;

import com.ch.cinephile.model.Tag;

public interface TagDao {

	Tag getTag(int tag_num);

	List<Tag> selectAll(String con);

	List<String> getCons(String con);

	Tag selectCon(String con);

	void insert(String con);

	List<Tag> allTag();

	void delete(int tag_num);

}

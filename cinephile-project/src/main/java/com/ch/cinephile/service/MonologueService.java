package com.ch.cinephile.service;

import java.util.Collection;
import java.util.List;

import com.ch.cinephile.model.Mogoodck;
import com.ch.cinephile.model.Monologue;

public interface MonologueService {

	void write(String c_id, String contents);

	List<Monologue> getForCid(String c_id);

	List<Monologue> searchHot();

	void goodup(int mo_num);

	void gooddown(int mo_num);

	void delete(int mo_num);

	int recentMono(String c_id);
	
	// 통합검색
	List<Monologue> moList(Monologue monologue);

}

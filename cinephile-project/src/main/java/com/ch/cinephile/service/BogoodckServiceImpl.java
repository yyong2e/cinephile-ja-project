package com.ch.cinephile.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.cinephile.dao.BogoodckDao;
import com.ch.cinephile.model.Bogoodck;

@Service
public class BogoodckServiceImpl implements BogoodckService{
	@Autowired
	private BogoodckDao bd;

	public Bogoodck ckGood(Bogoodck bgood) {
		return bd.ckGood(bgood);
	}
	public void insert(Bogoodck bgood) {
		bd.insert(bgood);
	}
	public void delete(Bogoodck bgood) {
		bd.delete(bgood);
	}
}

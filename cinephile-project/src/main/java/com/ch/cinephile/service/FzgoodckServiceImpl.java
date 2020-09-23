package com.ch.cinephile.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.cinephile.dao.FzgoodckDao;
import com.ch.cinephile.model.Fzgoodck;

@Service
public class FzgoodckServiceImpl implements FzgoodckService{
	@Autowired
	private FzgoodckDao fd;
	public void delete(Fzgoodck fzgoodck) {
		fd.delete(fzgoodck);
	}

	@Override
	public void insert(Fzgoodck fzgoodck) {
		fd.insert(fzgoodck);
	}
	public Fzgoodck searchId(Fzgoodck fg) {
		return fd.searchId(fg);
	}
}

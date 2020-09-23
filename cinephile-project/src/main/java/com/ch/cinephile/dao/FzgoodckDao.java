package com.ch.cinephile.dao;

import com.ch.cinephile.model.Fzgoodck;

public interface FzgoodckDao {
	void delete(Fzgoodck fzgoodck);

	void insert(Fzgoodck fzgoodck);

	Fzgoodck searchId(Fzgoodck fg);

}

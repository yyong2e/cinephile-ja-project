package com.ch.cinephile.dao;

import java.util.Collection;
import java.util.List;

import com.ch.cinephile.model.Cfavorite;
import com.ch.cinephile.model.Genre;
import com.ch.cinephile.model.Movie;

public interface MovieDao {

	List<Movie> searchMovie(int mv_num);

	int insert(Movie movie);

	Movie searchMoviee(int mv_num);
	Movie getMovie(Integer mv_num);

	List<Movie> getImgurl(List<Integer> cfList);
	
	String getOneImgurl(int mv_num);

	List<Movie> getAllMovie(List<Integer> mvnumList);

	
	// 통합검색
	List<Movie> mvList(Movie movie);

	
	// 모든 영화 보기
	Collection<Movie> mvAll();
	List<Movie> mvAllB();
	List<Movie> mvAllR();

	// 영화 수정
	int updateMovie(Movie movie);
	// 영화 장르 리스트 
	List<Genre> gnlist();


}

package com.ch.cinephile.service;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.cinephile.dao.MovieDao;
import com.ch.cinephile.model.Cfavorite;
import com.ch.cinephile.model.Genre;
import com.ch.cinephile.model.Movie;

@Service
public class MovieServiceImpl implements MovieService{
	@Autowired
	private MovieDao md;
	public List<Movie> searchMovie(int mv_num) {
		return md.searchMovie(mv_num);
	}
	public int insert(Movie movie) {
		return md.insert(movie);
	}
	public Movie searchMoviee(int mv_num) {
		return md.searchMoviee(mv_num);
	}
	@Override
	public Movie getMovie(Integer mv_num) {
		return md.getMovie(mv_num);
	}
	public List<Movie> getImgurl(List<Integer> cfList) {
		return md.getImgurl(cfList);
	}
	public String getOneImgurl(int mv_num) {
		return md.getOneImgurl(mv_num);
	}
	public List<Movie> getAllMovie(List<Integer> mvnumList) {
		return md.getAllMovie(mvnumList);
	}
	
	
	// 통합검색
	public List<Movie> mvList(Movie movie) {
		return md.mvList(movie);
	}
	
	
	// 모든 영화 보기
	public Collection<Movie> mvAll() {
		return md.mvAll();
	}
	public List<Movie> mvAllB() {
		return md.mvAllB();
	}
	public List<Movie> mvAllR() {
		return md.mvAllR();
	}
	
	//영화 수정
	public int updateMovie(Movie movie) {
		return md.updateMovie(movie);
	}
	//영화 장르
	public List<Genre> gnlist() {
		return md.gnlist();
	}
	@Override
	public List<Movie> searchMovie(String mv_name) {
		// TODO Auto-generated method stub
		return null;
	}
}

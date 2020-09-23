package com.ch.cinephile.dao;

import java.util.Collection;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.cinephile.model.Cfavorite;
import com.ch.cinephile.model.Genre;
import com.ch.cinephile.model.Movie;

@Repository
public class MovieDaoImpl implements MovieDao{
	@Autowired
	private SqlSessionTemplate sst;
	public List<Movie> searchMovie(int mv_num) {
		return sst.selectList("moviens.searchMovie",mv_num);
	}
	public int insert(Movie movie) {
		return sst.insert("moviens.insertMovie",movie);
	}
	public Movie searchMoviee(int mv_num) {
		return sst.selectOne("moviens.searchMoviee", mv_num);
	}
	@Override
	public Movie getMovie(Integer mv_num) {
		return sst.selectOne("moviens.getMovie", mv_num);
	}
	@Override
	public List<Movie> getImgurl(List<Integer> cfList) {
		
		return sst.selectList("moviens.getImgurl", cfList);
	}
	public String getOneImgurl(int mv_num) {
		return sst.selectOne("moviens.getOneImgurl", mv_num);
	}
	public List<Movie> getAllMovie(List<Integer> mvnumList) {
		return sst.selectList("moviens.getAllMovie", mvnumList);
	}
	
	
	// 통합검색
	public List<Movie> mvList(Movie movie) {
		return sst.selectList("moviens.mvList", movie);
	}
	
	
	// 모든 영화 보기
	public Collection<Movie> mvAll() {
		return sst.selectList("moviens.mvAll");
	}
	public List<Movie> mvAllB() {
		return sst.selectList("moviens.mvAllB");
	}
	public List<Movie> mvAllR() {
		return sst.selectList("moviens.mvAllR");
	}
	//영화 수정
	public int updateMovie(Movie movie) {
		return sst.update("moviens.updatemv",movie);
	}
	//영화 장르 리스트
	public List<Genre> gnlist() {
		return sst.selectList("moviens.gnlist");
	}

}

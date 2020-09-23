package com.ch.cinephile.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ch.cinephile.model.Cfavorite;
import com.ch.cinephile.model.Fzgoodck;
import com.ch.cinephile.model.Movie;
import com.ch.cinephile.service.CfavoriteService;
import com.ch.cinephile.service.FavoritezipService;
import com.ch.cinephile.service.FzgoodckService;
import com.ch.cinephile.service.MovieService;

@Controller
public class FavoritezipController {
	@Autowired
	private FavoritezipService fs;
	@Autowired
	private CfavoriteService cs;
	@Autowired
	private MovieService ms;
	@Autowired
	private FzgoodckService fgs;
	@RequestMapping("favoritechoice")
	public ModelAndView favoritechoice(int mv_num,int page,Model model,HttpSession session) throws UnsupportedEncodingException {
		Movie movie=ms.searchMoviee(mv_num);
		String c_id=(String)session.getAttribute("c_id");
		int zipnum=fs.selectZipnum(c_id);
		Cfavorite cfavorite=cs.ckChoice(mv_num,zipnum);
		String encodedParam = URLEncoder.encode(movie.getMv_name(), "UTF-8");
		String url = "redirect:/main";
		if(page == 0) {
			url = "redirect:/movieInfo?mv_num="+mv_num+"&mv_name="+encodedParam;
		}else url = "redirect:/movieList";
		//ModelAndView mav= new ModelAndView();
		//mav.setView(new RedirectView("movieInfo?mv_num="+mv_num+"&mv_name="+movie.getMv_name()));
		if(cfavorite!=null) {
			cs.delete(mv_num,zipnum);
			return new ModelAndView(url);
			//return  mav;
		}
		else{
			cs.insert(mv_num,zipnum);
		}
		//ModelAndView mav new ModelAndView();
		//mav.setView(new RedirectView("/movieInfo?movie=movie"));
		return new ModelAndView(url);
		//return mav;
	}
	@RequestMapping("favoritemovie")
	public String favoritemovie(String c_id,Model model) {
		int zipnum=fs.selectZipnum(c_id);
		List<Integer> mvnumList=cs.selectZipnum(zipnum);
		List<Movie> mList=ms.getAllMovie(mvnumList);
		model.addAttribute("mList", mList);
		return "profile/favoritemovie";
	}
	@RequestMapping("favoritegood")
	public String favoritegood(Fzgoodck fzgoodck,String ck) {
		if(ck.equals("y")) {
			fgs.delete(fzgoodck);
			fs.gooddown(fzgoodck.getZip_num());
		}
		else {
			fgs.insert(fzgoodck);
			fs.goodup(fzgoodck.getZip_num());
		}
		
		return "redirect:/main";
	}
	@RequestMapping(value="f",produces="text/html;charset=utf-8")
	@ResponseBody public String f(String zip_num,String c_id,Fzgoodck fzgoodck,String ck) {
		String msg = "";
		if(ck.equals("y")) {
			fgs.delete(fzgoodck);
			fs.gooddown(fzgoodck.getZip_num());
			msg="heartoff.png";
		}
		else {
			fgs.insert(fzgoodck);
			fs.goodup(fzgoodck.getZip_num());
			msg="hearton.png";
		}
		return msg; 
	}
}

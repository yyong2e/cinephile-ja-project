package com.ch.cinephile.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.cinephile.model.Cfavorite;
import com.ch.cinephile.model.Cgvcode;
import com.ch.cinephile.model.Movie;
import com.ch.cinephile.model.Mvtaglink;
import com.ch.cinephile.model.Tag;
import com.ch.cinephile.service.CfavoriteService;
import com.ch.cinephile.service.CgvcodeService;
import com.ch.cinephile.service.FavoritezipService;
import com.ch.cinephile.service.MovieService;
import com.ch.cinephile.service.MvtaglinkService;
import com.ch.cinephile.service.TagService;

@Controller
public class MovieinfoController {
	@Autowired
	private MovieService ms;
	@Autowired
	private CgvcodeService cs;
	@Autowired
	private FavoritezipService fs;
	@Autowired
	private CfavoriteService cfs;
	@Autowired
	private MvtaglinkService mvs;
	@Autowired
	private TagService ts;

	@RequestMapping("/movieInfo")
	public String movieInfo(Movie movie, Model model, HttpSession session) throws IOException {
		// 영화 좋아요 눌렀는지 안눌렀는지 체크
		String c_id = (String) session.getAttribute("c_id");
		if (c_id != null) {
			int zip_num = fs.selectZipnum(c_id);
			Cfavorite cfa = cfs.ckChoice(movie.getMv_num(), zip_num);
			if (cfa != null) {
				model.addAttribute("cfaon", "1");
			}
		}

		Movie nmovie = ms.searchMoviee(movie.getMv_num());
		String URL = "https://movie.naver.com/movie/bi/mi/basic.nhn?code=" + movie.getMv_num();
		Document doc = Jsoup.connect(URL).get();
		Elements reserve = doc.select("#reserveBasic");
		String streserve = reserve.attr("href");
		if (streserve != null && !streserve.equals("")) {
			model.addAttribute("streserve", streserve);
		}
		// if(movielist.size()==0) {
		if (nmovie == null) {
			nmovie = new Movie();
			String MURL = "https://movie.naver.com/movie/bi/mi/detail.nhn?code=" + movie.getMv_num();
			Document mdoc = Jsoup.connect(MURL).get();
			Elements title = doc
					.select("#content > div.article > div.mv_info_area > div.mv_info > h3 > a:nth-child(1)");
			Elements mv_direct = doc
					.select("#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(4) > p > a");
			Elements mv_genre = doc.select(
					"#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(2) > p > span:nth-child(1) > a:nth-child(1)");
			Elements mv_content = doc.select(
					"#content > div.article > div.section_group.section_group_frst > div:nth-child(1) > div > div.story_area > p");
			Elements mv_mjactor = doc
					.select("#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(6) > p");
			Elements mv_minactor = mdoc.select(
					"#content > div.article > div.section_group.section_group_frst > div.obj_section.noline > div > div.lst_people_area.height100 > ul >li");
			Elements mv_grade = doc
					.select("#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(8) > p > a");
			String min = "";
			if(mv_minactor.size()>10) {
				for (int i = 3; i < 10; i++) {
					Elements mv_min = mv_minactor.get(i).select("a");
					mv_min = mv_min.get(1).select("a");
					min += mv_min.text() + " ";
				}
			}
			else {
				for (int i = 3; i < mv_minactor.size(); i++) {
					Elements mv_min = mv_minactor.get(i).select("a");
					mv_min = mv_min.get(1).select("a");
					min += mv_min.text() + " ";
				}
			}
			Elements mv_reldate = doc.select(
					"#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(2) > p > span:nth-child(4)");
			Elements mv_rate = doc.select("#pointNetizenPersentBasic > span > span");
			Elements mv_runtime = doc.select(
					"#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(2) > p > span:nth-child(3)");
			Elements mv_imageurl = doc.select("#content > div.article > div.mv_info_area > div.poster > a > img");
			nmovie.setMv_num(movie.getMv_num());
			nmovie.setMv_name(title.text());
			nmovie.setMv_direct(mv_direct.text());
			nmovie.setMv_genre(mv_genre.text());
			nmovie.setMv_content(mv_content.text());
			nmovie.setMv_mjactor(mv_mjactor.text());
			nmovie.setMv_minactor(min);
			nmovie.setMv_reldate(mv_reldate.text());
			nmovie.setMv_grade(mv_grade.text());
			// 평점
			String rate = mv_rate.attr("style");
			int rateidx = rate.indexOf(':');
			String rate1 = rate.substring(rateidx + 1, rateidx + 2);
			String rate2 = rate.substring(rateidx + 2, rateidx + 3);
			int r1 = Integer.parseInt(rate1);
			int r2;
			if (rate2.equals("."))
				r2 = 0;
			else
				r2 = Integer.parseInt(rate2);
			float rateresult = (float) (r1 + (r2 * 0.1));
			nmovie.setMv_rate(rateresult);
			// 상영시간
			int minuteidx = mv_runtime.text().indexOf('분');
			String runtime = mv_runtime.text().substring(0, minuteidx);
			nmovie.setMv_runtime(Integer.parseInt(runtime));
			String image = mv_imageurl.attr("src");
			nmovie.setMv_imageurl(image);
			model.addAttribute("nmovie", nmovie);
			ms.insert(nmovie);
		} else {
			model.addAttribute("nmovie", nmovie);
		}
		List<Mvtaglink> mtagList = mvs.selectAllTag(nmovie.getMv_num());
		List<Tag> tagList = new ArrayList<>();
		for (int i = 0; i < mtagList.size(); i++) {
			Tag t = ts.getTag(mtagList.get(i).getTag_num());
			tagList.add(t);
		}
		model.addAttribute("tagList", tagList);
		return "movie/movieInfo";
	}

	@RequestMapping("reserve")
	public String reserve(String mv_name,int mv_num, Cgvcode cgv, String date, Model model) throws IOException {
		boolean datachk = true;
		// cgc코드
		if (cgv.getAreacode() == null || cgv.getAreacode().equals("")) {
			datachk = false;
			cgv.setAreacode("01");
			cgv.setTheatercode("0056");
			cgv.setLocal("강남");
		}
		// 극장 위치들 가져오기
		List<Cgvcode> cgvList = new ArrayList<Cgvcode>();
		cgvList = cs.searchThe();
		// 날짜 설정
		if (date == null || date.equals("")) {
			datachk = false;
			SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
			Calendar time = Calendar.getInstance();
			date = format1.format(time.getTime());
		} else {
			SimpleDateFormat format1 = new SimpleDateFormat("yyyy");
			Calendar time = Calendar.getInstance();
			String date2 = format1.format(time.getTime());
			date = date.substring(0, 2) + date.substring(3, date.length() - 1);
			date = date2 + date;
		}
		String URL = "http://www.cgv.co.kr/common/showtimes/iframeTheater.aspx?areacode=" + cgv.getAreacode()
				+ "&theatercode=" + cgv.getTheatercode() + "&date=" + date
				+ "&screencodes=&screenratingcode=&regioncode=";

		Document doc = Jsoup.connect(URL).get();
		// 영화 날짜 가져오기
		Elements moviedates = doc.select("#slider > div > ul > li > div > a");
		List<String> dateList = new ArrayList<String>();
		for (Element moviedate : moviedates) {
			String da = moviedate.text();
			String rda = da.substring(0, 3) + da.substring(6, 8) + "일";
			dateList.add(rda);
		}
		// 영화 제목
		Elements names = doc.select("body > div > div.sect-showtimes > ul > li > div > div.info-movie > a > strong");
		List<String> movieList = new ArrayList<String>();
		int movienum = 0;
		int size = names.size();
		// :가 있다면 -로 바꾸기 네이버cgv이름 다름
		for (int i = 0; i < size; i++) {
			String ma = names.get(i).text();
			movieList.add(ma);
			if (ma.equals(mv_name)) {
				movienum = i + 1;
			}
		}
		// 영화별 시간표
		List<String[]> timeList = new ArrayList<String[]>();
		if (datachk == true) {
			Elements t = doc.select("body > div > div.sect-showtimes > ul > li:nth-child(" + movienum
					+ ") > div >div > div.info-timetable");
			size = t.size();
			for (int i = 2; i <= size + 1; i++) {
				Elements ti = doc.select("li:nth-child(" + movienum + ") > div > div:nth-child(" + i
						+ ") > div.info-timetable > ul > li > a");
				String[] strarr = new String[ti.size()];
				boolean ck = false;
				for (int j = 0; j < ti.size(); j++) {
					String time = ti.get(j).attr("data-playstarttime");
					if (!time.equals("") && time != null) {
						ck = true;
						time = time.substring(0, 2) + ":" + time.substring(2, time.length());
						strarr[j] = time;
					}
				}
				if (ck)
					timeList.add(strarr);
			}
		}
		Movie movie = ms.searchMoviee(mv_num);
		model.addAttribute("movie", movie);
		// model.addAttribute("mv_name", mv_name);
		model.addAttribute("cgv", cgv);
		model.addAttribute("cgvList", cgvList);
		model.addAttribute("dateList", dateList);
		model.addAttribute("movieList", movieList);
		model.addAttribute("timeList", timeList);
		model.addAttribute("date", date);
		return "movie/reserve";
	}

	@RequestMapping(value = "timeChk", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String timeChk() {
		String msg = "<div class='btn btn-info' align='center' value='좌석확인' onclick='location.href=reserveSeat'>";// ?mv_name=${mv_name}&theatercode=${cgv.theatercode}&areacode=${cgv.areacode}&local=${cgv.local}&date=${date}'>";
		return msg;
	}

	// 모든 영화 보기
	@RequestMapping("movieList")
	public String movieList(Model model, Movie movie, HttpSession session) throws IOException {
		// 전체 목록 가져오기
		List<Movie> mvAll = (List<Movie>) ms.mvAll();

		// 개봉일 편집
		String rd = null;
		List reldate = new ArrayList();
		for (int i = 0; i < mvAll.size(); i++) {
			rd = mvAll.get(i).getMv_reldate();
			int size = rd.length();
			if (size > 14) {
				int idx = rd.indexOf(",");
				rd = rd.substring(idx + 1);
			}
			rd = rd.substring(0, rd.length() - 3);
			reldate.add(rd);
		}
		model.addAttribute("reldate", reldate);

		// 추천수 뽑아오기
		int mv_num = 0;
		Integer mvg = null;
		List mvgood = new ArrayList();
		for (int i = 0; i < mvAll.size(); i++) {
			mv_num = mvAll.get(i).getMv_num();
			mvg = cfs.mvgood(mv_num);
			if (mvg == null) {
				mvg = 0;
			}
			mvgood.add(mvg);
		}
		model.addAttribute("mvgood", mvgood);

		// 영화 좋아요 눌렀는지 안눌렀는지 체크
		String c_id = (String) session.getAttribute("c_id");
		if (c_id != null) {
			int zip_num = fs.selectZipnum(c_id);
			System.out.println(zip_num);
			List<Cfavorite> cfa = new ArrayList();
			
			cfa = cfs.ckChoiceAll(zip_num);
			for (int i = 0; i < mvAll.size(); i++) {
				mv_num = mvAll.get(i).getMv_num();
				boolean result = false;
				for (int j = 0; j < cfa.size(); j++) {
					int mv_num2 = cfa.get(j).getMv_num();
					if (mv_num == mv_num2) {
						result = true;
						break;
					}
				}
				if (result == true) {
					mvAll.get(i).setGdchk(1);
				} else {
					mvAll.get(i).setGdchk(0);
				}
			}
		}

		// 상영 여부확인
		// Movie nmovie = ms.searchMoviee(movie.getMv_name());
		for (int i = 0; i < mvAll.size(); i++) {
			boolean result = false;
			mv_num = mvAll.get(i).getMv_num();
			String URL = "https://movie.naver.com/movie/bi/mi/basic.nhn?code=" + mv_num;
			Document doc = Jsoup.connect(URL).get();
			Elements reserve = doc.select("#reserveBasic");
			String streserve = reserve.attr("href");
			if (streserve != null && !streserve.equals("")) {
				result = true;
			}
			if (result == true) {
				mvAll.get(i).setRechk(1);
			} else
				mvAll.get(i).setRechk(0);
		}

		model.addAttribute("mvAll", mvAll);
		return "movie/movieList";
	}

	@RequestMapping(value = "/mvall", method = RequestMethod.POST)
	@ResponseBody
	public List<Movie> mvall(HttpSession session) {
		List<Movie> mvAll = (List<Movie>) ms.mvAll();
		return mvAll;
	}
	// 모든 영화 보기(예매순)
	@RequestMapping("movieListBook")
	public String movieListBook(Model model, Movie movie, HttpSession session) throws IOException {
		// 전체 목록 가져오기
		List<Movie> mvAllB = (List<Movie>) ms.mvAllB();

		// 개봉일 편집
		String rd = null;
		List reldate = new ArrayList();
		for (int i = 0; i < mvAllB.size(); i++) {
			rd = mvAllB.get(i).getMv_reldate();
			int size = rd.length();
			if (size > 14) {
				int idx = rd.indexOf(",");
				rd = rd.substring(idx + 1);
			}
			rd = rd.substring(0, rd.length() - 3);
			reldate.add(rd);
		}
		model.addAttribute("reldate", reldate);

		// 추천수 뽑아오기
		int mv_num = 0;
		Integer mvg = null;
		List mvgood = new ArrayList();
		for (int i = 0; i < mvAllB.size(); i++) {
			mv_num = mvAllB.get(i).getMv_num();
			mvg = cfs.mvgood(mv_num);
			if (mvg == null) {
				mvg = 0;
			}
			mvgood.add(mvg);
		}
		model.addAttribute("mvgood", mvgood);

		// 영화 좋아요 눌렀는지 안눌렀는지 체크
		String c_id = (String) session.getAttribute("c_id");
		if (c_id != null) {
			int zip_num = fs.selectZipnum(c_id);
			List<Cfavorite> cfa = new ArrayList();
			cfa = cfs.ckChoiceAll(zip_num);
			for (int i = 0; i < mvAllB.size(); i++) {
				mv_num = mvAllB.get(i).getMv_num();
				boolean result = false;
				for (int j = 0; j < cfa.size(); j++) {
					int mv_num2 = cfa.get(j).getMv_num();
					if (mv_num == mv_num2) {
						result = true;
						break;
					}
				}
				if (result == true) {
					mvAllB.get(i).setGdchk(1);
				} else {
					mvAllB.get(i).setGdchk(0);
				}
			}
		}

		// 상영 여부확인
		// Movie nmovie = ms.searchMoviee(movie.getMv_name());
		for (int i = 0; i < mvAllB.size(); i++) {
			boolean result = false;
			mv_num = mvAllB.get(i).getMv_num();
			String URL = "https://movie.naver.com/movie/bi/mi/basic.nhn?code=" + mv_num;
			Document doc = Jsoup.connect(URL).get();
			Elements reserve = doc.select("#reserveBasic");
			String streserve = reserve.attr("href");
			if (streserve != null && !streserve.equals("")) {
				result = true;
			}
			if (result == true) {
				mvAllB.get(i).setRechk(1);
			} else
				mvAllB.get(i).setRechk(0);
		}

		model.addAttribute("mvAllB", mvAllB);
		return "movie/movieListBook";
	}
	// 모든 영화 보기(추천순)
	@RequestMapping("movieListRate")
	public String movieListRate(Model model, Movie movie, HttpSession session) throws IOException {
		// 전체 목록 가져오기
		List<Movie> mvAllR = (List<Movie>) ms.mvAllR();
		
		// 개봉일 편집
		String rd = null;
		List reldate = new ArrayList();
		for (int i = 0; i < mvAllR.size(); i++) {
			rd = mvAllR.get(i).getMv_reldate();
			int size = rd.length();
			if (size > 14) {
				int idx = rd.indexOf(",");
				rd = rd.substring(idx + 1);
			}
			rd = rd.substring(0, rd.length() - 3);
			reldate.add(rd);
		}
		model.addAttribute("reldate", reldate);
		
		// 추천수 뽑아오기
		int mv_num = 0;
		Integer mvg = null;
		List mvgood = new ArrayList();
		for (int i = 0; i < mvAllR.size(); i++) {
			mv_num = mvAllR.get(i).getMv_num();
			mvg = cfs.mvgood(mv_num);
			if (mvg == null) {
				mvg = 0;
			}
			mvgood.add(mvg);
		}
		model.addAttribute("mvgood", mvgood);
		
		// 영화 좋아요 눌렀는지 안눌렀는지 체크
		String c_id = (String) session.getAttribute("c_id");
		if (c_id != null) {
			int zip_num = fs.selectZipnum(c_id);
			List<Cfavorite> cfa = new ArrayList();
			cfa = cfs.ckChoiceAll(zip_num);
			for (int i = 0; i < mvAllR.size(); i++) {
				mv_num = mvAllR.get(i).getMv_num();
				boolean result = false;
				for (int j = 0; j < cfa.size(); j++) {
					int mv_num2 = cfa.get(j).getMv_num();
					if (mv_num == mv_num2) {
						result = true;
						break;
					}
				}
				if (result == true) {
					mvAllR.get(i).setGdchk(1);
				} else {
					mvAllR.get(i).setGdchk(0);
				}
			}
		}
		
		// 상영 여부확인
		// Movie nmovie = ms.searchMoviee(movie.getMv_name());
		for (int i = 0; i < mvAllR.size(); i++) {
			boolean result = false;
			mv_num = mvAllR.get(i).getMv_num();
			String URL = "https://movie.naver.com/movie/bi/mi/basic.nhn?code=" + mv_num;
			Document doc = Jsoup.connect(URL).get();
			Elements reserve = doc.select("#reserveBasic");
			String streserve = reserve.attr("href");
			if (streserve != null && !streserve.equals("")) {
				result = true;
			}
			if (result == true) {
				mvAllR.get(i).setRechk(1);
			} else
				mvAllR.get(i).setRechk(0);
		}
		
		model.addAttribute("mvAllR", mvAllR);
		return "movie/movieListRate";
	}
}

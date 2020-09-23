package com.ch.cinephile.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ch.cinephile.model.Board;
import com.ch.cinephile.model.Customer;
import com.ch.cinephile.model.Mogoodck;
import com.ch.cinephile.model.Monologue;
import com.ch.cinephile.model.Motaglink;
import com.ch.cinephile.model.Movie;
import com.ch.cinephile.model.Tag;
import com.ch.cinephile.service.BoardService;
import com.ch.cinephile.service.CustomerService;
import com.ch.cinephile.service.MogoodckService;
import com.ch.cinephile.service.MonologueService;
import com.ch.cinephile.service.MotaglinkService;
import com.ch.cinephile.service.MovieService;
import com.ch.cinephile.service.TagService;


@Controller
public class SearchController {
	@Autowired
	private MovieService ms;
	@Autowired
	private BoardService bs;
	@Autowired
	private MonologueService mos;
	@Autowired
	private CustomerService cus;
	@Autowired
	private MotaglinkService mts;
	@Autowired
	private TagService ts;
	@Autowired
	private MogoodckService mgs;
	
	@RequestMapping("t_search")
	public String search(String s_keyword, Model model, Board board, Movie movie, Monologue monologue, HttpServletRequest request, HttpSession session) throws IOException {
		String s = "#";
		String search = null;
		boolean a = s_keyword.contains(s); //s_keyword에 #이 포함되어있는가
		if(a == true ){ // 포함되어 있다면 
			search = "tag"; // search에 tag 입력
			movie.setSearch(search);
			monologue.setSearch(search);
			board.setSearch(search); // 각 모델의 search에 tag 삽입
			s_keyword = s_keyword.substring(1);
			
		}else { // 포함되어 있지 않으면
			movie.setSearch(search); 
			monologue.setSearch(search);
			board.setSearch(search); // 각 모델의 search에 tag 삽입
		}
		model.addAttribute("search", search); 
		//영화 검색
		movie.setKeyword(s_keyword);
		List<Movie> mvList = ms.mvList(movie);
		
		if (mvList.isEmpty()) {
			String clientId = "pXnmp0rJ4pERddYDEWUy"; //애플리케이션 클라이언트 아이디값"
		    String clientSecret = "cvVTDnIGEN"; //애플리케이션 클라이언트 시크릿값"
		    String text = s_keyword;
		    try {
		    	text = URLEncoder.encode(s_keyword, "UTF-8");
		        } catch (UnsupportedEncodingException e) {
		        	throw new RuntimeException("검색어 인코딩 실패",e);
		        }
		    System.out.println("a");
		    String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + text;    // json 결과
		    Map<String, String> requestHeaders = new HashMap<>();
		    requestHeaders.put("X-Naver-Client-Id", clientId);
		    requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		    String responseBody = get(apiURL,requestHeaders);
			while (responseBody.contains("https://movie.naver.com/movie/bi/mi/basic.nhn?code=")) {
				int idx = responseBody.indexOf("https://movie.naver.com/movie/bi/mi/basic.nhn?code=");
				idx += 51;
				responseBody = responseBody.substring(idx);
				idx = responseBody.indexOf("\"");
				String smv_num = responseBody.substring(0, idx);
				responseBody = responseBody.substring(1);
				int mv_num = Integer.parseInt(smv_num);
				System.out.println(mv_num);
				String URL = "https://movie.naver.com/movie/bi/mi/basic.nhn?code=" + mv_num;
				Document doc = Jsoup.connect(URL).get();
				Movie nmovie = new Movie();
				String MURL = "https://movie.naver.com/movie/bi/mi/detail.nhn?code=" + mv_num;
				Document mdoc = Jsoup.connect(MURL).get();
				// 평점 러닝타임 있는지 체크
				Elements mv_rate = doc.select("#pointNetizenPersentBasic > span > span");
				String rate = mv_rate.attr("style");
				Elements mv_runtime = doc.select(
						"#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(2) > p > span:nth-child(3)");
				int minuteidx = mv_runtime.text().indexOf('분');

				if (!rate.equals("") && minuteidx != -1) {

					Elements title = doc
							.select("#content > div.article > div.mv_info_area > div.mv_info > h3 > a:nth-child(1)");
					Elements mv_direct = doc.select(
							"#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(4) > p > a");
					Elements mv_genre = doc.select(
							"#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(2) > p > span:nth-child(1) > a:nth-child(1)");
					Elements mv_content = doc.select(
							"#content > div.article > div.section_group.section_group_frst > div:nth-child(1) > div > div.story_area > p");
					Elements mv_mjactor = doc.select(
							"#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(6) > p");
					Elements mv_minactor = mdoc.select(
							"#content > div.article > div.section_group.section_group_frst > div.obj_section.noline > div > div.lst_people_area.height100 > ul >li");
					Elements mv_grade = doc.select(
							"#content > div.article > div.mv_info_area > div.mv_info > dl > dd:nth-child(8) > p > a");
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
					Elements mv_imageurl = doc
							.select("#content > div.article > div.mv_info_area > div.poster > a > img");
					nmovie.setMv_num(mv_num);
					nmovie.setMv_name(title.text());
					nmovie.setMv_direct(mv_direct.text());
					nmovie.setMv_genre(mv_genre.text());
					String ncontent = mv_content.text();
					if (ncontent.length() > 1332) {
						ncontent = ncontent.substring(0, 1332);
					}
					nmovie.setMv_content(ncontent);
					nmovie.setMv_mjactor(mv_mjactor.text());
					nmovie.setMv_minactor(min);
					nmovie.setMv_reldate(mv_reldate.text());
					nmovie.setMv_grade(mv_grade.text());
					// 평점

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
					String runtime = mv_runtime.text().substring(0, minuteidx);
					nmovie.setMv_runtime(Integer.parseInt(runtime));
					String image = mv_imageurl.attr("src");
					nmovie.setMv_imageurl(image);
					System.out.println("q");
					ms.insert(nmovie);
					System.out.println("xx");
				}
			}
			mvList = (List<Movie>)ms.mvList(movie);
		}
		for(int i=0;i<mvList.size();i++) {
			if(mvList.get(i).getMv_content().length()>420) {
				mvList.get(i).setMv_content(mvList.get(i).getMv_content().substring(0,419)+"...");
			}
		}
		
		model.addAttribute("s_keyword", s_keyword);
		model.addAttribute("mvList", mvList);
		//모놀로그 검색
		monologue.setKeyword(s_keyword);
		List<Monologue> moList = mos.moList(monologue);
		//모놀로그 순서대로 회원정보 가져오기, 태그 가져오기
		List<Motaglink> mtagList=new ArrayList<>();
		List<Customer> moCusList=new ArrayList<>();
		//태그 이차배열
		List<String[]> mtagConList=new ArrayList<>();
		for(int i=0;i<moList.size();i++) {
			if(moList.get(i).getC_id()!=null)
				moCusList.add(cus.selectCid2(moList.get(i).getC_id()));
			mtagList=mts.selectTag(moList.get(i).getMo_num());
			String[] strarr=new String[mtagList.size()];
			for(int j=0;j<mtagList.size();j++) {
				Tag con=ts.getTag(mtagList.get(j).getTag_num());
				strarr[j]=con.getTag_con();
			}
			mtagConList.add(strarr);
		}
		model.addAttribute("mtagConList", mtagConList);
		model.addAttribute("moCusList", moCusList);
		model.addAttribute("moList", moList);
		model.addAttribute("tag", monologue.getKeyword());
		//로그인 했을시 모놀로그 좋아요 체크
				List<String> mogoodList =new ArrayList<String>();
				String c_id=(String) session.getAttribute("c_id");
				if(c_id!=null&&!c_id.equals("")) {
					Customer customer=cus.select(c_id);
					model.addAttribute("customer", customer);
				}
				if(c_id!=null&&!c_id.equals("")) {
					for(int i=0;i<moList.size();i++) {
						int monum=moList.get(i).getMo_num();
						Mogoodck mgc=new Mogoodck();
						mgc.setC_id(c_id);
						mgc.setMo_num(monum);
						Mogoodck mgc2=mgs.selectMonum(mgc);
						if(mgc2!=null) {
							mogoodList.add("y");
						}
						else
							mogoodList.add("n");
					}
					model.addAttribute("mogoodList", mogoodList);
				}
		//리뷰게시판 검색
		board.setKeyword(s_keyword);
		Collection<Board> rbList = bs.rbList(board);
		model.addAttribute("rbList", rbList);
		//영화정보 게시판 검색
		board.setKeyword(s_keyword);
		Collection<Board> ibList = bs.ibList(board);
		model.addAttribute("ibList", ibList);
		//자유게시판 검색
		board.setKeyword(s_keyword);
		Collection<Board> fbList = bs.fbList(board);
		model.addAttribute("fbList", fbList);
		//공지게시판 검색
		board.setKeyword(s_keyword);
		Collection<Board> nbList = bs.nbList(board);
		model.addAttribute("nbList", nbList);
		return "searchPage";
	}
	@RequestMapping("searchMovieList")
	public String searchMovieList(String s_keyword,Model model) {
		Movie movie=new Movie();
		movie.setKeyword(s_keyword);
		Collection<Movie> mvList = ms.mvList(movie);
		model.addAttribute("mvList", mvList);
		model.addAttribute("s_keyword", s_keyword);
		return "movie/searchMovieList";
	}
	private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 에러 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }

    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }
}
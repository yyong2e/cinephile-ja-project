package com.ch.cinephile.controller;

import java.io.Console;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ch.cinephile.model.Book;
import com.ch.cinephile.model.Customer;
import com.ch.cinephile.model.Genre;
import com.ch.cinephile.model.Motaglink;
import com.ch.cinephile.model.Movie;
import com.ch.cinephile.model.Mvtaglink;
import com.ch.cinephile.model.Tag;
import com.ch.cinephile.service.AdminService;
import com.ch.cinephile.service.BookService;
import com.ch.cinephile.service.CfavoriteService;
import com.ch.cinephile.service.CustomerService;
import com.ch.cinephile.service.MotaglinkService;
import com.ch.cinephile.service.MovieService;
import com.ch.cinephile.service.MvtaglinkService;
import com.ch.cinephile.service.PagingBean;
import com.ch.cinephile.service.TagService;

@Controller
public class AdminController {
	@Autowired
	private AdminService as;
	@Autowired
	private CustomerService cs;
	@Autowired
	private MovieService ms;
	@Autowired
	private CfavoriteService cfs;
	@Autowired
	private MvtaglinkService mvts;
	@Autowired
	private MotaglinkService mts;
	@Autowired
	private TagService ts;
	@Autowired
	private BookService bs;

	// 관리자 로그인 화면
	@RequestMapping("a_loginForm")
	public String a_loginForm() {
		return "admin/a_loginForm";
	}

	// 관리자
	@RequestMapping("a_login")
	public String a_login(String c_id, String c_password, Model model, HttpSession session) {
		int result = 0;
		// && c_password.equals("1234")
		if (c_id.equals("master") && c_password.equals("1234")) {
			session.setAttribute("c_id", c_id);
			result = 1;
		}
		model.addAttribute("result", result);

		return "admin/a_login";
	}

	@RequestMapping("adMain")
	public String adMain(String c_id, Model model, HttpSession session) {
		session.getAttribute("c_id");
		return "admin/adMain";
	}

	@RequestMapping("a_logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "admin/a_loginForm";
	}

	//
	@RequestMapping("cinfoList")
	public String cinfoList(Customer customer, String start, Model model, HttpServletRequest request,
			HttpSession session) {

		if (start == null || start.equals(""))
			start = "1";
		int currentPage = Integer.parseInt(start);
		int rowPerPage = 10;
		int total = cs.getTotalCustomer();
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int no = total - startRow + 1; // 페이지별 시작번호
		customer.setStartRow(startRow);
		customer.setEndRow(endRow);

		List<Customer> customerList = (List<Customer>) cs.getCustomerList(customer);
		PagingBean pb = new PagingBean(currentPage, rowPerPage, total);
		model.addAttribute("customerList", customerList);
		model.addAttribute("pb", pb);
		model.addAttribute("no",no);
		

		return "admin/cinfoList";

	}

	@RequestMapping("cinfoDetail")
	public String cinfoDetail(String c_id, Model model) {
		Customer customer = cs.select(c_id);
		model.addAttribute("customer", customer);
		return "admin/cinfoDetail";
	}

	@RequestMapping("editMember")
	public String editMember(String c_id, Model model) {
		Customer customer = cs.select(c_id);
		model.addAttribute("customer", customer);
		return "admin/editMember";
	}

	@RequestMapping(value = "editSuccess", method = RequestMethod.POST)
	public String editSuccess(Customer customer, Model model) {

		int result = cs.updateCustomer(customer);
		model.addAttribute("result", result);
		Customer customer2 = cs.select(customer.getC_id());
		model.addAttribute("customer", customer2);
		return "admin/editSuccess";
	}

	@RequestMapping("customerDelete")
	public String memberDelete(String c_id, Model model) {
		int result = cs.customerdelete(c_id);
		model.addAttribute("result", result);
		return "admin/customerDelete";
	}

	@RequestMapping("admovieList")
	public String admovieList(Model model, Movie movie) {
		List<Movie> mvAll = (List<Movie>) ms.mvAll();
		model.addAttribute("mvAll", mvAll);

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
			rd = rd.substring(0, rd.length());
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
		return "admin/admovieList";
	}

	// 영화 등록폼
	@RequestMapping("minsertForm")
	public String minsertForm(Model model, Movie movie) {
		return "admin/minsertForm";
	}

	// 영화 등록
	@RequestMapping(value = "minsert", method = RequestMethod.POST)
	public String minsert(Movie movie, Model model) {
		movie.setMv_rate(Float.parseFloat(movie.getMv_rate1()));
		int result = ms.insert(movie);
		model.addAttribute("result", result);
		return "admin/minsertResult";
	}

	// 영화 수정폼
	@RequestMapping("mupdateForm")
	public String mupdateForm(Movie movie1, Mvtaglink mvtaglink, Model model, String tags) {
		Movie movie = ms.getMovie(movie1.getMv_num());
		List<Genre> gn_list = ms.gnlist();
		model.addAttribute("gn_list", gn_list);
		model.addAttribute("movie", movie);
		System.out.println(movie.getMv_reldate());
		List<Mvtaglink> mtaglinkList = mvts.selectAllTag(movie.getMv_num());
		List<Tag> tagList = new ArrayList<>();
		for (int i = 0; i < mtaglinkList.size(); i++) {
			Tag tag = ts.getTag(mtaglinkList.get(i).getTag_num());
			tagList.add(tag);
		}
		model.addAttribute("tagList", tagList);

		return "admin/mupdateForm";
	}

	// 영화 수정
	@RequestMapping(value = "mupdate", method = RequestMethod.POST)
	public String mupdate(Movie movie, Model model, String tags, String c_id) {
		movie.setMv_rate(Float.parseFloat(movie.getMv_rate1()));
		int result = ms.updateMovie(movie);
		model.addAttribute("result", result);

		// 태그 추가
		Tag tag = new Tag();
		while (true) {
			int idx = tags.indexOf("#");
			if (idx == -1)
				break;
			else {
				tags = tags.substring(1, tags.length());
				int idx2 = tags.indexOf("#");
				String str = "";
				if (idx2 == -1) {
					str = tags;
					tag = ts.selectCon(str);
					if (tag == null) {
						ts.insert(str);
					}
					tag = ts.selectCon(str);
				} else {
					str = tags.substring(0, idx2);
					tags.substring(0, idx2);
					tag = ts.selectCon(str);
					if (tag == null) {
						ts.insert(str);
					}
					tag = ts.selectCon(str);

					tags = tags.substring(idx2, tags.length());
				}
				int tag_num = tag.getTag_num();
				Mvtaglink mvtag = new Mvtaglink();
				mvtag.setTag_num(tag_num);
				mvtag.setMv_num(movie.getMv_num());
				mvts.insert(mvtag);
			}

		}

		return "admin/mupdateResult";
	}

	// 태그 조회 태그 검색
	@RequestMapping("tag_search")
	public String ntagList(Tag tag, Model model) {

		return "admin/tagResult";
	}

	@RequestMapping("tagList")
	public String tagList(Model model) {
		List<Tag> tList = ts.allTag();
		model.addAttribute("tList", tList);
		return "admin/tagList";
	}

	@RequestMapping("tagDel")
	public String tagDel(int tag_num, Model model) {
		mvts.deleteTagnum(tag_num);
		mts.deleteTagnum(tag_num);
		ts.delete(tag_num);
		List<Tag> tList = ts.allTag();
		model.addAttribute("tList", tList);
		return "admin/tagList";
	}

	// 예매 조회
	@RequestMapping("customerBook")
	public String customerBook(Model model) {
		List<Book> bList = bs.selectAll();
		for (int i = 0; i < bList.size(); i++) {
			int mv_num = bList.get(i).getMv_num();
			String url = ms.getOneImgurl(mv_num);
			bList.get(i).setImg(url);
		}
		model.addAttribute("bList", bList);
		return "admin/customerBook";
	}

}

package com.ch.cinephile.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ch.cinephile.model.Book;
import com.ch.cinephile.model.Customer;
import com.ch.cinephile.model.Following;
import com.ch.cinephile.model.Monologue;
import com.ch.cinephile.model.Movie;
import com.ch.cinephile.service.BookService;
import com.ch.cinephile.service.CfavoriteService;
import com.ch.cinephile.service.CustomerService;
import com.ch.cinephile.service.FavoritezipService;
import com.ch.cinephile.service.FollowingService;
import com.ch.cinephile.service.MonologueService;
import com.ch.cinephile.service.MovieService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ProfileController {
	@Autowired
	private FavoritezipService fs;
	@Autowired
	private CfavoriteService cs;
	@Autowired
	private MovieService ms;
	@Autowired
	private MonologueService mls;
	@Autowired
	private CustomerService cts;
	@Autowired
	private BookService bs;
	@Autowired
	private FollowingService fws;
	@RequestMapping("profileMain")
	public String profileMain(Model model,HttpSession session) {
		String c_id=(String) session.getAttribute("c_id");
		Customer customer=cts.select(c_id);
		//취향집 찾기
		int zipnum=fs.selectZipnum(c_id);
		List<Integer> fList=cs.getCustomer(zipnum);
		List<Movie> mList= new ArrayList<Movie>();
		for(int i=0;i<fList.size();i++) {
			mList.add(ms.getMovie(fList.get(i)));
			
		}
		model.addAttribute("mList", mList);
		//팔로우 팔로잉
		int followcnt=fws.followCnt(c_id);
		int followingcnt=fws.followingCnt(c_id);
		
		//모놀로그 찾기
		List<Monologue> mlList=mls.getForCid(c_id);
		model.addAttribute("followcnt", followcnt);
		model.addAttribute("followingcnt", followingcnt);
		model.addAttribute("mlList", mlList);
		model.addAttribute("customer", customer);
		//무한스크롤 하기위한 코드
		ObjectMapper mapper = new ObjectMapper();
		String jsonText="";;
		try {
			jsonText = mapper.writeValueAsString( mlList );
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		model.addAttribute( "json", jsonText );
		return "profile/profileMain";
	}
	@RequestMapping("profileOther")
	public String profileOther(String c_id,Model model,HttpSession session) {
		String userid=(String) session.getAttribute("c_id");
		if(userid!=null&&userid.equals(c_id)) {
			return "redirect:/profileMain";
		}
		//팔로우 체크
		if(userid!=null) {
			Following following=new Following();
			following.setC_id(userid);
			following.setF_id(c_id);
			Following foll=fws.followCk(following);
			String followCk="";
			if(foll!=null) {
				followCk="y";
			}
			else {
				followCk="n";
			}
			model.addAttribute("followCk", followCk);
		}
		Customer customer=cts.select(c_id);
		customer.setC_password("");
		int zipnum=fs.selectZipnum(c_id);
		List<Integer> fList=cs.getCustomer(zipnum);
		List<Movie> mList= new ArrayList<Movie>();
		for(int i=0;i<fList.size();i++) {
			mList.add(ms.getMovie(fList.get(i)));
			
		}
		model.addAttribute("mList", mList);
		//팔로우 수
		int followcnt=fws.followCnt(c_id);
		int followingcnt=fws.followingCnt(c_id);
		//모놀로그 찾기
		List<Monologue> mlList=mls.getForCid(c_id);
		model.addAttribute("mlList", mlList);
		
		model.addAttribute("followingcnt", followingcnt);
		model.addAttribute("followcnt", followcnt);
		model.addAttribute("customer", customer);
		return "profile/profileOther";
	}
	@RequestMapping("bookChk")
	public String bookChk(HttpSession session, Model model) {
		String c_id=(String) session.getAttribute("c_id");
		List<Book> bList= bs.searchall(c_id);
		for(int i=0;i<bList.size();i++) {
			int mv_num=bList.get(i).getMv_num();
			String url=ms.getOneImgurl(mv_num);
			bList.get(i).setImg(url);
		}
		model.addAttribute("bList", bList);
		return "profile/bookChk";
	}
	@RequestMapping("cusUpdateForm")
	public String cusUpdateForm(String c_id,Model model) {
		Customer customer=cts.select(c_id);
		model.addAttribute("customer", customer);
		return "profile/updateForm";
	}
	@RequestMapping(value="passChk",produces="text/html;charset=utf-8")
	@ResponseBody public String passChk(String c_password,String c_id) {
		String msg = ""; 
		String nowpass = cts.passwordChk(c_id);
		if (nowpass.equals(c_password))
			msg="비밀번호가 맞습니다."; 
		else
			msg="비밀번호가 틀립니다."; 
		return msg; 
	}
	@RequestMapping(value="cusUpdate",method=RequestMethod.POST)
	public String update(Customer customer,String c_password2,MultipartFile proimg, Model model,HttpSession session) throws IOException {
		int result=0;
		Customer cus=cts.select(customer.getC_nickname());
		if(cus!=null&&!cus.getC_id().equals(customer.getC_id())) {
			result=-1;
			model.addAttribute("result", result);
			return "profile/update";
		}
		String nowpass = cts.passwordChk(customer.getC_id());
		if (!nowpass.equals(c_password2)) {
			result=-1;
			model.addAttribute("result", result);
			return "profile/update";
		}
		String img="";
		if(proimg.isEmpty()) {
			img=cts.searchProimg(customer.getC_id());
		}
		else {
			img="아이디"+customer.getC_id()+proimg.getOriginalFilename();
			//int fileSize = (int)proimg.getSize();
			// mf.transferTo(new File("/gov/"+fileName));
			String path = session.getServletContext().getRealPath("/img/proimg");
			String path2 = session.getServletContext().getRealPath("/WEB-INF/bootstrap/img/proimg");
			String fpath = path + "/" + img;
			String fpath2 = path2 + "/" + img;
			FileOutputStream fs = new FileOutputStream(fpath);
			FileOutputStream fs2 = new FileOutputStream(fpath2);
			fs.write(proimg.getBytes());
			fs2.write(proimg.getBytes());
			fs.close();
			fs2.close();
		}
		customer.setC_proimg(img);
		result=cts.update(customer);
		model.addAttribute("result", result);
		return "profile/update";
	}
	@RequestMapping(value="follow",produces="text/html;charset=utf-8")
	@ResponseBody public String follow(String f_id,HttpSession session) {
		String msg = "";
		String c_id=(String)session.getAttribute("c_id");
		if(c_id!=null) {
			Following following=new Following();
			following.setC_id(c_id);
			following.setF_id(f_id);
			Following foll=fws.followCk(following);
			if(foll!=null) {
				msg="followadd.png";
				fws.delete(following);
			}
			else {
				msg="followmi.png";
				fws.insert(following);
			}
		}
		return msg; 
	}
	@RequestMapping("followCk")
	public String followCk(Model model,HttpSession session) {
		String c_id=(String)session.getAttribute("c_id");
		List<Following> fList=fws.selectAll(c_id);
		List<Customer> cusList=new ArrayList<>();
		for(int i=0;i<fList.size();i++) {
			Customer cus=cts.selectCid2(fList.get(i).getF_id());
			cusList.add(cus);
		}
		model.addAttribute("cusList", cusList);
		return  "profile/followCk";
	}
	@RequestMapping("followingCk")
	public String followingCk(Model model,HttpSession session) {
		String c_id=(String)session.getAttribute("c_id");
		List<Following> fList=fws.selectAll2(c_id);
		List<Customer> cusList=new ArrayList<>();
		for(int i=0;i<fList.size();i++) {
			Customer cus=cts.selectCid2(fList.get(i).getC_id());
			cusList.add(cus);
		}
		model.addAttribute("cusList", cusList);
		return  "profile/followingCk";
	}
	@RequestMapping(value="/mono",method=RequestMethod.POST)
	@ResponseBody public List<Monologue> mono(HttpSession session) {
		String c_id=(String) session.getAttribute("c_id");
		List<Monologue> mlList=mls.getForCid(c_id);
		return mlList; 
	}
	@RequestMapping(value="/monoOther",method=RequestMethod.POST)
	@ResponseBody public List<Monologue> monoOther(@RequestParam String id,HttpSession session) {
		List<Monologue> mlList=mls.getForCid(id);
		return mlList; 
	}
}

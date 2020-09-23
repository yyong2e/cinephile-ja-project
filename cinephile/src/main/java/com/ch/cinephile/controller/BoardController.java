package com.ch.cinephile.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import com.ch.cinephile.model.Board;
import com.ch.cinephile.model.Bogoodck;
import com.ch.cinephile.model.Cfavorite;
import com.ch.cinephile.model.Customer;
import com.ch.cinephile.model.Mogoodck;
import com.ch.cinephile.model.Movie;
import com.ch.cinephile.service.BoardService;
import com.ch.cinephile.service.BogoodckService;
import com.ch.cinephile.service.PagingBean;
import com.ch.cinephile.service.ReplyBoardService;

@Controller
public class BoardController {
	@Autowired
	private ReplyBoardService rbs;
	@Autowired
	private BoardService bs;
	@Autowired
	private BogoodckService bgs;
	@RequestMapping("/list")
	public String initList() {
		return "redirect:/list/b_type/{b_type}/pageNum/1";
	}
	@RequestMapping("/list/b_type/{b_type}/pageNum/{pageNum}")
	public String list(@PathVariable String b_type,@PathVariable String pageNum, Board board, Model model,HttpSession session) {
		if (pageNum == null || pageNum.equals(""))
			pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage  = 10;
		int total = bs.getTotal(board);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int no = total - startRow + 1; // 페이지별 시작번호
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		 List<Board> list = (List<Board>)bs.list(board);
		PagingBean pb=new PagingBean(currentPage,rowPerPage,total);
		String tit[] = {"작성자","제목","내용","제목+내용"};
		String c_id=(String) session.getAttribute("c_id");
		board.setC_id(c_id);
		board.setB_type(b_type);
		model.addAttribute("c_id",c_id);
		model.addAttribute("b_type",b_type);
		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pb", pb);
		model.addAttribute("board", board);
		model.addAttribute("tit", tit);
		return "board/list";
	}
	
	@RequestMapping("/insertForm/nm/{nm}/pageNum/{pageNum}/b_type/{b_type}")
	public String insertForm(Board board,@PathVariable String b_type,@PathVariable String pageNum, Model model,HttpSession session) {
		int b_num = 0;
		String c_id=(String) session.getAttribute("c_id");
		board.setC_id(c_id);
		model.addAttribute("c_id",c_id);
		model.addAttribute("b_type",b_type);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("b_num", b_num);
		
		return "board/insertForm";
	}
	@RequestMapping("/insert")
	public String insert(Board board, String pageNum, Model model, HttpServletRequest request, HttpSession session) {
		String c_id=(String) session.getAttribute("c_id");
		board.setC_id(c_id);
		int number = bs.maxNum();
		board.setB_num(number);
		board.setB_del("n");
		int result = bs.insert(board);
		
		model.addAttribute("c_id",board.getC_id());
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("b_type",board.getB_type());
		return "board/insert";
	}
	@RequestMapping("/view/b_num/{b_num}/pageNum/{pageNum}")
	public String view(@PathVariable int b_num, @PathVariable String pageNum, Model model,HttpSession session,Board board){
		String c_id=(String) session.getAttribute("c_id");
		board.setC_id(c_id);
		bs.updateReadCount(b_num);
		board = bs.select(b_num);
		if(c_id==null) {
			c_id="";
		}
		Bogoodck bgood=new Bogoodck();
		bgood.setB_num(b_num);
		bgood.setC_id(c_id);
		bgood=bgs.ckGood(bgood);
		if(bgood==null) {
			model.addAttribute("ck", "n");
		}
		else
			model.addAttribute("ck", "y");
		model.addAttribute("c_id",c_id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		
		return "board/view";
	}
	@RequestMapping("/updateForm/b_num/{b_num}/pageNum/{pageNum}")
	public String updateForm(@PathVariable int b_num,@PathVariable String pageNum, Model model) {
		Board board = bs.select(b_num);
		String content = board.getB_content();
		String st =content.replace("<br>", "\r\n");
		board.setB_content(st);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/updateForm";
	}
	@RequestMapping("/update")
	public String update(Board board, String pageNum, Model model) {
		String st = board.getB_content().replace("\r\n", "<br>");
		board.setB_content(st);
		int result = bs.update(board);
		model.addAttribute("result", result);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/update";
	}
	@RequestMapping("/deleteForm/b_num/{b_num}/pageNum/{pageNum}")
	public String deleteForm(@PathVariable int b_num, @PathVariable String pageNum, Model model) {
		Board board = bs.select(b_num);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/deleteForm";
	}
	@RequestMapping("/delete")
	public String delete(String b_type,int b_num, String pageNum, Model model) {
		int result = bs.delete(b_num);
		rbs.deleteA(b_num);
		model.addAttribute("b_type",b_type);
		model.addAttribute("result", result);
		model.addAttribute("pageNum",pageNum);
		return "board/delete";
	}
	@RequestMapping("boardGood")
	public ModelAndView boardGood(int b_num,int pageNum,String ck,Model model,HttpSession session) throws UnsupportedEncodingException {
		String c_id=(String)session.getAttribute("c_id");
		Bogoodck bgood=new Bogoodck();
		bgood.setB_num(b_num);
		bgood.setC_id(c_id);
		if(ck.equals("n")) {
			bs.goodUp(b_num);
			bgood=new Bogoodck();
			bgood.setB_num(b_num);
			bgood.setC_id(c_id);
			bgs.insert(bgood);
		}
		else {
			bs.goodDown(b_num);
			bgs.delete(bgood);
		}
		String url = "redirect:/view/b_num/"+b_num+"/pageNum/"+pageNum;
		return new ModelAndView(url);
	}
	//통합검색용
	@RequestMapping("/view/b_num/{b_num}")
	public String view(@PathVariable int b_num, Model model) {
		bs.updateReadCount(b_num);
		Board board = bs.select(b_num);
		model.addAttribute("board", board);
		return "board/view";
	}
}

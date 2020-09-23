package com.ch.cinephile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.cinephile.model.Mogoodck;
import com.ch.cinephile.model.Motaglink;
import com.ch.cinephile.model.Tag;
import com.ch.cinephile.service.MogoodckService;
import com.ch.cinephile.service.MonologueService;
import com.ch.cinephile.service.MotaglinkService;
import com.ch.cinephile.service.TagService;

@Controller
public class MonologueController {
	@Autowired
	private MonologueService ms;
	@Autowired
	private MogoodckService mgs;
	@Autowired
	private TagService ts;
	@Autowired
	private MotaglinkService mos;
	@RequestMapping("monoWrite")
	public String monoWrite(String contents, String c_id,String tags) {
		ms.write(c_id,contents);
		Tag tag=new Tag();
		while(true) {
			int idx=tags.indexOf("#");
			if(idx==-1)
				break;
			else {
				tags=tags.substring(1, tags.length());
				int idx2=tags.indexOf("#");
				String str="";
				if(idx2==-1) {
					str=tags;
					tag=ts.selectCon(str);
					if(tag==null) {
						ts.insert(str);
					}
					tag=ts.selectCon(str);
				}
				else {
					str=tags.substring(0, idx2);
					tags.substring(0, idx2);
					tag=ts.selectCon(str);
					if(tag==null) {
						ts.insert(str);
					}
					tag=ts.selectCon(str);

					tags=tags.substring(idx2, tags.length());
				}
				int tag_num=tag.getTag_num();
				int mo_num=ms.recentMono(c_id);
				Motaglink mtag=new Motaglink();
				mtag.setTag_num(tag_num);
				mtag.setMo_num(mo_num);
				mos.insert(mtag);
			}
		}
		return "redirect:/main";	
	}
	@RequestMapping("monologuegood")
	public String monologuegood(Mogoodck mogoodck) {
		if(mgs.selectMonum(mogoodck)!=null) {
			mgs.delete(mogoodck);
			ms.gooddown(mogoodck.getMo_num());
		}
		else {
			mgs.insert(mogoodck);
			ms.goodup(mogoodck.getMo_num());
		}
		return "redirect:/main";
	}
	@RequestMapping("monoDelete")
	public String monoWrite(int mo_num) {
		ms.delete(mo_num);
		return "redirect:/profileMain";
		
	}
}

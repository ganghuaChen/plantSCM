package org.npc.plantSCM.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.Controller;
import org.npc.plantSCM.po.Staff;
import org.npc.plantSCM.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
	

@Controller
//@RequestMapping("/view")   // 这个相当于配置根路径
public class IndexController  {
	
	@Autowired
	private StaffService staffService;
	
	@RequestMapping("/index")     //如果配置了根路径 那么现在访问的就是 /view/index
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/view/index11.html");
		mav.addObject("message", "Hello Spring MVC");
		return mav;
	}
	
	//111
	@RequestMapping("/kk")     //如果配置了根路径 那么现在访问的就是 /view/index
	public ModelAndView handleRequest999(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/view/kk.html");
		return mav;
	}
	
	@RequestMapping("/ll")     //如果配置了根路径 那么现在访问的就是 /view/index
	public ModelAndView handleRequestww(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/view/ll.html");
		return mav;
	}
	
	/*@RequestMapping("/success11")     //如果配置了根路径 那么现在访问的就是 /view/index
	public ModelAndView handleRequestss(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/show/success11.jsp");
		return mav;
	}*/
	
	  @RequestMapping("/success11")
	   public String success11(){
			return "success11";
		}
	  
	  @RequestMapping("/zxc")
	   public String zxc(){
			return "/show/zxc";
		}

	   
	   @RequestMapping("/business_neworder")
	   public String business_neworder(){
			return "business_neworder";
		}
	   
	   @RequestMapping("/business_newpurchase")
	   public String business_newpurchase(){
			return "business_newpurchase";
		}
	   
	   
	   
}
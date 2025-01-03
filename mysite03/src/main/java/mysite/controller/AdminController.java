package mysite.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import mysite.security.Auth;
import mysite.security.AuthUser;
import mysite.service.FileUploadService;
import mysite.service.GuestbookService;
import mysite.service.SiteService;
import mysite.vo.BoardVo;
import mysite.vo.SiteVo;
import mysite.vo.UserVo;

@Auth(role="ADMIN")
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private final FileUploadService fileUploadService;
	
	@Autowired
	private SiteService siteService;
	public AdminController(SiteService siteService, FileUploadService fileUploadService) {
		this.siteService = siteService;
		this.fileUploadService = fileUploadService;
	}
	
	@RequestMapping({"", "/main"})
	public String main(Model model) {
		SiteVo siteVo = siteService.getSite();
		model.addAttribute("siteVo", siteVo);
		return "admin/main";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(
			@RequestParam("title") String title,
			@RequestParam("welcome") String welcome,
			@RequestParam("description") String description,
			@RequestParam("profile") MultipartFile profile) {
		
		SiteVo siteVo = new SiteVo();
		siteVo.setTitle(title);
		siteVo.setWelcome(welcome);
		siteVo.setDescription(description);
		
		String url = fileUploadService.restore(profile);
		siteVo.setProfile(url);
		siteService.updateSite(siteVo);
		return "redirect:/admin/main";
	}
	
	@RequestMapping("/guestbook")
	public String guestbook() {
		return "admin/guestbook";
	}
	
	@RequestMapping("/board")
	public String board() {
		return "admin/guestbook";
	}
	
	@RequestMapping("/user")
	public String user() {
		return "admin/user";
	}
}

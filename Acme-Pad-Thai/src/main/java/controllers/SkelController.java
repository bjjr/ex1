package controllers;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.SkelService;
import domain.Skel;

@Controller
@RequestMapping("/skel")
public class SkelController {

	// Services ----------------------------------------------
	
	@Autowired
	private SkelService skelService;
	
	// Constructors ------------------------------------------
	
	public SkelController() {
		super();
	}
	
	// Listing -----------------------------------------------
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView res;
		Collection<Skel> skels;
		
		skels = skelService.findAll();
		
		res = new ModelAndView("skel/list");
		res.addObject("skels");
//		res.addObject("requestURI", "skel/list.do");
		
		return res;
	}
	
	// Create ------------------------------------------------
	
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView res;
		Skel skel;
		
		skel = skelService.create();
		res = createEditModelAndView(skel);
		
		return res;
	}
	
	// Edition -----------------------------------------------
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam int skelId) {
		ModelAndView res;
		Skel skel;
		
		skel = skelService.findOneToEdit(skelId);
		res = createEditModelAndView(skel);
		
		return res;
	}
	
	// Save --------------------------------------------------
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid Skel skel, BindingResult binding) {
		ModelAndView res;
		
		if (binding.hasErrors()) {
			res = createEditModelAndView(skel);
		} else {
			try {
				skelService.save(skel);
				// TODO Redirigir a la vista adecuada
//				res = new ModelAndView("redirect:/skel...")
				res = null;
			} catch (Throwable oops) {
				res = createEditModelAndView(skel, oops.getMessage());
			}
		}
		
		return res;
	}
	
	// Deleting ----------------------------------------------
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "delete")
	public ModelAndView delete(Skel skel, BindingResult binding) {
		ModelAndView res;
		
		try {
			skelService.delete(skel);
			res = new ModelAndView("redirect:list.do");
		} catch (Throwable th) {
			res = createEditModelAndView(skel);
		}
		
		return res;
	}
	
	// Ancillary ---------------------------------------------
	
	protected ModelAndView createEditModelAndView(Skel skel) {
		ModelAndView res;
		
		res = createEditModelAndView(skel, null);
		
		return res;
	}
	
	protected ModelAndView createEditModelAndView(Skel skel, String message) {
		ModelAndView res;
		
		res = new ModelAndView("skel/edit");
		res.addObject("skel", skel);
		res.addObject("message", message);
		
		return res;
	}
	
}

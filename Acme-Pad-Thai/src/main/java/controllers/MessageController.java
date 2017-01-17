package controllers;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.ActorService;
import services.FolderService;
import services.MessageService;
import services.PriorityService;
import domain.Actor;
import domain.Folder;
import domain.Message;

@Controller
@RequestMapping("/message")
public class MessageController extends AbstractController{
	
	// Services -----------------------------------------------
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private FolderService folderService;
	
	@Autowired
	private ActorService actorService;
	
	@Autowired
	private PriorityService priorityService;
	
	// Constructors -------------------------------------------
	
	public MessageController(){
		super();
	}
	
	// Creating -----------------------------------------------
	
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create(){
		ModelAndView result;
		Message messageDomain;
		
		messageDomain = messageService.create();
		messageDomain.setSender(actorService.findByPrincipal());
		result = createEditModelAndView(messageDomain);
		
		return result;
	}
	
	// Send ---------------------------------------------------
	
	@RequestMapping(value = "/create", method = RequestMethod.POST, params = "send")
	public ModelAndView send(@Valid Message messageDomain, BindingResult binding){
		ModelAndView result;
		Actor sender;
		Collection<Actor> recipients;
		int folderId = 0;
		
		sender = actorService.findByPrincipal();
		recipients = messageDomain.getRecipients();
		
		for (Folder f : sender.getFolders()) {
			if (f.getName().equals("Outbox") && f.isObligatory()) {
				folderId = f.getId();
			}
		}
		
		if (binding.hasErrors()) {
			result = createEditModelAndView(messageDomain);
		} else {
			try {
				messageService.sendMessage(messageDomain, sender, recipients);
				result = new ModelAndView("redirect:listByFolder.do?folderId=" + folderId);
			} catch (Throwable oops) {
				result = createEditModelAndView(messageDomain, "message.commit.error");
			}
		}
		
		return result;
	}
	
	// List by folder ------------------------------------------
	
	@RequestMapping(value = "/listByFolder", method = RequestMethod.GET)
	public ModelAndView listByFolder(@RequestParam int folderId){
		ModelAndView result;
		Folder folder;
		Collection<Message> messages;
		Boolean outbox;
		Boolean trashbox;
		int actualFolderId;
		
		outbox = false;
		trashbox = false;
		folder = folderService.findOne(folderId);
		messages = folder.getMessages();
		actualFolderId = folderId;
		
		if(folder.getName().equals("Trashbox")){
			trashbox = true;
		}
		if(folder.getName().equals("Outbox")){
			outbox = true;
		}
		
		result = new ModelAndView("message/listByFolder");
		result.addObject("messages", messages);
		result.addObject("outbox", outbox);
		result.addObject("trashbox", trashbox);
		result.addObject("folderId", folderId);
		result.addObject("actualFolderId", actualFolderId);
		result.addObject("requestURI", "message/listByFolder.do");
		
		return result;
	}
	
	@RequestMapping(value = "/moveToTrashbox", method = RequestMethod.GET)
	public ModelAndView moveToTrashbox(@RequestParam int messageId, @RequestParam int folderId){
		ModelAndView result;
		Actor actor;
		Message message;
		
		actor = actorService.findByPrincipal();
		message = messageService.findOne(messageId);
		messageService.deleteMessageToTrash(actor, message);
		
		result = new ModelAndView("redirect:listByFolder.do?folderId=" + folderId);
		
		return result;
	}
	
	@RequestMapping(value = "/selectFolder", method = RequestMethod.GET)
	public ModelAndView selectFolder(@RequestParam int messageId, @RequestParam int actualFolderId){
		ModelAndView result;
		Message messageDomain;
		Actor actor;
		Folder actualFolder;
		Collection<Folder> folders;
		
		messageDomain = messageService.findOne(messageId);
		actor = actorService.findByPrincipal();
		actualFolder = folderService.findOne(actualFolderId);
		folders = actor.getFolders();
		
		Assert.isTrue(folders.contains(actualFolder));
		
		for(Folder f:folders){
			if(f.getName().equals("Trashbox")){
				folders.remove(f);
			}
		}
		
		folders.remove(actualFolder);

		result = new ModelAndView("message/move");
		result.addObject("actualFolderId", actualFolderId);
		result.addObject("messageId", messageId);
		result.addObject("messageDomain", messageDomain);
		result.addObject("folders", folders);
		
		return result;
	}
	
	@RequestMapping(value = "/move", method = RequestMethod.GET)
	public ModelAndView move(@RequestParam int messageId, @RequestParam int actualFolderId, @RequestParam int folderId){
		ModelAndView result;
		Actor actor;
		Message messageDomain;
		Folder folder;
		
		actor = actorService.findByPrincipal();
		messageDomain = messageService.findOne(messageId);
		folder = folderService.findOne(folderId);
		
		messageService.moveMessage(folder, messageDomain, actor);
		
		result = new ModelAndView("redirect:listByFolder.do?folderId=" + actualFolderId);
		result.addObject("messageId", messageId);
		result.addObject("actualFolderId", actualFolderId);
		result.addObject("folderId", folderId);
		
		return result;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public ModelAndView delete(@RequestParam int messageId, @RequestParam int actualFolderId){
		ModelAndView result;
		Actor actor;
		Message messageDomain;
		
		actor = actorService.findByPrincipal();
		messageDomain = messageService.findOne(messageId);
		
		try{
			messageService.delete(messageDomain, actor);
			result = new ModelAndView("redirect:listByFolder.do?folderId=" + actualFolderId);
		}
		catch(Throwable oops){
			result = new ModelAndView("redirect:listByFolder.do?folderId=" + actualFolderId);
			result.addObject("message", "message.commit.error");
		}
		
		return result;
	}
	
	
	// Ancillary methods -------------------------------------
	
	protected ModelAndView createEditModelAndView(Message messageDomain){
		ModelAndView result;
			
		result = createEditModelAndView(messageDomain, null);
				
		return result;
	}
			
	protected ModelAndView createEditModelAndView(Message messageDomain, String message){
		ModelAndView result;
		Collection<Message> messagesList;
				
		messagesList = messageService.findAll();
				
		result = new ModelAndView("message/create");
		result.addObject("messageDomain", messageDomain);
		result.addObject("messagesList", messagesList);
		result.addObject("message", message);
		result.addObject("actors", actorService.findAll());
		result.addObject("priorities", priorityService.findAll());
			
		return result;
	}

}

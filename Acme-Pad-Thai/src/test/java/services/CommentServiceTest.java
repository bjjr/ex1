package services;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import domain.Comment;
import domain.Recipe;

import utilities.AbstractTest;
import utilities.TestUtils;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"classpath:spring/datasource.xml",
	"classpath:spring/config/packages.xml"})
@Transactional
public class CommentServiceTest extends AbstractTest{
	
	//Service under test
	@Autowired
	private CommentService commentService;
	
	//Supporting services
	@Autowired
	private RecipeService recipeService;
	
	//Tests
	@Test
	public void testCreateComment(){
		Comment comment;
		int recipeId;
		Recipe recipe;
		
		super.authenticate("nutritionist1");
		
		recipeId = TestUtils.getIdFromBeanName("recipe1");
		recipe = recipeService.findOne(recipeId);
		comment = commentService.create(recipe);
		
		super.authenticate(null);
		
		System.out.println("Comment" + comment.getId() + "created");
		
	}
	
	@Test
	public void testSaveComment(){
		Comment comment, saved;
		
		super.authenticate("User2");

		comment = commentService.findOne(146);
		
		saved = commentService.save(comment);
		commentService.flush();
		
		super.authenticate(null);
		
		System.out.println("Comment" + saved.getId() + "saved");
	}
	
	@Test
	public void testDeleteComment(){
		Comment comment;
		
		comment = commentService.findOne(146);
		
		commentService.delete(comment);
		
		System.out.println("Comment deleted");
	}
	
	@Test
	public void testFindOneComment(){
		Comment comment;
		
		comment = commentService.findOne(146);
				
		System.out.println("Comment" + comment.getId() + "found");
	}

}

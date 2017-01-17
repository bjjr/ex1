package services;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import domain.Ingredient;
import domain.Property;

import repositories.IngredientRepository;

@Service
@Transactional
public class IngredientService {
	
	//Managed repository
	@Autowired
	private IngredientRepository ingredientRepository;
	
	// Supporting services
	@Autowired
	private ActorService actorService;
	
	@Autowired
	private PropertyService propertyService;
	
	//Constructors
	public IngredientService(){
		super();
	}
	
	// Simple CRUD methods
	public Ingredient create(){
		Assert.isTrue(actorService.checkAuthority("NUTRITIONIST"));
		Ingredient result;
		Collection<Property> properties;
		Property property;
		
		properties = new ArrayList<Property>();
		property = propertyService.findOne(173);
		properties.add(property);
		result = new Ingredient();
		result.setProperties(properties);
		
		return result;
	}
	
	public Collection<Ingredient> findAll(){
		Assert.isTrue(actorService.checkAuthority("NUTRITIONIST") ||
					  actorService.checkAuthority("USER"));
		Collection<Ingredient> result;
		
		result = ingredientRepository.findAll();
		Assert.notNull(result);
		
		return result;
	}
	
	public Ingredient findOne(int id){
		Assert.notNull(id);
		Assert.isTrue(id!=0);
		
		Ingredient result;
		
		result = ingredientRepository.findOne(id);
		Assert.notNull(result);
		
		return result;
		
	}
	
	public Ingredient save(Ingredient ingredient){
		Assert.isTrue(actorService.checkAuthority("NUTRITIONIST"));
		Assert.notNull(ingredient);
		
		Ingredient result;
		Collection<Property> properties;
		Property property;
		
		if(ingredient.getId() == 0){
			properties = new ArrayList<>();
			property = propertyService.findOne(173);
			properties.add(property);
			ingredient.setProperties(properties);
			result = ingredientRepository.save(ingredient);
			property.addIngredient(result);
			propertyService.save(property);
		}
		else{
			result = ingredientRepository.save(ingredient);
		}
		
		return result;
	}
	
	public void flush() {
		ingredientRepository.flush();
	}
	
	public void delete(Ingredient ingredient){
		Assert.isTrue(actorService.checkAuthority("NUTRITIONIST"));
		Assert.notNull(ingredient);
		Assert.isTrue(ingredient.getId()!=0);
		Assert.isTrue(ingredientRepository.exists(ingredient.getId()));
		
		Collection<Ingredient> usedIngredients;
		
		usedIngredients = ingredientRepository.findAllUsedIngredients();
		
		Assert.isTrue(!usedIngredients.contains(ingredient), "This ingredient is used in some recipes");
		
		for(Property p : ingredient.getProperties()){
			ingredient.removeProperty(p);
			p.removeIngredient(ingredient);
			propertyService.save(p);
		}
		
		ingredientRepository.delete(ingredient);
		
	}
	
	// Other business methods
	public Double findAvgIngredientPerRecipe(){
		Assert.isTrue(actorService.checkAuthority("ADMINISTRATOR"));
		
		Double result;
		
		result = ingredientRepository.findAvgIngredientPerRecipe();
		Assert.notNull(result);
		
		return result;
	}
	
	public Double findStandardDeviationIngredientPerRecipe(){
		Assert.isTrue(actorService.checkAuthority("ADMINISTRATOR"));
		
		Double result;
		
		result = ingredientRepository.findStandardDeviationIngredientPerRecipe();
		Assert.notNull(result);
		
		return result;
	}
	
	public void addProperty(Ingredient ingredient, Property property){
		Assert.notNull(ingredient);
		Assert.notNull(property);
		
		ingredient.addProperty(property);
		save(ingredient);
		propertyService.save(property);
	
	}
	
	public void removeProperty(Ingredient ingredient, Property property){
		Assert.notNull(ingredient);
		Assert.notNull(property);
		
		ingredient.removeProperty(property);
		save(ingredient);
		propertyService.save(property);
	
	}

}
